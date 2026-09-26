//
//  ZodiacDetailView.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI


struct ZodiacDetailView: View {


    let sign: ZodiacSign


    @State private var reading: ZodiacReading?

    @State private var loading = false


    var body: some View {


        ZStack {


            //AppGradients.background.ignoresSafeArea()
            CosmicBackground()


            ScrollView {


                VStack(
                    spacing:20
                ){

                        
                        header
                        
                        if loading {
                            
                            
                            ProgressView()
                                .tint(.white)
                            
                            
                        }
                        
                        
                        
                        if let reading {
                            
                            
                            ReadingSection(
                                icon:"sparkles",
                                title:"Personality",
                                text:
                                    reading.personality
                            )
                            
                            
                            ReadingSection(
                                icon:"heart.fill",
                                title:"Love",
                                text:
                                    reading.love
                            )
                            
                            
                            ReadingSection(
                                icon:"case.fill",
                                title:"Career",
                                text:
                                    reading.career
                            )
                            
                            
                            ReadingSection(
                                icon:"star.fill",
                                title:"Strengths",
                                text:
                                    reading.strengths
                            )
                            
                            
                            ReadingSection(
                                icon:"moonphase.new.moon",
                                title:"Challenges",
                                text:
                                    reading.challenges
                            )
                            
                            
                            ReadingSection(
                                icon:"lasso.badge.sparkles",
                                title:"Advice",
                                text:
                                    reading.advice
                            )
                            
                            
                        }

                }
                .padding()

            }
            .task {
                await loadReading()
            }

        }
        
        .navigationTitle(
            "Horoscope"
        )
        .navigationBarTitleDisplayMode(
            .inline
        )

    }



    var header: some View {


        VStack(
            spacing:15
        ){


            Text(
                sign.symbol
            )
            .font(
                .system(
                    size:90
                )
            )
            .foregroundStyle(sign.gradient)


            Text(
                sign.title
            )
            .font(
                .largeTitle.bold()
            )
            



        }
        .foregroundStyle(
            .white
        )

    }



    @MainActor
    func loadReading() async {


        loading = true


        do {


            reading =
            try await AIService.shared
                .generateZodiacReading(
                    sign: sign
                )


        } catch {


            print(error)


        }


        loading = false

    }

}
