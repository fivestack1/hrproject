//
//  OpenAIRequest.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation

struct OpenAIRequest: Encodable {

    let model: String

    let messages: [Message]

    let response_format: ResponseFormat

    struct Message: Encodable {

        let role: String
        let content: String
    }
}

struct ResponseFormat: Encodable {

    let type: String
    let json_schema: JSONSchema
}

struct JSONSchema: Encodable {

    let name: String
    let strict: Bool
    let schema: Schema
}

struct Schema: Encodable {

    let type: String
    let additionalProperties: Bool
    let properties: [String: Property]
    let required: [String]
}

struct Property: Encodable {

    let type: String
}
