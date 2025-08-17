import SwiftUI

struct VocabularyView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // 背景色
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    // 中间的提示文字
                    Text("生词本功能开发中...")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
            }
            .navigationTitle("生词本")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    VocabularyView()
}