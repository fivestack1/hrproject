//
//  AstrologyHoroscopeApp.swift
//  AstrologyHoroscope
//

import SwiftUI
import SwiftData

@main
struct AstrologyHoroscopeApp: App {
    @State private var subscription = SubscriptionManager.shared
    var body: some Scene {
        WindowGroup {
            Group {
                ContentView()
                    .environment(subscription)
                    .task {
                        await checkSubscription()

                    }
            }
            .preferredColorScheme(.dark)
        }
        .modelContainer(
            for:[
                UserProfile.self,
                ChatMessage.self,
                AIReading.self,
                DailyReading.self
            ]
        )


    }
    
    private func checkSubscription() async {

        subscription.startListening()
        await subscription.updatePurchasedProducts()
    }
}
