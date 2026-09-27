//
//  AIReading.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation
import SwiftData



@Model
final class AIReading {


    var title:String

    var content:String

    var createdAt:Date



    init(
        title:String,
        content:String
    ){

        self.title = title

        self.content = content

        self.createdAt = Date()

    }

}