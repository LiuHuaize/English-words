# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

这是一个基于 SwiftUI 的 iOS 英语单词学习应用，使用艾宾浩斯遗忘曲线算法帮助用户科学记忆单词。

## 技术栈

- **平台**: iOS (SwiftUI)
- **语言**: Swift
- **最低部署目标**: iOS 15.0+
- **主要依赖**: 
  - Lottie (4.5.2) - 动画库
- **架构模式**: MVVM + SwiftUI 声明式 UI

## 常用开发命令

### 构建与运行
```bash
# 构建项目（Debug 模式）
xcodebuild -scheme English-words -configuration Debug build

# 构建项目（Release 模式）
xcodebuild -scheme English-words -configuration Release build

# 清理构建缓存
xcodebuild -scheme English-words clean

# 在模拟器运行
xcodebuild -scheme English-words -destination 'platform=iOS Simulator,name=iPhone 15' build run
```

### 测试
```bash
# 运行单元测试
xcodebuild test -scheme English-words -destination 'platform=iOS Simulator,name=iPhone 15'

# 运行特定测试类
xcodebuild test -scheme English-words -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:English-wordsTests/SpecificTestClass

# 运行 UI 测试
xcodebuild test -scheme English-words -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:English-wordsUITests
```

## 项目架构

### 核心目录结构
```
English-words/
├── Views/              # UI 视图层
│   ├── Auth/          # 认证相关视图（登录、注册）
│   └── Components/    # 可复用 UI 组件
├── Resources/         # 资源文件
│   ├── AppColors.swift    # 颜色定义
│   └── AppStrings.swift   # 文字常量
├── Extensions/        # Swift 扩展
├── Animations/        # Lottie 动画相关
│   ├── LottieView.swift           # Lottie 视图封装
│   └── LottieAnimationManager.swift # 动画管理器
└── doc/              # 项目文档
```

### 架构说明

1. **视图层架构**: 项目采用 SwiftUI 的声明式 UI，所有视图都继承自 `View` 协议
2. **组件化设计**: UI 组件高度模块化，如 `CustomTextField`、`GradientButton`、`GradientBackground` 等可复用组件
3. **资源管理**: 所有颜色和文字常量集中在 `Resources` 目录管理，便于国际化和主题切换
4. **导航结构**: 使用 `ContentView` 作为根视图控制器，通过状态管理控制登录/主界面切换

## 核心功能模块（规划中）

根据需求文档，应用将包含以下核心模块：

1. **AI 翻译模块**: 集成百度翻译 API
2. **生词本管理**: 单词存储与状态管理
3. **复习系统**: 基于艾宾浩斯曲线的 8 个复习时间点
4. **学习流程**: 词义记忆 → 拼写练习 → 造句练习
5. **用户统计**: 学习进度追踪

## 开发注意事项

### UI 开发规范
- 所有颜色使用 `AppColors` 中定义的颜色
- 所有文字使用 `AppStrings` 中定义的常量
- 新建组件优先放在 `Views/Components` 目录
- 动画效果使用 Lottie 实现，相关文件放在 `Animations` 目录

### 状态管理
- 使用 SwiftUI 的 `@State`、`@Binding`、`@StateObject` 等属性包装器
- 全局状态考虑使用 `@EnvironmentObject` 或 `@Environment`

### 代码风格
- 遵循 Swift 官方命名规范
- 视图文件以 `View` 结尾
- 使用计算属性拆分复杂视图，提高可读性

## 当前开发状态

- ✅ 基础项目结构搭建
- ✅ 登录/注册界面 UI
- ✅ UI 组件库（按钮、输入框、背景等）
- ✅ Lottie 动画集成
- 🚧 用户认证逻辑
- ⏳ 主界面开发
- ⏳ 翻译功能集成
- ⏳ 生词本功能
- ⏳ 复习系统
- ⏳ 数据持久化

## 待实现的关键功能

1. 实现 `ContentView` 中的主应用界面
2. 完成 `LoginView` 的实际登录逻辑
3. 集成百度翻译 API
4. 设计并实现数据模型层
5. 实现本地数据存储（Core Data 或 SwiftData）
6. 实现艾宾浩斯复习算法