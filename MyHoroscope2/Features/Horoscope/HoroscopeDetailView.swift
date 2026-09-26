//
//  HoroscopeDetailView.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI


struct HoroscopeDetailView: View {


    let sign: ZodiacSign


    @State private var selected =
        "Today"



    let tabs = [
        "Today",
        "Week",
        "Month",
        "Year"
    ]
    
    @State private var aiText = ""
    @State private var loading = false



    var body: some View {


        ZStack {


            //AppGradients.background.ignoresSafeArea()
            CosmicBackground()


            ScrollView {


                VStack(
                    spacing:20
                ) {



                    header



                    Picker(
                        "",
                        selection:$selected
                    ){

                        ForEach(
                            tabs,
                            id:\.self
                        ){ tab in


                            Text(tab)
                                .tag(tab)

                        }

                    }
                    .pickerStyle(
                        .segmented
                    )



                    ReadingCard(
                        icon:"✨",
                        title:"Overview",
                        text:
                        overviewText
                    )



                    ReadingCard(
                        icon:"❤️",
                        title:"Love",
                        text:
                        "Your relationships feel more balanced today. Open communication creates stronger connections."
                    )



                    ReadingCard(
                        icon:"💼",
                        title:"Career",
                        text:
                        "A good day to focus on goals and new opportunities."
                    )



                    ReadingCard(
                        icon:"🧘",
                        title:"Health",
                        text:
                        "Balance your energy. Rest and mindfulness will help."
                    )
                    
                    Button {
                        loading = true
                        Task {
                            aiText =
                            try await HoroscopeAI
                            .generate(
                                sign:sign
                            )
                            loading = false
                        }
                    } label:{
                        Text(
                            "Generate AI Horoscope ✨"
                        )
                    }
                    
                    if !aiText.isEmpty {
                        ReadingCard(
                            icon:"🤖",
                            title:"AI Reading",
                            text:aiText
                        )

                    }


                }
                .padding()

            }


        }
        .navigationTitle(
            sign.title
        )
        .navigationBarTitleDisplayMode(
            .inline
        )

    }



    var header: some View {


        VStack(
            spacing:12
        ){


            Text(sign.symbol)
                .font(
                    .system(
                        size:90
                    )
                )



            Text(
                sign.title
            )
            .font(
                .largeTitle.bold()
            )


            Text(
                sign.dateRange
            )
            .opacity(0.7)



        }
        .foregroundStyle(
            .white
        )
        .frame(
            maxWidth:.infinity
        )
        .padding()
        .background(
            sign.gradient
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 30)
        )

    }



    var overviewText:String {


        switch selected {


        case "Week":

            return "This week brings new motivation and important decisions."

        case "Month":

            return "The month focuses on growth, relationships and confidence."

        case "Year":

            return "A year of transformation and personal development."

        default:

            return "Your energy is strong today. Follow your intuition and stay open to new possibilities."

        }

    }

}
