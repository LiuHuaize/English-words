//
//  LoginView.swift
//  English-words
//
//  Created by 刘怀泽 on 16/8/2025.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isAgreed: Bool = false
    @State private var isPasswordVisible: Bool = false
    @State private var showRegisterView: Bool = false
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular && verticalSizeClass == .regular
    }
    
    private var maxContentWidth: CGFloat {
        isIPad ? 600 : 380
    }
    
    private var animationSize: CGFloat {
        isIPad ? 350 : 200
    }
    
    private var animationScale: CGFloat {
        isIPad ? 0.8 : 0.6
    }
    
    private var titleFontSize: CGFloat {
        isIPad ? 48 : 36
    }
    
    private var subtitleFontSize: CGFloat {
        isIPad ? 18 : 14
    }
    
    private var topPadding: CGFloat {
        isIPad ? 100 : 50
    }
    
    var body: some View {
        ZStack {
            GradientBackground()
            
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 0) {
                        headerSection
                        
                        // 动态调整动画容器高度
                        ZStack {
                            Color.clear
                                .frame(height: animationSize * animationScale * 1.1)
                            
                            animationSection
                        }
                        
                        VStack(spacing: isIPad ? 35 : 25) {
                            inputSection
                            loginButton
                            registerLink
                        }
                        .frame(maxWidth: maxContentWidth)
                        .padding(.horizontal, isIPad ? 40 : 24)
                        .padding(.top, isIPad ? 30 : 20)
                        
                        Spacer(minLength: isIPad ? 60 : 40)
                        
                        agreementSection
                    }
                    .frame(minHeight: geometry.size.height)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .onTapGesture {
            dismissKeyboard()
        }
        .sheet(isPresented: $showRegisterView) {
            RegisterView(isPresented: $showRegisterView)
        }
    }
    
    private var headerSection: some View {
        VStack(spacing: isIPad ? 12 : 8) {
            Text(AppStrings.General.appTitle)
                .font(.system(size: titleFontSize, weight: .bold, design: .rounded))
                .foregroundColor(AppColors.primary)
                .shadow(color: AppColors.primary.opacity(0.2), radius: 2, x: 0, y: 2)
            
            Text(AppStrings.General.appSubtitle)
                .font(.system(size: subtitleFontSize, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
                .opacity(0.8)
        }
        .padding(.top, topPadding)
        .padding(.bottom, isIPad ? 40 : 30)
    }
    
    private var animationSection: some View {
        LottieView(animation: .girlStudyingOnLaptop)
            .frame(width: animationSize, height: animationSize)
            .scaleEffect(animationScale)
    }
    
    private var inputSection: some View {
        VStack(spacing: isIPad ? 20 : 16) {
            CustomTextField(
                icon: "person.fill",
                placeholder: AppStrings.Login.usernamePlaceholder,
                text: $username
            )
            
            CustomTextField(
                icon: "lock.fill",
                placeholder: AppStrings.Login.passwordPlaceholder,
                text: $password,
                isSecure: true,
                isSecureVisible: $isPasswordVisible
            )
        }
    }
    
    private var loginButton: some View {
        GradientButton(
            title: AppStrings.Login.loginButton,
            icon: "arrow.right.circle.fill",
            isEnabled: isAgreed,
            action: {
                handleLogin()
            }
        )
    }
    
    private var registerLink: some View {
        HStack(spacing: 4) {
            Text(AppStrings.Login.noAccount)
                .foregroundColor(AppColors.textSecondary.opacity(0.8))
                .font(.system(size: isIPad ? 16 : 14))
            
            Button(action: {
                showRegisterView = true
            }) {
                Text(AppStrings.Login.register)
                    .foregroundColor(AppColors.primary)
                    .font(.system(size: isIPad ? 16 : 14, weight: .semibold))
                    .underline()
            }
        }
        .padding(.top, isIPad ? 8 : 5)
    }
    
    private var agreementSection: some View {
        VStack(spacing: isIPad ? 16 : 12) {
            HStack(spacing: isIPad ? 8 : 6) {
                agreementCheckbox
                
                Text(AppStrings.Login.agreementPrefix)
                    .font(.system(size: isIPad ? 14 : 12))
                    .foregroundColor(AppColors.textSecondary.opacity(0.7))
                
                Button(action: openUserAgreement) {
                    Text(AppStrings.Login.userAgreement)
                        .font(.system(size: isIPad ? 14 : 12))
                        .foregroundColor(AppColors.primary)
                }
                
                Text(AppStrings.Login.and)
                    .font(.system(size: isIPad ? 14 : 12))
                    .foregroundColor(AppColors.textSecondary.opacity(0.7))
                
                Button(action: openPrivacyPolicy) {
                    Text(AppStrings.Login.privacyPolicy)
                        .font(.system(size: isIPad ? 14 : 12))
                        .foregroundColor(AppColors.primary)
                }
            }
            
            if !isAgreed {
                Text(AppStrings.Login.agreementReminder)
                    .font(.system(size: isIPad ? 13 : 11))
                    .foregroundColor(AppColors.accent)
                    .transition(.opacity)
            }
        }
        .padding(.bottom, isIPad ? 50 : 30)
        .animation(.easeInOut, value: isAgreed)
    }
    
    private var agreementCheckbox: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                isAgreed.toggle()
            }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(isAgreed ? AppColors.primary : Color.clear)
                    .frame(width: isIPad ? 24 : 20, height: isIPad ? 24 : 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(isAgreed ? AppColors.primary : AppColors.borderLight, lineWidth: 1.5)
                    )
                
                if isAgreed {
                    Image(systemName: "checkmark")
                        .font(.system(size: isIPad ? 14 : 12, weight: .bold))
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    private func handleLogin() {
        print("Login with username: \(username)")
        // TODO: 实现登录逻辑
    }
    
    private func openUserAgreement() {
        print("Open user agreement")
        // TODO: 打开用户协议
    }
    
    private func openPrivacyPolicy() {
        print("Open privacy policy")
        // TODO: 打开隐私政策
    }
    
    private func dismissKeyboard() {
        // 使用 SwiftUI 的方式隐藏键盘
    }
}