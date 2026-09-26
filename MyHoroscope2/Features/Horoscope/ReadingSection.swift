//
//  ReadingSection.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI


struct ReadingSection: View {


    let icon:String

    let title:String

    let text:String



    var body: some View {


        VStack(
            alignment:.leading,
            spacing:12
        ){


            HStack {


                Text(Image(systemName: icon))
                    .font(.title)



                Text(title)
                    .font(
                        .headline.bold()
                    )
Spacer()

            }


            Text(text)
                .font(.body)
                .opacity(0.85)



        }
        .padding()

        .background(
            AppColors.card
        )

        .clipShape(
            RoundedRectangle(
                cornerRadius: 24
            )
        )

        .foregroundStyle(
            .white
        )

    }
}
