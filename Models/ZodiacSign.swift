//
//  ZodiacSign.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI

enum ZodiacSign: String, CaseIterable, Codable, Identifiable {

    case aries
    case taurus
    case gemini
    case cancer
    case leo
    case virgo
    case libra
    case scorpio
    case sagittarius
    case capricorn
    case aquarius
    case pisces

    var id: String { rawValue }

    var title: String {
        switch self {
        case .aries: return "Aries"
        case .taurus: return "Taurus"
        case .gemini: return "Gemini"
        case .cancer: return "Cancer"
        case .leo: return "Leo"
        case .virgo: return "Virgo"
        case .libra: return "Libra"
        case .scorpio: return "Scorpio"
        case .sagittarius: return "Sagittarius"
        case .capricorn: return "Capricorn"
        case .aquarius: return "Aquarius"
        case .pisces: return "Pisces"
        }
    }

    var symbol: String {
        switch self {
        case .aries: return "♈︎"
        case .taurus: return "♉︎"
        case .gemini: return "♊︎"
        case .cancer: return "♋︎"
        case .leo: return "♌︎"
        case .virgo: return "♍︎"
        case .libra: return "♎︎"
        case .scorpio: return "♏︎"
        case .sagittarius: return "♐︎"
        case .capricorn: return "♑︎"
        case .aquarius: return "♒︎"
        case .pisces: return "♓︎"
        }
    }

    var dateRange: String {
        switch self {
        case .aries: return "Mar 21 - Apr 19"
        case .taurus: return "Apr 20 - May 20"
        case .gemini: return "May 21 - Jun 20"
        case .cancer: return "Jun 21 - Jul 22"
        case .leo: return "Jul 23 - Aug 22"
        case .virgo: return "Aug 23 - Sep 22"
        case .libra: return "Sep 23 - Oct 22"
        case .scorpio: return "Oct 23 - Nov 21"
        case .sagittarius: return "Nov 22 - Dec 21"
        case .capricorn: return "Dec 22 - Jan 19"
        case .aquarius: return "Jan 20 - Feb 18"
        case .pisces: return "Feb 19 - Mar 20"
        }
    }

    var gradient: LinearGradient {

        switch self {

        case .aries:
            return LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.25, blue: 0.15),
                    Color(red: 0.95, green: 0.55, blue: 0.15)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .taurus:
            return LinearGradient(
                colors: [
                    Color(red: 0.15, green: 0.65, blue: 0.35),
                    Color(red: 0.05, green: 0.35, blue: 0.20)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .gemini:
            return LinearGradient(
                colors: [
                    Color(red: 0.65, green: 0.35, blue: 1.0),
                    Color(red: 0.25, green: 0.55, blue: 1.0)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .cancer:
            return LinearGradient(
                colors: [
                    Color(red: 0.2, green: 0.75, blue: 1.0),
                    Color(red: 0.15, green: 0.35, blue: 0.85)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .leo:
            return LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.65, blue: 0.15),
                    Color(red: 0.95, green: 0.25, blue: 0.15)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .virgo:
            return LinearGradient(
                colors: [
                    Color(red: 0.45, green: 0.9, blue: 0.65),
                    Color(red: 0.15, green: 0.55, blue: 0.45)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .libra:
            return LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.55, blue: 0.8),
                    Color(red: 0.65, green: 0.35, blue: 1.0)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .scorpio:
            return LinearGradient(
                colors: [
                    Color(red: 0.45, green: 0.05, blue: 0.25),
                    Color(red: 0.95, green: 0.1, blue: 0.35)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .sagittarius:
            return LinearGradient(
                colors: [
                    Color(red: 0.2, green: 0.45, blue: 1.0),
                    Color(red: 0.55, green: 0.2, blue: 1.0)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .capricorn:
            return LinearGradient(
                colors: [
                    Color(red: 0.35, green: 0.25, blue: 0.75),
                    Color(red: 0.95, green: 0.65, blue: 0.25)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .aquarius:
            return LinearGradient(
                colors: [
                    Color(red: 0.1, green: 0.85, blue: 1.0),
                    Color(red: 0.25, green: 0.3, blue: 1.0)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .pisces:
            return LinearGradient(
                colors: [
                    Color(red: 0.35, green: 0.2, blue: 1.0),
                    Color(red: 0.15, green: 0.8, blue: 0.95)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}
