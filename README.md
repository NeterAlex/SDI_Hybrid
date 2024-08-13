## SDI-Hybrid

### 简介

适用于 SDI 项目的跨平台客户端，使用 Flutter(Dart) 构建。

### 技术栈

- 使用 Dart 作为开发语言，Flutter 作为跨平台框架。
- 使用 Bruno 作为组件库。
- 后端服务使用 Python + FastAPI 框架构建。

### 目录说明

- `android` - Android kotlin
- `assets` - 资源及设置文件
- `lib` - 代码目录
    - `lib/common` - 全局配置
    - `lib/models` - 数据模型
    - `lib/state` - 状态 Provider
    - `lib/tabs` - 页面 Tabs
    - `lib/widgets` - Flutter 组件
    - `lib/layout.dart` - 全局布局框架
    - `lib/main.dart` - App 入口点
- `ios` - iOS swift
- `test` - 测试
- `web` - Web javascript
- `pubspec.yaml` - 项目依赖文件

### 调试与构建

> 项目使用 **JDK17** 作为默认的 JDK 版本；
> 默认启用的构建目标：Android、iOS、Web。

1. 克隆或 fork 项目
2. 配置 Flutter SDK、Dart SDK
3. 配置 Android SDK 和 Android Emulator
4. 使用 IntelliJ IDEA 打开项目(需安装 Flutter 和 Dart 插件)
5. 运行 `pub get` 安装项目依赖
6. 在不同目标设备启动项目

### Information

### Build for

+ Android
+ iOS
+ Web

