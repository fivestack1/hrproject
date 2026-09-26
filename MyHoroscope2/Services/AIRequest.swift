//
//  AIRequest.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation


struct AIRequest: Encodable {

    let model:String

    let messages:[Message]

    let temperature:Double


    struct Message:Encodable {

        let role:String

        let content:String
    }
}