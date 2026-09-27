//
//  AIResponse.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation


struct AIResponse: Decodable {


    let choices:[Choice]


    struct Choice:Decodable {


        let message:Message

    }


    struct Message:Decodable {

        let role:String

        let content:String

    }

}