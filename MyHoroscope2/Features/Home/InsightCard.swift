//
//  InsightCard.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI


struct InsightCard: View {
    
    let text: String


    var body: some View {


        VStack(
            alignment:.leading,
            spacing:12
        ){


            HStack {


                Image(
                    systemName:
                    "sparkles"
                )
                .foregroundStyle(
                    .yellow
                )


                Text("Cosmic Insight")
                    .font(.headline)
                Spacer()

            }


            Text(text)
            .font(.body)

            Spacer()
        }
        .astroCard()
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)


    }
}
