//
//  ImageAssets.swift
//  English-words
//
//  图片资源管理文件
//

import SwiftUI

struct ImageAssets {
    // SVG图片路径说明
    // 注意：iOS不直接支持SVG格式，需要：
    // 1. 使用在线工具(如 https://cloudconvert.com/svg-to-png) 将SVG转换为PNG
    // 2. 或使用第三方库如 SVGKit
    // 3. 或在Xcode中使用PDF格式（从SVG导出）
    
    static let readingImagePath = "/Users/liuhuaize/Desktop/English-words/image/reading.svg"
    
    // 临时的插画视图组件
    // 使用自定义绘制来模拟阅读插画的效果
    static func getReadingIllustration() -> some View {
        ZStack {
            // 背景装饰
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.4, green: 0.39, blue: 1.0).opacity(0.1),
                            Color(red: 0.58, green: 0.39, blue: 1.0).opacity(0.05)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 220, height: 220)
                .blur(radius: 30)
                .offset(x: -20, y: -10)
            
            // 主要图形元素 - 模拟阅读场景
            VStack(spacing: 15) {
                // 书本图标
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 0.4, green: 0.39, blue: 1.0))
                        .frame(width: 80, height: 100)
                        .rotationEffect(.degrees(-5))
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .frame(width: 76, height: 96)
                        .rotationEffect(.degrees(-5))
                    
                    VStack(spacing: 4) {
                        ForEach(0..<4) { _ in
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 60, height: 2)
                        }
                    }
                    .rotationEffect(.degrees(-5))
                }
                
                // 人物轮廓
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 0.4, green: 0.39, blue: 1.0),
                                Color(red: 0.58, green: 0.39, blue: 1.0)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                
                Text("开始学习")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(red: 0.4, green: 0.39, blue: 1.0))
            }
            .padding(30)
            .background(
                Circle()
                    .fill(Color.white)
                    .shadow(color: Color.gray.opacity(0.15), radius: 20, x: 0, y: 8)
            )
        }
        .frame(width: 200, height: 200)
    }
}

// 图片转换说明视图
struct ImageConversionGuide: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("SVG图片使用指南")
                .font(.headline)
            
            Text("方法1: 转换为PNG")
                .font(.subheadline)
                .fontWeight(.semibold)
            
            Text("1. 访问 https://cloudconvert.com/svg-to-png")
            Text("2. 上传 reading.svg 文件")
            Text("3. 设置输出尺寸为 2x 或 3x (如 400x400)")
            Text("4. 下载PNG文件")
            Text("5. 将PNG拖入 Assets.xcassets")
            
            Text("方法2: 使用矢量PDF")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.top)
            
            Text("1. 使用 Adobe Illustrator 或 Inkscape 打开SVG")
            Text("2. 导出为PDF格式")
            Text("3. 在Assets中设置为 'Preserve Vector Data'")
            
            Text("方法3: 使用第三方库")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.top)
            
            Text("1. 添加 SVGKit 到项目依赖")
            Text("2. import SVGKit")
            Text("3. 使用 SVGKImage 加载SVG文件")
        }
        .padding()
        .font(.caption)
    }
}