plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    signingConfigs {
        // 创建 release 签名配置
        create("release") {
            storeFile = file("C:\\Users\\12769\\Desktop\\key") // 注意：这里要确保是完整的密钥文件路径（如 key.jks）
            storePassword = "123456"
            keyAlias = "key"
            keyPassword = "123456"
            // 可选：开启V1/V2签名（兼容不同Android版本）
            enableV1Signing = true
            enableV2Signing = true
        }
        // 创建 debug 签名配置（可选，若不需要可删除）
    }
    namespace = "com.example.adscope_sdk_demo"
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
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.adscope_sdk_demo"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 24
        targetSdk = 33
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        // Release 构建类型配置
        release {
            isDebuggable = false // 对应 debuggable false
            isMinifyEnabled = true // 对应 minifyEnabled true
            isZipAlignEnabled = true // 对应 zipAlignEnabled true
            isShrinkResources = true // 对应 shrinkResources true

            // 混淆规则文件配置（等效 proguardFiles）
            proguardFiles(
                getDefaultProguardFile("proguard-android.txt"),
                file("proguard-rules.pro")
            )

            // 关联release签名配置（需先定义signingConfigs）
            signingConfig = signingConfigs.getByName("release")
        }

        // Debug 构建类型配置
        debug {
            isMinifyEnabled = false // 对应 minifyEnabled false
        }
    }
}
dependencies {
    implementation(fileTree("libs") {
        include("*.jar", "*.aar")
    })
    implementation("com.google.android.material:material:1.13.0")
    implementation("androidx.appcompat:appcompat:1.7.1")
    implementation("com.google.android.material:material:1.13.0")
    // 引入 LocalBroadcastManager 兼容库（支持 AndroidX 项目）
    implementation("androidx.localbroadcastmanager:localbroadcastmanager:1.1.0")
}
flutter {
    source = "../.."
}
