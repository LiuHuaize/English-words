//
//  RegisterView.swift
//  English-words
//
//  Created by 刘怀泽 on 16/8/2025.
//

import SwiftUI

struct RegisterView: View {
    @Binding var isPresented: Bool
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false
    @State private var isRegistering: Bool = false
    @State private var statusMessage: String = ""
    @State private var showStatusMessage: Bool = false
    @State private var isStatusSuccess: Bool = false
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular && verticalSizeClass == .regular
    }
    
    private var maxContentWidth: CGFloat {
        isIPad ? 600 : 380
    }
    
    var passwordsMatch: Bool {
        !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword
    }
    
    var passwordsDontMatch: Bool {
        !confirmPassword.isEmpty && password != confirmPassword
    }
    
    var canRegister: Bool {
        !username.isEmpty && 
        password.count >= 6 && 
        passwordsMatch
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                GradientBackground()
                
                ScrollView {
                    VStack(spacing: isIPad ? 30 : 25) {
                        headerSection
                        
                        // 统一的状态提示信息
                        if showStatusMessage {
                            HStack(spacing: 8) {
                                Image(systemName: isStatusSuccess ? "checkmark.circle.fill" : "exclamationmark.circle.fill")
                                    .font(.system(size: isIPad ? 16 : 14))
                                Text(statusMessage)
                                    .font(.system(size: 14, weight: .medium))
                            }
                            .foregroundColor(isStatusSuccess ? .green : AppColors.accent)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(isStatusSuccess ? Color.green.opacity(0.1) : AppColors.accent.opacity(0.1))
                            )
                            .transition(.scale.combined(with: .opacity))
                        }
                        
                        inputSection
                        passwordValidation
                        registerButton
                        loginLink
                    }
                    .padding(.horizontal, isIPad ? 40 : 20)
                    .frame(maxWidth: maxContentWidth)
                }
            }
            .navigationBarItems(
                leading: closeButton
            )
        }
    }
    
    private var headerSection: some View {
        VStack(spacing: isIPad ? 12 : 8) {
            Image(systemName: "person.badge.plus.fill")
                .font(.system(size: isIPad ? 80 : 60))
                .foregroundColor(AppColors.primary)
                .padding(.top, isIPad ? 30 : 20)
            
            Text(AppStrings.Register.title)
                .font(.system(size: isIPad ? 36 : 28, weight: .bold, design: .rounded))
                .foregroundColor(AppColors.primary)
            
            Text(AppStrings.Register.subtitle)
                .font(.system(size: isIPad ? 18 : 14, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
                .opacity(0.8)
        }
        .padding(.top, isIPad ? 30 : 20)
        .padding(.bottom, isIPad ? 30 : 20)
    }
    
    private var inputSection: some View {
        VStack(spacing: isIPad ? 24 : 20) {
            CustomTextField(
                icon: "person.fill",
                placeholder: AppStrings.Register.usernamePlaceholder,
                text: $username
            )
            
            CustomTextField(
                icon: "lock.fill",
                placeholder: AppStrings.Register.passwordPlaceholder,
                text: $password,
                isSecure: true,
                isSecureVisible: $isPasswordVisible
            )
            
            VStack(alignment: .leading, spacing: 4) {
                CustomTextField(
                    icon: "lock.fill",
                    placeholder: AppStrings.Register.confirmPasswordPlaceholder,
                    text: $confirmPassword,
                    isSecure: true,
                    isSecureVisible: $isConfirmPasswordVisible
                )
                
                if passwordsDontMatch {
                    HStack(spacing: 4) {
                        Image(systemName: "exclamationmark.circle.fill")
                            .font(.system(size: 12))
                        Text(AppStrings.Register.passwordMismatch)
                            .font(.system(size: 12))
                    }
                    .foregroundColor(AppColors.accent)
                    .padding(.horizontal, 16)
                    .transition(.opacity)
                }
            }
        }
    }
    
    private var passwordValidation: some View {
        Group {
            if password.count > 0 && password.count < 6 {
                Text(AppStrings.Register.passwordRequirement)
                    .font(.system(size: 12))
                    .foregroundColor(AppColors.accent)
                    .padding(.horizontal)
                    .transition(.opacity)
            }
        }
    }
    
    private var registerButton: some View {
        GradientButton(
            title: AppStrings.Register.registerButton,
            icon: "person.badge.plus",
            isEnabled: canRegister && !isRegistering,
            isLoading: isRegistering,
            action: handleRegister
        )
        .padding(.top, 10)
    }
    
    private var loginLink: some View {
        HStack(spacing: 4) {
            Text(AppStrings.Register.alreadyHaveAccount)
                .foregroundColor(AppColors.textSecondary.opacity(0.8))
                .font(.system(size: 14))
            
            Button(action: {
                isPresented = false
            }) {
                Text(AppStrings.Register.goToLogin)
                    .foregroundColor(AppColors.primary)
                    .font(.system(size: 14, weight: .semibold))
                    .underline()
            }
        }
        .padding(.top, 5)
    }
    
    private var closeButton: some View {
        Button(action: {
            isPresented = false
        }) {
            Image(systemName: "xmark")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(AppColors.primary)
        }
    }
    
    private func handleRegister() {
        guard canRegister else {
            showMessage("请填写所有必要的信息", isSuccess: false)
            return
        }
        
        withAnimation {
            isRegistering = true
            showStatusMessage = false
        }
        
        Task {
            do {
                let user = try await NetworkManager.shared.register(
                    username: username,
                    password: password
                )
                
                await MainActor.run {
                    withAnimation {
                        isRegistering = false
                    }
                    showMessage("注册成功！欢迎加入，\(user.username)！", isSuccess: true)
                    
                    // 2秒后关闭注册页面
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isPresented = false
                    }
                }
            } catch {
                await MainActor.run {
                    withAnimation {
                        isRegistering = false
                    }
                    
                    // 显示人性化的错误信息
                    let errorMessage = error.localizedDescription
                    showMessage(errorMessage, isSuccess: false)
                }
            }
        }
    }
    
    private func showMessage(_ message: String, isSuccess: Bool) {
        withAnimation(.easeInOut(duration: 0.3)) {
            statusMessage = message
            isStatusSuccess = isSuccess
            showStatusMessage = true
        }
        
        // 5秒后自动隐藏提示信息
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            withAnimation(.easeInOut(duration: 0.3)) {
                showStatusMessage = false
            }
        }
    }
}

#Preview {
    RegisterView(isPresented: .constant(true))
}