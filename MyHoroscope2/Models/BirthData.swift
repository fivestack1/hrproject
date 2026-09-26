//
//  BirthData.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation


struct BirthData: Codable {

    let date: Date

    let time: Date

    let city: String

    let latitude: Double

    let longitude: Double
}