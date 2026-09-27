//
//  ChartReadyView.swift
//  MyHoroscope2
//
//  Created by admin on 24.06.2026.
//


import SwiftUI


struct ChartReadyView: View {


    let action: () -> Void


    var body: some View {


        VStack(spacing:25) {


            Text("✨")
                .font(
                    .system(size:90)
                )


            Text(
                "Your Chart Is Ready"
            )
            .font(
                .largeTitle.bold()
            )


            Text(
                "Your planets and cosmic energy have been calculated."
            )
            .multilineTextAlignment(.center)



            Button(
                action: action
            ) {

                Text(
                    "Enter App"
                )
                .frame(
                    maxWidth:.infinity
                )
                .padding()

            }
            .buttonStyle(
                CosmicButtonStyle()
            )


        }
        .padding()
        .foregroundStyle(.white)
    }
}