//
//  QuizViewModel.swift
//  MyHoroscope2
//
//  Created by admin on 24.06.2026.
//


import Foundation
import SwiftUI

@Observable
final class QuizViewModel {

    var currentIndex = 0

    var selectedAnswers: [String] = []

    var isLoading = false

    var profileText = ""

    let questions: [QuizQuestion] = [

        QuizQuestion(
            title: "What are you looking for most?",
            answers: [
                "Love",
                "Career",
                "Money",
                "Self Growth"
            ]
        ),

        QuizQuestion(
            title: "How often do you check horoscopes?",
            answers: [
                "Never",
                "Sometimes",
                "Weekly",
                "Daily"
            ]
        ),

        QuizQuestion(
            title: "What best describes you?",
            answers: [
                "Dreamer",
                "Leader",
                "Empath",
                "Adventurer"
            ]
        ),
        
        /*QuizQuestion(
            title: "How intuitive are you?",
            answers: [
                "Very",
                "Sometimes",
                "Rarely",
                "Not Sure"
            ]
        )

        QuizQuestion(
            title: "What feels blocked right now?",
            answers: [
                "Love",
                "Career",
                "Money",
                "Confidence"
            ]
        ),*/

        QuizQuestion(
            title: "Do you believe timing matters?",
            answers: [
                "Always",
                "Sometimes",
                "Not Sure",
                "No"
            ]
        )
        
    ]

    var currentQuestion: QuizQuestion {
        questions[currentIndex]
    }

    var progress: Double {

        Double(currentIndex + 1)
        /
        Double(questions.count)
    }

    func select(
        _ answer: String
    ) {

        selectedAnswers.append(answer)

        if currentIndex < questions.count - 1 {

            currentIndex += 1
        }
    }
}
