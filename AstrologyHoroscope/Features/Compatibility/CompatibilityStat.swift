//
//  CompatibilityStat.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI


struct CompatibilityStat: View {


    let icon:String
    let title:String
    let value:String
    let color:Color



    var body: some View {


        VStack(
            spacing:10
        ){


            Text(Image(systemName: icon))
                .font(.title)
                .foregroundStyle(color)



            Text(value)
                .font(
                    .title2.bold()
                )


            HStack{
                Text(title)
                    .font(.caption)
                    .opacity(0.7)
                
                Spacer()
            }


        }
        .frame(
            maxWidth:.infinity,
            minHeight:100
        )
        .astroCard()
        .foregroundStyle(.white)

    }
}
