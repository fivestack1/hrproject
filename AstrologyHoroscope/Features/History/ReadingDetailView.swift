//
//  ReadingDetailView.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI



struct ReadingDetailView: View {


    let reading:DailyReading

    @Environment(\.dismiss) private var dismiss
    
    var body: some View {


        ZStack {


            //AppGradients.background.ignoresSafeArea()
            CosmicBackground()

            ScrollView {


                VStack(
                    spacing:20
                ){


                    HStack {
                        Text(
                            reading.zodiac
                        )
                        .font(
                            .largeTitle.bold()
                        )
                        Spacer()
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundStyle(.gray)
                        }
                    }


                    Text(
                        reading.date,
                        format:.dateTime
                    )



                    ReadingSection(
                        icon:"book",
                        title:"Reading",
                        text:
                        reading.overview
                    )



                    ReadingSection(
                        icon:"sparkles",
                        title:"Insight",
                        text:
                        reading.aiInsight
                    )



                }
                .padding()

            }

        }

    }

}
