//
//  RootView.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI
import SwiftData


struct RootView: View {

    
    @Query
    private var users: [UserProfile]

    var body: some View {

            if users.isEmpty {
                
                OnboardingView()
                
                
            } else {
                
                MainTabView()
                
            }
            

    }
}
