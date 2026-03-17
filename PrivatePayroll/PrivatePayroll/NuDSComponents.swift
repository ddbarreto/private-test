//
//  NuDSComponents.swift
//  Private Payroll
//
//  Componentes no estilo NuDS (design system) para experiência de repositório.
//

import SwiftUI

private extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Tokens NuDS (alinhado ao Figma / nuds-library)
enum NuDS {
    enum Color {
        static let accentPrimary = SwiftUI.Color(hex: "820AD1")
        static let accentPrimarySubtle = SwiftUI.Color(hex: "F6ECFF")
        static let surfaceDefault = SwiftUI.Color.white
        static let surfaceSubtle = SwiftUI.Color(hex: "EFEFEF")
        static let backgroundSecondary = SwiftUI.Color(hex: "F0F1F5")
        static let contentDefault = SwiftUI.Color(hex: "000000")
        static let contentSecondary = SwiftUI.Color(hex: "727683")
        static let contentOnColor = SwiftUI.Color.white
    }
    enum Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
    }
    enum Radius {
        static let pill: CGFloat = 100
        static let card: CGFloat = 12
    }
}

// MARK: - Card (widget estilo NuDS)
struct NuDSCard<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        content
            .padding(NuDS.Spacing.lg)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(NuDS.Color.surfaceDefault, in: RoundedRectangle(cornerRadius: NuDS.Radius.card))
    }
}

// MARK: - Pill (botão/capsula estilo NuDS)
struct NuDSPill: View {
    let icon: String?
    let title: String
    let action: () -> Void
    init(icon: String? = nil, title: String, action: @escaping () -> Void) {
        self.icon = icon
        self.title = title
        self.action = action
    }
    var body: some View {
        Button(action: action) {
            HStack(spacing: NuDS.Spacing.sm) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 18))
                        .foregroundStyle(NuDS.Color.contentDefault)
                }
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(NuDS.Color.contentDefault)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(NuDS.Color.contentSecondary)
            }
            .padding(.horizontal, NuDS.Spacing.lg)
            .padding(.vertical, NuDS.Spacing.md + 4)
            .background(NuDS.Color.surfaceSubtle, in: RoundedRectangle(cornerRadius: NuDS.Radius.card))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - List Title (título de seção estilo NuDS)
struct NuDSListTitle: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.system(size: 18, weight: .medium))
            .foregroundStyle(NuDS.Color.contentDefault)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, NuDS.Spacing.lg)
            .padding(.vertical, NuDS.Spacing.sm)
    }
}

// MARK: - Tile Item (item de lista com chevron)
struct NuDSTileItem: View {
    let title: String
    let subtitle: String?
    let action: (() -> Void)?
    init(title: String, subtitle: String? = nil, action: (() -> Void)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.action = action
    }
    var body: some View {
        Button(action: { action?() }) {
            HStack {
                VStack(alignment: .leading, spacing: NuDS.Spacing.xs) {
                    Text(title)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(NuDS.Color.contentDefault)
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.system(size: 13))
                            .foregroundStyle(NuDS.Color.contentSecondary)
                    }
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundStyle(NuDS.Color.contentSecondary)
            }
            .padding(.horizontal, NuDS.Spacing.lg)
            .padding(.vertical, NuDS.Spacing.md)
            .background(NuDS.Color.surfaceDefault)
        }
        .buttonStyle(.plain)
    }
}
