//
//  CosmicButtonStyle.swift
//  MyHoroscope2
//
//  Created by admin on 24.06.2026.
//


import SwiftUI

/*struct CosmicButtonStyle: ButtonStyle {

    func makeBody(
        configuration: Configuration
    ) -> some View {

        configuration.label

            .font(.headline.weight(.semibold))

            .foregroundStyle(.white)

            .background {

                RoundedRectangle(
                    cornerRadius: 22
                )
                .fill(

                    LinearGradient(

                        colors: [

                            Color.purple,

                            Color.blue

                        ],

                        startPoint: .topLeading,

                        endPoint: .bottomTrailing
                    )
                )
            }

            .scaleEffect(
                configuration.isPressed
                ? 0.97
                : 1
            )

            .shadow(
                color: .purple.opacity(0.5),
                radius: 12
            )

            .animation(
                .easeOut(duration: 0.15),
                value: configuration.isPressed
            )
    }
}*/

struct CosmicButtonStyle: ButtonStyle {

    func makeBody(
        configuration: Configuration
    ) -> some View {

        configuration.label

            .font(.headline.bold())

            .foregroundStyle(.white)

            .padding(.vertical, 4)

            .background {

                RoundedRectangle(
                    cornerRadius: 24
                )
                .fill(.ultraThinMaterial)

                RoundedRectangle(
                    cornerRadius: 24
                )
                .stroke(
                    LinearGradient(
                        colors: [
                            .purple.opacity(0.8),
                            .blue.opacity(0.8)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1.5
                )
            }

            .shadow(
                color: .purple.opacity(0.35),
                radius: 15
            )

            .scaleEffect(
                configuration.isPressed
                ? 0.96
                : 1
            )

            .animation(
                .easeInOut(duration: 0.15),
                value: configuration.isPressed
            )
    }
}

