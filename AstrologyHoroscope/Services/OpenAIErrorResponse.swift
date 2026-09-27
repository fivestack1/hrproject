//
//  OpenAIErrorResponse.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation


struct OpenAIErrorResponse: Decodable {

    let error: ErrorDetail


    struct ErrorDetail: Decodable {

        let message: String

        let type: String?

    }
}