# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

这是一个基于 SwiftUI 的 iOS 英语单词学习应用，使用艾宾浩斯遗忘曲线算法帮助用户科学记忆单词。

## 技术栈

- **平台**: iOS (SwiftUI)
- **语言**: Swift
- **最低部署目标**: iOS 18.5
- **Xcode Scheme**: English-words
- **主要依赖**: 
  - Lottie (通过 Swift Package Manager) - 动画库
- **架构模式**: SwiftUI 声明式 UI + 组件化设计

## 常用开发命令

### 构建与运行
```bash
# 构建项目（Debug 模式）
xcodebuild -scheme English-words -configuration Debug build

# 构建项目（Release 模式）
xcodebuild -scheme English-words -configuration Release build

# 清理构建缓存
xcodebuild -scheme English-words clean

# 在 iPhone 16 模拟器构建并运行
xcodebuild -scheme English-words -destination 'platform=iOS Simulator,name=iPhone 16' build run

# 使用 MCP 工具在模拟器运行（推荐）
# 先列出可用模拟器：mcp__XcodeBuildMCP__list_sims
# 然后构建运行：mcp__XcodeBuildMCP__build_run_sim_name_proj
```

### 测试
```bash
# 运行单元测试
xcodebuild test -scheme English-words -destination 'platform=iOS Simulator,name=iPhone 16'

# 运行特定测试类
xcodebuild test -scheme English-words -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:English-wordsTests/SpecificTestClass

# 运行 UI 测试
xcodebuild test -scheme English-words -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:English-wordsUITests
```

## 项目架构

### 核心架构设计

**应用入口流程**
1. `English_wordsApp` (@main) → 应用入口点，创建 WindowGroup
2. `ContentView` → 根视图控制器，管理认证状态和界面导航
   - 未登录: 显示 `LoginView`
   - 已登录: 显示主应用界面（待实现）

**组件化架构**
- **可复用 UI 组件** (`Views/Components/`)
  - `CustomTextField`: 带图标和渐变边框的输入框
  - `GradientButton`: 渐变背景按钮，支持多种样式
  - `GradientBackground`: 渐变背景容器视图
  
- **认证视图** (`Views/Auth/`)
  - `LoginView`: 登录界面，包含 Lottie 动画
  - `RegisterView`: 注册界面

- **动画系统** (`Animations/`)
  - `LottieView`: Lottie 动画的 SwiftUI 封装
  - `LottieAnimationManager`: 动画资源管理和配置

**资源管理策略**
- `AppColors`: 定义所有颜色常量，支持深浅模式
- `AppStrings`: 所有文字常量，便于国际化
- `ImageAssets`: 图片资源管理

## 核心功能模块（规划中）

根据需求文档，应用将包含以下核心模块：

1. **AI 翻译模块**: 集成百度翻译 API
2. **生词本管理**: 单词存储与状态管理
3. **复习系统**: 基于艾宾浩斯曲线的 8 个复习时间点
4. **学习流程**: 词义记忆 → 拼写练习 → 造句练习
5. **用户统计**: 学习进度追踪

## 开发注意事项

### SwiftUI 状态管理模式
- **局部状态**: 使用 `@State` 管理视图内部状态
- **数据传递**: 使用 `@Binding` 在父子视图间双向绑定
- **对象观察**: 使用 `@StateObject`/`@ObservedObject` 管理复杂状态对象
- **环境共享**: 使用 `@EnvironmentObject` 跨层级共享数据

### 组件开发约定
- 所有自定义视图组件必须使用 `AppColors` 中的颜色定义
- 文字内容统一从 `AppStrings` 获取，禁止硬编码
- 新组件遵循现有命名模式：`CustomXXX`、`GradientXXX`
- 复杂视图使用 `extension` 和计算属性拆分，保持 body 简洁

### Lottie 动画集成
- 动画文件存放在项目 Bundle 中
- 通过 `LottieAnimationManager` 统一管理动画配置
- 使用 `LottieView` 封装来保持 SwiftUI 风格

## 关键实现要点

### 数据持久化方案
- iOS 18.5 支持 SwiftData，推荐使用 SwiftData 而非 Core Data
- 需要设计的核心数据模型：Word、ReviewRecord、UserProgress

### 艾宾浩斯复习算法实现
复习时间点（从首次学习开始）：
- 5分钟、30分钟、12小时
- 1天、2天、4天、7天、15天

### API 集成考虑
- 百度翻译 API 需要在 Info.plist 配置 App Transport Security
- 建议使用 URLSession 和 async/await 进行网络请求

### 项目依赖管理
- 当前通过 Swift Package Manager 管理 Lottie
- 添加新依赖时使用 Xcode 的 Package Dependencies 界面