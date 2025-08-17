import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // AI翻译页面
            AITranslationView()
                .tabItem {
                    VStack {
                        Image(systemName: "character.book.closed.fill.zh")
                        Text("AI翻译")
                    }
                }
                .tag(0)
            
            // 生词本页面
            VocabularyView()
                .tabItem {
                    VStack {
                        Image(systemName: "book.fill")
                        Text("生词本")
                    }
                }
                .tag(1)
            
            // 个人信息页面
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("我的")
                    }
                }
                .tag(2)
        }
        .accentColor(Color(red: 0.5, green: 0.3, blue: 0.8))
    }
}

#Preview {
    MainTabView()
}