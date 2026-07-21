/*
import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "taqreri-5b6fb",
          "private_key_id": "27c1dddcba21333bdc770533dfa4f61026a47920",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDwSZVFg09V+EMI\nzTenlRE3k2UPwpMLhl6nuKidFJlr/n0BxF2427x9lVabgXPvlXTpVPiNydS9dlKx\nHTMxM7v3nJyWx2mhnsP1Xide/t+vhE/KYiOIHpslJw9nRSQXya+cPUym1k4CS7bA\nLqEZIvq7XG+9G3FMBXWtaDGd599WbLkH91Mipfhk30iaol9zs2qals7Wl6AsSA33\nY05Yq+w6yb8scgiI3So4YD46th/66jXDLw2o1VTJiFQsc5bLQUYcVBVM59eFJC7j\nFSwltP0L09BsZl+B4sGCwO8a7NvcIPK5qyf1uuFNf5TgHq/cvh7uJn1uEaGGLsn/\nK7nZtoIvAgMBAAECggEABdos8LP5hIUBkPR6lLIh6Ldwyy5N1DEyG1Cj3quH7w7p\nhC0AVrEXXqb6pIVFycHbRpbjX4SuZ0I7Ulqn4Adms77/O1bhAObegUUz8pwviNVR\nTNhmDXnSr9ggh78x2Vh4AUym53CpwWQ5r7roVos5DcN7FIvXZGbE+R5kCE4Dl6sN\nzZpvbj9k4tUxc1ybcB+mSCkQuJhZ6jTqz8Dnf8EhnFD38HABQsTJCwF0CvER2DXf\nrVawiEd7MFu9XGNTvBEY04OcKmoZCf8JrwvljW8MHTK/Ah3DzCY1KdzOZDkbqt9M\nemTJbTU5uAxt2ypr9/5bwzwKLXMtOPDGu11AfJQadQKBgQD9+HLvehqtXAdtQD3h\nrmCODkbOMUIX1PzcLgEA69wmecGo9/3/1acOObM0DaZwGxiZstHJOrDDIsnbDJce\nnBigrR7xBrQSafhc8i92cz1V69brpXu4YT5/1K6FId8oO2OAEa+yJd5kfIUlUqN0\nZD1mA/1RoqO+beyW8CF6W7h0KwKBgQDyNSR5XHFzJc57fOtaZVHVjGP2b4pS+ioE\nzFfdGpgB04sUZvu2x64AA7qH7yKKKnFRIWLtnSj1OORsHOQDvEwU4jacGqRyhRe3\naR5/I+WCJMuK2aocrRxVjm14smCqJEKynl7EUiYrTBN/al26DeAAwH4bz7Prrum/\nIcEOd+/UDQKBgQC9uiAq1N4fCjQmIqrX8MwC85ljqhrE8QEhf2CSjqC9QZIyJ2lh\n+Ps+vk4oodXnw+ZB0/uyx5yLem6vrJ0sadJgHlSSHL7jTrUSwn5Aj+CPUosRKWPe\nnw7wsjLaFC7AwHUZlJzbijy0du2Er1KavdO8ZViV5tlKhpYLQELSRLjsVwKBgGZv\nTUa6bwy475PQaCUp9qsvHdPKpqCjRoQS/BH5vlH/arGtQEW0O4WsDgaRf3UZsCUU\nzqcZsYnMjuaebVybFT470cbBic0ZNseOAKTaxKT+9Mp7dfN8zx/sBaZnInSyszah\nvgifiZ8EJLbdgFhAp/0JbAxNEpXZuufn2aNJ3Dc9AoGAMTO7bjBuFmhoYmusNAk9\nB/SzXWKMuDQRYdR5aYS1GpTnmzcX+t4KNuAbRozEIPtFxiVMBsy0xlZLNmDK/dzC\nkHVrNtqpNdoI7FvTlSyDCB2n12sd/wBXDMmEKCmOt0QFt5D1OkIGUlnzmKriQycb\nfl2opRpnfIESOSVLKWNdl+g=\n-----END PRIVATE KEY-----\n",
          "client_email": "firebase-adminsdk-fbsvc@taqreri-5b6fb.iam.gserviceaccount.com",
          "client_id": "114256853778549367138",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40taqreri-5b6fb.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        scopes);
    final accessServerKey = await client.credentials.accessToken.data;
    print("kkkkkkkkkkkkkkkkkkkkkkkkkss $accessServerKey");
    return accessServerKey;
  }
}
*/
