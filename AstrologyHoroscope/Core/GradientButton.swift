//
//  GradientButton.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI

struct GradientButton: View {

    let title: String
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    AppGradients.purpleCard
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 18
                    )
                )
        }
        .foregroundStyle(.white)
    }
}