package com.flovix.kitchen

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.net.Inet4Address
import java.net.NetworkInterface

class MainActivity : FlutterActivity() {
    private val channelName = "com.flovix.kitchen/local_ip"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getLocalIpv4Addresses" -> {
                        try {
                            result.success(collectLocalIpv4Addresses())
                        } catch (e: Exception) {
                            result.error("LOCAL_IP", e.message, null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    /**
     * Returns IPv4 addresses even when Wi‑Fi is off (Ethernet / USB / hotspot / etc).
     * Each entry: { "ip": "192.168.x.x", "interface": "eth0", "transport": "ethernet" }
     */
    private fun collectLocalIpv4Addresses(): List<Map<String, String>> {
        val found = linkedMapOf<String, Map<String, String>>()

        // 1) ConnectivityManager — active + all networks (works with Wi‑Fi off + Ethernet on).
        val cm = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        for (network in cm.allNetworks) {
            val caps = cm.getNetworkCapabilities(network) ?: continue
            val link = cm.getLinkProperties(network) ?: continue
            val transport = when {
                caps.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) -> "ethernet"
                caps.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> "wifi"
                caps.hasTransport(NetworkCapabilities.TRANSPORT_WIFI_AWARE) -> "wifi"
                caps.hasTransport(NetworkCapabilities.TRANSPORT_VPN) -> "vpn"
                caps.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> "cellular"
                else -> "other"
            }
            // Cellular is not a POS LAN path; skip unless nothing else exists later.
            if (transport == "cellular") continue

            val ifName = link.interfaceName ?: transport
            for (linkAddress in link.linkAddresses) {
                val addr = linkAddress.address
                if (addr is Inet4Address && !addr.isLoopbackAddress) {
                    val ip = addr.hostAddress ?: continue
                    if (ip.startsWith("169.254.")) continue
                    found.putIfAbsent(
                        ip,
                        mapOf(
                            "ip" to ip,
                            "interface" to ifName,
                            "transport" to transport,
                        ),
                    )
                }
            }
        }

        // 2) Java NetworkInterface — catches hotspot (ap0/softap) and adapters CM misses.
        val interfaces = NetworkInterface.getNetworkInterfaces()
        if (interfaces != null) {
            for (ni in interfaces) {
                if (!ni.isUp) continue
                val name = ni.name.lowercase()
                if (name == "lo" || name.startsWith("rmnet") || name.startsWith("ccmni") ||
                    name.startsWith("pdp") || name.contains("dummy")
                ) {
                    continue
                }
                val transport = when {
                    name.startsWith("eth") || name.contains("usb") || name.contains("rndis") ->
                        "ethernet"
                    name.startsWith("wlan") || name.contains("wifi") -> "wifi"
                    name.startsWith("ap") || name.contains("softap") || name.startsWith("swlan") ->
                        "hotspot"
                    else -> "other"
                }
                val addrs = ni.inetAddresses
                while (addrs.hasMoreElements()) {
                    val addr = addrs.nextElement()
                    if (addr is Inet4Address && !addr.isLoopbackAddress) {
                        val ip = addr.hostAddress ?: continue
                        if (ip.startsWith("169.254.")) continue
                        found.putIfAbsent(
                            ip,
                            mapOf(
                                "ip" to ip,
                                "interface" to ni.name,
                                "transport" to transport,
                            ),
                        )
                    }
                }
            }
        }

        // 3) If still empty, allow cellular only as last resort (better than blank UI).
        if (found.isEmpty()) {
            for (network in cm.allNetworks) {
                val caps = cm.getNetworkCapabilities(network) ?: continue
                if (!caps.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR)) continue
                val link = cm.getLinkProperties(network) ?: continue
                for (linkAddress in link.linkAddresses) {
                    val addr = linkAddress.address
                    if (addr is Inet4Address && !addr.isLoopbackAddress) {
                        val ip = addr.hostAddress ?: continue
                        if (ip.startsWith("169.254.")) continue
                        found.putIfAbsent(
                            ip,
                            mapOf(
                                "ip" to ip,
                                "interface" to (link.interfaceName ?: "cellular"),
                                "transport" to "cellular",
                            ),
                        )
                    }
                }
            }
        }

        return found.values.toList()
    }
}
