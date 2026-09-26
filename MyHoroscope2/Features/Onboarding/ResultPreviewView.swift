//
//  ResultPreviewView.swift
//  MyHoroscope2
//
//  Created by admin on 24.06.2026.
//


import SwiftUI

struct ResultPreviewView: View {

    let profileText: String

    @State private var showPaywall = false

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                Text(Image(systemName: "sparkles"))
                    .font(
                        .system(size: 80)
                    )
                    .foregroundStyle(.yellow)

                Text(
                    "Your Profile"
                )
                .font(
                    .largeTitle.bold()
                )

                GlowCard {

                    Text(profileText)
                        .foregroundStyle(
                            .white
                        )
                    
                }

                /*Button {
                    showPaywall = true
                } label: {
                    Text(
                        "Unlock Full Reading"
                    )
                    .frame(
                        maxWidth: .infinity
                    )
                    .padding()
                }
                .buttonStyle(CosmicButtonStyle())*/
                
                GradientButton(title: "Unlock Full Reading", action: {
                    showPaywall = true
                })
            }
            .padding()
        }
        .fullScreenCover(isPresented: $showPaywall) {
            PaywallView()
        }
    }
    
    
}

