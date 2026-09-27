//
//  MoonCard.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI


struct MoonCard: View {

    @State private var moon: MoonPhase?

    @State private var moonText = ""
    var sign = ""
    
    var body: some View {


        HStack {


            if let moon {


                VStack(alignment: .leading) {

                HStack {
                    Text(
                        Image(systemName: moon.emoji)
                        
                    )
                    .font(
                        .system(
                            size:50
                        )
                    )
                    

                    Text(
                        moon.name
                    )
                    .font(
                        .title2
                    )
                }



            ProgressView(
                value:
                Double(
                    moon.illumination
                ),
                total:100
            )
            .padding(.bottom, 10)

                Spacer()

            /*Text(
                "\(moon.illumination)% illumination"
            )
            .font(.body)*/


            Text(
                moonText
            )
            .font(.body)


            }


            }


            Spacer()

        }
        .astroCard()
        .foregroundStyle(.white)
        .task {
            await loadMoon()

        }

    }
    
    @MainActor
    func loadMoon() async {


        let phase =
        MoonCalculator
            .shared
            .calculate()


        moon = phase



        do {

            moonText =
            try await MoonAIService
                .shared
                .generate(
                    moon:phase,
                    sign: sign
                )


        } catch {

            moonText =
            phase.description
        }

    }
}
