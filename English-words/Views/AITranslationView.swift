import SwiftUI

struct AITranslationView: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var searchText = ""
    @State private var isWordSaved = false
    @State private var isPlaying = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 渐变背景
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.95, green: 0.97, blue: 1.0),
                        Color(red: 0.89, green: 0.93, blue: 0.98)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // 自定义导航栏
                    customNavigationBar
                    
                    // 主内容区域 - 所有内容都在ScrollView中
                    ScrollView {
                        VStack(spacing: 20) {
                            // 单词卡片（现在跟随滚动）
                            wordCard
                                .padding(.horizontal, contentHorizontalPadding)
                                .padding(.top, 10)
                                .frame(maxWidth: maxContentWidth)
                            
                            // AI解读部分
                            aiInterpretationSection
                                .padding(.horizontal, contentHorizontalPadding)
                                .frame(maxWidth: maxContentWidth)
                            
                            // 趣味记忆部分
                            interestingMemorySection
                                .padding(.horizontal, contentHorizontalPadding)
                                .frame(maxWidth: maxContentWidth)
                            
                            // 释义与例句部分
                            definitionAndExampleSection
                                .padding(.horizontal, contentHorizontalPadding)
                                .frame(maxWidth: maxContentWidth)
                            
                            // 底部安全区域
                            Color.clear
                                .frame(height: 100)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // 自定义导航栏
    private var customNavigationBar: some View {
        HStack {
            Text("AI翻译")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black)
            
            Spacer()
            
            // 搜索按钮
            Button(action: {
                // 搜索功能
            }) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 22))
                    .foregroundColor(.black)
                    .frame(width: 44, height: 44)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            }
        }
        .padding(.horizontal, contentHorizontalPadding)
        .padding(.vertical, 12)
        .frame(maxWidth: maxContentWidth)
        .frame(maxWidth: .infinity)
        .background(Color.clear)
    }
    
    // 单词卡片
    private var wordCard: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                // 单词
                Text("Conception")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                // 音标和播放按钮
                HStack(spacing: 8) {
                    Button(action: {
                        isPlaying.toggle()
                    }) {
                        Image(systemName: isPlaying ? "speaker.wave.3.fill" : "speaker.wave.2.fill")
                            .font(.system(size: 18))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    Text("[kənˈsepʃ(ə)n]")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.9))
                        .lineLimit(1)
                }
            }
            
            Spacer(minLength: 8)
            
            // 添加生词本按钮 - 优化确保一行显示
            Button(action: {
                withAnimation(.spring()) {
                    isWordSaved.toggle()
                }
            }) {
                HStack(spacing: 4) {
                    Image(systemName: isWordSaved ? "heart.fill" : "heart")
                        .font(.system(size: 14))
                        .foregroundColor(isWordSaved ? .red : .gray)
                    
                    Text("添加生词本")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.black)
                        .fixedSize(horizontal: true, vertical: false) // 防止文字换行
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.white)
                .cornerRadius(18)
            }
        }
        .padding(20)
        .frame(height: 110)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.2, green: 0.6, blue: 0.9),
                    Color(red: 0.3, green: 0.7, blue: 0.95)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
    }
    
    // AI解读部分
    private var aiInterpretationSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionTitle("AI解读")
            
            Text("这个词优雅地描绘了思维或创造的起源时刻。它不仅指向思想的诞生，也暗示了创意的孕育过程。在艺术领域，它代表了灵感的火花；在科学上，它象征着理论的萌芽；在生命中，它标志着新生命的开始。")
                .font(.system(size: 15))
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.6))
                .lineSpacing(6)
        }
    }
    
    // 趣味记忆部分
    private var interestingMemorySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionTitle("趣味记忆")
            
            VStack(alignment: .leading, spacing: 12) {
                Text("\"肯赛普神\"，可以想象成我们的脑袋肯定要塞进各种普通的神奇观念。")
                    .font(.system(size: 15))
                    .foregroundColor(.black.opacity(0.8))
                    .lineSpacing(6)
                
                Text("这个词在科技界最著名的应用是 Inception（盗梦空间）这部经典科幻电影，影片探讨了想法的植入与起源。")
                    .font(.system(size: 15))
                    .foregroundColor(.black.opacity(0.7))
                    .lineSpacing(6)
            }
        }
    }
    
    // 释义与例句部分
    private var definitionAndExampleSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionTitle("释义与例句")
            
            VStack(alignment: .leading, spacing: 20) {
                // 第一个释义
                VStack(alignment: .leading, spacing: 8) {
                    Text("n. 概念")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text("This conception of this plan is very creative.")
                        .font(.system(size: 15))
                        .foregroundColor(Color(red: 0.2, green: 0.5, blue: 0.8))
                        .italic()
                    
                    Text("这个计划的概念非常有创意")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                // 第二个释义
                VStack(alignment: .leading, spacing: 8) {
                    Text("n. 怀孕，受孕（生理现象）")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text("The doctor confirmed the conception occurred three weeks ago.")
                        .font(.system(size: 15))
                        .foregroundColor(Color(red: 0.2, green: 0.5, blue: 0.8))
                        .italic()
                    
                    Text("医生确认受孕发生在三周前。")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    // 章节标题样式
    private func sectionTitle(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Color(red: 0.3, green: 0.6, blue: 0.9)
                        .cornerRadius(12)
                )
            Spacer()
        }
    }
    
    // 获取屏幕宽度
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    // 根据设备类型动态计算内容宽度
    private var maxContentWidth: CGFloat {
        if horizontalSizeClass == .regular {
            // iPad 或大屏设备 - 限制最大宽度以保持可读性
            return min(screenWidth, 800)
        } else {
            // iPhone - 使用全宽
            return screenWidth
        }
    }
    
    // 动态计算水平内边距
    private var contentHorizontalPadding: CGFloat {
        if horizontalSizeClass == .regular {
            // iPad - 使用固定内边距
            return 24
        } else {
            // iPhone - 根据屏幕宽度计算
            return screenWidth * 0.05
        }
    }
}

#Preview {
    AITranslationView()
}