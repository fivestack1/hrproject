//
//  AstrologyContextService.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation
import SwiftData


@MainActor
final class AstrologyContextService {


    static let shared =
    AstrologyContextService()


    private init(){}



    func build(
        user: UserProfile,
        context: ModelContext
    ) -> UserAstrologyContext {


        let moon =
        "Unknown"

        let rising =
        "Unknown"


        let phase =
        MoonCalculator.shared
            .calculate()



        return UserAstrologyContext(

            zodiac:
                user.zodiac.title,

            moon:
                moon,

            rising:
                rising,

            todayInsight:
                "Focus on your personal growth today.",

            moonPhase:
                phase.name
        )
    }
}