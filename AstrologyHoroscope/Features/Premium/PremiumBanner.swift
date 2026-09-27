//
//  PremiumManager.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI

struct premiumCard: View {
    @State private var isShowingSheet = false
    var body: some View {
        VStack(
            alignment: .leading,
            spacing:15
        ){
            
            HStack {
                Text(
                    "Unlock All Features"
                )
                .font(
                    .title3.bold()
                )
                Spacer()
            }
                
                
                Text(
                    "Get insights, connections and future predictions"
                ).font(
                    .caption
                )
            
            
            
            GradientButton(
                title:
                    "Unlock Premium"
            ){
                isShowingSheet = true
            }
            
            
            
        }
        .astroCard()
        .foregroundStyle(
            .white
        )
        .frame(maxWidth: .infinity)
        .fullScreenCover(isPresented: $isShowingSheet) {
            PaywallView()
        }
    }
}
