//
//  StarField.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI

struct StarField: View {

    @State private var stars: [Star] = []

    var body: some View {

        GeometryReader { geo in

            TimelineView(.animation) { _ in

                Canvas { context, size in

                    for star in stars {

                        let rect = CGRect(
                            x: star.x * size.width,
                            y: star.y * size.height,
                            width: star.size,
                            height: star.size
                        )

                        context.fill(
                            Path(ellipseIn: rect),
                            with: .color(.white.opacity(star.opacity))
                        )
                    }
                }
            }
        }
        .onAppear {

            stars = (0..<120).map { _ in

                Star(
                    x: .random(in: 0...1),
                    y: .random(in: 0...1),
                    size: .random(in: 1...3),
                    opacity: .random(in: 0.2...1)
                )
            }
        }
    }
}

struct Star {

    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
    let opacity: Double
}