//
//  BirthChartView.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI
import SwiftData



struct BirthChartView: View {

    @Query private var users:[UserProfile]

    var user:UserProfile? {
        users.first
    }

    @Environment(SubscriptionManager.self)
    private var premium
    
    @State private var chart: BirthChartReading?

    @State private var loading = false


    var body: some View {


NavigationStack {
    ZStack {
        
        
        //AppGradients.background.ignoresSafeArea()
        CosmicBackground()
        
        
        
            ScrollView {
                
                
                VStack(
                    spacing:25
                ){
                    
                    
                    
                    //title
                    
                    if !premium.isSubscribed {
                        premiumCard()
                    }
                    
                    VStack {
                        
                        
                        
                        if let chart {
                            AstrologyWheel(
                                chart: chart
                            )
                            .padding(.bottom, 20)
                        }
                        
                        
                        
                        
                        placements
                        
                        
                        
                        aiReading
                        
                        
                    }
                    .premiumLocked(
                        premium.isSubscribed
                    )
                    
                    
                    
                    
                }
                .padding()
                
            }
        
        }
    .task {
        if premium.isSubscribed {
            await loadChart()
        }
    }
    .navigationTitle("Birth Chart")
    .toolbarTitleDisplayMode(.inlineLarge)
    }


    }


    @MainActor
    func loadChart() async {


        guard let user else {
            return
        }


        guard let date = user.birthDate,
              let time = user.birthTime
        else {
            return
        }



        loading = true


        let birth =
        BirthData(

            date:date,

            time:time,

            city:
            user.birthCity ?? "",

            latitude:
            user.latitude,

            longitude:
            user.longitude
        )



        do {


            let calculated =
                try await AstrologyAPIService.shared.calculateChart(
                    birth: birth
                )

            chart =
                try await AIService.shared.generateBirthChartReading(
                    birth: calculated
                )


        } catch {


            print(
                error
            )


        }


        loading = false
    }


    var title:some View {


        VStack(
            spacing:8
        ){


            Text(
                "Your Birth Chart"
            )
            .font(
                .largeTitle.bold()
            )



        }
        .foregroundStyle(
            .white
        )

    }





    var placements:some View {


        VStack(
            spacing:12
        ){



            SectionHeader(
                title:"Planet Placements"
            )



            if let chart {

                PlanetCard(
                    icon:"☀️",
                    title:"Sun",
                    value: chart.sun
                )
                
                PlanetCard(
                    icon:"🌙",
                    title:"Moon",
                    value: chart.moon
                )

                PlanetCard(
                    icon:"☿",
                    title:"Mercury",
                    value: chart.mercury
                )

                PlanetCard(
                    icon:"♀",
                    title:"Venus",
                    value: chart.venus
                )

                PlanetCard(
                    icon:"♂",
                    title:"Mars",
                    value: chart.mars
                )

                PlanetCard(
                    icon:"⬆️",
                    title:"Rising",
                    value: chart.rising
                )

            }


        }


    }





    var aiReading:some View {


        VStack(
            alignment:.leading,
            spacing:12
        ){


            Text(
                "Birth Reading"
            )
            .font(
                .headline
            )


            if let chart {
                Text(chart.reading)
            }


        }
        .astroCard()
        .foregroundStyle(
            .white
        )


    }





    

}
