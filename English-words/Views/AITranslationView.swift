import SwiftUI

struct AITranslationView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // 背景色
                Color(UIColor.systemBackground)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    // 中间的提示文字
                    Text("翻译功能开发中...")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
            }
            .navigationTitle("AI翻译")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    AITranslationView()
}