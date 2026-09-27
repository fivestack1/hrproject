//
//  SignSelectorCard.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI


struct SignSelectorCard: View {

    let title: String
    let sign: ZodiacSign
    let action: () -> Void


    var body: some View {


        Button(
            action: action
        ) {


            VStack(
                spacing:12
            ) {


                Text(title)
                    .font(.caption)
                    .opacity(0.7)



                Text(sign.symbol)
                    .font(
                        .system(
                            size:55
                        )
                    )


                Text(sign.title)
                    .font(.headline)



            }
            .frame(
                maxWidth:.infinity
            )
            .frame(
                height:150
            )
            .background(
                sign.gradient
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 26)
            )

        }
        .foregroundStyle(.white)

    }
}
