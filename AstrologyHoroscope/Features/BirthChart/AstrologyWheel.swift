//
//  AstrologyWheel.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI

struct AstrologyWheel: View {

    let chart: BirthChartReading

    @State private var appeared = false

    private let zodiacSymbols = [
        "♈︎",
        "♉︎",
        "♊︎",
        "♋︎",
        "♌︎",
        "♍︎",
        "♎︎",
        "♏︎",
        "♐︎",
        "♑︎",
        "♒︎",
        "♓︎"
    ]

    private let zodiacNames = [
        "Aries",
        "Taurus",
        "Gemini",
        "Cancer",
        "Leo",
        "Virgo",
        "Libra",
        "Scorpio",
        "Sagittarius",
        "Capricorn",
        "Aquarius",
        "Pisces"
    ]

    var body: some View {

        ZStack {

            // MARK: - Outer Glow

            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.purple.opacity(0.18),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 20,
                        endRadius: 150
                    )
                )
                .blur(radius: 12)

            // MARK: - Outer Ring

            Circle()
                .stroke(
                    Color.white.opacity(0.25),
                    lineWidth: 2
                )

            // MARK: - Zodiac Ring

            Circle()
                .stroke(
                    Color.white.opacity(0.15),
                    lineWidth: 1
                )
                .padding(35)

            // MARK: - Zodiac Dividers

            ForEach(0..<12, id: \.self) { index in

                Rectangle()
                    .fill(
                        Color.white.opacity(0.12)
                    )
                    .frame(
                        width: 1,
                        height: 18
                    )
                    .offset(y: -121)
                    .rotationEffect(
                        .degrees(
                            Double(index) * 30
                        )
                    )
            }

            // MARK: - Zodiac Symbols

            ForEach(0..<12, id: \.self) { index in

                zodiacSymbol(
                    index: index
                )
            }

            // MARK: - Inner Circle

            Circle()
                .stroke(
                    Color.white.opacity(0.12),
                    lineWidth: 1
                )
                .padding(70)

            // MARK: - Planet Connections

            planetLines

            // MARK: - Planets

            planetMarker(
                symbol: "☉",
                name: "Sun",
                sign: chart.sun,
                angle: planetAngle(
                    for: chart.sun
                )
            )

            planetMarker(
                symbol: "☽",
                name: "Moon",
                sign: chart.moon,
                angle: planetAngle(
                    for: chart.moon
                )
            )

            planetMarker(
                symbol: "☿",
                name: "Mercury",
                sign: chart.mercury,
                angle: planetAngle(
                    for: chart.mercury
                )
            )

            planetMarker(
                symbol: "♀",
                name: "Venus",
                sign: chart.venus,
                angle: planetAngle(
                    for: chart.venus
                )
            )

            planetMarker(
                symbol: "♂",
                name: "Mars",
                sign: chart.mars,
                angle: planetAngle(
                    for: chart.mars
                )
            )

            // MARK: - Rising

            risingMarker

            // MARK: - Center

            ZStack {

                Circle()
                    .fill(
                        Color.white.opacity(0.05)
                    )
                    .frame(
                        width: 65,
                        height: 65
                    )

                Circle()
                    .stroke(
                        Color.white.opacity(0.15),
                        lineWidth: 1
                    )
                    .frame(
                        width: 65,
                        height: 65
                    )

                Text("✦")
                    .font(
                        .system(
                            size: 28,
                            weight: .light
                        )
                    )
                    .foregroundStyle(
                        .white.opacity(0.85)
                    )
            }
        }
        .frame(
            width: 280,
            height: 280
        )
        .scaleEffect(
            appeared ? 1 : 0.85
        )
        .opacity(
            appeared ? 1 : 0
        )
        .animation(
            .spring(
                response: 0.8,
                dampingFraction: 0.8
            ),
            value: appeared
        )
        .onAppear {
            appeared = true
        }
    }

    // MARK: - Zodiac Symbol

    private func zodiacSymbol(
        index: Int
    ) -> some View {

        Text(
            zodiacSymbols[index]
        )
        .font(
            .system(
                size: 20,
                weight: .medium
            )
        )
        .foregroundStyle(
            .white.opacity(0.85)
        )
        .position(
            x: 140 + cos(
                angleForIndex(index)
            ) * 108,
            y: 140 + sin(
                angleForIndex(index)
            ) * 108
        )
    }

    // MARK: - Planet Marker

    private func planetMarker(
        symbol: String,
        name: String,
        sign: String,
        angle: Double
    ) -> some View {

        let radius = 76.0

        return ZStack {

            Circle()
                .fill(
                    Color.white.opacity(0.08)
                )
                .frame(
                    width: 34,
                    height: 34
                )

            Circle()
                .stroke(
                    Color.white.opacity(0.2),
                    lineWidth: 1
                )
                .frame(
                    width: 34,
                    height: 34
                )

            Text(symbol)
                .font(
                    .system(
                        size: 17,
                        weight: .medium
                    )
                )
        }
        .foregroundStyle(.white)
        .position(
            x: 140 + cos(angle) * radius,
            y: 140 + sin(angle) * radius
        )
    }

    // MARK: - Rising Marker

    private var risingMarker: some View {

        let angle = planetAngle(
            for: chart.rising
        )

        return ZStack {

            Circle()
                .stroke(
                    Color.white.opacity(0.5),
                    lineWidth: 1.5
                )
                .frame(
                    width: 42,
                    height: 42
                )

            Text("ASC")
                .font(
                    .system(
                        size: 8,
                        weight: .bold
                    )
                )
        }
        .foregroundStyle(.white)
        .position(
            x: 140 + cos(angle) * 100,
            y: 140 + sin(angle) * 100
        )
    }

    // MARK: - Planet Lines

    private var planetLines: some View {

        Canvas { context, size in

            let center = CGPoint(
                x: size.width / 2,
                y: size.height / 2
            )

            let planets = [
                chart.sun,
                chart.moon,
                chart.mercury,
                chart.venus,
                chart.mars
            ]

            var points: [CGPoint] = []

            for sign in planets {

                let angle = planetAngle(
                    for: sign
                )

                let point = CGPoint(
                    x: center.x + cos(angle) * 76,
                    y: center.y + sin(angle) * 76
                )

                points.append(point)
            }

            for index in 0..<points.count {

                for secondIndex in (index + 1)..<points.count {

                    var path = Path()

                    path.move(
                        to: points[index]
                    )

                    path.addLine(
                        to: points[secondIndex]
                    )

                    context.stroke(
                        path,
                        with: .color(
                            Color.white.opacity(0.08)
                        ),
                        lineWidth: 1
                    )
                }
            }
        }
        .allowsHitTesting(false)
    }

    // MARK: - Angle

    private func planetAngle(
        for sign: String
    ) -> Double {

        let normalized = sign.lowercased()

        if let index = zodiacNames.firstIndex(
            where: {
                normalized.contains(
                    $0.lowercased()
                )
            }
        ) {

            return angleForIndex(
                index
            )
        }

        return 0
    }

    private func angleForIndex(
        _ index: Int
    ) -> Double {

        let degrees =
            Double(index) * 30.0 - 90.0

        return degrees * .pi / 180
    }
}
