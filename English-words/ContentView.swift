//
//  ContentView.swift
//  English-words
//
//  Created by 刘怀泽 on 16/8/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        if isLoggedIn {
            // TODO: 显示主应用界面
            Text("主应用界面")
                .onAppear {
                    print("User logged in, showing main app")
                }
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}