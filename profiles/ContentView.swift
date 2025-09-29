import SwiftUI

struct ContentView: View {
    var body: some View {
        AboutMeView(
            profileImageName: "ss",       // صورة البروفايل (يفضل PNG بخلفية شفافة)
            textImageName: "texts",        // صورة النص (PNG لو حابة)
            backgroundOverlayName: "bgOverlay"
        )
    }
}

struct AboutMeView: View {
    let profileImageName: String
    let textImageName: String
    let backgroundOverlayName: String?

    var body: some View {
        ZStack {
            // خلفية ناعمة
            LinearGradient(
                colors: [Color(hex: "#FDFBFB"), Color(hex: "#EBEDEE")],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // صورة خلفية اختيارية متحركة
            if let bg = backgroundOverlayName {
                FloatingImage(imageName: bg,
                              floatDuration: 8,
                              floatRange: 30,
                              opacity: 0.18,
                              scale: 1.1,
                              glow: true)
                    .ignoresSafeArea()
            }

            VStack(spacing: 28) {
                // صورة البروفايل مع إضاءة
                FloatingImage(imageName: profileImageName,
                              floatDuration: 5,
                              floatRange: 20,
                              cornerRadius: 60,
                              shadowRadius: 25,
                              scale: 1.05,
                              glow: true)
                    .frame(width: 220, height: 220)

                // النص كـ Text
                VStack(spacing: 6) {
                    Text("Hi, I’m Shahad ✨")
                        .font(.title2.bold())
                        .foregroundColor(Color(hex: "#444"))
                        .shadow(radius: 2)

                    Text("I love exploring new ideas,\ncreating beautiful things, and sharing good vibes.\nAlways curious, always growing. 🌿")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hex: "#555"))
                        .shadow(radius: 1)
                }
                .padding(.horizontal, 24)
            }
            .padding(.vertical, 48)
        }
    }
}

// صورة متحركة + Glow
struct FloatingImage: View {
    let imageName: String
    let floatDuration: Double
    let floatRange: CGFloat
    var opacity: Double = 1
    var cornerRadius: CGFloat = 0
    var shadowRadius: CGFloat = 0
    var scale: CGFloat = 1.0
    var glow: Bool = false

    @State private var animate = false

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .opacity(opacity)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .shadow(color: glow ? Color.pink.opacity(0.6) : .clear,
                    radius: glow ? 20 : shadowRadius,
                    x: 0, y: 0)
            .shadow(color: glow ? Color.blue.opacity(0.4) : .clear,
                    radius: glow ? 35 : 0,
                    x: 0, y: 0)
            .offset(y: animate ? -floatRange : floatRange) // حركة up/down
            .scaleEffect(animate ? scale * 1.02 : scale)   // نبضة خفيفة
            .onAppear {
                withAnimation(.easeInOut(duration: floatDuration).repeatForever(autoreverses: true)) {
                    animate = true
                }
            }
    }
}

// HEX Color
extension Color {
    init(hex: String, alpha: Double = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8)  / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }
}

#Preview {
    ContentView()
}
