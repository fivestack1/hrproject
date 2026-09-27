//
//  MoonAIService.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation


final class MoonAIService {


    static let shared =
    MoonAIService()


    private init(){}



    func generate(
        moon: MoonPhase,
        sign: String
    ) async throws -> String {


        try await AIService.shared.ask(

            prompt: """
The moon phase today is:

\(moon.name)

Sign is:

\(sign)

Illumination:
\(moon.illumination)%

Give a short astrology style
guidance for:
- emotions
- relationships
- productivity

Keep it under 120 words.
"""
        )

    }

}
