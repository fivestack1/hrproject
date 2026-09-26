//
//  MyHoroscope2App.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//

import SwiftUI
import SwiftData

@main
struct MyHoroscope2App: App {
    @State
    private var subscription =
        SubscriptionManager.shared
    
    var body: some Scene {
        WindowGroup {
            Group {
                RootView()
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
