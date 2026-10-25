import SwiftUI

extension RGBAColor {
    var swiftUIColor: Color {
        Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}

extension TimeInterval {
    var timecode: String {
        let total = Int(self)
        let seconds = total % 60
        let minutes = (total / 60) % 60
        let hours = total / 3600
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%d:%02d", minutes, seconds)
        }
    }
}

// MARK: - Палитра макета (CSS :root)

extension Color {
    /// Цвет из шестнадцатеричного значения 0xRRGGBB.
    init(gannHex hex: UInt32, opacity: Double = 1) {
        self.init(.sRGB,
                  red: Double((hex >> 16) & 0xFF) / 255,
                  green: Double((hex >> 8) & 0xFF) / 255,
                  blue: Double(hex & 0xFF) / 255,
                  opacity: opacity)
    }
}

enum GANNTheme {
    /// Фон окна, заголовков и строки статуса.
    static let bg0 = Color(gannHex: 0x121214)
    /// Основной фон панелей.
    static let bg1 = Color(gannHex: 0x1A1A1D)
    /// Боковая панель, карточки эффектов.
    static let bg2 = Color(gannHex: 0x222226)
    /// Поля поиска, кнопки, подсветка наведения.
    static let bg3 = Color(gannHex: 0x2B2B30)
    /// Границы и разделители.
    static let stroke = Color(gannHex: 0x34343A)

    static let text1 = Color(gannHex: 0xF2F2F5)
    static let text2 = Color(gannHex: 0xA3A3AD)
    static let text3 = Color(gannHex: 0x6E6E78)

    /// Акцент интерфейса: выбранные строки, включённые режимы, основные кнопки.
    static let accent = Color(gannHex: 0x5B8DFF)
    static let accentSoft = Color(gannHex: 0x5B8DFF, opacity: 0.14)
}

/// Кнопка с тонкой рамкой (как «Загрузить» и «Сохранить» в макете).
struct GANNGhostButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(GANNTheme.text2)
            .background(RoundedRectangle(cornerRadius: 6).stroke(GANNTheme.stroke, lineWidth: 1))
            .opacity(configuration.isPressed ? 0.7 : 1)
            .contentShape(Rectangle())
    }
}

/// Общая анимация перестановки: плейлисты и треки двигаются одинаково.
enum GANNMotion {
    static let reorder = Animation.easeInOut(duration: 0.18)
}
