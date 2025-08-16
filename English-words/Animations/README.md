# Lottie 动画管理系统

## 文件结构
```
Animations/
├── README.md                    # 本文档
├── LottieAnimationManager.swift # 动画管理器
├── LottieView.swift            # 通用 Lottie 视图组件
└── *.json                      # Lottie 动画文件
```

## Lottie 库集成注意事项

### ⚠️ 重要：避免链接冲突
- **只选择 Lottie 产品**，不要选择 Lottie-Dynamic
- 两者的区别：
  - `Lottie`：静态库，推荐用于单个 App Target
  - `Lottie-Dynamic`：动态库，适用于多个 Target 共享

### 正确的集成步骤
1. 通过 Swift Package Manager 添加：`https://github.com/airbnb/lottie-ios`
2. 版本：4.4.0 或更高
3. 产品选择：**只勾选 Lottie**

## 使用方法

### 添加新动画
1. 将 `.json` 文件放入此 `Animations` 文件夹
2. 在 `LottieAnimationManager.swift` 的 `LottieAnimation` 枚举中添加新 case
3. 配置动画的默认参数

### 在视图中使用
```swift
// 基础用法
LottieView(animation: .girlStudyingOnLaptop)
    .frame(width: 200, height: 200)

// 自定义配置
LottieView(
    animation: .loadingAnimation,
    configuration: AnimationConfiguration(
        loopMode: .loop,
        animationSpeed: 1.5,
        contentMode: .scaleAspectFit
    )
)
```

## 动画文件列表
- `Girl_Studying_on_Laptop.json` - 学习场景动画（登录界面使用）

## 故障排除

### 编译错误：找不到 Lottie-Dynamic
- 原因：同时链接了 Lottie 和 Lottie-Dynamic
- 解决：移除包依赖，重新添加时只选择 Lottie

### 动画不显示
- 检查 `.json` 文件是否存在于 Animations 文件夹
- 确认文件名在 `LottieAnimation` 枚举中正确配置
- 验证 Lottie 库已正确集成（import Lottie 不报错）