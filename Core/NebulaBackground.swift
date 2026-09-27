//
//  NebulaBackground.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI

struct NebulaBackground: View {

    @State private var animate = false

    var body: some View {

        ZStack {

            RadialGradient(
                colors: [
                    .blue.opacity(0.6),
                    .clear
                ],
                center: animate ? .topLeading : .bottomTrailing,
                startRadius: 50,
                endRadius: 500
            )

            RadialGradient(
                colors: [
                    .pink.opacity(0.5),
                    .clear
                ],
                center: animate ? .bottomTrailing : .topLeading,
                startRadius: 50,
                endRadius: 450
            )
        }
        /*.animation(
            .easeInOut(duration: 10)
            .repeatForever(autoreverses: true),
            value: animate
        )
        .onAppear {

            animate = true
        }*/
    }
}
