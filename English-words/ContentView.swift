//
//  ContentView.swift
//  English-words
//
//  Created by 刘怀泽 on 16/8/2025.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// 用于检测图片是否存在的扩展
#if os(iOS)
extension UIImage {
    static func imageExists(named name: String) -> Bool {
        return UIImage(named: name) != nil
    }
}
#endif

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isAgreed: Bool = false
    @State private var isPasswordVisible: Bool = false
    @State private var showRegisterView: Bool = false
    
    // 定义所有的文本常量
    let appTitle = "懒人记单词"
    let appSubtitle = "让学习变得简单有趣"
    let usernamePlaceholder = "请输入用户名"
    let passwordPlaceholder = "请输入密码"
    let loginButtonText = "登录"
    let noAccountText = "还没有账号？"
    let registerText = "立即注册"
    let agreementText = "我已阅读并同意"
    let userAgreementText = "《用户协议》"
    let andText = "和"
    let privacyPolicyText = "《隐私政策》"
    
    // 定义颜色方案
    let primaryColor = Color(red: 0.25, green: 0.47, blue: 0.99) // 主题蓝色
    let secondaryColor = Color(red: 0.45, green: 0.65, blue: 1.0) // 浅蓝色
    let accentColor = Color(red: 0.96, green: 0.56, blue: 0.35) // 橙色点缀
    let backgroundColor = Color(red: 0.97, green: 0.98, blue: 1.0) // 淡蓝灰背景
    
    var body: some View {
        ZStack {
            // 渐变背景
            LinearGradient(
                gradient: Gradient(colors: [
                    backgroundColor,
                    Color.white,
                    backgroundColor.opacity(0.3)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // 装饰性圆形背景
            GeometryReader { geometry in
                Circle()
                    .fill(primaryColor.opacity(0.05))
                    .frame(width: geometry.size.width * 1.2, height: geometry.size.width * 1.2)
                    .position(x: geometry.size.width * 0.1, y: -geometry.size.width * 0.2)
                
                Circle()
                    .fill(secondaryColor.opacity(0.03))
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.8)
                    .position(x: geometry.size.width * 0.9, y: geometry.size.height * 1.1)
            }
            
            ScrollView {
                VStack(spacing: 0) {
                    // 顶部标题区域
                    VStack(spacing: 8) {
                        Text(appTitle)
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundColor(primaryColor)
                            .shadow(color: primaryColor.opacity(0.2), radius: 2, x: 0, y: 2)
                        
                        Text(appSubtitle)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.gray)
                            .opacity(0.8)
                    }
                    .padding(.top, 50)
                    .padding(.bottom, 30)
                    
                    // 主要内容卡片
                    VStack(spacing: 25) {
                        // Lottie 动画替代原有的静态图片
                        LottieView(animation: .girlStudyingOnLaptop)
                            .frame(width: 200, height: 200)
                            .padding(.vertical, 10)
                        
                        // 输入框区域（带图标的现代设计）
                        VStack(spacing: 16) {
                            // 用户名输入框
                            HStack(spacing: 12) {
                                Image(systemName: "person.fill")
                                    .foregroundColor(primaryColor.opacity(0.7))
                                    .font(.system(size: 18))
                                    .frame(width: 20)
                                
                                TextField(usernamePlaceholder, text: $username)
                                    .font(.system(size: 16))
                                    .foregroundColor(.primary)
                                
                                if !username.isEmpty {
                                    Button(action: {
                                        username = ""
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(Color.gray.opacity(0.5))
                                            .font(.system(size: 16))
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(username.isEmpty ? Color.clear : primaryColor.opacity(0.3), lineWidth: 1)
                            )
                            
                            // 密码输入框
                            HStack(spacing: 12) {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(primaryColor.opacity(0.7))
                                    .font(.system(size: 18))
                                    .frame(width: 20)
                                
                                if isPasswordVisible {
                                    TextField(passwordPlaceholder, text: $password)
                                        .font(.system(size: 16))
                                        .foregroundColor(.primary)
                                } else {
                                    SecureField(passwordPlaceholder, text: $password)
                                        .font(.system(size: 16))
                                        .foregroundColor(.primary)
                                }
                                
                                if !password.isEmpty {
                                    Button(action: {
                                        isPasswordVisible.toggle()
                                    }) {
                                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                            .foregroundColor(Color.gray.opacity(0.5))
                                            .font(.system(size: 16))
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(password.isEmpty ? Color.clear : primaryColor.opacity(0.3), lineWidth: 1)
                            )
                        }
                        
                        // 登录按钮（渐变效果）
                        Button(action: {
                            // TODO: 实现登录功能
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                // 添加按钮点击动画反馈
                            }
                            print("Login button tapped")
                        }) {
                            HStack {
                                Text(loginButtonText)
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.white)
                                
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white.opacity(0.9))
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [primaryColor, secondaryColor]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                            .shadow(color: primaryColor.opacity(0.3), radius: 12, x: 0, y: 6)
                        }
                        .scaleEffect(isAgreed ? 1.0 : 0.97)
                        .animation(.spring(response: 0.3), value: isAgreed)
                        .disabled(!isAgreed)
                        .opacity(isAgreed ? 1.0 : 0.6)
                        
                        // 注册链接（更优雅的设计）
                        HStack(spacing: 4) {
                            Text(noAccountText)
                                .foregroundColor(Color.gray.opacity(0.8))
                                .font(.system(size: 14))
                            
                            Button(action: {
                                showRegisterView = true
                            }) {
                                Text(registerText)
                                    .foregroundColor(primaryColor)
                                    .font(.system(size: 14, weight: .semibold))
                                    .underline()
                            }
                        }
                        .padding(.top, 5)
                    }
                    .frame(maxWidth: 380)
                    .padding(.horizontal, 24)
                    
                    Spacer(minLength: 40)
                    
                    // 底部协议区域（更紧凑的设计）
                    VStack(spacing: 12) {
                        HStack(spacing: 6) {
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    isAgreed.toggle()
                                }
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(isAgreed ? primaryColor : Color.clear)
                                        .frame(width: 20, height: 20)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 4)
                                                .stroke(isAgreed ? primaryColor : Color.gray.opacity(0.4), lineWidth: 1.5)
                                        )
                                    
                                    if isAgreed {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            
                            Text(agreementText)
                                .font(.system(size: 12))
                                .foregroundColor(Color.gray.opacity(0.7))
                            
                            Button(action: {
                                // TODO: 打开用户协议
                                print("User agreement tapped")
                            }) {
                                Text(userAgreementText)
                                    .font(.system(size: 12))
                                    .foregroundColor(primaryColor)
                            }
                            
                            Text(andText)
                                .font(.system(size: 12))
                                .foregroundColor(Color.gray.opacity(0.7))
                            
                            Button(action: {
                                // TODO: 打开隐私政策
                                print("Privacy policy tapped")
                            }) {
                                Text(privacyPolicyText)
                                    .font(.system(size: 12))
                                    .foregroundColor(primaryColor)
                            }
                        }
                        
                        if !isAgreed {
                            Text("请先同意用户协议和隐私政策")
                                .font(.system(size: 11))
                                .foregroundColor(accentColor)
                                .transition(.opacity)
                        }
                    }
                    .padding(.bottom, 30)
                    .animation(.easeInOut, value: isAgreed)
                }
            }
        }
        .onTapGesture {
            // 点击空白处收起键盘
            #if os(iOS)
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            #endif
        }
        .sheet(isPresented: $showRegisterView) {
            RegisterView(isPresented: $showRegisterView)
        }
    }
}

#Preview {
    ContentView()
}