//
//  AstroCard.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI

struct AstroCard<Content: View>: View {

    @ViewBuilder
    let content: Content

    var body: some View {
        content
            .astroCard()
    }
}