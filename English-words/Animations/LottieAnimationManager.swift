//
//  LottieAnimationManager.swift
//  English-words
//
//  Created on 16/8/2025.
//

import SwiftUI

// 动画文件枚举，集中管理所有 Lottie 动画资源
enum LottieAnimation: String, CaseIterable {
    // 学习相关动画
    case girlStudyingOnLaptop = "Girl_Studying_on_Laptop"
    
    // 登录注册相关动画
    case loginAnimation = "login_animation"
    case welcomeAnimation = "welcome_animation"
    
    // 成功/失败状态动画
    case successAnimation = "success_animation"
    case errorAnimation = "error_animation"
    
    // 加载动画
    case loadingAnimation = "loading_animation"
    
    // 空状态动画
    case emptyStateAnimation = "empty_state_animation"
    
    // 获取动画文件路径
    var fileName: String {
        return self.rawValue
    }
    
    // 获取动画的默认配置
    var defaultConfiguration: AnimationConfiguration {
        switch self {
        case .girlStudyingOnLaptop, .loginAnimation, .welcomeAnimation:
            return AnimationConfiguration(
                loopMode: .loop,
                animationSpeed: 1.0,
                contentMode: .scaleAspectFit
            )
        case .successAnimation, .errorAnimation:
            return AnimationConfiguration(
                loopMode: .playOnce,
                animationSpeed: 1.2,
                contentMode: .scaleAspectFit
            )
        case .loadingAnimation:
            return AnimationConfiguration(
                loopMode: .loop,
                animationSpeed: 1.5,
                contentMode: .scaleAspectFit
            )
        case .emptyStateAnimation:
            return AnimationConfiguration(
                loopMode: .loop,
                animationSpeed: 0.8,
                contentMode: .scaleAspectFit
            )
        }
    }
    
    // 获取动画的推荐尺寸
    var recommendedSize: CGSize {
        switch self {
        case .girlStudyingOnLaptop, .loginAnimation, .welcomeAnimation:
            return CGSize(width: 200, height: 200)
        case .successAnimation, .errorAnimation:
            return CGSize(width: 120, height: 120)
        case .loadingAnimation:
            return CGSize(width: 80, height: 80)
        case .emptyStateAnimation:
            return CGSize(width: 250, height: 250)
        }
    }
}

// 动画配置结构体
struct AnimationConfiguration {
    enum LoopMode {
        case playOnce
        case loop
        case autoReverse
        case repeatCount(Float)
    }
    
    let loopMode: LoopMode
    let animationSpeed: Double
    let contentMode: ContentMode
    
    enum ContentMode {
        case scaleToFill
        case scaleAspectFit
        case scaleAspectFill
    }
}

// Lottie 动画管理器
class LottieAnimationManager {
    static let shared = LottieAnimationManager()
    
    private init() {}
    
    // 检查动画文件是否存在
    func animationExists(_ animation: LottieAnimation) -> Bool {
        let animationPath = getAnimationPath(for: animation)
        return FileManager.default.fileExists(atPath: animationPath)
    }
    
    // 获取动画文件的完整路径
    func getAnimationPath(for animation: LottieAnimation) -> String {
        // 首先尝试从 Bundle 中获取
        if let bundlePath = Bundle.main.path(forResource: animation.fileName, ofType: "json") {
            return bundlePath
        }
        
        // 如果 Bundle 中没有，尝试从项目的 Animations 文件夹获取
        let animationsPath = "/Users/liuhuaize/Desktop/English-words/English-words/Animations/\(animation.fileName).json"
        if FileManager.default.fileExists(atPath: animationsPath) {
            return animationsPath
        }
        
        // 返回 Bundle 中的路径作为默认值
        return animation.fileName
    }
    
    // 获取所有可用的动画
    func getAvailableAnimations() -> [LottieAnimation] {
        return LottieAnimation.allCases.filter { animationExists($0) }
    }
    
    // 预加载动画（可选，用于性能优化）
    func preloadAnimation(_ animation: LottieAnimation) {
        // 这里可以实现预加载逻辑
        // 例如：将动画文件加载到内存缓存中
    }
    
    // 批量预加载动画
    func preloadAnimations(_ animations: [LottieAnimation]) {
        animations.forEach { preloadAnimation($0) }
    }
}