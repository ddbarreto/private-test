//
//  NuDSTokens.swift
//  Private Payroll
//
//  Tokens alinhados ao repositório nuds-library (packages/tokens).
//  Segmento: pf (pessoa física), tema: light.
//

import SwiftUI

// MARK: - Cores primitivas (primitives.ts)
enum NuDSPrimitives {
    static let white = SwiftUI.Color(hex: "FFFFFF")
    static let black = SwiftUI.Color(hex: "1F0230")
    enum Purple {
        static let p05 = SwiftUI.Color(hex: "FAF6FF")
        static let p10 = SwiftUI.Color(hex: "F6ECFF")
        static let p20 = SwiftUI.Color(hex: "ECD9FF")
        static let p60 = SwiftUI.Color(hex: "820AD1")
    }
    enum Gray {
        static let g05 = SwiftUI.Color(hex: "F8F6F8")
        static let g10 = SwiftUI.Color(hex: "F0EEF1")
        static let g20 = SwiftUI.Color(hex: "E3E0E5")
        static let g50 = SwiftUI.Color(hex: "766380")
    }
}

// MARK: - Semânticas pf.light (semantics.ts) — pessoa física, tema claro
enum NuDSSemantic {
    enum Background {
        static let `default` = NuDSPrimitives.white
        static let subtle = NuDSPrimitives.Gray.g10
        static let accentPrimary = NuDSPrimitives.Purple.p60
    }
    enum Surface {
        static let `default` = NuDSPrimitives.white
        static let subtle = NuDSPrimitives.Gray.g05
        static let subtleOnSubtle = NuDSPrimitives.Gray.g20  // pressed state (ListRow)
        static let accentPrimary = NuDSPrimitives.Purple.p60
        static let accentPrimarySubtle = NuDSPrimitives.Purple.p10
    }
    enum Border {
        static let `default` = NuDSPrimitives.black.opacity(0.08)  // blackAlpha.20
    }
    enum Content {
        static let `default` = NuDSPrimitives.black
        static let onColor = NuDSPrimitives.white
        static let subtle = NuDSPrimitives.black.opacity(0.62)  // blackAlpha.60
        static let accentPrimary = NuDSPrimitives.Purple.p60
        static let disabled = NuDSPrimitives.black.opacity(0.3)  // blackAlpha.40
    }
    enum Feedback {
        static let success = SwiftUI.Color(hex: "34C759") // green.50
    }
}

// MARK: - Escala de spacing 4pt (spacing.ts)
enum NuDSSpacing {
    static let s0: CGFloat = 0
    static let s1: CGFloat = 4
    static let s2: CGFloat = 8
    static let s3: CGFloat = 12
    static let s4: CGFloat = 16
    static let s5: CGFloat = 20
    static let s6: CGFloat = 24
    static let s7: CGFloat = 28
    static let s8: CGFloat = 32
    static let s10: CGFloat = 40
    static let s12: CGFloat = 48
    static let s16: CGFloat = 64
}

// MARK: - Radius (radius.ts)
enum NuDSRadius {
    static let none: CGFloat = 0
    static let sm: CGFloat = 4
    static let md: CGFloat = 8
    static let lg: CGFloat = 16
    static let xl: CGFloat = 24
    static let xxl: CGFloat = 32
    static let full: CGFloat = 64
}

// MARK: - Motion / duração (motion.ts)
enum NuDSMotion {
    static let quick: Double = 0.2   // t200
    static let medium: Double = 0.3  // t300
    static let slow: Double = 0.4    // t400
}

// MARK: - Tipografia (tamanhos em pt — typography.ts; fontes = system no iOS)
enum NuDSTypography {
    static let titleXSmall: CGFloat = 20   // lineHeight 24
    static let titleSmall: CGFloat = 24    // 28.8
    static let subtitleMedium: CGFloat = 18  // 23.4
    static let subtitleSmall: CGFloat = 16  // 20.8
    static let paragraphMedium: CGFloat = 16
    static let paragraphSmall: CGFloat = 14
    static let labelMedium: CGFloat = 16
    static let labelSmall: CGFloat = 14
    static let labelXSmall: CGFloat = 12
}

// Extensão Color hex (para uso nos tokens)
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default: (r, g, b) = (0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255)
    }
}
