//
//  NatalChartCalculator.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation

final class NatalChartCalculator {

    static let shared =
    NatalChartCalculator()

    private init() {}

    func calculate(
        user: UserProfile
    ) -> BirthChartReading {

        let signs =
        ZodiacSign.allCases
            .map(\.title)

        let moon =
        signs.randomElement() ?? "Virgo"

        let rising =
        signs.randomElement() ?? "Leo"

        return BirthChartReading(

            sun: user.zodiac.title,

            moon: moon,

            rising: rising,

            mercury: moon,

            venus: rising,

            mars: user.zodiac.title,

            reading: ""
        )
    }
}

extension BirthChartReading {

    static var schema: JSONSchema {

        JSONSchema(

            name: "birth_chart",

            strict: true,

            schema: Schema(

                type: "object",
                additionalProperties:false,
                properties: [

                    "sun":
                        Property(type:"string"),

                    "moon":
                        Property(type:"string"),

                    "rising":
                        Property(type:"string"),

                    "mercury":
                        Property(type:"string"),

                    "venus":
                        Property(type:"string"),

                    "mars":
                        Property(type:"string"),

                    "reading":
                        Property(type:"string")
                ],

                required: [

                    "sun",
                    "moon",
                    "rising",
                    "mercury",
                    "venus",
                    "mars",
                    "reading"
                ]
            )
        )
    }
}
