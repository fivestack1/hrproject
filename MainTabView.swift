//
//  MainTabView.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI

struct MainTabView: View {

    var body: some View {

        TabView {

            HomeView()
                .tabItem {
                    Label(
                        "Home",
                        systemImage: "sparkles"
                    )
                }

            HoroscopeView()
                .tabItem {
                    Label(
                        "Horoscope",
                        systemImage: "moon.stars"
                    )
                }

            CompatibilityView()
                .tabItem {
                    Label(
                        "Match",
                        systemImage: "heart.circle"
                    )
                }

            AIChatView()
                .tabItem {
                    Label(
                        "Astrologer",
                        systemImage: "wand.and.stars"
                    )
                }
            
            BirthChartView()
                .tabItem {

                    Label(
                        "Chart",
                        systemImage:
                        "gauge.chart.leftthird.topthird.rightthird"
                    )

                }


        }
        //.tint(AppColors.blue)
        .tint(.white)
    }
}
