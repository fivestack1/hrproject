//
//  HomeAIService.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation

final class HomeAIService {

    static let shared = HomeAIService()

    private init() {}

    func generateHomeReading(
        sign: ZodiacSign
    ) async throws -> HomeReading {

        let prompt = """

        Create a horoscope dashboard for \(sign.title).

        Return ONLY valid JSON.

        {
          "overview":"",
          "luckyNumber":"",
          "luckyColor":"",
          "loveScore":0,
          "careerScore":0,
          "moneyScore":0,
          "healthScore":0,
          "aiInsight":""
        }

        loveScore, careerScore,
        moneyScore, healthScore
        must be integers from 60-99.

        """

        let result = try await AIService.shared.ask(
            prompt: prompt
        )

        let data = Data(result.utf8)

        return try JSONDecoder()
            .decode(
                HomeReading.self,
                from: data
            )
    }
    
    
}
