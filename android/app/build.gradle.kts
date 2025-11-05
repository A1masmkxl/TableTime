plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    // ✅ Плагин Google Services для Firebase
    id("com.google.gms.google-services")
    // ✅ Flutter Gradle Plugin (должен быть последним)
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.tabletime"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.tabletime"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // ✅ Firebase BoM — управляет версиями SDK
    implementation(platform("com.google.firebase:firebase-bom:34.4.0"))

    // ✅ Основные модули Firebase (версии не указываем!)
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")

    // ✅ Kotlin stdlib
    implementation("org.jetbrains.kotlin:kotlin-stdlib")
}
