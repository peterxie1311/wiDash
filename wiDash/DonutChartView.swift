import SwiftUI

struct DonutChartView: View {
    @Binding var progress: Double
    let strokeWidth: CGFloat
    let strokeColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray, lineWidth: strokeWidth)
                .overlay(
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(max(progress, 0), 1.0)))
                        .stroke(strokeColor, lineWidth: strokeWidth)
                        .rotationEffect(.degrees(-90))
                        .animation(.linear)
                )
                .frame(width: 50, height: 50)
            
            Text(String(format: "%.0f%%", progress * 100))
                .font(.system(size: 12))
                .bold()
        }
    }
}



struct DonutChartViewUnBind: View {
    var progress: Double
    let strokeWidth: CGFloat
    let strokeColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray, lineWidth: strokeWidth)
                .overlay(
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(max(progress, 0), 1.0)))
                        .stroke(strokeColor, lineWidth: strokeWidth)
                        .rotationEffect(.degrees(-90))
                        .animation(.linear)
                )
                .frame(width: 50, height: 50)
            
            Text(String(format: "%.0f%%", progress * 100))
                .font(.system(size: 12))
                .bold()
        }
    }
}


struct BubbleView: View {
    let text: [String]
    let font : CGFloat
    let color : Color
    
    var body: some View {
        let combinedString = text.joined(separator: "\n")
        Text(combinedString)
            .font(.system(size: font))
            .padding()
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(30)
            .opacity(5) // Start with opacity 0
            .onAppear {
                withAnimation(.easeIn(duration: 1)) {
                    self.opacity(1) // Fade in animation
                }
            }
    }
}


struct BubbleViewBold: View {
    let text: [String]
    let font : CGFloat
    let color : Color
    
    var body: some View {
        let combinedString = text.joined(separator: "\n")
        Text(combinedString)
            .font(.system(size: font, weight: .bold))
            .padding()
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(30)
            .opacity(5) // Start with opacity 0
            .onAppear {
                withAnimation(.easeIn(duration: 1)) {
                    self.opacity(1) // Fade in animation
                }
            }
    }
}
