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
    
    let primaryColor = Color(red: 0.25, green: 0.47, blue: 0.99)
    let secondaryColor = Color(red: 0.45, green: 0.65, blue: 1.0)
    let accentColor = Color(red: 0.96, green: 0.56, blue: 0.35)
    let backgroundColor = Color(red: 0.97, green: 0.98, blue: 1.0)
    
    var passwordsMatch: Bool {
        !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword
    }
    
    var passwordsDontMatch: Bool {
        !confirmPassword.isEmpty && password != confirmPassword
    }
    
    var body: some View {
        NavigationView {
            ZStack {
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
                
                ScrollView {
                    VStack(spacing: 25) {
                        VStack(spacing: 8) {
                            Image(systemName: "person.badge.plus.fill")
                                .font(.system(size: 60))
                                .foregroundColor(primaryColor)
                                .padding(.top, 20)
                            
                            Text("创建新账户")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundColor(primaryColor)
                            
                            Text("开始你的学习之旅")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color.gray)
                                .opacity(0.8)
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                        
                        VStack(spacing: 20) {
                            HStack(spacing: 12) {
                                Image(systemName: "person.fill")
                                    .foregroundColor(primaryColor.opacity(0.7))
                                    .font(.system(size: 18))
                                    .frame(width: 20)
                                
                                TextField("请输入用户名", text: $username)
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
                            
                            HStack(spacing: 12) {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(primaryColor.opacity(0.7))
                                    .font(.system(size: 18))
                                    .frame(width: 20)
                                
                                if isPasswordVisible {
                                    TextField("请输入密码", text: $password)
                                        .font(.system(size: 16))
                                        .foregroundColor(.primary)
                                } else {
                                    SecureField("请输入密码", text: $password)
                                        .font(.system(size: 16))
                                        .foregroundColor(.primary)
                                }
                                
                                Button(action: {
                                    isPasswordVisible.toggle()
                                }) {
                                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(Color.gray.opacity(0.5))
                                        .font(.system(size: 16))
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
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 12) {
                                    Image(systemName: "lock.fill")
                                        .foregroundColor(primaryColor.opacity(0.7))
                                        .font(.system(size: 18))
                                        .frame(width: 20)
                                    
                                    if isConfirmPasswordVisible {
                                        TextField("请确认密码", text: $confirmPassword)
                                            .font(.system(size: 16))
                                            .foregroundColor(.primary)
                                    } else {
                                        SecureField("请确认密码", text: $confirmPassword)
                                            .font(.system(size: 16))
                                            .foregroundColor(.primary)
                                    }
                                    
                                    Button(action: {
                                        isConfirmPasswordVisible.toggle()
                                    }) {
                                        Image(systemName: isConfirmPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                            .foregroundColor(Color.gray.opacity(0.5))
                                            .font(.system(size: 16))
                                    }
                                    
                                    if passwordsMatch {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(Color.green)
                                            .font(.system(size: 16))
                                            .transition(.scale)
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
                                        .stroke(
                                            passwordsDontMatch ? Color.red.opacity(0.5) :
                                            (confirmPassword.isEmpty ? Color.clear : 
                                             (passwordsMatch ? Color.green.opacity(0.5) : primaryColor.opacity(0.3))),
                                            lineWidth: 1
                                        )
                                )
                                
                                if passwordsDontMatch {
                                    HStack {
                                        Image(systemName: "exclamationmark.circle.fill")
                                            .font(.system(size: 12))
                                        Text("两次输入的密码不一致")
                                            .font(.system(size: 12))
                                    }
                                    .foregroundColor(Color.red)
                                    .padding(.horizontal, 5)
                                    .transition(.opacity)
                                }
                            }
                            
                            if showEmptyFieldError {
                                HStack {
                                    Image(systemName: "info.circle.fill")
                                        .font(.system(size: 12))
                                    Text("请填写所有必填字段")
                                        .font(.system(size: 12))
                                }
                                .foregroundColor(accentColor)
                                .transition(.opacity)
                            }
                        }
                        .padding(.horizontal, 24)
                        
                        VStack(spacing: 16) {
                            Button(action: {
                                handleRegister()
                            }) {
                                HStack {
                                    if isRegistering {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                            .scaleEffect(0.8)
                                    } else {
                                        Text("注册")
                                            .font(.system(size: 17, weight: .semibold))
                                        
                                        Image(systemName: "arrow.right.circle.fill")
                                            .font(.system(size: 18))
                                    }
                                }
                                .foregroundColor(.white)
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
                            .disabled(isRegistering || !isFormValid())
                            .opacity((isRegistering || !isFormValid()) ? 0.6 : 1.0)
                            .padding(.horizontal, 24)
                            
                            HStack(spacing: 4) {
                                Text("已有账号？")
                                    .foregroundColor(Color.gray.opacity(0.8))
                                    .font(.system(size: 14))
                                
                                Button(action: {
                                    isPresented = false
                                }) {
                                    Text("返回登录")
                                        .foregroundColor(primaryColor)
                                        .font(.system(size: 14, weight: .semibold))
                                        .underline()
                                }
                            }
                        }
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationBarItems(
                trailing: Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Color.gray.opacity(0.7))
                }
            )
        }
    }
    
    func isFormValid() -> Bool {
        return !username.isEmpty && !password.isEmpty && passwordsMatch
    }
    
    func handleRegister() {
        showEmptyFieldError = false
        showPasswordMismatchError = false
        
        guard !username.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            withAnimation {
                showEmptyFieldError = true
            }
            return
        }
        
        guard passwordsMatch else {
            withAnimation {
                showPasswordMismatchError = true
            }
            return
        }
        
        isRegistering = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isRegistering = false
            isPresented = false
            print("注册成功: 用户名: \(username)")
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(isPresented: .constant(true))
    }
}