//
//  AppColors.swift
//  English-words
//
//  Created by 刘怀泽 on 16/8/2025.
//

import SwiftUI

enum AppColors {
    static let primary = Color(red: 0.25, green: 0.47, blue: 0.99)
    static let secondary = Color(red: 0.45, green: 0.65, blue: 1.0)
    static let accent = Color(red: 0.96, green: 0.56, blue: 0.35)
    static let background = Color(red: 0.97, green: 0.98, blue: 1.0)
    
    static let textPrimary = Color.primary
    static let textSecondary = Color.gray
    static let textPlaceholder = Color.gray.opacity(0.7)
    
    static let shadowLight = Color.black.opacity(0.04)
    static let shadowMedium = Color.black.opacity(0.1)
    
    static let borderLight = Color.gray.opacity(0.3)
    static let borderFocused = primary.opacity(0.3)
}