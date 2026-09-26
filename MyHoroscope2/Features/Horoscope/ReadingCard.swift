//
//  ReadingCard.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI


struct ReadingCard: View {

    let icon: String
    let title: String
    let text: String


    var body: some View {

        VStack(
            alignment:.leading,
            spacing:14
        ) {


            HStack {

                Text(icon)
                    .font(.title)

                Text(title)
                    .font(.headline)

            }


            Text(text)
                .font(.body)
                .foregroundStyle(
                    .white.opacity(0.75)
                )


        }
        .frame(
            maxWidth:.infinity,
            alignment:.leading
        )
        .astroCard()
        .foregroundStyle(.white)

    }
}