//
//  ChatBubble.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI


struct ChatBubble: View {


    let message:ChatMessage



    var body: some View {


        HStack {


            if message.isUser {

                Spacer()

            }



            Text(message.text)
                .padding()
                .background(

                    message.isUser
                    ? AppColors.purple
                    : AppColors.card

                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 22)
                )
                .foregroundStyle(
                    .white
                )



            if !message.isUser {

                Spacer()

            }


        }

    }

}
