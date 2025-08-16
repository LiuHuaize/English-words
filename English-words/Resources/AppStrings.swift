//
//  AppStrings.swift
//  English-words
//
//  Created by 刘怀泽 on 16/8/2025.
//

import Foundation

enum AppStrings {
    enum General {
        static let appTitle = "懒人记单词"
        static let appSubtitle = "让学习变得简单有趣"
    }
    
    enum Login {
        static let usernamePlaceholder = "请输入用户名"
        static let passwordPlaceholder = "请输入密码"
        static let loginButton = "登录"
        static let noAccount = "还没有账号？"
        static let register = "立即注册"
        static let agreementPrefix = "我已阅读并同意"
        static let userAgreement = "《用户协议》"
        static let and = "和"
        static let privacyPolicy = "《隐私政策》"
        static let agreementReminder = "请先同意用户协议和隐私政策"
    }
    
    enum Register {
        static let title = "创建新账户"
        static let subtitle = "开始你的学习之旅"
        static let usernamePlaceholder = "请输入用户名"
        static let passwordPlaceholder = "请输入密码"
        static let confirmPasswordPlaceholder = "请确认密码"
        static let registerButton = "注册"
        static let alreadyHaveAccount = "已有账号？"
        static let goToLogin = "去登录"
        static let passwordMismatch = "两次输入的密码不一致"
        static let emptyFields = "请填写所有必填字段"
        static let passwordRequirement = "密码至少需要6位"
    }
}