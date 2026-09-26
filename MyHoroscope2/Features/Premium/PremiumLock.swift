//
//  PremiumLock.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI



struct PremiumLock: ViewModifier {


    let unlocked:Bool



    func body(
        content:Content
    ) -> some View {


        if unlocked {

            content


        } else {


            content
                .blur(
                    radius:5
                )
                .overlay {


                    Image(
                        systemName:
                        "lock.fill"
                    )
                    .font(.largeTitle)
                    .foregroundStyle(
                        .white
                    )

                }

        }

    }

}


extension View {


    func premiumLocked(
        _ value:Bool
    ) -> some View {


        modifier(
            PremiumLock(
                unlocked:value
            )
        )

    }

}