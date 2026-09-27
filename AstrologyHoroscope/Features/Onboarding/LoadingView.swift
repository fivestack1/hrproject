//
//  LoadingView.swift
//  MyHoroscope2
//
//  Created by admin on 24.06.2026.
//


import SwiftUI

struct LoadingView: View {

    @State private var text =

    "Reading cosmic energy..."

    var body: some View {

        VStack(spacing: 25) {

            ProgressView()
                .scaleEffect(2)

            Text(text)
                .font(
                    .title3.bold()
                )
        }
        .foregroundStyle(.white)

        .task {

            let items = [

                "Reading cosmic energy...",
                "Matching planetary patterns...",
                "Analyzing hidden strengths...",
                "Building your profile..."
            ]

            for item in items {

                text = item

                try? await Task.sleep(
                    for: .seconds(1)
                )
            }
        }
    }
}