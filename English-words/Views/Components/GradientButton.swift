//
//  GradientButton.swift
//  English-words
//
//  Created by 刘怀泽 on 16/8/2025.
//

import SwiftUI

struct GradientButton: View {
    let title: String
    let icon: String?
    let action: () -> Void
    let isEnabled: Bool
    let isLoading: Bool
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular && verticalSizeClass == .regular
    }
    
    init(title: String, icon: String? = nil, isEnabled: Bool = true, isLoading: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.isEnabled = isEnabled
        self.isLoading = isLoading
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            if isEnabled && !isLoading {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    action()
                }
            }
        }) {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(isIPad ? 1.0 : 0.8)
                } else {
                    Text(title)
                        .font(.system(size: isIPad ? 20 : 17, weight: .semibold))
                        .foregroundColor(.white)
                    
                    if let icon = icon {
                        Image(systemName: icon)
                            .font(.system(size: isIPad ? 22 : 18))
                            .foregroundColor(.white.opacity(0.9))
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: isIPad ? 60 : 52)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [AppColors.primary, AppColors.secondary]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(isIPad ? 14 : 12)
            .shadow(color: AppColors.primary.opacity(0.3), radius: isIPad ? 14 : 12, x: 0, y: 6)
        }
        .scaleEffect(isEnabled ? 1.0 : 0.97)
        .animation(.spring(response: 0.3), value: isEnabled)
        .disabled(!isEnabled || isLoading)
        .opacity(isEnabled ? 1.0 : 0.6)
    }
}