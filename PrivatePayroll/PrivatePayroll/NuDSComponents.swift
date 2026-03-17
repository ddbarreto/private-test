//
//  NuDSComponents.swift
//  Private Payroll
//
//  Componentes NuDS — espelho dos componentes do nuds-library (ListRow, SectionTitle, NText, Box).
//

import SwiftUI

// MARK: - NuDS (tokens para uso nas views; espelho nuds-library)
enum NuDS {
    enum Color {
        static let accentPrimary = NuDSSemantic.Surface.accentPrimary
        static let accentPrimarySubtle = NuDSSemantic.Surface.accentPrimarySubtle
        static let surfaceDefault = NuDSSemantic.Surface.default
        static let surfaceSubtle = NuDSSemantic.Surface.subtle
        static let surfaceSubtleOnSubtle = NuDSSemantic.Surface.subtleOnSubtle
        static let backgroundDefault = NuDSSemantic.Background.default
        static let backgroundSubtle = NuDSSemantic.Background.subtle
        static let backgroundSecondary = NuDSSemantic.Background.subtle
        static let contentDefault = NuDSSemantic.Content.default
        static let contentSecondary = NuDSSemantic.Content.subtle
        static let contentOnColor = NuDSSemantic.Content.onColor
        static let contentDisabled = NuDSSemantic.Content.disabled
        static let borderDefault = NuDSSemantic.Border.default
        static let feedbackSuccess = NuDSSemantic.Feedback.success
    }
    enum Spacing {
        static let s0 = NuDSSpacing.s0
        static let s1 = NuDSSpacing.s1
        static let s2 = NuDSSpacing.s2
        static let s3 = NuDSSpacing.s3
        static let s4 = NuDSSpacing.s4
        static let s5 = NuDSSpacing.s5
        static let s6 = NuDSSpacing.s6
        static let xs = NuDSSpacing.s1
        static let sm = NuDSSpacing.s2
        static let md = NuDSSpacing.s4
        static let lg = NuDSSpacing.s6
    }
    enum Radius {
        static let sm = NuDSRadius.sm
        static let md = NuDSRadius.md
        static let lg = NuDSRadius.lg
        static let xl = NuDSRadius.xl
        static let full = NuDSRadius.full
        static let pill = NuDSRadius.full
        static let card = NuDSRadius.lg
    }
}

// MARK: - NuDSText (espelho NText — variant + tone)
enum NuDSTextVariant {
    case titleXSmall, titleSmall
    case subtitleMediumDefault, subtitleMediumStrong
    case subtitleSmallDefault, subtitleSmallStrong
    case paragraphMediumDefault, paragraphMediumStrong
    case paragraphSmallDefault, paragraphSmallStrong
    case labelMediumDefault, labelMediumStrong
    case labelSmallDefault, labelSmallStrong
    case labelXSmallDefault, labelXSmallStrong
}

enum NuDSTextTone {
    case primary   // content.default
    case secondary // content.subtle
    case inverse   // content.onColor
    case accent   // content.accentPrimary
    case positive  // feedback.success
}

struct NuDSText: View {
    let text: String
    var variant: NuDSTextVariant = .paragraphMediumDefault
    var tone: NuDSTextTone = .primary
    var lineLimit: Int?

    private var fontSize: CGFloat {
        switch variant {
        case .titleXSmall: return 20
        case .titleSmall: return 24
        case .subtitleMediumDefault, .subtitleMediumStrong: return 18
        case .subtitleSmallDefault, .subtitleSmallStrong: return 16
        case .paragraphMediumDefault, .paragraphMediumStrong, .labelMediumDefault, .labelMediumStrong: return 16
        case .paragraphSmallDefault, .paragraphSmallStrong, .labelSmallDefault, .labelSmallStrong: return 14
        case .labelXSmallDefault, .labelXSmallStrong: return 12
        }
    }

