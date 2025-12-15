import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Load signing properties if available
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.inputStream().use { keystoreProperties.load(it) }
}

android {
    namespace = "com.kominfo.pendekarkotamadiun"
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
        applicationId = "com.kominfo.pendekarkotamadiun"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    signingConfigs {
        if (!keystoreProperties.isEmpty) {
            create("release") {
                keyAlias = keystoreProperties["keyAlias"] as String?
                keyPassword = keystoreProperties["keyPassword"] as String?
                storeFile = (keystoreProperties["storeFile"] as String?)?.let { file(it) }
                storePassword = keystoreProperties["storePassword"] as String?
            }
        }
    }

    buildTypes {
        getByName("release") {
            // For testing - use debug signing to ensure APK is installable
            signingConfig = signingConfigs.getByName("debug")
            // Keep minify/shrink disabled for now
            // isMinifyEnabled = true
            // isShrinkResources = true
            // proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), file("proguard-rules.pro"))
        }
    }
}
flutter {
    source = "../.."
}

// Mirror APKs to the Flutter project root build path so Flutter tooling can find them reliably.
val copyApkToFlutterRoot by tasks.registering(Copy::class) {
    val buildDirProv = layout.buildDirectory
    from(buildDirProv.dir("outputs/flutter-apk")) { include("*.apk") }
    from(buildDirProv.dir("outputs/apk")) { include("**/*.apk") }
    // Compute Flutter project root: parent of the Android directory
    val flutterRoot = rootDir.parentFile
    into(File(flutterRoot, "build/app/outputs/flutter-apk"))
    // Always run to ensure the output exists
    outputs.upToDateWhen { false }
}

tasks.matching {
    it.name.equals("assembleDebug", ignoreCase = true) ||
    it.name.equals("packageDebug", ignoreCase = true) ||
    it.name.equals("installDebug", ignoreCase = true) ||
    it.name.equals("assembleRelease", ignoreCase = true) ||
    it.name.equals("packageRelease", ignoreCase = true)
}.configureEach {
    finalizedBy(copyApkToFlutterRoot)
}

