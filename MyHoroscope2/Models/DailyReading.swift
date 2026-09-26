//
//  DailyReading.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//

import Foundation
import SwiftData


@Model
final class DailyReading {

    @Attribute(
            .unique
        )
        var id: UUID

    
    var zodiac: String

    var date: Date

    var overview: String

    var luckyNumber: String

    var luckyColor: String

    var loveScore: Int

    var careerScore: Int

    var moneyScore: Int

    var healthScore: Int

    var aiInsight: String


    init(
        zodiac: String,
        date: Date,
        overview: String,
        luckyNumber: String,
        luckyColor: String,
        loveScore: Int,
        careerScore: Int,
        moneyScore: Int,
        healthScore: Int,
        aiInsight: String
    ) {

        id = UUID()
        
        self.zodiac = zodiac
        self.date = date

        self.overview = overview

        self.luckyNumber = luckyNumber
        self.luckyColor = luckyColor

        self.loveScore = loveScore
        self.careerScore = careerScore
        self.moneyScore = moneyScore
        self.healthScore = healthScore

        self.aiInsight = aiInsight
    }
}