    private var fontWeight: Font.Weight {
        switch variant {
        case .titleXSmall, .titleSmall: return .medium
        case .subtitleMediumStrong, .subtitleSmallStrong, .paragraphMediumStrong, .paragraphSmallStrong,
             .labelMediumStrong, .labelSmallStrong, .labelXSmallStrong: return .semibold
        default: return .regular
        }
    }

    private var color: Color {
        switch tone {
        case .primary: return NuDS.Color.contentDefault
        case .secondary: return NuDS.Color.contentSecondary
        case .inverse: return NuDS.Color.contentOnColor
        case .accent: return NuDS.Color.accentPrimary
        case .positive: return NuDS.Color.feedbackSuccess
        }
    }

    var body: some View {
        Text(text)
            .font(.system(size: fontSize, weight: fontWeight))
            .foregroundStyle(color)
            .lineLimit(lineLimit)
    }
}

// MARK: - NuDSListRow (espelho ListRow — leading 20pt, label, description, secondaryLabel, showChevron)
struct NuDSListRow: View {
    var label: String
    var description: String? = nil
    var secondaryLabel: String? = nil
    var leading: (() -> AnyView)? = nil
    var showChevron: Bool = true
    var onPress: (() -> Void)? = nil

    var body: some View {
        Button(action: { onPress?() }) {
            HStack(alignment: .center, spacing: NuDS.Spacing.s3) {
                if let leading = leading {
                    leading()
                        .frame(width: 20, height: 20, alignment: .center)
                }
                VStack(alignment: .leading, spacing: NuDS.Spacing.s1) {
                    NuDSText(text: label, variant: .labelSmallStrong, tone: .primary, lineLimit: 1)
                    if let description = description {
                        NuDSText(text: description, variant: .paragraphSmallDefault, tone: .secondary, lineLimit: 2)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                if let secondary = secondaryLabel {
                    NuDSText(text: secondary, variant: .labelSmallStrong, tone: .primary, lineLimit: 1)
                }
                if showChevron {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(NuDS.Color.contentDefault)
                }
            }
            .padding(.horizontal, NuDS.Spacing.s5)
            .padding(.vertical, NuDS.Spacing.s4)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(NuDSListRowButtonStyle())
        .disabled(onPress == nil)
    }
}

private struct NuDSListRowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .fill(configuration.isPressed ? NuDS.Color.surfaceSubtleOnSubtle : NuDS.Color.surfaceDefault)
            )
    }
}

// MARK: - NuDSSectionTitle (espelho SectionTitle — altura 48, labelSmallStrong secondary)
struct NuDSSectionTitle: View {
    var title: String
    var secondary: String? = nil
    var secondaryTone: NuDSTextTone = .secondary
    var trailing: (() -> AnyView)? = nil
    var onSecondaryPress: (() -> Void)? = nil
    var onTrailingPress: (() -> Void)? = nil

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            NuDSText(text: title, variant: .labelSmallStrong, tone: .secondary, lineLimit: 1)
                .frame(maxWidth: .infinity, alignment: .leading)
            if let secondary = secondary {
                if onSecondaryPress != nil {
                    Button(action: { onSecondaryPress?() }) {
                        NuDSText(text: secondary, variant: .labelSmallDefault, tone: secondaryTone, lineLimit: 1)
                    }
                    .padding(.trailing, trailing != nil ? 0 : NuDS.Spacing.s3)
                } else {
                    NuDSText(text: secondary, variant: .labelSmallDefault, tone: secondaryTone, lineLimit: 1)
                        .padding(.trailing, trailing != nil ? 0 : NuDS.Spacing.s3)
                }
            }
            if let trailing = trailing {
                Button(action: { onTrailingPress?() }) {
                    trailing()
                }
                .frame(width: 48, height: 48)
                .contentShape(Rectangle())
            }
        }
        .frame(height: 48)
        .padding(.leading, NuDS.Spacing.s5)
        .padding(.trailing, NuDS.Spacing.s2)
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
