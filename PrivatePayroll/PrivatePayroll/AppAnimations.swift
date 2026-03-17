//
//  AppAnimations.swift
//  Private Payroll
//
//  Animações estilo Apple: spring suave, fade-in, transições fluidas.
//

import SwiftUI

enum AppAnimations {
    /// Spring suave (estilo Apple)
    static let spring = Animation.spring(response: 0.5, dampingFraction: 0.82)
    /// Spring mais rápido para feedback tátil
    static let springFast = Animation.spring(response: 0.35, dampingFraction: 0.75)
    /// Entrada de tela (push)
    static let screenEnter = Animation.spring(response: 0.55, dampingFraction: 0.85)
}

// MARK: - Modificador: fade-in + leve slide (entrada de conteúdo)
struct FadeInUpModifier: ViewModifier {
    let delay: Double
    @State private var appeared = false

    func body(content: Content) -> some View {
        content
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 14)
            .onAppear {
                withAnimation(AppAnimations.spring.delay(delay)) {
                    appeared = true
                }
            }
    }
}

// MARK: - Modificador: entrada em tela (telas de destino)
struct ScreenEnterModifier: ViewModifier {
    @State private var appeared = false

    func body(content: Content) -> some View {
        content
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 8)
            .onAppear {
                withAnimation(AppAnimations.screenEnter) {
                    appeared = true
                }
            }
    }
}

// MARK: - Botão com scale no toque (feedback estilo Apple)
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(AppAnimations.springFast, value: configuration.isPressed)
    }
}

extension View {
    /// Entrada suave: fade-in + slide up (para listas e seções)
    func fadeInUp(delay: Double = 0) -> some View {
        modifier(FadeInUpModifier(delay: delay))
    }

    /// Entrada de tela (telas de navegação)
    func screenEnter() -> some View {
        modifier(ScreenEnterModifier())
    }
}
