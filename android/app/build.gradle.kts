plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.flutter_application_1"
    compileSdk = 34

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    defaultConfig {
        applicationId = "com.example.flutter_application_1"
        minSdk = 21
        targetSdk = 34

        // ✅ Safe access to Flutter values
        val flutter = project.extensions.getByName("flutter") as Map<String, Any>
        versionCode = (flutter["versionCode"] as String).toInt()
        versionName = flutter["versionName"] as String
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

configure<dev.flutter.plugins.FlutterPlugin.FlutterExtension> {
    source = "../.."
}
