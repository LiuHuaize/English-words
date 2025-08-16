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
    @State private var showPasswordMismatchError: Bool = false
    @State private var showEmptyFieldError: Bool = false
    @State private var isRegistering: Bool = false
    
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
                    VStack(spacing: 25) {
                        headerSection
                        inputSection
                        passwordValidation
                        registerButton
                        loginLink
                        
                        if showEmptyFieldError {
                            errorMessage
                        }
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: 380)
                }
            }
            .navigationBarItems(
                leading: closeButton
            )
        }
    }
    
    private var headerSection: some View {
        VStack(spacing: 8) {
            Image(systemName: "person.badge.plus.fill")
                .font(.system(size: 60))
                .foregroundColor(AppColors.primary)
                .padding(.top, 20)
            
            Text(AppStrings.Register.title)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(AppColors.primary)
            
            Text(AppStrings.Register.subtitle)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
                .opacity(0.8)
        }
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
    
    private var inputSection: some View {
        VStack(spacing: 20) {
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
    
    private var errorMessage: some View {
        Text(AppStrings.Register.emptyFields)
            .font(.system(size: 12))
            .foregroundColor(AppColors.accent)
            .transition(.opacity)
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
            withAnimation {
                showEmptyFieldError = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    showEmptyFieldError = false
                }
            }
            return
        }
        
        withAnimation {
            isRegistering = true
        }
        
        // TODO: 实现实际的注册逻辑
        print("Registering user: \(username)")
        
        // 模拟网络请求
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                isRegistering = false
            }
            // 注册成功后关闭页面
            isPresented = false
        }
    }
}

#Preview {
    RegisterView(isPresented: .constant(true))
}