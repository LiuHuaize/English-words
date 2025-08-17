//
//  ContentView.swift
//  English-words
//
//  Created by 刘怀泽 on 16/8/2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    var body: some View {
        if isLoggedIn {
            // 显示AI翻译界面
            AITranslationView()
                .onAppear {
                    print("User logged in, showing AI Translation view")
                }
        } else {
            LoginView(isLoggedIn: $isLoggedIn)
        }
    }
}

#Preview {
    ContentView()
}

