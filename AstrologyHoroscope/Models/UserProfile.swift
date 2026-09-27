//
//  UserProfile.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation
import SwiftData


@Model
final class UserProfile {

    var birthDate: Date?
    var birthTime: Date?
    var birthCity: String?

    var birthLocation: String

    var zodiac: ZodiacSign

    var latitude: Double
    var longitude: Double


    init(
        birthDate: Date = Date(),
        birthTime: Date? = nil,
        birthCity: String = "",
        birthLocation: String = "",
        zodiac: ZodiacSign = .gemini,
        
        latitude: Double = 0,
        longitude: Double = 0
    ) {

        self.birthDate = birthDate
        self.birthTime = birthTime
        self.birthLocation = birthLocation
        self.zodiac = zodiac
        self.birthCity = birthCity
        self.latitude = latitude
        self.longitude = longitude
    }
}
