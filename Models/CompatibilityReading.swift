//
//  CompatibilityReading.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation

struct CompatibilityReading: Codable {

    let overallScore: Int

    let loveScore: Int

    let communicationScore: Int

    let friendshipScore: Int

    let longTermScore: Int

    let insight: String
}

extension CompatibilityReading {

    static var schema: JSONSchema {

        JSONSchema(
            name: "compatibility_reading",
            strict: true,
            schema: Schema(
                type: "object",
                additionalProperties:false,
                properties: [

                    "overallScore":
                        Property(type: "integer"),

                    "loveScore":
                        Property(type: "integer"),

                    "communicationScore":
                        Property(type: "integer"),

                    "friendshipScore":
                        Property(type: "integer"),

                    "longTermScore":
                        Property(type: "integer"),

                    "insight":
                        Property(type: "string")
                ],
                required: [
                    "overallScore",
                    "loveScore",
                    "communicationScore",
                    "friendshipScore",
                    "longTermScore",
                    "insight"
                ]
            )
        )
    }
}

extension CompatibilityReading {

    static let fallback =
    CompatibilityReading(
        overallScore: 85,
        loveScore: 88,
        communicationScore: 84,
        friendshipScore: 87,
        longTermScore: 82,
        insight:
"""
This relationship has strong potential through communication and mutual respect.
"""
    )
}
