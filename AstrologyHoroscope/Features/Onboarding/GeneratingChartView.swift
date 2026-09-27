//
//  GeneratingChartView.swift
//  MyHoroscope2
//
//  Created by admin on 24.06.2026.
//


import SwiftUI


struct GeneratingChartView: View {


    var body: some View {


        VStack(spacing:25) {


            ProgressView()
                .scaleEffect(2)



            Text(
"""
Reading your planets...
Calculating your cosmic pattern...
Creating your birth chart...
"""
            )
            .multilineTextAlignment(.center)
            .font(.title3.bold())


        }
        .foregroundStyle(.white)

    }
}