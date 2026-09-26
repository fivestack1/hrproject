import Foundation



final class AIService {


    static let shared =
    AIService()



    private init(){}



    let apiKey = "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"
        



    private let url =
    URL(
        string:
        "https://api.openai.com/v1/chat/completions"
    )!




    func ask(
        prompt:String
    ) async throws -> String {


        let body =
        AIRequest(

            model:
            "gpt-4.1-mini",

            messages:[

                .init(
                    role:"system",
                    content:
"""
You are a professional astrology assistant.

Explain astrology in a positive,
entertaining and thoughtful way.

Never present predictions as guaranteed facts.
"""

                ),

                .init(
                    role:"user",
                    content:prompt
                )

            ],

            temperature:0.8
        )



        var request =
        URLRequest(
            url:url
        )


        request.httpMethod =
        "POST"


        request.setValue(
            "Bearer \(apiKey)",
            forHTTPHeaderField:
            "Authorization"
        )


        request.setValue(
            "application/json",
            forHTTPHeaderField:
            "Content-Type"
        )


        request.httpBody =
        try JSONEncoder()
            .encode(body)



        let (data,_) =
        try await URLSession.shared
            .data(
                for:request
            )



        let result =
        try JSONDecoder()
            .decode(
                AIResponse.self,
                from:data
            )



        return result
            .choices
            .first?
            .message
            .content
        ??
        "No response"

    }


    /*func generateDashboard(
        sign: ZodiacSign
    ) async throws -> HomeReading {

        let prompt = """

        Generate a horoscope dashboard.

        Zodiac Sign:
        \(sign.title)

        Return ONLY JSON.

        {
          "overview":"",
          "luckyNumber":"",
          "luckyColor":"",
          "loveScore":80,
          "careerScore":80,
          "moneyScore":80,
          "healthScore":80,
          "aiInsight":""
        }

        """

        let response =
        try await ask(
            prompt: prompt
        )

        let data =
        Data(
            response.utf8
        )

        return try JSONDecoder()
            .decode(
                HomeReading.self,
                from: data
            )
    }*/
    
    func generateDashboard(
        sign: ZodiacSign
    ) async throws -> HomeReading {


        let request =
        OpenAIRequest(

            model: "gpt-4.1-mini",

            messages: [

                .init(
                    role: "system",
                    content:
                    """
                    You are an astrology assistant.
                    Generate daily horoscope data.
                    """
                ),

                .init(
                    role: "user",
                    content:
                    """
                    Generate horoscope dashboard
                    for \(sign.title).
                    """
                )
            ],

            response_format:
                ResponseFormat(
                    type: "json_schema",
                    json_schema:
                        HomeReading.schema
                )
        )


        var urlRequest =
        URLRequest(
            url:url
        )


        urlRequest.httpMethod = "POST"


        urlRequest.setValue(
            "Bearer \(apiKey)",
            forHTTPHeaderField:
            "Authorization"
        )


        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField:
            "Content-Type"
        )


        urlRequest.timeoutInterval = 60


        urlRequest.httpBody =
        try JSONEncoder()
            .encode(request)



        let (data, response) =
        try await URLSession.shared
            .data(
                for:urlRequest
            )


        guard let http =
            response as? HTTPURLResponse
        else {
            throw URLError(.badServerResponse)
        }


        let raw =
        String(
            data:data,
            encoding:.utf8
        )


        print(
            "STATUS:",
            http.statusCode
        )

        print(
            "RESPONSE:",
            raw ?? ""
        )


        guard http.statusCode == 200 else {

            throw NSError(
                domain:"OpenAI",
                code:http.statusCode,
                userInfo:[
                    NSLocalizedDescriptionKey:
                    raw ?? "Unknown error"
                ]
            )
        }


        let decoded =
        try JSONDecoder()
            .decode(
                AIResponse.self,
                from:data
            )


        guard let json =
            decoded.choices.first?
                .message
                .content
        else {

            throw NSError(
                domain:"AI",
                code:1,
                userInfo:[
                    NSLocalizedDescriptionKey:
                    "No AI content"
                ]
            )
        }


