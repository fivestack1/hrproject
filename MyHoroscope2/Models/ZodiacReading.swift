//
//  ZodiacReading.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import Foundation


struct ZodiacReading: Codable {

    let personality: String

    let love: String

    let career: String

    let strengths: String

    let challenges: String

    let advice: String
}
	
import Foundation


extension ZodiacReading {


    static var schema: JSONSchema {


        JSONSchema(

            name:"zodiac_reading",

            strict:true,

            schema:

            Schema(
                type:"object",
                additionalProperties:false,
                properties:[

                    "personality":
                        Property(
                            type:"string"
                        ),


                    "love":
                        Property(
                            type:"string"
                        ),


                    "career":
                        Property(
                            type:"string"
                        ),


                    "strengths":
                        Property(
                            type:"string"
                        ),


                    "challenges":
                        Property(
                            type:"string"
                        ),


                    "advice":
                        Property(
                            type:"string"
                        )

                ],



                required:[

                    "personality",
                    "love",
                    "career",
                    "strengths",
                    "challenges",
                    "advice"

                ]
            )
        )
    }
}
