//
//  CompatibilityScore.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI


struct CompatibilityScore: View {


    let value:Int



    var body: some View {


        ZStack {


            Circle()
                .stroke(
                    Color.white.opacity(0.15),
                    lineWidth:18
                )


            Circle()
                .trim(
                    from:0,
                    to:CGFloat(value)/100
                )
                .stroke(
                    AppGradients.purpleCard,
                    style:
                        StrokeStyle(
                            lineWidth:18,
                            lineCap:.round
                        )
                )
                .rotationEffect(
                    .degrees(-90)
                )



            VStack {


                Text("\(value)%")
                    .font(
                        .system(
                            size:45,
                            weight:.bold
                        )
                    )


                Text("Match")
                    .opacity(0.7)


            }


        }
        .frame(
            width:180,
            height:180
        )
        .foregroundStyle(.white)


    }
}