        return try JSONDecoder()
            .decode(
                HomeReading.self,
                from:
                Data(json.utf8)
            )
    }
    
    
    
    func generateCompatibility(
        first: ZodiacSign,
        second: ZodiacSign
    ) async throws -> CompatibilityReading {

        let request = OpenAIRequest(

            model: "gpt-4.1-mini",

            messages: [

                .init(
                    role: "system",
                    content:
    """
    You are an astrology compatibility expert.
    """
                ),

                .init(
                    role: "user",
                    content:
    """
    Analyze compatibility between:

    \(first.title)
    and
    \(second.title)

    Provide:
    - overall score
    - love
    - communication
    - friendship
    - long term
    - insight
    """
                )
            ],

            response_format:
                ResponseFormat(
                    type: "json_schema",
                    json_schema:
                        CompatibilityReading.schema
                )
        )

        // Same request code used in generateDashboard()

        let json =
        try await performStructuredRequest(
            request
        )

        return try JSONDecoder()
            .decode(
                CompatibilityReading.self,
                from:
                    Data(json.utf8)
            )
    }
    
    /*private func performStructuredRequest(
        _ request: OpenAIRequest
    ) async throws -> String {


        var urlRequest =
        URLRequest(
            url: url
        )


        urlRequest.httpMethod =
        "POST"


        urlRequest.setValue(
            "Bearer \(apiKey)",
            forHTTPHeaderField:
            "Authorization"
        )


        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField:
            "Content-Type"
        )


        urlRequest.httpBody =
        try JSONEncoder()
            .encode(request)



        let (data, _) =
        try await URLSession.shared
            .data(
                for:urlRequest
            )



        let response =
        try JSONDecoder()
            .decode(
                AIResponse.self,
                from:data
            )


        guard let content =
            response.choices.first?
                .message
                .content
        else {

            throw NSError(
                domain:"AI",
                code:1,
                userInfo:[
                    NSLocalizedDescriptionKey:
                    "Empty AI response"
                ]
            )
        }


        return content
    }*/
    
    private func performStructuredRequest(
        _ request: OpenAIRequest
    ) async throws -> String {


        var urlRequest =
        URLRequest(
            url:url
        )


        urlRequest.httpMethod = "POST"


        urlRequest.setValue(
            "Bearer \(apiKey)",
            forHTTPHeaderField:
            "Authorization"
        )


        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField:
            "Content-Type"
        )


        urlRequest.httpBody =
        try JSONEncoder()
            .encode(request)



        let (data, response) =
        try await URLSession.shared
            .data(
                for:urlRequest
            )



        guard let http =
            response as? HTTPURLResponse
        else {

            throw NSError(
                domain:"AI",
                code:-1
            )
        }



        let raw =
        String(
            data:data,
            encoding:.utf8
        )


        print("AI STATUS:", http.statusCode)

        print("AI RESPONSE:", raw ?? "")



        if http.statusCode >= 400 {


            if let error =
                try? JSONDecoder()
                .decode(
                    OpenAIErrorResponse.self,
                    from:data
                ) {


                throw NSError(
                    domain:"OpenAI",
                    code:http.statusCode,
                    userInfo:[
                        NSLocalizedDescriptionKey:
                        error.error.message
                    ]
                )
            }


            throw NSError(
                domain:"OpenAI",
                code:http.statusCode
            )

        }



        let decoded =
        try JSONDecoder()
            .decode(
                AIResponse.self,
                from:data
            )



        guard let content =
            decoded.choices.first?
                .message
                .content
        else {

            throw NSError(
                domain:"AI",
                code:2,
                userInfo:[
                    NSLocalizedDescriptionKey:
                    "Empty AI response"
                ]
            )
        }


        return content
    }
     
    
    func generateBirthChartReading(
        birth: CalculatedBirthData
    ) async throws -> BirthChartReading {

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium

        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short

        let dateString = dateFormatter.string(
            from: birth.date
        )

        let timeString = timeFormatter.string(
            from: birth.time
        )

        let latitudeString: String

        if let latitude = birth.latitude {
            latitudeString = String(latitude)
        } else {
            latitudeString = "Unknown"
        }

        let systemMessage = """
        You are an expert astrology assistant.

        Generate a personalized natal astrology reading.

        Return valid JSON matching the provided schema.
        """

        let userMessage = """
        Create a personalized birth chart reading.

        Birth date:
        \(dateString)

        Birth time:
        \(timeString)

        Birth city:
        \(birth.city)

        Latitude:
        \(latitudeString)

        Longitude:
        \(birth.longitude)

        Sun sign:
        \(birth.sunSign)

        Generate:
        - Sun sign
        - Moon sign
        - Rising sign
        - Mercury sign
        - Venus sign
        - Mars sign
        - Personalized personality reading
        """

        let request = OpenAIRequest(
            model: "gpt-4.1-mini",
            messages: [
                .init(
                    role: "system",
                    content: systemMessage
                ),
                .init(
                    role: "user",
                    content: userMessage
                )
            ],
            response_format: ResponseFormat(
                type: "json_schema",
                json_schema: BirthChartReading.schema
            )
        )

        let json = try await performStructuredRequest(
            request
        )

        let data = Data(
            json.utf8
        )

        return try JSONDecoder().decode(
            BirthChartReading.self,
            from: data
        )
    }
    
    
    func generateZodiacReading(
        sign: ZodiacSign
    ) async throws -> ZodiacReading {


        let request =
        OpenAIRequest(

            model:"gpt-4.1-mini",


            messages:[


                .init(
                    role:"system",
                    content:
                    """
                    You are a professional
                    astrology assistant.
                    """
                ),


                .init(
                    role:"user",

                    content:
                    """
                    Create astrology profile
                    for:

                    \(sign.title)

                    Include personality,
                    love, career,
                    strengths,
                    challenges,
                    advice.
                    """
                )

            ],


            response_format:

            ResponseFormat(
                type:"json_schema",

                json_schema:
                ZodiacReading.schema
            )
        )



        let json =
        try await performStructuredRequest(
            request
        )


        return try JSONDecoder()
            .decode(
                ZodiacReading.self,
                from:
                Data(json.utf8)
            )
    }
    
    func generateQuizProfile(
        answers: [String]
    ) async throws -> String {

        let prompt = """

        Based on these quiz answers:

        \(answers.joined(separator: ", "))

        Generate a short
        personality profile.

        Keep under 100 words.
        """

        return try await ask(
            prompt: prompt
        )
    }
    
    
}
