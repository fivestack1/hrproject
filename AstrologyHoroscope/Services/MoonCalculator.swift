//
//  MoonCalculator.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation


final class MoonCalculator {


    static let shared =
    MoonCalculator()


    private init(){}



    func calculate(
        date: Date = Date()
    ) -> MoonPhase {


        let knownNewMoon =
        Calendar.current.date(
            from:
            DateComponents(
                year:2024,
                month:1,
                day:11
            )
        )!



        let days =
        Int(
            date.timeIntervalSince(
                knownNewMoon
            )
            /
            86400
        )


        let age =
        days % 29



        switch age {


        case 0...1:

            return MoonPhase(

                name:"New Moon",

                emoji:"moonphase.full.moon.inverse",

                illumination:0,

                age:age,

                description:
                "A time for new beginnings."
            )



        case 2...7:

            return MoonPhase(

                name:"Waxing Crescent",

                emoji:"moonphase.waxing.crescent",

                illumination:25,

                age:age,

                description:
                "Growth and intention energy."
            )



        case 8...15:

            return MoonPhase(

                name:"Full Moon",

                emoji:"moonphase.new.moon.inverse",

                illumination:100,

                age:age,

                description:
                "Peak emotional energy."
            )



        default:

            return MoonPhase(

                name:"Waning Moon",

                emoji:"moonphase.waning.crescent",

                illumination:60,

                age:age,

                description:
                "Reflection and release."
            )
        }
    }

}
