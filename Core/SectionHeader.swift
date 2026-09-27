//
//  SectionHeader.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI

struct SectionHeader: View {

    let title: String

    var body: some View {

        HStack {

            Text(title)
                .font(.title3.bold())

            Spacer()
        }
        .foregroundStyle(.white)
    }
}