//
//  AppGradients.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI

enum AppGradients {

    static let background = LinearGradient(
        colors: [
            Color.black,
            Color.indigo.opacity(0.4),
            Color.black
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let purpleCard = LinearGradient(
        colors: [
            //.purple,
            .orange,
            .pink
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
