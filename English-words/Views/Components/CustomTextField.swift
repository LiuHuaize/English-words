//
//  CustomTextField.swift
//  English-words
//
//  Created by 刘怀泽 on 16/8/2025.
//

import SwiftUI

struct CustomTextField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var showToggleButton: Bool = false
    @Binding var isSecureVisible: Bool
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular && verticalSizeClass == .regular
    }
    
    init(icon: String, placeholder: String, text: Binding<String>) {
        self.icon = icon
        self.placeholder = placeholder
        self._text = text
        self.isSecure = false
        self.showToggleButton = false
        self._isSecureVisible = .constant(false)
    }
    
    init(icon: String, placeholder: String, text: Binding<String>, isSecure: Bool, isSecureVisible: Binding<Bool>) {
        self.icon = icon
        self.placeholder = placeholder
        self._text = text
        self.isSecure = isSecure
        self.showToggleButton = isSecure
        self._isSecureVisible = isSecureVisible
    }
    
    var body: some View {
        HStack(spacing: isIPad ? 16 : 12) {
            Image(systemName: icon)
                .foregroundColor(AppColors.primary.opacity(0.7))
                .font(.system(size: isIPad ? 22 : 18))
                .frame(width: isIPad ? 24 : 20)
            
            if isSecure && !isSecureVisible {
                SecureField(placeholder, text: $text)
                    .font(.system(size: isIPad ? 18 : 16))
                    .foregroundColor(.primary)
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: isIPad ? 18 : 16))
                    .foregroundColor(.primary)
            }
            
            if !text.isEmpty {
                if showToggleButton {
                    Button(action: {
                        isSecureVisible.toggle()
                    }) {
                        Image(systemName: isSecureVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(Color.gray.opacity(0.5))
                            .font(.system(size: isIPad ? 18 : 16))
                    }
                } else {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color.gray.opacity(0.5))
                            .font(.system(size: isIPad ? 18 : 16))
                    }
                }
            }
        }
        .padding(.horizontal, isIPad ? 20 : 16)
        .padding(.vertical, isIPad ? 18 : 14)
        .background(
            RoundedRectangle(cornerRadius: isIPad ? 14 : 12)
                .fill(Color.white)
                .shadow(color: AppColors.shadowLight, radius: isIPad ? 10 : 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: isIPad ? 14 : 12)
                .stroke(text.isEmpty ? Color.clear : AppColors.borderFocused, lineWidth: isIPad ? 1.5 : 1)
        )
    }
}