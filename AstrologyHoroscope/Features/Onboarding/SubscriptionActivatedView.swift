//
//  SubscriptionActivatedView.swift
//  MyHoroscope2
//
//  Created by admin on 24.06.2026.
//


import SwiftUI


struct SubscriptionActivatedView: View {


    let action: () -> Void


    var body: some View {


        VStack(spacing:30) {


            Text("🎉")
                .font(
                    .system(size:90)
                )


            Text(
                "Subscription Activated"
            )
            .font(
                .largeTitle.bold()
            )
            .multilineTextAlignment(.center)



            Text(
"""
Your premium journey begins.

Next step:
Generate your personal birth chart.
"""
            )
            .multilineTextAlignment(.center)
            .foregroundStyle(
                .secondary
            )


            Button(
                action: action
            ) {

                Text(
                    "Create My Birth Chart"
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
