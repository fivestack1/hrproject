//
//  HistoryView.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI
import SwiftData



struct HistoryView: View {


    @Query(
        sort:\DailyReading.date,
        order:.reverse
    )
    private var readings:[DailyReading]


    @State private var selected:
    DailyReading?



    var body: some View {


        NavigationStack {


            ZStack {


                //AppGradients.background.ignoresSafeArea()
                CosmicBackground()

                ScrollView {


                    VStack(
                        spacing:20
                    ){


                        calendar



                        ForEach(
                            readings
                        ){ reading in


                            ReadingHistoryCard(
                                reading:reading
                            )
                            .onTapGesture {

                                selected =
                                reading

                            }

                        }


                    }
                    .padding()

                }

            }

            .navigationTitle(
                "History"
            )
            .toolbarTitleDisplayMode(.inline)
            .sheet(
                item:$selected
            ){ item in

                ReadingDetailView(
                    reading:item
                )

            }

        }

    }



    var calendar: some View {


        HStack{


            Text(
                "Saved readings"
            )
            .font(
                .title2.bold()
            )

            Spacer()

            Text(
                "\(readings.count) insights"
            )
            .foregroundStyle(.secondary)
            

        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)

    }

}
