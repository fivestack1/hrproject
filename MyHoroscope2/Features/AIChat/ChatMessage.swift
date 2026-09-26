//
//  ChatMessage.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation
import SwiftData


@Model
final class ChatMessage {


    var id: UUID

    var text: String

    var isUser: Bool

    var createdAt: Date



    init(
        text:String,
        isUser:Bool
    ){

        self.id = UUID()

        self.text = text

        self.isUser = isUser

        self.createdAt = Date()
    }

}
