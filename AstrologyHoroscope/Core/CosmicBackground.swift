//
//  CosmicBackground.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI

struct CosmicBackground: View {

    var body: some View {

        GeometryReader { geo in

            ZStack {

                NebulaBackground()

                StarField()


                Color.black.opacity(0.25)
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
}
struct CosmicBackground1: View {

    var body: some View {

        GeometryReader { geo in

            ZStack {

                Image("Bg")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height
                    )
                    .clipped()


                Color.black.opacity(0.25)
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
}
