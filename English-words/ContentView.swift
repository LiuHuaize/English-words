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
    
    // 定义所有的文本常量
    let appTitle = "懒人记单词"
    let usernamePlaceholder = "请输入用户名"
    let passwordPlaceholder = "请输入密码"
    let loginButtonText = "登录"
    let noAccountText = "还没有账号？"
    let registerText = "立即注册"
    let agreementText = "我已阅读并同意"
    let userAgreementText = "《用户协议》"
    let andText = "和"
    let privacyPolicyText = "《隐私政策》"
    
    var body: some View {
        ZStack {
            // 背景颜色
            #if os(iOS)
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            #else
            Color(NSColor.windowBackgroundColor)
                .ignoresSafeArea()
            #endif
            
            ScrollView {
                VStack(spacing: 0) {
                    // 顶部导航标题
                    Text(appTitle)
                        .font(.system(size: 34, weight: .bold))
                        .padding(.top, 60)
                        .padding(.bottom, 50)
                    
                    // 中间内容区域容器
                    VStack(spacing: 20) {
                        // 插画图片容器
                        Group {
                            // 方式1: 从Assets.xcassets加载（推荐）
                            if let _ = UIImage(named: "reading") {
                                Image("reading")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                            }
                            // 方式2: 从文件路径加载
                            else if let uiImage = UIImage(contentsOfFile: "/Users/liuhuaize/Desktop/English-words/image/reading.png") {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                            }
                            // 方式3: 使用自定义绘制的备用插画
                            else {
                                ImageAssets.getReadingIllustration()
                            }
                        }
                        .padding(.bottom, 20)
                        
                        // 输入框容器
                        VStack(spacing: 15) {
                            // 用户名输入框
                            TextField(usernamePlaceholder, text: $username)
                                .padding()
                                .frame(height: 50)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
                                )
                                .font(.system(size: 16))
                            
                            // 密码输入框
                            SecureField(passwordPlaceholder, text: $password)
                                .padding()
                                .frame(height: 50)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
                                )
                                .font(.system(size: 16))
                        }
                        
                        // 登录按钮
                        Button(action: {
                            // TODO: 实现登录功能
                            print("Login button tapped")
                        }) {
                            Text(loginButtonText)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(10)
                                .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 3)
                        }
                        .padding(.top, 10)
                        
                        // 注册链接
                        HStack {
                            Text(noAccountText)
                                .foregroundColor(Color.gray)
                                .font(.system(size: 14))
                            Button(action: {
                                // TODO: 实现跳转到注册页面
                                print("Register button tapped")
                            }) {
                                Text(registerText)
                                    .foregroundColor(.blue)
                                    .font(.system(size: 14))
                            }
                        }
                        .padding(.top, 5)
                    }
                    .frame(maxWidth: 500) // 固定最大宽度
                    .padding(.horizontal, 30)
                    
                    Spacer(minLength: 50)
                    
                    // 底部用户协议和隐私政策
                    VStack(spacing: 10) {
                        HStack(spacing: 5) {
                            Button(action: {
                                isAgreed.toggle()
                            }) {
                                Image(systemName: isAgreed ? "checkmark.square.fill" : "square")
                                    .foregroundColor(isAgreed ? .blue : Color.gray.opacity(0.5))
                                    .font(.system(size: 18))
                            }
                            
                            Text(agreementText)
                                .font(.system(size: 12))
                                .foregroundColor(Color.gray)
                            
                            Button(action: {
                                // TODO: 打开用户协议
                                print("User agreement tapped")
                            }) {
                                Text(userAgreementText)
                                    .font(.system(size: 12))
                                    .foregroundColor(.blue)
                            }
                            
                            Text(andText)
                                .font(.system(size: 12))
                                .foregroundColor(Color.gray)
                            
                            Button(action: {
                                // TODO: 打开隐私政策
                                print("Privacy policy tapped")
                            }) {
                                Text(privacyPolicyText)
                                    .font(.system(size: 12))
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}


