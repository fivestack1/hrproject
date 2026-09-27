//
//  HoroscopeAI.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation



final class HoroscopeAI {


    static func generate(
        sign: ZodiacSign
    ) async throws -> String {


        try await AIService.shared.ask(

            prompt: """
Create today's horoscope.

Zodiac sign:
\(sign.title)

Include:
- general energy
- love
- career
- advice

Keep it under 200 words.
"""

        )

    }

}
