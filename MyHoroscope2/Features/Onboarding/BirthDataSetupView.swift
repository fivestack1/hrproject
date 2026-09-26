//
//  BirthDataSetupView.swift
//  MyHoroscope2
//
//  Created by admin on 24.06.2026.
//


import SwiftUI
import SwiftData



struct BirthDataSetupView: View {

    @Environment(\.modelContext)
    private var context

    @Query
    private var users: [UserProfile]

    @State private var birthDate = Date()

    @State private var birthTime = Date()

    @State private var city = ""

    var body: some View {

        ZStack {

            CosmicBackground()

            ScrollView {

                VStack(spacing: 24) {

                    Text(Image(systemName: "moon"))
                        .font(.system(size: 70))
                        .foregroundStyle(.yellow)

                    Text("Complete Your Birth Chart")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)

                    Text(
                        "Your birth details help generate accurate astrology insights."
                    )
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)

                    VStack(spacing: 16) {

                        HStack {

                            Text("Birth Date")

                            DatePicker(
                                "",
                                selection: $birthDate,
                                displayedComponents: .date
                            )
                            .labelsHidden()
                            Spacer()
                        }

                        HStack {

                            Text("Birth Time")

                            DatePicker(
                                "",
                                selection: $birthTime,
                                displayedComponents: .hourAndMinute
                            )
                            .labelsHidden()
                            Spacer()
                        }

                        HStack {

                            Text("Birth City")

                            TextField(
                                "New York",
                                text: $city
                            )
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 18)
                            )
                            Spacer()
                        }
                    }

                    /*Button {
                        saveProfile()
                    } label: {
                        Text("Generate Horoscope")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .buttonStyle(CosmicButtonStyle())*/
                    
                    Text("By tapping Agree you acknowledge and consent to your data may be transmitted to and processed by AI service to generate responses. Please avoid sharing sensitive personal data, confidential details or private information. AI-generated outputs may occasionally be inaccurate.")
                    
                    GradientButton(title: "Agree and Generate Horoscope", action: {
                        saveProfile()
                    })
                    
                }
                .padding()
                .foregroundStyle(.white)
            }
        }
    }

    private func saveProfile() {

        let user = users.first ?? UserProfile()

        user.birthDate = birthDate
        user.birthTime = birthTime
        user.birthCity = city
        
        let newSign =
        ZodiacCalculator.sign(
            from: birthDate
        )
        user.zodiac = newSign

        if users.isEmpty {
            context.insert(user)
        }

        try? context.save()

        NotificationCenter.default.post(
            name: .onboardingFinished,
            object: nil
        )
    }
}
