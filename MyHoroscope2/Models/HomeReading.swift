//
//  HomeReading.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation

struct HomeReading: Codable {

    let overview: String

    let luckyNumber: String

    let luckyColor: String

    let loveScore: Int

    let careerScore: Int

    let moneyScore: Int

    let healthScore: Int

    let aiInsight: String
}

extension HomeReading {

    static var schema: JSONSchema {

        JSONSchema(
            name: "daily_horoscope",
            strict: true,
            schema: Schema(
                type: "object",
                additionalProperties:false,
                properties: [

                    "overview":
                        Property(type: "string"),

                    "luckyNumber":
                        Property(type: "string"),

                    "luckyColor":
                        Property(type: "string"),

                    "loveScore":
                        Property(type: "integer"),

                    "careerScore":
                        Property(type: "integer"),

                    "moneyScore":
                        Property(type: "integer"),

                    "healthScore":
                        Property(type: "integer"),

                    "aiInsight":
                        Property(type: "string")
                ],

                required: [
                    "overview",
                    "luckyNumber",
                    "luckyColor",
                    "loveScore",
                    "careerScore",
                    "moneyScore",
                    "healthScore",
                    "aiInsight"
                ]
            )
        )
    }
}

extension HomeReading {

    static let fallback =
    HomeReading(

        overview:
"""
Today encourages reflection and balance.
""",

        luckyNumber: "7",

        luckyColor: "Blue",

        loveScore: 85,

        careerScore: 82,

        moneyScore: 80,

        healthScore: 84,

        aiInsight:
"""
Focus on long-term goals today.
"""
    )
}
