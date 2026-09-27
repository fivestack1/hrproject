//
//  PlanetCard.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI


struct PlanetCard: View {


    let icon:String

    let title:String

    let value:String



    var body: some View {


        HStack {


            Text(icon)
                .font(.largeTitle)



            VStack(
                alignment:.leading
            ){

                Text(title)
                    .font(.caption)
                    .opacity(0.7)



                Text(value)
                    .font(
                        .headline.bold()
                    )

            }



            Spacer()


        }
        .padding()
        .background(
            AppColors.card
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 22)
        )
        .foregroundStyle(
            .white
        )

    }

}
