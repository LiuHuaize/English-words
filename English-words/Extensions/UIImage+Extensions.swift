//
//  UIImage+Extensions.swift
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

#if os(iOS)
extension UIImage {
    static func imageExists(named name: String) -> Bool {
        return UIImage(named: name) != nil
    }
}
#endif