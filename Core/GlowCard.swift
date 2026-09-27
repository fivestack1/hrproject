//
//  GlowCard.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI

struct GlowCard<Content: View>: View {

    @ViewBuilder
    let content: Content

    var body: some View {

        content

            .padding()

            .background(
                RoundedRectangle(
                    cornerRadius: 28
                )
                .fill(
                    .ultraThinMaterial
                )
            )

            .overlay {

                RoundedRectangle(
                    cornerRadius: 28
                )
                .stroke(
                    .white.opacity(0.15),
                    lineWidth: 1
                )
            }

            .shadow(
                color: .purple.opacity(0.4),
                radius: 20
            )
    }
}