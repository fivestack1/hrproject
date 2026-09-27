//
//  CardStyle.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI

struct CardStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(
                    cornerRadius: 24,
                    style: .continuous
                )
                .fill(AppColors.card)
            )
            .overlay(
                RoundedRectangle(
                    cornerRadius: 24,
                    style: .continuous
                )
                .stroke(
                    Color.white.opacity(0.08),
                    lineWidth: 1
                )
            )
    }
}

extension View {

    func astroCard() -> some View {
        modifier(CardStyle())
    }
}