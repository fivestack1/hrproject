//
//  UserAstrologyContext.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation


struct UserAstrologyContext {


    let zodiac: String

    let moon: String

    let rising: String

    let todayInsight: String

    let moonPhase: String



    var prompt: String {


"""
User astrology profile:

Sun sign:
\(zodiac)

Moon sign:
\(moon)

Rising sign:
\(rising)

Today's horoscope:
\(todayInsight)

Moon phase:
\(moonPhase)

Use this information
when answering.
"""
    }
}