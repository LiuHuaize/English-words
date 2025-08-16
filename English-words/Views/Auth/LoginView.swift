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
    
    var body: some View {
        ZStack {
            GradientBackground()
            
            ScrollView {
                VStack(spacing: 0) {
                    headerSection
                    
                    // 使用固定高度的容器包裹动画，防止缩放影响布局
                    ZStack {
                        Color.clear
                            .frame(height: 130) // 调整容器高度以适应更小的动画
                        
                        animationSection
                    }
                    
                    VStack(spacing: 25) {
                        inputSection
                        loginButton
                        registerLink
                    }
                    .frame(maxWidth: 380)
                    .padding(.horizontal, 24)
                    .padding(.top, 20) // 添加顶部间距
                    
                    Spacer(minLength: 40)
                    
                    agreementSection
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
        VStack(spacing: 8) {
            Text(AppStrings.General.appTitle)
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundColor(AppColors.primary)
                .shadow(color: AppColors.primary.opacity(0.2), radius: 2, x: 0, y: 2)
            
            Text(AppStrings.General.appSubtitle)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
                .opacity(0.8)
        }
        .padding(.top, 50)
        .padding(.bottom, 30)
    }
    
    private var animationSection: some View {
        LottieView(animation: .girlStudyingOnLaptop)
            .frame(width: 200, height: 200) // 保持原始尺寸用于布局
            .scaleEffect(0.6) // 缩小到60%，更小巧精致
    }
    
    private var inputSection: some View {
        VStack(spacing: 16) {
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
                .font(.system(size: 14))
            
            Button(action: {
                showRegisterView = true
            }) {
                Text(AppStrings.Login.register)
                    .foregroundColor(AppColors.primary)
                    .font(.system(size: 14, weight: .semibold))
                    .underline()
            }
        }
        .padding(.top, 5)
    }
    
    private var agreementSection: some View {
        VStack(spacing: 12) {
            HStack(spacing: 6) {
                agreementCheckbox
                
                Text(AppStrings.Login.agreementPrefix)
                    .font(.system(size: 12))
                    .foregroundColor(AppColors.textSecondary.opacity(0.7))
                
                Button(action: openUserAgreement) {
                    Text(AppStrings.Login.userAgreement)
                        .font(.system(size: 12))
                        .foregroundColor(AppColors.primary)
                }
                
                Text(AppStrings.Login.and)
                    .font(.system(size: 12))
                    .foregroundColor(AppColors.textSecondary.opacity(0.7))
                
                Button(action: openPrivacyPolicy) {
                    Text(AppStrings.Login.privacyPolicy)
                        .font(.system(size: 12))
                        .foregroundColor(AppColors.primary)
                }
            }
            
            if !isAgreed {
                Text(AppStrings.Login.agreementReminder)
                    .font(.system(size: 11))
                    .foregroundColor(AppColors.accent)
                    .transition(.opacity)
            }
        }
        .padding(.bottom, 30)
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
                    .frame(width: 20, height: 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(isAgreed ? AppColors.primary : AppColors.borderLight, lineWidth: 1.5)
                    )
                
                if isAgreed {
                    Image(systemName: "checkmark")
                        .font(.system(size: 12, weight: .bold))
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
        #if os(iOS)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #endif
    }
}