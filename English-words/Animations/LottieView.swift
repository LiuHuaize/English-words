//
//  LottieView.swift
//  English-words
//
//  Created on 16/8/2025.
//

import SwiftUI
import UIKit
import Lottie

// 通用的 Lottie 动画视图
struct LottieView: View {
    let animation: LottieAnimation
    let configuration: AnimationConfiguration?
    @State private var isAnimating: Bool = false
    
    // 便利初始化方法，使用默认配置
    init(animation: LottieAnimation) {
        self.animation = animation
        self.configuration = nil
    }
    
    // 完整初始化方法，自定义配置
    init(animation: LottieAnimation, configuration: AnimationConfiguration) {
        self.animation = animation
        self.configuration = configuration
    }
    
    var body: some View {
        LottieAnimationViewRepresentable(
            animation: animation,
            configuration: configuration ?? animation.defaultConfiguration
        )
    }
}

// UIViewRepresentable 包装器，用于在 SwiftUI 中使用 Lottie
struct LottieAnimationViewRepresentable: UIViewRepresentable {
    let animation: LottieAnimation
    let configuration: AnimationConfiguration
    
    func makeUIView(context: Context) -> LottieAnimationView {
        let animationView = LottieAnimationView()
        
        // 从文件路径加载动画
        let animationPath = LottieAnimationManager.shared.getAnimationPath(for: animation)
        
        // 尝试不同的加载方式
        if animationPath.hasSuffix(".json") && FileManager.default.fileExists(atPath: animationPath) {
            // 从文件路径加载
            animationView.animation = Lottie.LottieAnimation.filepath(animationPath)
        } else {
            // 从 Bundle 加载
            animationView.animation = Lottie.LottieAnimation.named(animation.fileName)
        }
        
        // 应用配置
        switch configuration.loopMode {
        case .playOnce:
            animationView.loopMode = .playOnce
        case .loop:
            animationView.loopMode = .loop
        case .autoReverse:
            animationView.loopMode = .autoReverse
        case .repeatCount(let count):
            animationView.loopMode = .repeat(count)
        }
        
        animationView.animationSpeed = CGFloat(configuration.animationSpeed)
        
        switch configuration.contentMode {
        case .scaleToFill:
            animationView.contentMode = .scaleToFill
        case .scaleAspectFit:
            animationView.contentMode = .scaleAspectFit
        case .scaleAspectFill:
            animationView.contentMode = .scaleAspectFill
        }
        
        // 开始播放动画
        animationView.play()
        
        return animationView
    }
    
    func updateUIView(_ uiView: LottieAnimationView, context: Context) {
        // 如果需要，可以在这里更新动画状态
    }
}


// 便利视图修饰符
extension View {
    func withLottieAnimation(_ animation: LottieAnimation, size: CGSize? = nil) -> some View {
        self.overlay(
            LottieView(animation: animation)
                .frame(
                    width: size?.width ?? animation.recommendedSize.width,
                    height: size?.height ?? animation.recommendedSize.height
                )
                .allowsHitTesting(false)
        )
    }
}

// 预览
#if DEBUG
struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            // 简单的预览占位符，避免预览时的编译问题
            Text("Lottie Animation Preview")
                .font(.title2)
                .foregroundColor(.gray)
            
            Text("Girl Studying Animation")
                .frame(width: 200, height: 200)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
        }
        .padding()
    }
}
#endif