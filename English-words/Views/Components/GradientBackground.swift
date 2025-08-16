//
//  GradientBackground.swift
//  English-words
//
//  Created by 刘怀泽 on 16/8/2025.
//

import SwiftUI

struct GradientBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    AppColors.background,
                    Color.white,
                    AppColors.background.opacity(0.3)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            GeometryReader { geometry in
                Circle()
                    .fill(AppColors.primary.opacity(0.05))
                    .frame(width: geometry.size.width * 1.2, height: geometry.size.width * 1.2)
                    .position(x: geometry.size.width * 0.1, y: -geometry.size.width * 0.2)
                
                Circle()
                    .fill(AppColors.secondary.opacity(0.03))
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.8)
                    .position(x: geometry.size.width * 0.9, y: geometry.size.height * 1.1)
            }
        }
    }
}