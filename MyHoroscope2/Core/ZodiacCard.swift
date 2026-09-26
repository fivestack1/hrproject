//
//  ZodiacCard.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI

struct ZodiacCard: View {

    let sign: ZodiacSign

    var body: some View {

        VStack(spacing: 12) {

            Text(sign.symbol)
                .font(.system(size: 48))
                //.foregroundStyle(sign.gradient)

            Text(sign.title)
                .font(.headline)

            Text(sign.dateRange)
                .font(.caption)
                //.opacity(0.7)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 170)
        .background(sign.gradient.opacity(0.8))
        /*.background {
            RoundedRectangle(
                cornerRadius: 28
            )
            .fill(.ultraThinMaterial)
            RoundedRectangle(
                cornerRadius: 28
            )
            .stroke(
                sign.gradient,
                lineWidth: 1.5
            )
        }*/
        .shadow(
            color: .purple.opacity(0.35),
            radius: 15
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 28,
                style: .continuous
            )
        )
        
        
    }
}
