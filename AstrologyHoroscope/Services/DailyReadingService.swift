//
//  DailyReadingService.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation
import SwiftData


@MainActor
final class DailyReadingService {

    static let shared =
    DailyReadingService()

    private init() {}


    func reading(
        sign: ZodiacSign,
        context: ModelContext
    ) async throws -> DailyReading {


        let calendar =
        Calendar.current


        let today =
        calendar.startOfDay(
            for: Date()
        )


        let descriptor =
        FetchDescriptor<DailyReading>()


        let readings =
        try context.fetch(
            descriptor
        )


        print(
            "Cached readings:",
            readings.count
        )


        if let cached =
            readings.first(
                where: {

                    $0.zodiac ==
                    sign.rawValue &&

                    calendar.isDate(
                        $0.date,
                        inSameDayAs:
                        today
                    )

                }
            ) {


            print(
                "Using cached reading"
            )


            return cached
        }



        print(
            "Generating AI reading..."
        )


        let generated: HomeReading


        do {

            generated =
            try await AIService.shared
                .generateDashboard(
                    sign: sign
                )

        } catch {

            print(
                "AI failed:",
                error
            )


            generated =
            HomeReading.fallback
        }



        let reading =
        DailyReading(

            zodiac:
                sign.rawValue,

            date:
                today,

            overview:
                generated.overview,

            luckyNumber:
                generated.luckyNumber,

            luckyColor:
                generated.luckyColor,

            loveScore:
                generated.loveScore,

            careerScore:
                generated.careerScore,

            moneyScore:
                generated.moneyScore,

            healthScore:
                generated.healthScore,

            aiInsight:
                generated.aiInsight
        )



        context.insert(
            reading
        )


        do {

            try context.save()

            print(
                "Saved reading"
            )

        } catch {

            print(
                "Save failed:",
                error
            )
        }


        return reading
    }
}
