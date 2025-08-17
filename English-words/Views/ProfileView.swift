import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // 背景色
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    // 中间的提示文字
                    Text("个人信息功能开发中...")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
            }
            .navigationTitle("我的")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ProfileView()
}