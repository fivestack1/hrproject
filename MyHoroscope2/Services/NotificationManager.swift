//
//  NotificationManager.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation
import UserNotifications



final class NotificationManager {


    static let shared =
    NotificationManager()



    private init(){}



    func requestPermission() async {


        do {

            try await UNUserNotificationCenter
                .current()
                .requestAuthorization(
                    options:[
                        .alert,
                        .sound,
                        .badge
                    ]
                )


        } catch {

            print(
                error.localizedDescription
            )

        }

    }




    func scheduleDailyHoroscope(
        hour:Int,
        minute:Int
    ){


        let content =
        UNMutableNotificationContent()


        content.title =
        "Your Horoscope ✨"


        content.body =
        "Your daily guidance is ready."


        content.sound =
        .default




        var components =
        DateComponents()


        components.hour =
        hour


        components.minute =
        minute




        let trigger =
        UNCalendarNotificationTrigger(
            dateMatching:
            components,
            repeats:true
        )



        let request =
        UNNotificationRequest(
            identifier:
            "daily_horoscope",
            content:content,
            trigger:trigger
        )



        UNUserNotificationCenter
            .current()
            .add(request)

    }




    func removeNotifications(){


        UNUserNotificationCenter
            .current()
            .removePendingNotificationRequests(
                withIdentifiers:[
                    "daily_horoscope"
                ]
            )

    }


}

extension Notification.Name {

    static let onboardingFinished =
    Notification.Name(
        "onboardingFinished"
    )

}
