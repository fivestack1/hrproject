//
//  HoroscopeHeroCard.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI


struct HoroscopeHeroCard: View {

    let sign: ZodiacSign
    let overview: String
    let luckyNumber: String
    let luckyColor: String

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 10
        ) {


            HStack {

                VStack(
                    alignment:.leading
                ){

                    Text("TODAY'S HOROSCOPE")
                        .font(.caption)
                        .opacity(0.8)


                    Text(
                        "\(sign.title)"
                    )
                    .font(.largeTitle.bold())

                }


                Spacer()


                Text(sign.symbol)
                    .font(
                        .system(
                            size:70
                        )
                    )
            }



            Text(overview)
            .font(.headline)



            Spacer()



            HStack {


                VStack(
                    alignment:.leading
                ){

                    Text("Lucky Number")
                        .font(.caption)


                    Text(luckyNumber)
                        .font(.title.bold())
                }



                Spacer()



                VStack(
                    alignment:.leading
                ){

                    Text("Lucky Color")
                        .font(.caption)


                    Text(luckyColor)
                        .font(.title.bold())
                }

            }

        }
        .padding()
        .frame(
            height:280
        )
        .frame(
            maxWidth:.infinity
        )
        .background(sign.gradient.opacity(0.8))
        .clipShape(
            RoundedRectangle(
                cornerRadius:32,
                style:.continuous
            )
        )
        .foregroundStyle(.white)

    }
}
