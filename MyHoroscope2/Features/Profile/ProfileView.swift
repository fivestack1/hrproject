//
//  ProfileView.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI
import SwiftData

struct ProfileView: View {
    
    @Query private var users: [UserProfile]
    var user: UserProfile? {
        users.first
    }
    
    @State private var reminders = false
    @State private var time = Date()
    @State private var isShowingSheet = false
    
    @Environment(SubscriptionManager.self) private var premium

    var body: some View {

        ZStack {
            CosmicBackground()

                VStack(
                    spacing: 20
                ) {
                    
                    if let user {
                        
                        
                        Text(user.zodiac.title)
                            .font(
                                .system(size: 50)
                            )
                        
                        Form {
                            
                        
                            Section {
                                if premium.isSubscribed {
                                    Text("Premium activated")
                                } else {
                                    GradientButton(
                                        title:
                                            "Unlock Premium"
                                    ){
                                        isShowingSheet = true
                                    }
                                }
                                Button("Restore Purchases") {
                                    Task {
                                        await premium.restorePurchases()
                                    }
                                }
                            }
                        
                            DatePicker(
                                "Birthday",
                                selection:
                                    Binding(
                                        get: {
                                            user.birthDate ?? Date()
                                        },
                                        set: {
                                            user.birthDate = $0

                                            updateZodiac(
                                                date: $0,
                                                user: user
                                            )
                                        }
                                    ),
                                displayedComponents: .date
                            )
                                
                                
                                DatePicker(
                                    "Birth Time",
                                    selection:
                                        Binding(
                                            get:{
                                                user.birthTime ?? Date()
                                            },
                                            set:{
                                                user.birthTime = $0
                                            }
                                        ),
                                    displayedComponents:.hourAndMinute
                                )
                                
                                
                                TextField(
                                    "Birth City",
                                    text:
                                        Binding(
                                            get:{
                                                user.birthCity ?? ""
                                            },
                                            set:{
                                                user.birthCity = $0
                                            }
                                        )
                                )
                            Section {
                                Toggle(
                                    "Daily Horoscope",
                                    isOn:
                                        $reminders
                                )
                                .onChange(of: reminders) { _, value in
                                    if value {
                                        Task {
                                            
                                            await NotificationManager
                                                .shared
                                                .requestPermission()
                                            
                                            
                                            let calendar =
                                            Calendar.current
                                            
                                            let hour =
                                            calendar.component(
                                                .hour,
                                                from:time
                                            )
                                            let minute =
                                            calendar.component(
                                                .minute,
                                                from:time
                                            )
                                            NotificationManager
                                                .shared
                                                .scheduleDailyHoroscope(
                                                    hour:hour,
                                                    minute:minute
                                                )
                                        }
                                    } else {
                                        NotificationManager
                                            .shared
                                            .removeNotifications()
   
                                    }
                                }

                                DatePicker(
                                    "Reminder Time",
                                    selection:$time,
                                    displayedComponents:
                                            .hourAndMinute
                                )
                                
                                
                                
                                
                            }
                            
                        }
                        .scrollContentBackground(.hidden)

                }
            }
            .navigationTitle("Profile")
            .toolbarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $isShowingSheet) {
                PaywallView()
            }
        }
    }
    
    private func updateZodiac(
        date: Date,
        user: UserProfile
    ) {

        let newSign =
        ZodiacCalculator.sign(
            from: date
        )

        if user.zodiac != newSign {

            withAnimation(.spring()) {

                user.zodiac = newSign
            }
        }
    }
}
