//
//  ReadingHistoryCard.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI



struct ReadingHistoryCard: View {


    let reading:DailyReading



    var body: some View {


        VStack(
            alignment:.leading,
            spacing:12
        ){


            HStack {


                Text(
                    reading.zodiac
                )
                .font(
                    .headline.bold()
                )


                Spacer()



                Text(
                    reading.date,
                    format:.dateTime.month().day()
                )
                .font(.caption)


            }



            Text(
                reading.overview
            )
            .lineLimit(3)



            HStack {


                Text(
                    "\(reading.loveScore)"
                )


                Text(
                    "\(reading.careerScore)"
                )


                Text(
                    "\(reading.moneyScore)"
                )

            }
            .font(.caption)


        }
        .padding()


        .background(
            .ultraThinMaterial
        )


        .clipShape(
            RoundedRectangle(
                cornerRadius:24
            )
        )


        .foregroundStyle(
            .white
        )

    }

}
