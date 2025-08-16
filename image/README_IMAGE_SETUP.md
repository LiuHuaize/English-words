# 图片配置指南

## 将reading.png添加到Xcode项目

### 方法1: 添加到Assets.xcassets（推荐）

1. **打开Xcode项目**
2. **找到Assets.xcassets文件**（在项目导航器中）
3. **拖拽reading.png到Assets.xcassets**
   - 或者右键点击Assets.xcassets空白处
   - 选择"Import..."
   - 选择reading.png文件
4. **重命名资源**（如果需要）
   - 单击导入的图片资源
   - 在右侧检查器中修改名称为"reading"
5. **设置图片属性**（可选）
   - Render As: Default
   - Scales: 可以提供1x, 2x, 3x版本

### 方法2: 添加到项目Bundle

1. **在Xcode中右键点击项目文件夹**
2. **选择"Add Files to 'English-words'..."**
3. **选择reading.png文件**
4. **确保勾选以下选项：**
   - ✅ Copy items if needed
   - ✅ Add to targets: English-words
5. **点击"Add"**

### 当前代码支持的加载方式

代码已经配置了三种加载方式，会按顺序尝试：

1. **从Assets.xcassets加载**（性能最佳）
   ```swift
   Image("reading")
   ```

2. **从文件路径加载**（当前可用）
   ```swift
   UIImage(contentsOfFile: "/Users/liuhuaize/Desktop/English-words/image/reading.png")
   ```

3. **使用自定义绘制的备用插画**（后备方案）

## 注意事项

- 使用Assets.xcassets可以获得更好的性能和内存管理
- Assets中的图片支持自动的暗黑模式适配
- 建议提供@2x和@3x版本的图片以支持不同分辨率的设备
- 当前PNG图片尺寸适合作为@2x版本使用

## 图片优化建议

- 当前图片可以正常使用
- 如需优化，可以：
  - 使用ImageOptim等工具压缩PNG文件大小
  - 创建多个分辨率版本（1x: 200x200, 2x: 400x400, 3x: 600x600）