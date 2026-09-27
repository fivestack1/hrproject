//
//  QuizQuestion.swift
//  MyHoroscope2
//
//  Created by admin on 24.06.2026.
//


import Foundation

struct QuizQuestion: Identifiable {

    let id = UUID()

    let title: String

    let answers: [String]
}