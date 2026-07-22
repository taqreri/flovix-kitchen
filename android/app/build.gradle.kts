plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.flovix.kitchen"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.flovix.kitchen"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    flavorDimensions += "env"
    productFlavors {
        create("production") {
            dimension = "env"
            applicationId = "com.flovix.kitchen"
            resValue("string", "app_name", "Flovix Kitchen")
            manifestPlaceholders["appIcon"] = "@drawable/ic_launcher_production"
            manifestPlaceholders["appRoundIcon"] = "@drawable/ic_launcher_production"
        }
        create("staging") {
            dimension = "env"
            applicationId = "com.flovix.kitchen.stg"
            resValue("string", "app_name", "Flovix Kitchen STG")
            manifestPlaceholders["appIcon"] = "@drawable/ic_launcher_staging"
            manifestPlaceholders["appRoundIcon"] = "@drawable/ic_launcher_staging"
        }
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// When product flavors are enabled, Gradle outputs app-<flavor>-debug.apk.
// Flutter run/build without --flavor looks for app-debug.apk — alias production debug.
android.applicationVariants.configureEach {
    if (buildType.name == "debug" && flavorName == "production") {
        assembleProvider.configure {
            doLast {
                val flutterApkDir =
                    file("${rootProject.projectDir}/../build/app/outputs/flutter-apk")
                val srcApk = flutterApkDir.resolve("app-production-debug.apk")
                val destApk = flutterApkDir.resolve("app-debug.apk")
                if (srcApk.exists()) {
                    srcApk.copyTo(destApk, overwrite = true)
                }
            }
        }
    }
}

flutter {
    source = "../.."
}

kotlin {
    compilerOptions {
        jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
    }
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:34.10.0"))
    implementation("com.github.felHR85:UsbSerial:6.0.6")
    implementation("com.google.firebase:firebase-analytics")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
