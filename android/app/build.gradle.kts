plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android") // use full plugin ID
    id("dev.flutter.flutter-gradle-plugin")
}

val flutter: dev.flutter.plugins.FlutterPlugin.FlutterExtension by project.extensions

android {
    namespace = "com.example.flutter_application_1"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    defaultConfig {
        applicationId = "com.example.flutter_application_1"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode.set(flutter.versionCode.toInt())
        versionName.set(flutter.versionName)
    }

    buildTypes {
        getByName("release") {
            // Use actual signingConfig for release build if available
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
