//
//  ContentView.swift
//  AstrologyHoroscope
//

import Foundation
import SwiftUI
import SwiftData
import StoreKit
import Observation
import UserNotifications

struct ContentView: View {
    
    @Query
    private var users: [UserProfile]

    var body: some View {

            if users.isEmpty {
                
                OnboardingView()
                
                
            } else {
                
                MainTabView()
                
            }
            

    }
    
}

/*#Preview {
    ContentView()
}*/


enum AppColors {

    static let background = Color(
        red: 0.04,
        green: 0.05,
        blue: 0.08
    )

    static let card = Color(
        red: 0.10,
        green: 0.11,
        blue: 0.16
    )

    static let purple = Color(
        red: 0.70,
        green: 0.45,
        blue: 1.00
    )

    static let blue = Color(
        red: 0.30,
        green: 0.60,
        blue: 1.00
    )

    static let textPrimary = Color.white

    static let textSecondary = Color.white.opacity(0.7)
}

enum AppGradients {

    static let background = LinearGradient(
        colors: [
            Color.black,
            Color.indigo.opacity(0.4),
            Color.black
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let purpleCard = LinearGradient(
        colors: [
            //.purple,
            .orange,
            .pink
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

struct AstroCard<Content: View>: View {

    @ViewBuilder
    let content: Content

    var body: some View {
        content
            .astroCard()
    }
}

truct CardStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(
                    cornerRadius: 24,
                    style: .continuous
                )
                .fill(AppColors.card)
            )
            .overlay(
                RoundedRectangle(
                    cornerRadius: 24,
                    style: .continuous
                )
                .stroke(
                    Color.white.opacity(0.08),
                    lineWidth: 1
                )
            )
    }
}

extension View {

    func astroCard() -> some View {
        modifier(CardStyle())
    }
}


struct CosmicBackground: View {

    var body: some View {

        GeometryReader { geo in

            ZStack {

                NebulaBackground()

                StarField()


                Color.black.opacity(0.25)
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
}
struct CosmicBackground1: View {

    var body: some View {

        GeometryReader { geo in

            ZStack {

                Image("Bg")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height
                    )
                    .clipped()


                Color.black.opacity(0.25)
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
}

struct CosmicButtonStyle: ButtonStyle {

    func makeBody(
        configuration: Configuration
    ) -> some View {

        configuration.label

            .font(.headline.bold())

            .foregroundStyle(.white)

            .padding(.vertical, 4)

            .background {

                RoundedRectangle(
                    cornerRadius: 24
                )
                .fill(.ultraThinMaterial)

                RoundedRectangle(
                    cornerRadius: 24
                )
                .stroke(
                    LinearGradient(
                        colors: [
                            .purple.opacity(0.8),
                            .blue.opacity(0.8)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1.5
                )
            }

            .shadow(
                color: .purple.opacity(0.35),
                radius: 15
            )

            .scaleEffect(
                configuration.isPressed
                ? 0.96
                : 1
            )

            .animation(
                .easeInOut(duration: 0.15),
                value: configuration.isPressed
            )
    }
}

struct GlowCard<Content: View>: View {

    @ViewBuilder
    let content: Content

    var body: some View {

        content

            .padding()

            .background(
                RoundedRectangle(
                    cornerRadius: 28
                )
                .fill(
                    .ultraThinMaterial
                )
            )

            .overlay {

                RoundedRectangle(
                    cornerRadius: 28
                )
                .stroke(
                    .white.opacity(0.15),
                    lineWidth: 1
                )
            }

            .shadow(
                color: .purple.opacity(0.4),
                radius: 20
            )
    }
}

struct GradientButton: View {

    let title: String
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    AppGradients.purpleCard
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 18
                    )
                )
        }
        .foregroundStyle(.white)
    }
}

struct NebulaBackground: View {

    @State private var animate = false

    var body: some View {

        ZStack {

            RadialGradient(
                colors: [
                    .blue.opacity(0.6),
                    .clear
                ],
                center: animate ? .topLeading : .bottomTrailing,
                startRadius: 50,
                endRadius: 500
            )

            RadialGradient(
                colors: [
                    .pink.opacity(0.5),
                    .clear
                ],
                center: animate ? .bottomTrailing : .topLeading,
                startRadius: 50,
                endRadius: 450
            )
        }
        /*.animation(
            .easeInOut(duration: 10)
            .repeatForever(autoreverses: true),
            value: animate
        )
        .onAppear {

            animate = true
        }*/
    }
}

struct SectionHeader: View {

    let title: String

    var body: some View {

        HStack {

            Text(title)
                .font(.title3.bold())

            Spacer()
        }
        .foregroundStyle(.white)
    }
}

struct StarField: View {

    @State private var stars: [Star] = []

    var body: some View {

        GeometryReader { geo in

            TimelineView(.animation) { _ in

                Canvas { context, size in

                    for star in stars {

                        let rect = CGRect(
                            x: star.x * size.width,
                            y: star.y * size.height,
                            width: star.size,
                            height: star.size
                        )

                        context.fill(
                            Path(ellipseIn: rect),
                            with: .color(.white.opacity(star.opacity))
                        )
                    }
                }
            }
        }
        .onAppear {

            stars = (0..<120).map { _ in

                Star(
                    x: .random(in: 0...1),
                    y: .random(in: 0...1),
                    size: .random(in: 1...3),
                    opacity: .random(in: 0.2...1)
                )
            }
        }
    }
}

struct Star {

    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
    let opacity: Double
}

struct ZodiacCard: View {

    let sign: ZodiacSign

    var body: some View {

        VStack(spacing: 12) {

            Text(sign.symbol)
                .font(.system(size: 48))
                //.foregroundStyle(sign.gradient)

            Text(sign.title)
                .font(.headline)

            Text(sign.dateRange)
                .font(.caption)
                //.opacity(0.7)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 170)
        .background(sign.gradient.opacity(0.8))
        /*.background {
            RoundedRectangle(
                cornerRadius: 28
            )
            .fill(.ultraThinMaterial)
            RoundedRectangle(
                cornerRadius: 28
            )
            .stroke(
                sign.gradient,
                lineWidth: 1.5
            )
        }*/
        .shadow(
            color: .purple.opacity(0.35),
            radius: 15
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 28,
                style: .continuous
            )
        )
        
        
    }
}

struct AIChatView: View {


    @Environment(
        \.modelContext
    )
    private var context

    @Environment(\.modelContext)
    private var modelContext

    @Query(
        sort:
        \ChatMessage.createdAt
    )
    private var messages:
    [ChatMessage]



    @State private var input = ""

    @State private var loading = false

    @Environment(SubscriptionManager.self)
    private var premium


    let suggestions = [

        "My career future",

        "Love compatibility",

        "Moon meaning",

        "Birth chart"

    ]




    var body: some View {

        NavigationStack {
            ZStack {
                
                
                //AppGradients.background.ignoresSafeArea()
                CosmicBackground()
                
                
                ScrollView {
                    VStack {
                        
                        
                        //header
                        
                        if !premium.isSubscribed {
                            premiumCard().padding()
                        }
                        
                        
                        VStack {
                            ScrollView {
                                
                                
                                VStack(
                                    spacing:14
                                ){
                                    
                                    
                                    
                                    if messages.isEmpty {
                                        
                                        
                                        welcome
                                        
                                        
                                        
                                    }
                                    
                                    
                                    
                                    ForEach(
                                        messages
                                    ){ message in
                                        
                                        
                                        
                                        ChatBubble(
                                            message:message
                                        )
                                        
                                    }
                                    
                                    
                                }
                                .padding()
                                
                                
                            }
                            
                            suggestionsView
                            
                            inputBar
                        }
                        .premiumLocked(
                            premium.isSubscribed
                        )
                        
                        
                        
                    }
                }
                
            }
            .navigationTitle("Astrologer")
            .toolbarTitleDisplayMode(.inlineLarge)
        }


    }




    var header:some View {


        Text(
            "Astrologer"
        )
        .font(
            .largeTitle.bold()
        )
        .foregroundStyle(
            .white
        )
        .padding()

        
    }




    var welcome:some View {


        VStack(
            spacing:15
        ){
            Text(
                "Ask anything about your destiny"
            )
            .font(.headline)



        }
        .foregroundStyle(
            .white
        )


    }




    var suggestionsView:some View {


        ScrollView(
            .horizontal
        ){


            HStack {


                ForEach(
                    suggestions,
                    id:\.self
                ){ item in



                    Button(item){


                        send(
                            item
                        )


                    }
                    .padding(.horizontal,15)
                    .padding(.vertical,8)
                    .background(
                        AppColors.card
                    )
                    .clipShape(
                        Capsule()
                    )
                    .foregroundStyle(
                        .white
                    )


                }


            }
            .padding(.horizontal)

        }


    }




    var inputBar:some View {


        HStack {


            TextField(
                "Ask AI...",
                text:$input
            )
            .padding()
            .background(
                AppColors.card
            )
            .clipShape(
                Capsule()
            )



            Button {


                send(
                    input
                )



            } label:{


                Image(
                    systemName:
                    "arrow.up.circle.fill"
                )
                .font(
                    .largeTitle
                )


            }


        }
        .foregroundStyle(
            .white
        )
        .padding()

    }





    func send(
        _ text:String
    ){


        guard !text.isEmpty else {
            return
        }



        let user =
        ChatMessage(
            text:text,
            isUser:true
        )


        context.insert(user)



        input = ""

        loading = true



        Task {

            do {

                let reply =
                try await AIService.shared
                    .ask(
                        prompt: text
                    )


                let ai =
                ChatMessage(
                    text: reply,
                    isUser: false
                )


                await MainActor.run {

                    context.insert(ai)

                    loading = false
                }


            } catch {


                let errorMessage =
                ChatMessage(
                    text:
                    "Sorry, I couldn't connect right now ✨",
                    isUser:false
                )


                await MainActor.run {

                    context.insert(errorMessage)

                    loading = false

                }

            }

        }


    }

}

struct ChatBubble: View {


    let message:ChatMessage



    var body: some View {


        HStack {


            if message.isUser {

                Spacer()

            }



            Text(message.text)
                .padding()
                .background(

                    message.isUser
                    ? AppColors.purple
                    : AppColors.card

                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 22)
                )
                .foregroundStyle(
                    .white
                )



            if !message.isUser {

                Spacer()

            }


        }

    }

}

@Model
final class ChatMessage {


    var id: UUID

    var text: String

    var isUser: Bool

    var createdAt: Date



    init(
        text:String,
        isUser:Bool
    ){

        self.id = UUID()

        self.text = text

        self.isUser = isUser

        self.createdAt = Date()
    }

}

struct AstrologyWheel: View {

    let chart: BirthChartReading

    @State private var appeared = false

    private let zodiacSymbols = [
        "♈︎",
        "♉︎",
        "♊︎",
        "♋︎",
        "♌︎",
        "♍︎",
        "♎︎",
        "♏︎",
        "♐︎",
        "♑︎",
        "♒︎",
        "♓︎"
    ]

    private let zodiacNames = [
        "Aries",
        "Taurus",
        "Gemini",
        "Cancer",
        "Leo",
        "Virgo",
        "Libra",
        "Scorpio",
        "Sagittarius",
        "Capricorn",
        "Aquarius",
        "Pisces"
    ]

    var body: some View {

        ZStack {

            // MARK: - Outer Glow

            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.purple.opacity(0.18),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 20,
                        endRadius: 150
                    )
                )
                .blur(radius: 12)

            // MARK: - Outer Ring

            Circle()
                .stroke(
                    Color.white.opacity(0.25),
                    lineWidth: 2
                )

            // MARK: - Zodiac Ring

            Circle()
                .stroke(
                    Color.white.opacity(0.15),
                    lineWidth: 1
                )
                .padding(35)

            // MARK: - Zodiac Dividers

            ForEach(0..<12, id: \.self) { index in

                Rectangle()
                    .fill(
                        Color.white.opacity(0.12)
                    )
                    .frame(
                        width: 1,
                        height: 18
                    )
                    .offset(y: -121)
                    .rotationEffect(
                        .degrees(
                            Double(index) * 30
                        )
                    )
            }

            // MARK: - Zodiac Symbols

            ForEach(0..<12, id: \.self) { index in

                zodiacSymbol(
                    index: index
                )
            }

            // MARK: - Inner Circle

            Circle()
                .stroke(
                    Color.white.opacity(0.12),
                    lineWidth: 1
                )
                .padding(70)

            // MARK: - Planet Connections

            planetLines

            // MARK: - Planets

            planetMarker(
                symbol: "☉",
                name: "Sun",
                sign: chart.sun,
                angle: planetAngle(
                    for: chart.sun
                )
            )

            planetMarker(
                symbol: "☽",
                name: "Moon",
                sign: chart.moon,
                angle: planetAngle(
                    for: chart.moon
                )
            )

            planetMarker(
                symbol: "☿",
                name: "Mercury",
                sign: chart.mercury,
                angle: planetAngle(
                    for: chart.mercury
                )
            )

            planetMarker(
                symbol: "♀",
                name: "Venus",
                sign: chart.venus,
                angle: planetAngle(
                    for: chart.venus
                )
            )

            planetMarker(
                symbol: "♂",
                name: "Mars",
                sign: chart.mars,
                angle: planetAngle(
                    for: chart.mars
                )
            )

            // MARK: - Rising

            risingMarker

            // MARK: - Center

            ZStack {

                Circle()
                    .fill(
                        Color.white.opacity(0.05)
                    )
                    .frame(
                        width: 65,
                        height: 65
                    )

                Circle()
                    .stroke(
                        Color.white.opacity(0.15),
                        lineWidth: 1
                    )
                    .frame(
                        width: 65,
                        height: 65
                    )

                Text("✦")
                    .font(
                        .system(
                            size: 28,
                            weight: .light
                        )
                    )
                    .foregroundStyle(
                        .white.opacity(0.85)
                    )
            }
        }
        .frame(
            width: 280,
            height: 280
        )
        .scaleEffect(
            appeared ? 1 : 0.85
        )
        .opacity(
            appeared ? 1 : 0
        )
        .animation(
            .spring(
                response: 0.8,
                dampingFraction: 0.8
            ),
            value: appeared
        )
        .onAppear {
            appeared = true
        }
    }

    // MARK: - Zodiac Symbol

    private func zodiacSymbol(
        index: Int
    ) -> some View {

        Text(
            zodiacSymbols[index]
        )
        .font(
            .system(
                size: 20,
                weight: .medium
            )
        )
        .foregroundStyle(
            .white.opacity(0.85)
        )
        .position(
            x: 140 + cos(
                angleForIndex(index)
            ) * 108,
            y: 140 + sin(
                angleForIndex(index)
            ) * 108
        )
    }

    // MARK: - Planet Marker

    private func planetMarker(
        symbol: String,
        name: String,
        sign: String,
        angle: Double
    ) -> some View {

        let radius = 76.0

        return ZStack {

            Circle()
                .fill(
                    Color.white.opacity(0.08)
                )
                .frame(
                    width: 34,
                    height: 34
                )

            Circle()
                .stroke(
                    Color.white.opacity(0.2),
                    lineWidth: 1
                )
                .frame(
                    width: 34,
                    height: 34
                )

            Text(symbol)
                .font(
                    .system(
                        size: 17,
                        weight: .medium
                    )
                )
        }
        .foregroundStyle(.white)
        .position(
            x: 140 + cos(angle) * radius,
            y: 140 + sin(angle) * radius
        )
    }

    // MARK: - Rising Marker

    private var risingMarker: some View {

        let angle = planetAngle(
            for: chart.rising
        )

        return ZStack {

            Circle()
                .stroke(
                    Color.white.opacity(0.5),
                    lineWidth: 1.5
                )
                .frame(
                    width: 42,
                    height: 42
                )

            Text("ASC")
                .font(
                    .system(
                        size: 8,
                        weight: .bold
                    )
                )
        }
        .foregroundStyle(.white)
        .position(
            x: 140 + cos(angle) * 100,
            y: 140 + sin(angle) * 100
        )
    }

    // MARK: - Planet Lines

    private var planetLines: some View {

        Canvas { context, size in

            let center = CGPoint(
                x: size.width / 2,
                y: size.height / 2
            )

            let planets = [
                chart.sun,
                chart.moon,
                chart.mercury,
                chart.venus,
                chart.mars
            ]

            var points: [CGPoint] = []

            for sign in planets {

                let angle = planetAngle(
                    for: sign
                )

                let point = CGPoint(
                    x: center.x + cos(angle) * 76,
                    y: center.y + sin(angle) * 76
                )

                points.append(point)
            }

            for index in 0..<points.count {

                for secondIndex in (index + 1)..<points.count {

                    var path = Path()

                    path.move(
                        to: points[index]
                    )

                    path.addLine(
                        to: points[secondIndex]
                    )

                    context.stroke(
                        path,
                        with: .color(
                            Color.white.opacity(0.08)
                        ),
                        lineWidth: 1
                    )
                }
            }
        }
        .allowsHitTesting(false)
    }

    // MARK: - Angle

    private func planetAngle(
        for sign: String
    ) -> Double {

        let normalized = sign.lowercased()

        if let index = zodiacNames.firstIndex(
            where: {
                normalized.contains(
                    $0.lowercased()
                )
            }
        ) {

            return angleForIndex(
                index
            )
        }

        return 0
    }

    private func angleForIndex(
        _ index: Int
    ) -> Double {

        let degrees =
            Double(index) * 30.0 - 90.0

        return degrees * .pi / 180
    }
}

struct BirthChartView: View {

    @Query private var users:[UserProfile]

    var user:UserProfile? {
        users.first
    }

    @Environment(SubscriptionManager.self)
    private var premium
    
    @State private var chart: BirthChartReading?

    @State private var loading = false


    var body: some View {


NavigationStack {
    ZStack {
        
        
        //AppGradients.background.ignoresSafeArea()
        CosmicBackground()
        
        
        
            ScrollView {
                
                
                VStack(
                    spacing:25
                ){
                    
                    
                    
                    //title
                    
                    if !premium.isSubscribed {
                        premiumCard()
                    }
                    
                    VStack {
                        
                        
                        
                        if let chart {
                            AstrologyWheel(
                                chart: chart
                            )
                            .padding(.bottom, 20)
                        }
                        
                        
                        
                        
                        placements
                        
                        
                        
                        aiReading
                        
                        
                    }
                    .premiumLocked(
                        premium.isSubscribed
                    )
                    
                    
                    
                    
                }
                .padding()
                
            }
        
        }
    .task {
        if premium.isSubscribed {
            await loadChart()
        }
    }
    .navigationTitle("Birth Chart")
    .toolbarTitleDisplayMode(.inlineLarge)
    }


    }


    @MainActor
    func loadChart() async {


        guard let user else {
            return
        }


        guard let date = user.birthDate,
              let time = user.birthTime
        else {
            return
        }



        loading = true


        let birth =
        BirthData(

            date:date,

            time:time,

            city:
            user.birthCity ?? "",

            latitude:
            user.latitude,

            longitude:
            user.longitude
        )



        do {


            let calculated =
                try await AstrologyAPIService.shared.calculateChart(
                    birth: birth
                )

            chart =
                try await AIService.shared.generateBirthChartReading(
                    birth: calculated
                )


        } catch {


            print(
                error
            )


        }


        loading = false
    }


    var title:some View {


        VStack(
            spacing:8
        ){


            Text(
                "Your Birth Chart"
            )
            .font(
                .largeTitle.bold()
            )



        }
        .foregroundStyle(
            .white
        )

    }





    var placements:some View {


        VStack(
            spacing:12
        ){



            SectionHeader(
                title:"Planet Placements"
            )



            if let chart {

                PlanetCard(
                    icon:"☀️",
                    title:"Sun",
                    value: chart.sun
                )
                
                PlanetCard(
                    icon:"🌙",
                    title:"Moon",
                    value: chart.moon
                )

                PlanetCard(
                    icon:"☿",
                    title:"Mercury",
                    value: chart.mercury
                )

                PlanetCard(
                    icon:"♀",
                    title:"Venus",
                    value: chart.venus
                )

                PlanetCard(
                    icon:"♂",
                    title:"Mars",
                    value: chart.mars
                )

                PlanetCard(
                    icon:"⬆️",
                    title:"Rising",
                    value: chart.rising
                )

            }


        }


    }





    var aiReading:some View {


        VStack(
            alignment:.leading,
            spacing:12
        ){


            Text(
                "Birth Reading"
            )
            .font(
                .headline
            )


            if let chart {
                Text(chart.reading)
            }


        }
        .astroCard()
        .foregroundStyle(
            .white
        )

    }

}

struct PlanetCard: View {


    let icon:String

    let title:String

    let value:String



    var body: some View {


        HStack {


            Text(icon)
                .font(.largeTitle)



            VStack(
                alignment:.leading
            ){

                Text(title)
                    .font(.caption)
                    .opacity(0.7)



                Text(value)
                    .font(
                        .headline.bold()
                    )

            }



            Spacer()


        }
        .padding()
        .background(
            AppColors.card
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 22)
        )
        .foregroundStyle(
            .white
        )

    }

}

struct CompatibilityScore: View {


    let value:Int



    var body: some View {


        ZStack {


            Circle()
                .stroke(
                    Color.white.opacity(0.15),
                    lineWidth:18
                )


            Circle()
                .trim(
                    from:0,
                    to:CGFloat(value)/100
                )
                .stroke(
                    AppGradients.purpleCard,
                    style:
                        StrokeStyle(
                            lineWidth:18,
                            lineCap:.round
                        )
                )
                .rotationEffect(
                    .degrees(-90)
                )



            VStack {


                Text("\(value)%")
                    .font(
                        .system(
                            size:45,
                            weight:.bold
                        )
                    )


                Text("Match")
                    .opacity(0.7)


            }


        }
        .frame(
            width:180,
            height:180
        )
        .foregroundStyle(.white)


    }
}

struct CompatibilityStat: View {


    let icon:String
    let title:String
    let value:String
    let color:Color



    var body: some View {


        VStack(
            spacing:10
        ){


            Text(Image(systemName: icon))
                .font(.title)
                .foregroundStyle(color)



            Text(value)
                .font(
                    .title2.bold()
                )


            HStack{
                Text(title)
                    .font(.caption)
                    .opacity(0.7)
                
                Spacer()
            }


        }
        .frame(
            maxWidth:.infinity,
            minHeight:100
        )
        .astroCard()
        .foregroundStyle(.white)

    }
}

struct CompatibilityView: View {


    @State private var mySign =
        ZodiacSign.gemini


    @State private var partner =
        ZodiacSign.libra



    @State private var showingPicker = false


    @State private var selectingMine = true

    @State private var reading: CompatibilityReading?

    @State private var loading = false
    
    @Environment(SubscriptionManager.self)
    private var premium

    var body: some View {


        NavigationStack{
            ZStack {
                
                
                //AppGradients.background.ignoresSafeArea()
                CosmicBackground()
                
                
                ScrollView {
                    
                    
                    VStack(
                        spacing:25
                    ){
                        
                        
                        
                        /*Text("Cosmic Match")
                            .font(
                                .largeTitle.bold()
                            )*/
                        
                        
                        if !premium.isSubscribed {
                            premiumCard()
                        }
                        
                        VStack {
                            
                            Text(
                                "Discover your connection"
                            )
                            .opacity(0.7)
                            HStack(
                                spacing:14
                            ){
                                
                                
                                
                                SignSelectorCard(
                                    title:"You",
                                    sign:mySign
                                ){
                                    
                                    selectingMine = true
                                    showingPicker = true
                                    
                                }
                                
                                
                                
                                Image(
                                    systemName:
                                        "heart.fill"
                                )
                                .font(.largeTitle)
                                .foregroundStyle(
                                    .pink
                                )
                                
                                
                                
                                SignSelectorCard(
                                    title:"Partner",
                                    sign:partner
                                ){
                                    
                                    selectingMine = false
                                    showingPicker = true
                                    
                                }
                                
                                
                                
                            }
                            
                            
                            
                            if let reading {
                                
                                CompatibilityScore(
                                    value:
                                        reading.overallScore
                                )
                                .padding(.vertical, 20)
                                
                                
                            }
                            
                            
                            LazyVGrid(
                                columns:[
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                ],
                                spacing:15
                            ){
                                
                                
                                if let reading {
                                    
                                    CompatibilityStat(
                                        icon:"heart.fill",
                                        title:"Love",
                                        value:"\(reading.loveScore)%",
                                        color: .red
                                    )
                                    
                                    
                                    CompatibilityStat(
                                        icon:"message.fill",
                                        title:"Communication",
                                        value:"\(reading.communicationScore)%",
                                        color: .yellow
                                    )
                                    
                                    
                                    CompatibilityStat(
                                        icon:"figure.2.right.holdinghands",
                                        title:"Friendship",
                                        value:"\(reading.friendshipScore)%",
                                        color: .green
                                    )
                                    
                                    
                                    CompatibilityStat(
                                        icon:"stopwatch",
                                        title:"Long Term",
                                        value:"\(reading.longTermScore)%",
                                        color: .blue
                                    )
                                    
                                }
                                
                                
                            }
                            
                            
                            
                            aiCard
                            
                        }
                        .premiumLocked(
                            premium.isSubscribed
                        )
                        
                        
                        
                    }
                    .padding()
                    
                    
                }
                
                
            }
            .task {
                if premium.isSubscribed {
                    await loadCompatibility()
                }
            }
            .onChange(of: mySign) {
                Task {
                    await loadCompatibility()
                }
            }
            .onChange(of: partner) {
                Task {
                    await loadCompatibility()
                }
            }
            .sheet(
                isPresented:
                    $showingPicker
            ){
                signPicker
            }
            .navigationTitle("Match")
            .toolbarTitleDisplayMode(.inlineLarge)
        }

    }

    @MainActor
    func loadCompatibility() async {

        loading = true

        do {

            reading =
            try await AIService.shared
                .generateCompatibility(
                    first: mySign,
                    second: partner
                )

        } catch {

            reading = .fallback

        }

        loading = false
    }

    var signPicker: some View {


        NavigationStack {


            List {


                ForEach(
                    ZodiacSign.allCases
                ){ sign in



                    Button {


                        if selectingMine {

                            mySign = sign

                        } else {

                            partner = sign

                        }


                        showingPicker = false



                    } label:{



                        HStack {


                            Text(sign.symbol)
                                .font(.largeTitle)


                            Text(sign.title)



                            Spacer()

                        }


                    }



                }


            }
            .navigationTitle(
                "Choose Sign"
            )


        }

    }



    var aiCard:some View {


        VStack(
            alignment:.leading,
            spacing:12
        ){


            Text(
                "Relationship Insight"
            )
            .font(.headline)



            Text(
                "Gemini and Libra create a strong intellectual connection. Communication and creativity are your biggest strengths."
            )



        }
        .astroCard()
        .foregroundStyle(.white)

    }


}

struct SignSelectorCard: View {

    let title: String
    let sign: ZodiacSign
    let action: () -> Void


    var body: some View {


        Button(
            action: action
        ) {


            VStack(
                spacing:12
            ) {


                Text(title)
                    .font(.caption)
                    .opacity(0.7)



                Text(sign.symbol)
                    .font(
                        .system(
                            size:55
                        )
                    )


                Text(sign.title)
                    .font(.headline)



            }
            .frame(
                maxWidth:.infinity
            )
            .frame(
                height:150
            )
            .background(
                sign.gradient
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 26)
            )

        }
        .foregroundStyle(.white)

    }
}

struct HistoryView: View {


    @Query(
        sort:\DailyReading.date,
        order:.reverse
    )
    private var readings:[DailyReading]


    @State private var selected:
    DailyReading?



    var body: some View {


        NavigationStack {


            ZStack {


                //AppGradients.background.ignoresSafeArea()
                CosmicBackground()

                ScrollView {


                    VStack(
                        spacing:20
                    ){


                        calendar



                        ForEach(
                            readings
                        ){ reading in


                            ReadingHistoryCard(
                                reading:reading
                            )
                            .onTapGesture {

                                selected =
                                reading

                            }

                        }


                    }
                    .padding()

                }

            }

            .navigationTitle(
                "History"
            )
            .toolbarTitleDisplayMode(.inline)
            .sheet(
                item:$selected
            ){ item in

                ReadingDetailView(
                    reading:item
                )

            }

        }

    }



    var calendar: some View {


        HStack{


            Text(
                "Saved readings"
            )
            .font(
                .title2.bold()
            )

            Spacer()

            Text(
                "\(readings.count) insights"
            )
            .foregroundStyle(.secondary)
            

        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)

    }

}

struct ReadingDetailView: View {


    let reading:DailyReading

    @Environment(\.dismiss) private var dismiss
    
    var body: some View {


        ZStack {


            //AppGradients.background.ignoresSafeArea()
            CosmicBackground()

            ScrollView {


                VStack(
                    spacing:20
                ){


                    HStack {
                        Text(
                            reading.zodiac
                        )
                        .font(
                            .largeTitle.bold()
                        )
                        Spacer()
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundStyle(.gray)
                        }
                    }


                    Text(
                        reading.date,
                        format:.dateTime
                    )



                    ReadingSection(
                        icon:"book",
                        title:"Reading",
                        text:
                        reading.overview
                    )



                    ReadingSection(
                        icon:"sparkles",
                        title:"Insight",
                        text:
                        reading.aiInsight
                    )



                }
                .padding()

            }

        }

    }

}


struct ReadingHistoryCard: View {


    let reading:DailyReading



    var body: some View {


        VStack(
            alignment:.leading,
            spacing:12
        ){


            HStack {


                Text(
                    reading.zodiac
                )
                .font(
                    .headline.bold()
                )


                Spacer()



                Text(
                    reading.date,
                    format:.dateTime.month().day()
                )
                .font(.caption)


            }



            Text(
                reading.overview
            )
            .lineLimit(3)



            HStack {


                Text(
                    "\(reading.loveScore)"
                )


                Text(
                    "\(reading.careerScore)"
                )


                Text(
                    "\(reading.moneyScore)"
                )

            }
            .font(.caption)


        }
        .padding()


        .background(
            .ultraThinMaterial
        )


        .clipShape(
            RoundedRectangle(
                cornerRadius:24
            )
        )


        .foregroundStyle(
            .white
        )

    }

}

struct HomeView: View {


    @Query
    private var users:[UserProfile]


    var user:UserProfile? {

        users.first

    }
    
    //@State private var reading: HomeReading?
    //@State private var loading = false
    @State private var errorText = ""
    
    @Environment(\.modelContext) private var context
    @State private var reading: DailyReading?
    @State private var loading = false

    var body: some View {


        NavigationStack {


            ZStack {


                //AppGradients.background.ignoresSafeArea()
                CosmicBackground()


                ScrollView {


                    VStack(
                        spacing:22
                    ){


                        //header

                        //premium
                        
                        if loading {

                            ProgressView()
                                .controlSize(.large)
                                .tint(.white)

                        }


                        if let reading {

                            HoroscopeHeroCard(
                                sign: user!.zodiac,
                                overview: reading.overview,
                                luckyNumber: reading.luckyNumber,
                                luckyColor: reading.luckyColor
                            )

                       



                        SectionHeader(
                            title:"Cosmic Weather"
                        )



                            MoonCard(sign: user!.zodiac.rawValue)



                        SectionHeader(
                            title:"Daily Insights"
                        )



                        insights
                        

                            InsightCard(
                                text: reading.aiInsight
                            )
                        }

                    }
                    .padding()

                }

            }
            .task {
                //await loadReading()
                await loadDashboard()
            }
            .navigationTitle("Welcome")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    // 3. Directly use NavigationLink as the button
                    NavigationLink(destination: HistoryView()) {
                        Image(systemName: "clock")
                            .tint(.white)
                    }
                    
                }
                ToolbarItem(placement: .topBarTrailing) {
                    // 3. Directly use NavigationLink as the button
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.fill")
                            .tint(.white)
                    }
                }
            }
            

        }
        
    }

    /*@MainActor
    func loadReading() async {

        guard let user else {
            return
        }

        loading = true

        do {

            reading =
            try await HomeAIService
                .shared
                .generateHomeReading(
                    sign: user.zodiac
                )

        } catch {

            errorText =
            error.localizedDescription

        }

        loading = false
    }*/
    
    @MainActor
    func loadDashboard() async {

        guard let user else {
            return
        }

        loading = true

        do {

            reading =
            try await DailyReadingService
                .shared
                .reading(
                    sign: user.zodiac,
                    context: context
                )

        } catch {

            print(error)

        }

        loading = false
    }


    var header:some View {


        VStack(
            alignment:.leading,
            spacing:4
        ){


            Text(
                "Good Evening"
            )
            .font(.title)



            Text(
                "Stargazer"
            )
            .font(
                .largeTitle.bold()
            )

        }
        .foregroundStyle(
            .white
        )
        .frame(
            maxWidth:.infinity,
            alignment:.leading
        )

    }



    var insights:some View {


        LazyVGrid(
            columns:[
                GridItem(.flexible()),
                GridItem(.flexible())
            ],
            spacing:15
        ){

            if let reading {
                CompatibilityStat(
                    icon:"heart.fill",
                    title:"Love",
                    value:"\(reading.loveScore)%",
                    color: .red
                )
                
                CompatibilityStat(
                    icon:"case.fill",
                    title:"Career",
                    value:"\(reading.careerScore)%",
                    color: .brown
                )
                
                CompatibilityStat(
                    icon:"dollarsign",
                    title:"Money",
                    value:"\(reading.moneyScore)%",
                    color: .green
                )
                
                CompatibilityStat(
                    icon:"figure.mixed.cardio",
                    title:"Health",
                    value:"\(reading.healthScore)%",
                    color: .blue
                )
            }

        }
        
        

    }



    func stat(
        _ icon:String,
        _ title:String,
        _ value:String
    )->some View{


        VStack(
            spacing:10
        ){

            Text(icon)
                .font(.title)


            Text(value)
                .font(
                    .title.bold()
                )


            Text(title)
                .opacity(0.7)

        }
        .frame(
            maxWidth:.infinity,
            minHeight:110
        )
        .astroCard()
        .foregroundStyle(.white)

    }




    var premium:some View{


        VStack(
            alignment:.leading,
            spacing:12
        ){


            Text(
                "Unlock Permium"
            )
            .font(
                .title3.bold()
            )


            Text(
                "Get personalized astrology, tarot and prediction"
            )



            GradientButton(
                title:"Try Premium"
            ){}


        }
        .astroCard()

    }
}


struct HoroscopeHeroCard: View {

    let sign: ZodiacSign
    let overview: String
    let luckyNumber: String
    let luckyColor: String

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 10
        ) {


            HStack {

                VStack(
                    alignment:.leading
                ){

                    Text("TODAY'S HOROSCOPE")
                        .font(.caption)
                        .opacity(0.8)


                    Text(
                        "\(sign.title)"
                    )
                    .font(.largeTitle.bold())

                }


                Spacer()


                Text(sign.symbol)
                    .font(
                        .system(
                            size:70
                        )
                    )
            }



            Text(overview)
            .font(.headline)



            Spacer()



            HStack {


                VStack(
                    alignment:.leading
                ){

                    Text("Lucky Number")
                        .font(.caption)


                    Text(luckyNumber)
                        .font(.title.bold())
                }



                Spacer()



                VStack(
                    alignment:.leading
                ){

                    Text("Lucky Color")
                        .font(.caption)


                    Text(luckyColor)
                        .font(.title.bold())
                }

            }

        }
        .padding()
        .frame(
            height:280
        )
        .frame(
            maxWidth:.infinity
        )
        .background(sign.gradient.opacity(0.8))
        .clipShape(
            RoundedRectangle(
                cornerRadius:32,
                style:.continuous
            )
        )
        .foregroundStyle(.white)

    }
}


struct InsightCard: View {
    
    let text: String


    var body: some View {


        VStack(
            alignment:.leading,
            spacing:12
        ){


            HStack {


                Image(
                    systemName:
                    "sparkles"
                )
                .foregroundStyle(
                    .yellow
                )


                Text("Cosmic Insight")
                    .font(.headline)
                Spacer()

            }


            Text(text)
            .font(.body)

            Spacer()
        }
        .astroCard()
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)


    }
}


struct MoonCard: View {

    @State private var moon: MoonPhase?

    @State private var moonText = ""
    var sign = ""
    
    var body: some View {


        HStack {


            if let moon {


                VStack(alignment: .leading) {

                HStack {
                    Text(
                        Image(systemName: moon.emoji)
                        
                    )
                    .font(
                        .system(
                            size:50
                        )
                    )
                    

                    Text(
                        moon.name
                    )
                    .font(
                        .title2
                    )
                }



            ProgressView(
                value:
                Double(
                    moon.illumination
                ),
                total:100
            )
            .padding(.bottom, 10)

                Spacer()

            /*Text(
                "\(moon.illumination)% illumination"
            )
            .font(.body)*/


            Text(
                moonText
            )
            .font(.body)


            }


            }


            Spacer()

        }
        .astroCard()
        .foregroundStyle(.white)
        .task {
            await loadMoon()

        }

    }
    
    @MainActor
    func loadMoon() async {


        let phase =
        MoonCalculator
            .shared
            .calculate()


        moon = phase



        do {

            moonText =
            try await MoonAIService
                .shared
                .generate(
                    moon:phase,
                    sign: sign
                )


        } catch {

            moonText =
            phase.description
        }

    }
}


struct HoroscopeDetailView: View {


    let sign: ZodiacSign


    @State private var selected =
        "Today"



    let tabs = [
        "Today",
        "Week",
        "Month",
        "Year"
    ]
    
    @State private var aiText = ""
    @State private var loading = false



    var body: some View {


        ZStack {


            //AppGradients.background.ignoresSafeArea()
            CosmicBackground()


            ScrollView {


                VStack(
                    spacing:20
                ) {



                    header



                    Picker(
                        "",
                        selection:$selected
                    ){

                        ForEach(
                            tabs,
                            id:\.self
                        ){ tab in


                            Text(tab)
                                .tag(tab)

                        }

                    }
                    .pickerStyle(
                        .segmented
                    )



                    ReadingCard(
                        icon:"✨",
                        title:"Overview",
                        text:
                        overviewText
                    )



                    ReadingCard(
                        icon:"❤️",
                        title:"Love",
                        text:
                        "Your relationships feel more balanced today. Open communication creates stronger connections."
                    )



                    ReadingCard(
                        icon:"💼",
                        title:"Career",
                        text:
                        "A good day to focus on goals and new opportunities."
                    )



                    ReadingCard(
                        icon:"🧘",
                        title:"Health",
                        text:
                        "Balance your energy. Rest and mindfulness will help."
                    )
                    
                    Button {
                        loading = true
                        Task {
                            aiText =
                            try await HoroscopeAI
                            .generate(
                                sign:sign
                            )
                            loading = false
                        }
                    } label:{
                        Text(
                            "Generate AI Horoscope ✨"
                        )
                    }
                    
                    if !aiText.isEmpty {
                        ReadingCard(
                            icon:"🤖",
                            title:"AI Reading",
                            text:aiText
                        )

                    }


                }
                .padding()

            }


        }
        .navigationTitle(
            sign.title
        )
        .navigationBarTitleDisplayMode(
            .inline
        )

    }



    var header: some View {


        VStack(
            spacing:12
        ){


            Text(sign.symbol)
                .font(
                    .system(
                        size:90
                    )
                )



            Text(
                sign.title
            )
            .font(
                .largeTitle.bold()
            )


            Text(
                sign.dateRange
            )
            .opacity(0.7)



        }
        .foregroundStyle(
            .white
        )
        .frame(
            maxWidth:.infinity
        )
        .padding()
        .background(
            sign.gradient
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 30)
        )

    }



    var overviewText:String {


        switch selected {


        case "Week":

            return "This week brings new motivation and important decisions."

        case "Month":

            return "The month focuses on growth, relationships and confidence."

        case "Year":

            return "A year of transformation and personal development."

        default:

            return "Your energy is strong today. Follow your intuition and stay open to new possibilities."

        }

    }

}


struct HoroscopeView: View {


    let signs = ZodiacSign.allCases

    @Environment(SubscriptionManager.self)
    private var premium

    var body: some View {


        NavigationStack {


            ZStack {


                //AppGradients.background.ignoresSafeArea()
                CosmicBackground()


                ScrollView {
                    
                    VStack(
                        spacing:25
                    ){
                    
                        if !premium.isSubscribed {
                            premiumCard()
                        }


                    LazyVGrid(
                        columns:[
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing:16
                    ){
                        
                        
                        ForEach(
                            signs
                        ){ sign in
                            
                            
                            
                            NavigationLink {
                                
                                
                                //HoroscopeDetailView(
                                ZodiacDetailView(
                                    sign:sign
                                )
                                
                                
                            } label:{
                                
                                
                                
                                ZodiacCard(
                                    sign:sign
                                )
                                
                                
                                
                            }
                            
                            
                        }
                        
                    }
                    .premiumLocked(
                        premium.isSubscribed
                    )
                    }.padding()
                    


                }


            }
            .navigationTitle(
                "Horoscope"
            )
            .toolbarTitleDisplayMode(.inlineLarge)

        }

    }
}


struct ReadingCard: View {

    let icon: String
    let title: String
    let text: String


    var body: some View {

        VStack(
            alignment:.leading,
            spacing:14
        ) {


            HStack {

                Text(icon)
                    .font(.title)

                Text(title)
                    .font(.headline)

            }


            Text(text)
                .font(.body)
                .foregroundStyle(
                    .white.opacity(0.75)
                )


        }
        .frame(
            maxWidth:.infinity,
            alignment:.leading
        )
        .astroCard()
        .foregroundStyle(.white)

    }
}


struct ReadingSection: View {


    let icon:String

    let title:String

    let text:String



    var body: some View {


        VStack(
            alignment:.leading,
            spacing:12
        ){


            HStack {


                Text(Image(systemName: icon))
                    .font(.title)



                Text(title)
                    .font(
                        .headline.bold()
                    )
Spacer()

            }


            Text(text)
                .font(.body)
                .opacity(0.85)



        }
        .padding()

        .background(
            AppColors.card
        )

        .clipShape(
            RoundedRectangle(
                cornerRadius: 24
            )
        )

        .foregroundStyle(
            .white
        )

    }
}


struct ZodiacDetailView: View {


    let sign: ZodiacSign


    @State private var reading: ZodiacReading?

    @State private var loading = false


    var body: some View {


        ZStack {


            //AppGradients.background.ignoresSafeArea()
            CosmicBackground()


            ScrollView {


                VStack(
                    spacing:20
                ){

                        
                        header
                        
                        if loading {
                            
                            
                            ProgressView()
                                .tint(.white)
                            
                            
                        }
                        
                        
                        
                        if let reading {
                            
                            
                            ReadingSection(
                                icon:"sparkles",
                                title:"Personality",
                                text:
                                    reading.personality
                            )
                            
                            
                            ReadingSection(
                                icon:"heart.fill",
                                title:"Love",
                                text:
                                    reading.love
                            )
                            
                            
                            ReadingSection(
                                icon:"case.fill",
                                title:"Career",
                                text:
                                    reading.career
                            )
                            
                            
                            ReadingSection(
                                icon:"star.fill",
                                title:"Strengths",
                                text:
                                    reading.strengths
                            )
                            
                            
                            ReadingSection(
                                icon:"moonphase.new.moon",
                                title:"Challenges",
                                text:
                                    reading.challenges
                            )
                            
                            
                            ReadingSection(
                                icon:"lasso.badge.sparkles",
                                title:"Advice",
                                text:
                                    reading.advice
                            )
                            
                            
                        }

                }
                .padding()

            }
            .task {
                await loadReading()
            }

        }
        
        .navigationTitle(
            "Horoscope"
        )
        .navigationBarTitleDisplayMode(
            .inline
        )

    }



    var header: some View {


        VStack(
            spacing:15
        ){


            Text(
                sign.symbol
            )
            .font(
                .system(
                    size:90
                )
            )
            .foregroundStyle(sign.gradient)


            Text(
                sign.title
            )
            .font(
                .largeTitle.bold()
            )
            



        }
        .foregroundStyle(
            .white
        )

    }



    @MainActor
    func loadReading() async {


        loading = true


        do {


            reading =
            try await AIService.shared
                .generateZodiacReading(
                    sign: sign
                )


        } catch {


            print(error)


        }


        loading = false

    }

}


struct BirthDataSetupView: View {

    @Environment(\.modelContext)
    private var context

    @Query
    private var users: [UserProfile]

    @State private var birthDate = Date()

    @State private var birthTime = Date()

    @State private var city = ""

    var body: some View {

        ZStack {

            CosmicBackground()

            ScrollView {

                VStack(spacing: 24) {

                    Text(Image(systemName: "moon"))
                        .font(.system(size: 70))
                        .foregroundStyle(.yellow)

                    Text("Complete Your Birth Chart")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)

                    Text(
                        "Your birth details help generate accurate astrology insights."
                    )
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)

                    VStack(spacing: 16) {

                        HStack {

                            Text("Birth Date")

                            DatePicker(
                                "",
                                selection: $birthDate,
                                displayedComponents: .date
                            )
                            .labelsHidden()
                            Spacer()
                        }

                        HStack {

                            Text("Birth Time")

                            DatePicker(
                                "",
                                selection: $birthTime,
                                displayedComponents: .hourAndMinute
                            )
                            .labelsHidden()
                            Spacer()
                        }

                        HStack {

                            Text("Birth City")

                            TextField(
                                "New York",
                                text: $city
                            )
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 18)
                            )
                            Spacer()
                        }
                    }

                    /*Button {
                        saveProfile()
                    } label: {
                        Text("Generate Horoscope")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .buttonStyle(CosmicButtonStyle())*/
                    
                    Text("By tapping Agree you acknowledge and consent to your data may be transmitted to and processed by AI service to generate responses. Please avoid sharing sensitive personal data, confidential details or private information. AI-generated outputs may occasionally be inaccurate.")
                    
                    GradientButton(title: "Agree and Generate Horoscope", action: {
                        saveProfile()
                    })
                    
                }
                .padding()
                .foregroundStyle(.white)
            }
        }
    }

    private func saveProfile() {

        let user = users.first ?? UserProfile()

        user.birthDate = birthDate
        user.birthTime = birthTime
        user.birthCity = city
        
        let newSign =
        ZodiacCalculator.sign(
            from: birthDate
        )
        user.zodiac = newSign

        if users.isEmpty {
            context.insert(user)
        }

        try? context.save()

        NotificationCenter.default.post(
            name: .onboardingFinished,
            object: nil
        )
    }
}


struct ChartReadyView: View {


    let action: () -> Void


    var body: some View {


        VStack(spacing:25) {


            Text("✨")
                .font(
                    .system(size:90)
                )


            Text(
                "Your Chart Is Ready"
            )
            .font(
                .largeTitle.bold()
            )


            Text(
                "Your planets and cosmic energy have been calculated."
            )
            .multilineTextAlignment(.center)



            Button(
                action: action
            ) {

                Text(
                    "Enter App"
                )
                .frame(
                    maxWidth:.infinity
                )
                .padding()

            }
            .buttonStyle(
                CosmicButtonStyle()
            )


        }
        .padding()
        .foregroundStyle(.white)
    }
}


struct GeneratingChartView: View {


    var body: some View {


        VStack(spacing:25) {


            ProgressView()
                .scaleEffect(2)



            Text(
"""
Reading your planets...
Calculating your cosmic pattern...
Creating your birth chart...
"""
            )
            .multilineTextAlignment(.center)
            .font(.title3.bold())


        }
        .foregroundStyle(.white)

    }
}


struct LoadingView: View {

    @State private var text =

    "Reading cosmic energy..."

    var body: some View {

        VStack(spacing: 25) {

            ProgressView()
                .scaleEffect(2)

            Text(text)
                .font(
                    .title3.bold()
                )
        }
        .foregroundStyle(.white)

        .task {

            let items = [

                "Reading cosmic energy...",
                "Matching planetary patterns...",
                "Analyzing hidden strengths...",
                "Building your profile..."
            ]

            for item in items {

                text = item

                try? await Task.sleep(
                    for: .seconds(1)
                )
            }
        }
    }
}

enum OnboardingStep {

    case quiz

    case result

    case paywall

    case activated

    case birthData

    case generatingChart

    case chartReady

    case finished
}

enum AppOnboardingStep {

    case quiz
    case paywall
    case birthData
    case completed
}

struct OnboardingView: View {

    @State private var vm = QuizViewModel()

    @State private var showLoading = false

    @State private var showResult = false

    var body: some View {

        NavigationStack {

            ZStack {

                CosmicBackground()
                //AppGradients.background.ignoresSafeArea()

                if showLoading {

                    LoadingView()

                } else if showResult {

                    ResultPreviewView(
                        profileText:
                        vm.profileText
                    )

                } else {

                    QuestionView(
                        vm: vm,
                        onFinished: {

                            Task {

                                await generateProfile()

                            }

                        }
                    )
                }

            }
        }
    }

    @MainActor
    func generateProfile() async {

        showLoading = true

        do {

            let result =
            try await AIService.shared
                .generateQuizProfile(
                    answers:
                    vm.selectedAnswers
                )

            vm.profileText =
            result

        } catch {

            vm.profileText =
            """
            You possess strong intuition,
            emotional awareness and a
            natural drive for growth.
            """
        }

        try? await Task.sleep(
            for: .seconds(2)
        )

        showLoading = false

        showResult = true
    }
}

struct QuestionView: View {

    @Bindable var vm: QuizViewModel

    let onFinished: () -> Void

    var body: some View {

        VStack(spacing: 30) {

            ProgressView(
                value: vm.progress
            )
            .tint(.purple)

            Spacer()

            Text(
                vm.currentQuestion.title
            )
            .font(
                .largeTitle.bold()
            )
            .multilineTextAlignment(
                .center
            )

            VStack(spacing: 16) {

                ForEach(
                    vm.currentQuestion.answers,
                    id: \.self
                ) { answer in

                    Button {

                        if vm.currentIndex ==
                            vm.questions.count - 1 {

                            vm.select(answer)

                            onFinished()

                        } else {

                            vm.select(answer)
                        }

                    } label: {

                        Text(answer)
                            .frame(
                                maxWidth: .infinity
                            )
                            .padding()
                    }
                    .buttonStyle(
                        CosmicButtonStyle()
                    )
                }
            }

            Spacer()
        }
        .padding()
        .foregroundStyle(.white)
    }
    
    
}


struct QuizQuestion: Identifiable {

    let id = UUID()

    let title: String

    let answers: [String]
}


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

struct ResultPreviewView: View {

    let profileText: String

    @State private var showPaywall = false

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                Text(Image(systemName: "sparkles"))
                    .font(
                        .system(size: 80)
                    )
                    .foregroundStyle(.yellow)

                Text(
                    "Your Profile"
                )
                .font(
                    .largeTitle.bold()
                )

                GlowCard {

                    Text(profileText)
                        .foregroundStyle(
                            .white
                        )
                    
                }

                /*Button {
                    showPaywall = true
                } label: {
                    Text(
                        "Unlock Full Reading"
                    )
                    .frame(
                        maxWidth: .infinity
                    )
                    .padding()
                }
                .buttonStyle(CosmicButtonStyle())*/
                
                GradientButton(title: "Unlock Full Reading", action: {
                    showPaywall = true
                })
            }
            .padding()
        }
        .fullScreenCover(isPresented: $showPaywall) {
            PaywallView()
        }
    }
    
    
}


struct SubscriptionActivatedView: View {


    let action: () -> Void


    var body: some View {


        VStack(spacing:30) {


            Text("🎉")
                .font(
                    .system(size:90)
                )


            Text(
                "Subscription Activated"
            )
            .font(
                .largeTitle.bold()
            )
            .multilineTextAlignment(.center)



            Text(
"""
Your premium journey begins.

Next step:
Generate your personal birth chart.
"""
            )
            .multilineTextAlignment(.center)
            .foregroundStyle(
                .secondary
            )


            Button(
                action: action
            ) {

                Text(
                    "Create My Birth Chart"
                )
                .frame(
                    maxWidth:.infinity
                )
                .padding()

            }
            .buttonStyle(
                CosmicButtonStyle()
            )

        }
        .padding()
        .foregroundStyle(.white)
    }
}

struct PaywallView: View {

    @Environment(\.dismiss)
    private var dismiss

    @State
    private var subscriptions =
    SubscriptionManager.shared

    @State
    private var animateHero = false

    var onSuccess: (() -> Void)?
    
    @State
    private var showBdata = false
    
    @Query
    private var users: [UserProfile]

    var body: some View {

        ZStack {

            CosmicBackground()

            ScrollView(showsIndicators: false) {

                VStack(spacing: 28) {

                    hero

                    titleSection

                    features

                    subscriptionsSection

                    purchaseButton

                    bottomButtons

                }
                .padding(.horizontal, 24)
                

            }

            if subscriptions.purchaseInProgress {

                loadingOverlay

            }

        }
        .task {

            await subscriptions.loadProducts()

            await subscriptions.updatePurchasedProducts()

        }
        .onChange(
            of: subscriptions.isSubscribed
        ) { _, subscribed in

            if subscribed {

                dismiss()

                onSuccess?()

            }
        }
        .alert(
            "Purchase Error",
            isPresented: .constant(
                subscriptions.errorMessage != nil
            )
        ) {

            Button("OK") {

                subscriptions.errorMessage = nil

            }

        } message: {

            Text(
                subscriptions.errorMessage ?? ""
            )

        }

    }

    // MARK: Hero

    var hero: some View {

        VStack(spacing: 20) {
            
            ZStack {
                
                Circle()
                    .fill(
                        Color.purple.opacity(0.15)
                    )
                    .frame(
                        width: 70,
                        height: 70
                    )
                
                Image(systemName: "sparkles")
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
                
                if !users.isEmpty {
                    HStack {
                        Spacer()
                        VStack{
                            dismissButton
                            Spacer()
                        }
                    }
                }
                
            }
            /*.scaleEffect(
                animateHero ? 1.05 : 0.95
            )
            .animation(
                .easeInOut(duration: 2)
                .repeatForever(),
                value: animateHero
            )
            .onAppear {
                animateHero = true
                
            }*/
            
        }.padding(.top, 0)

    }

    // MARK: Title

    var titleSection: some View {

        VStack(spacing: 12) {

            Text("Unlock Premium")
                .font(.system(size: 34, weight: .bold))
                .multilineTextAlignment(.center)

            Text(
                "Unlimited astrology, birth charts and personal astrologer"
            )
            .font(.body)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)

        }
        .foregroundStyle(.white)

    }

    // MARK: Features

    var features: some View {

        GlowCard {

            VStack(spacing: 18) {

                PremiumFeatureRow(
                    icon: "sparkles",
                    title: "Unlimited AI Horoscope"
                )

                PremiumFeatureRow(
                    icon: "moon.stars.fill",
                    title: "Personal Birth Chart"
                )

                PremiumFeatureRow(
                    icon: "heart.fill",
                    title: "Compatibility Reports"
                )

                PremiumFeatureRow(
                    icon: "message.fill",
                    title: "Unlimited AI Chat"
                )

                PremiumFeatureRow(
                    icon: "star.fill",
                    title: "Premium Features Forever"
                )

            }

        }

    }

    // MARK: Plans

    var subscriptionsSection: some View {

        VStack(spacing: 15) {

            if let yearly = subscriptions.yearlyProduct {

                SubscriptionCard(

                    product: yearly,

                    selected:
                    subscriptions.yearlySelected,

                    badge: "BEST VALUE"

                ) {

                    subscriptions.selectYearly()

                }

            }

            if let weekly = subscriptions.weeklyProduct {

                SubscriptionCard(

                    product: weekly,

                    selected:
                    subscriptions.weeklySelected

                ) {

                    subscriptions.selectWeekly()

                }

            }

        }

    }

    // MARK: Purchase
    var purchaseButton: some View {
        /*Button {
            Task {
                await subscriptions.purchaseSelected()
            }
        } label: {
            Text(
                subscriptions.selectedProduct?.hasTrial == true ? "Start Free Trial" : "Continue"
            )
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
        }
        .buttonStyle(CosmicButtonStyle())*/
        GradientButton(title: subscriptions.selectedProduct?.hasTrial == true ? "Start Free Trial" : "Continue", action: {
            Task {
                await subscriptions.purchaseSelected()
            }
        })
    }

    // MARK: Footer

    var bottomButtons: some View {
        
        VStack {
            
            HStack {
                Button("Restore") {
                    Task {
                        await subscriptions.restorePurchases()
                    }
                }
                                
                Link("Terms", destination: URL(string: "https://google.com")!)
                Link("Policy", destination: URL(string: "https://google.com")!)

                if users.isEmpty {
                    Button("Start with limits") {
                        showBdata = true
                    }
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.65))
                }
            }
            .font(.caption)
            .foregroundStyle(.white.opacity(0.65))
            .padding(.top, 0)
            Text("Subscriptions auto-renew. Cancel anytime in App Store Settings.")
                                .font(.system(size: 10))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .opacity(0.65)
                                .padding(.top, 10)
        }
        .fullScreenCover(isPresented: $showBdata) {
            BirthDataSetupView()
        }
    }

    // MARK: Loading

    var loadingOverlay: some View {

        ZStack {

            Color.black.opacity(0.5)
                .ignoresSafeArea()

            VStack(spacing: 20) {

                ProgressView()

                Text("Processing Purchase...")

            }
            .padding(30)
            .background(.ultraThinMaterial)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 24
                )
            )

        }
        .foregroundStyle(.white)

    }

    private var dismissButton: some View {

        Button {

            dismiss()

        } label: {

            Image(systemName: "xmark")
                .font(.headline)
                .foregroundStyle(.white).opacity(0.7)
                
        }
    }
}


struct PremiumFeatureRow: View {

    let icon: String

    let title: String

    var body: some View {

        HStack(spacing: 16) {

            Image(systemName: icon)
                .font(.title3)

                .foregroundStyle(.purple)

                .frame(width: 30)

            Text(title)

            Spacer()

        }
        .foregroundStyle(.white)

    }

}


struct SubscriptionCard: View {

    let product: Product

    let selected: Bool

    var badge: String? = nil

    let action: () -> Void

    @State private var pulse = false

    var body: some View {

        Button(action: action) {

            ZStack(alignment: .topTrailing) {

                RoundedRectangle(cornerRadius: 26)
                    .fill(.ultraThinMaterial)

                RoundedRectangle(cornerRadius: 26)
                    .strokeBorder(
                        selected
                        ? Color.purple
                        : Color.white.opacity(0.12),
                        lineWidth: selected ? 2.5 : 1
                    )

                VStack(alignment: .leading, spacing: 18) {

                    HStack(alignment: .top) {

                        VStack(alignment: .leading, spacing: 6) {

                            HStack{
                                Text(title)
                                    .font(.title3.bold())
                                    .padding(.trailing, 10)
                                
                                /*if let badge {
                                    Text(badge)
                                        .font(.caption2.bold())
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(
                                            Capsule()
                                                .fill(
                                                    LinearGradient(
                                                        colors: [
                                                            .pink,
                                                            .pink
                                                        ],
                                                        startPoint: .leading,
                                                        endPoint: .trailing
                                                    )
                                                )
                                        )
                                        .foregroundStyle(.white)
                                        //.offset(x: -16, y: 14)
                                        .scaleEffect(
                                            pulse ? 1.05 : 0.95
                                        )
                                        .animation(
                                            .easeInOut(duration: 1.6)
                                            .repeatForever(),
                                            value: pulse
                                        )
                                        .onAppear {
                                            pulse = true

                                        }
                                }*/
                            }

                            /*Text(subtitle)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)*/
                            
                            Text("\(product.displayPrice) / \(priceDescription)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        /*Image(systemName:
                                selected
                                ? "checkmark.circle.fill"
                                : "circle")
                        .font(.title2)
                        .foregroundStyle(
                            selected
                            ? Color.purple
                            : Color.gray
                        )*/
                        
                        Text(product.displayPrice)
                            .font(.title3.bold())
                    }

                    //Divider().overlay(Color.white.opacity(0.08))

                    /*HStack(alignment: .bottom) {

                        VStack(alignment: .leading, spacing: 4) {

                            Text(product.displayPrice)
                                .font(.system(size: 28, weight: .bold))

                            Text(priceDescription)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        if let weekly = product.weeklyEquivalent {

                            VStack(alignment: .trailing, spacing: 4) {

                                Text("\(weekly)/week")
                                    .font(.headline)

                                Text("Equivalent")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        
                        if let badge {

                            Text(badge)
                                .font(.caption2.bold())
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(
                                            LinearGradient(
                                                colors: [
                                                    .purple,
                                                    .blue
                                                ],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                )
                                .foregroundStyle(.white)
                                .offset(x: -16, y: 14)
                                .scaleEffect(
                                    pulse ? 1.05 : 0.95
                                )
                                .animation(
                                    .easeInOut(duration: 1.6)
                                    .repeatForever(),
                                    value: pulse
                                )
                                .onAppear {

                                    pulse = true

                                }
                        }
                    }*/
                }
                .padding(22)

                

            }
            //.frame(height: 170)
            .shadow(
                color: selected
                ? .purple.opacity(0.35)
                : .clear,
                radius: 20
            )
            .scaleEffect(selected ? 1.02 : 1)
            .animation(
                .spring(
                    response: 0.35,
                    dampingFraction: 0.8
                ),
                value: selected
            )

        }
        .buttonStyle(.plain)
    }

    private var selectedGradient: LinearGradient {

        LinearGradient(
            colors: [
                .purple,
                .blue
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private var title: String {

        if product.id == SubscriptionManager.yearlyID {
            return "Monthly"
        }

        return "Weekly"
    }

    private var subtitle: String {

        if product.id == SubscriptionManager.yearlyID {

            if product.hasTrial {
                return "Includes Free Trial"
            }

            return "Best value"
        }

        return "Cancel anytime"
    }

    private var priceDescription: String {

        if product.id == SubscriptionManager.yearlyID {
            return "per month"
        }

        return "per week"
    }
}


struct premiumCard: View {
    @State private var isShowingSheet = false
    var body: some View {
        VStack(
            alignment: .leading,
            spacing:15
        ){
            
            HStack {
                Text(
                    "Unlock All Features"
                )
                .font(
                    .title3.bold()
                )
                Spacer()
            }
                
                
                Text(
                    "Get insights, connections and future predictions"
                ).font(
                    .caption
                )
            
            
            
            GradientButton(
                title:
                    "Unlock Premium"
            ){
                isShowingSheet = true
            }
            
            
            
        }
        .astroCard()
        .foregroundStyle(
            .white
        )
        .frame(maxWidth: .infinity)
        .fullScreenCover(isPresented: $isShowingSheet) {
            PaywallView()
        }
    }
}


struct PremiumLock: ViewModifier {


    let unlocked:Bool



    func body(
        content:Content
    ) -> some View {


        if unlocked {

            content


        } else {


            content
                .blur(
                    radius:5
                )
                .overlay {


                    Image(
                        systemName:
                        "lock.fill"
                    )
                    .font(.largeTitle)
                    .foregroundStyle(
                        .white
                    )

                }

        }

    }

}


extension View {


    func premiumLocked(
        _ value:Bool
    ) -> some View {


        modifier(
            PremiumLock(
                unlocked:value
            )
        )

    }

}

@MainActor
@Observable
final class SubscriptionManager {

    static let shared = SubscriptionManager()

    private init() {}

    // MARK: - Product IDs

    static let weeklyID = "horoscope001"
    static let yearlyID = "horoscope002"

    // MARK: - Published State

    var products: [Product] = []

    var weeklyProduct: Product?

    var yearlyProduct: Product?

    var selectedProduct: Product?

    var purchasedProductIDs: Set<String> = []

    var isSubscribed = false

    var isLoading = false

    var purchaseInProgress = false

    var errorMessage: String?
    

    // MARK: - Load Products

    func loadProducts() async {

        guard products.isEmpty else { return }

        isLoading = true

        do {

            let storeProducts = try await Product.products(
                for: [
                    Self.weeklyID,
                    Self.yearlyID
                ]
            )

            products = storeProducts

            weeklyProduct = storeProducts.first {
                $0.id == Self.weeklyID
            }

            yearlyProduct = storeProducts.first {
                $0.id == Self.yearlyID
            }

            selectedProduct = yearlyProduct ?? weeklyProduct

        } catch {

            errorMessage = error.localizedDescription

            print(error)
        }

        isLoading = false
    }

    // MARK: - Purchase

    func purchaseSelected() async {

        guard let product = selectedProduct else {
            return
        }

        purchaseInProgress = true

        do {

            let result = try await product.purchase()

            switch result {

            case .success(let verification):

                switch verification {

                case .verified(let transaction):

                    await transaction.finish()

                    await updatePurchasedProducts()

                case .unverified(_, let error):

                    errorMessage = error.localizedDescription
                }

            case .pending:
                break

            case .userCancelled:
                break

            @unknown default:
                break
            }

        } catch {

            errorMessage = error.localizedDescription
        }

        purchaseInProgress = false
    }

    // MARK: - Restore

    func restorePurchases() async {

        do {

            try await AppStore.sync()

            await updatePurchasedProducts()

        } catch {

            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Check Entitlements

    func updatePurchasedProducts() async {

        purchasedProductIDs.removeAll()

        for await result in Transaction.currentEntitlements {

            guard case .verified(let transaction) = result else {
                continue
            }

            purchasedProductIDs.insert(
                transaction.productID
            )
        }

        isSubscribed = purchasedProductIDs.contains(Self.weeklyID) || purchasedProductIDs.contains(Self.yearlyID)
    }

    // MARK: - Transaction Listener

    func startListening() {

        Task {

            for await update in Transaction.updates {

                guard case .verified(let transaction) = update else {
                    continue
                }

                await transaction.finish()

                await updatePurchasedProducts()
            }
        }
    }

    // MARK: - Helpers

    func selectWeekly() {

        selectedProduct = weeklyProduct
    }

    func selectYearly() {

        selectedProduct = yearlyProduct
    }

    var yearlySelected: Bool {

        selectedProduct?.id == Self.yearlyID
    }

    var weeklySelected: Bool {

        selectedProduct?.id == Self.weeklyID
    }
}


extension Product {

    var displayPriceText: String {

        displayPrice
    }

    var hasTrial: Bool {

        subscription?
            .introductoryOffer != nil
    }

    var weeklyEquivalent: String? {

        guard
            let subscription,
            subscription.subscriptionPeriod.unit == .year,
            let price = Decimal(string: price.description)
        else {
            return nil
        }

        let weekly = price / 52

        let formatter = NumberFormatter()

        formatter.numberStyle = .currency

        formatter.currencyCode = priceFormatStyle.currencyCode

        return formatter.string(
            from: weekly as NSNumber
        )
    }
}


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


enum ZodiacCalculator {

    static func sign(
        from date: Date
    ) -> ZodiacSign {


        let calendar = Calendar.current


        let month =
        calendar.component(
            .month,
            from: date
        )


        let day =
        calendar.component(
            .day,
            from: date
        )


        switch (month, day) {


        case (3,21...31),
             (4,1...19):
            return .aries


        case (4,20...30),
             (5,1...20):
            return .taurus


        case (5,21...31),
             (6,1...20):
            return .gemini


        case (6,21...30),
             (7,1...22):
            return .cancer


        case (7,23...31),
             (8,1...22):
            return .leo


        case (8,23...31),
             (9,1...22):
            return .virgo


        case (9,23...30),
             (10,1...22):
            return .libra


        case (10,23...31),
             (11,1...21):
            return .scorpio


        case (11,22...30),
             (12,1...21):
            return .sagittarius


        case (12,22...31),
             (1,1...19):
            return .capricorn


        case (1,20...31),
             (2,1...18):
            return .aquarius


        case (2,19...29),
             (3,1...20):
            return .pisces


        default:
            return .aries
        }
    }
}


@Model
final class AIReading {


    var title:String

    var content:String

    var createdAt:Date



    init(
        title:String,
        content:String
    ){

        self.title = title

        self.content = content

        self.createdAt = Date()

    }

}

struct BirthChartReading: Codable {

    let sun: String
    let moon: String
    let rising: String

    let mercury: String
    let venus: String
    let mars: String

    let reading: String
}

struct BirthData: Codable {

    let date: Date

    let time: Date

    let city: String

    let latitude: Double

    let longitude: Double
}

struct CompatibilityReading: Codable {

    let overallScore: Int

    let loveScore: Int

    let communicationScore: Int

    let friendshipScore: Int

    let longTermScore: Int

    let insight: String
}

extension CompatibilityReading {

    static var schema: JSONSchema {

        JSONSchema(
            name: "compatibility_reading",
            strict: true,
            schema: Schema(
                type: "object",
                additionalProperties:false,
                properties: [

                    "overallScore":
                        Property(type: "integer"),

                    "loveScore":
                        Property(type: "integer"),

                    "communicationScore":
                        Property(type: "integer"),

                    "friendshipScore":
                        Property(type: "integer"),

                    "longTermScore":
                        Property(type: "integer"),

                    "insight":
                        Property(type: "string")
                ],
                required: [
                    "overallScore",
                    "loveScore",
                    "communicationScore",
                    "friendshipScore",
                    "longTermScore",
                    "insight"
                ]
            )
        )
    }
}

extension CompatibilityReading {

    static let fallback =
    CompatibilityReading(
        overallScore: 85,
        loveScore: 88,
        communicationScore: 84,
        friendshipScore: 87,
        longTermScore: 82,
        insight:
"""
This relationship has strong potential through communication and mutual respect.
"""
    )
}

@Model
final class DailyReading {

    @Attribute(
            .unique
        )
        var id: UUID

    
    var zodiac: String

    var date: Date

    var overview: String

    var luckyNumber: String

    var luckyColor: String

    var loveScore: Int

    var careerScore: Int

    var moneyScore: Int

    var healthScore: Int

    var aiInsight: String


    init(
        zodiac: String,
        date: Date,
        overview: String,
        luckyNumber: String,
        luckyColor: String,
        loveScore: Int,
        careerScore: Int,
        moneyScore: Int,
        healthScore: Int,
        aiInsight: String
    ) {

        id = UUID()
        
        self.zodiac = zodiac
        self.date = date

        self.overview = overview

        self.luckyNumber = luckyNumber
        self.luckyColor = luckyColor

        self.loveScore = loveScore
        self.careerScore = careerScore
        self.moneyScore = moneyScore
        self.healthScore = healthScore

        self.aiInsight = aiInsight
    }
}


struct HomeReading: Codable {

    let overview: String

    let luckyNumber: String

    let luckyColor: String

    let loveScore: Int

    let careerScore: Int

    let moneyScore: Int

    let healthScore: Int

    let aiInsight: String
}

extension HomeReading {

    static var schema: JSONSchema {

        JSONSchema(
            name: "daily_horoscope",
            strict: true,
            schema: Schema(
                type: "object",
                additionalProperties:false,
                properties: [

                    "overview":
                        Property(type: "string"),

                    "luckyNumber":
                        Property(type: "string"),

                    "luckyColor":
                        Property(type: "string"),

                    "loveScore":
                        Property(type: "integer"),

                    "careerScore":
                        Property(type: "integer"),

                    "moneyScore":
                        Property(type: "integer"),

                    "healthScore":
                        Property(type: "integer"),

                    "aiInsight":
                        Property(type: "string")
                ],

                required: [
                    "overview",
                    "luckyNumber",
                    "luckyColor",
                    "loveScore",
                    "careerScore",
                    "moneyScore",
                    "healthScore",
                    "aiInsight"
                ]
            )
        )
    }
}

extension HomeReading {

    static let fallback =
    HomeReading(

        overview:
"""
Today encourages reflection and balance.
""",

        luckyNumber: "7",

        luckyColor: "Blue",

        loveScore: 85,

        careerScore: 82,

        moneyScore: 80,

        healthScore: 84,

        aiInsight:
"""
Focus on long-term goals today.
"""
    )
}

struct MoonPhase: Codable {

    let name: String

    let emoji: String

    let illumination: Int

    let age: Int

    let description: String

}

struct UserAstrologyContext {


    let zodiac: String

    let moon: String

    let rising: String

    let todayInsight: String

    let moonPhase: String



    var prompt: String {


"""
User astrology profile:

Sun sign:
\(zodiac)

Moon sign:
\(moon)

Rising sign:
\(rising)

Today's horoscope:
\(todayInsight)

Moon phase:
\(moonPhase)

Use this information
when answering.
"""
    }
}


@Model
final class UserProfile {

    var birthDate: Date?
    var birthTime: Date?
    var birthCity: String?

    var birthLocation: String

    var zodiac: ZodiacSign

    var latitude: Double
    var longitude: Double


    init(
        birthDate: Date = Date(),
        birthTime: Date? = nil,
        birthCity: String = "",
        birthLocation: String = "",
        zodiac: ZodiacSign = .gemini,
        
        latitude: Double = 0,
        longitude: Double = 0
    ) {

        self.birthDate = birthDate
        self.birthTime = birthTime
        self.birthLocation = birthLocation
        self.zodiac = zodiac
        self.birthCity = birthCity
        self.latitude = latitude
        self.longitude = longitude
    }
}


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


enum ZodiacSign: String, CaseIterable, Codable, Identifiable {

    case aries
    case taurus
    case gemini
    case cancer
    case leo
    case virgo
    case libra
    case scorpio
    case sagittarius
    case capricorn
    case aquarius
    case pisces

    var id: String { rawValue }

    var title: String {
        switch self {
        case .aries: return "Aries"
        case .taurus: return "Taurus"
        case .gemini: return "Gemini"
        case .cancer: return "Cancer"
        case .leo: return "Leo"
        case .virgo: return "Virgo"
        case .libra: return "Libra"
        case .scorpio: return "Scorpio"
        case .sagittarius: return "Sagittarius"
        case .capricorn: return "Capricorn"
        case .aquarius: return "Aquarius"
        case .pisces: return "Pisces"
        }
    }

    var symbol: String {
        switch self {
        case .aries: return "♈︎"
        case .taurus: return "♉︎"
        case .gemini: return "♊︎"
        case .cancer: return "♋︎"
        case .leo: return "♌︎"
        case .virgo: return "♍︎"
        case .libra: return "♎︎"
        case .scorpio: return "♏︎"
        case .sagittarius: return "♐︎"
        case .capricorn: return "♑︎"
        case .aquarius: return "♒︎"
        case .pisces: return "♓︎"
        }
    }

    var dateRange: String {
        switch self {
        case .aries: return "Mar 21 - Apr 19"
        case .taurus: return "Apr 20 - May 20"
        case .gemini: return "May 21 - Jun 20"
        case .cancer: return "Jun 21 - Jul 22"
        case .leo: return "Jul 23 - Aug 22"
        case .virgo: return "Aug 23 - Sep 22"
        case .libra: return "Sep 23 - Oct 22"
        case .scorpio: return "Oct 23 - Nov 21"
        case .sagittarius: return "Nov 22 - Dec 21"
        case .capricorn: return "Dec 22 - Jan 19"
        case .aquarius: return "Jan 20 - Feb 18"
        case .pisces: return "Feb 19 - Mar 20"
        }
    }

    var gradient: LinearGradient {

        switch self {

        case .aries:
            return LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.25, blue: 0.15),
                    Color(red: 0.95, green: 0.55, blue: 0.15)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .taurus:
            return LinearGradient(
                colors: [
                    Color(red: 0.15, green: 0.65, blue: 0.35),
                    Color(red: 0.05, green: 0.35, blue: 0.20)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .gemini:
            return LinearGradient(
                colors: [
                    Color(red: 0.65, green: 0.35, blue: 1.0),
                    Color(red: 0.25, green: 0.55, blue: 1.0)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .cancer:
            return LinearGradient(
                colors: [
                    Color(red: 0.2, green: 0.75, blue: 1.0),
                    Color(red: 0.15, green: 0.35, blue: 0.85)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .leo:
            return LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.65, blue: 0.15),
                    Color(red: 0.95, green: 0.25, blue: 0.15)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .virgo:
            return LinearGradient(
                colors: [
                    Color(red: 0.45, green: 0.9, blue: 0.65),
                    Color(red: 0.15, green: 0.55, blue: 0.45)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .libra:
            return LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.55, blue: 0.8),
                    Color(red: 0.65, green: 0.35, blue: 1.0)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .scorpio:
            return LinearGradient(
                colors: [
                    Color(red: 0.45, green: 0.05, blue: 0.25),
                    Color(red: 0.95, green: 0.1, blue: 0.35)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .sagittarius:
            return LinearGradient(
                colors: [
                    Color(red: 0.2, green: 0.45, blue: 1.0),
                    Color(red: 0.55, green: 0.2, blue: 1.0)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .capricorn:
            return LinearGradient(
                colors: [
                    Color(red: 0.35, green: 0.25, blue: 0.75),
                    Color(red: 0.95, green: 0.65, blue: 0.25)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .aquarius:
            return LinearGradient(
                colors: [
                    Color(red: 0.1, green: 0.85, blue: 1.0),
                    Color(red: 0.25, green: 0.3, blue: 1.0)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )


        case .pisces:
            return LinearGradient(
                colors: [
                    Color(red: 0.35, green: 0.2, blue: 1.0),
                    Color(red: 0.15, green: 0.8, blue: 0.95)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}


struct AIRequest: Encodable {

    let model:String

    let messages:[Message]

    let temperature:Double


    struct Message:Encodable {

        let role:String

        let content:String
    }
}


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


struct CalculatedBirthData: Codable {

    let date: Date
    let time: Date
    let city: String

    let latitude: Double?
    let longitude: Double

    let sunSign: String
}

final class AstrologyAPIService {

    static let shared = AstrologyAPIService()

    private init() {}

    func calculateChart(
        birth: BirthData
    ) async throws -> CalculatedBirthData {

        let sunSign = zodiacSign(
            from: birth.date
        )

        return CalculatedBirthData(
            date: birth.date,
            time: birth.time,
            city: birth.city,
            latitude: birth.latitude,
            longitude: birth.longitude,
            sunSign: sunSign
        )
    }

    // MARK: - Zodiac

    private func zodiacSign(
        from date: Date
    ) -> String {

        let calendar = Calendar.current

        let month = calendar.component(
            .month,
            from: date
        )

        let day = calendar.component(
            .day,
            from: date
        )

        switch (month, day) {

        case (3, 21...31), (4, 1...19):
            return "Aries"

        case (4, 20...30), (5, 1...20):
            return "Taurus"

        case (5, 21...31), (6, 1...20):
            return "Gemini"

        case (6, 21...30), (7, 1...22):
            return "Cancer"

        case (7, 23...31), (8, 1...22):
            return "Leo"

        case (8, 23...31), (9, 1...22):
            return "Virgo"

        case (9, 23...30), (10, 1...22):
            return "Libra"

        case (10, 23...31), (11, 1...21):
            return "Scorpio"

        case (11, 22...30), (12, 1...21):
            return "Sagittarius"

        case (12, 22...31), (1, 1...19):
            return "Capricorn"

        case (1, 20...31), (2, 1...18):
            return "Aquarius"

        case (2, 19...29), (3, 1...20):
            return "Pisces"

        default:
            return "Aries"
        }
    }
}

@MainActor
final class AstrologyContextService {


    static let shared =
    AstrologyContextService()


    private init(){}



    func build(
        user: UserProfile,
        context: ModelContext
    ) -> UserAstrologyContext {


        let moon =
        "Unknown"

        let rising =
        "Unknown"


        let phase =
        MoonCalculator.shared
            .calculate()



        return UserAstrologyContext(

            zodiac:
                user.zodiac.title,

            moon:
                moon,

            rising:
                rising,

            todayInsight:
                "Focus on your personal growth today.",

            moonPhase:
                phase.name
        )
    }
}


@MainActor
final class DailyReadingService {

    static let shared =
    DailyReadingService()

    private init() {}


    func reading(
        sign: ZodiacSign,
        context: ModelContext
    ) async throws -> DailyReading {


        let calendar =
        Calendar.current


        let today =
        calendar.startOfDay(
            for: Date()
        )


        let descriptor =
        FetchDescriptor<DailyReading>()


        let readings =
        try context.fetch(
            descriptor
        )


        print(
            "Cached readings:",
            readings.count
        )


        if let cached =
            readings.first(
                where: {

                    $0.zodiac ==
                    sign.rawValue &&

                    calendar.isDate(
                        $0.date,
                        inSameDayAs:
                        today
                    )

                }
            ) {


            print(
                "Using cached reading"
            )


            return cached
        }



        print(
            "Generating AI reading..."
        )


        let generated: HomeReading


        do {

            generated =
            try await AIService.shared
                .generateDashboard(
                    sign: sign
                )

        } catch {

            print(
                "AI failed:",
                error
            )


            generated =
            HomeReading.fallback
        }



        let reading =
        DailyReading(

            zodiac:
                sign.rawValue,

            date:
                today,

            overview:
                generated.overview,

            luckyNumber:
                generated.luckyNumber,

            luckyColor:
                generated.luckyColor,

            loveScore:
                generated.loveScore,

            careerScore:
                generated.careerScore,

            moneyScore:
                generated.moneyScore,

            healthScore:
                generated.healthScore,

            aiInsight:
                generated.aiInsight
        )



        context.insert(
            reading
        )


        do {

            try context.save()

            print(
                "Saved reading"
            )

        } catch {

            print(
                "Save failed:",
                error
            )
        }


        return reading
    }
}


final class HomeAIService {

    static let shared = HomeAIService()

    private init() {}

    func generateHomeReading(
        sign: ZodiacSign
    ) async throws -> HomeReading {

        let prompt = """

        Create a horoscope dashboard for \(sign.title).

        Return ONLY valid JSON.

        {
          "overview":"",
          "luckyNumber":"",
          "luckyColor":"",
          "loveScore":0,
          "careerScore":0,
          "moneyScore":0,
          "healthScore":0,
          "aiInsight":""
        }

        loveScore, careerScore,
        moneyScore, healthScore
        must be integers from 60-99.

        """

        let result = try await AIService.shared.ask(
            prompt: prompt
        )

        let data = Data(result.utf8)

        return try JSONDecoder()
            .decode(
                HomeReading.self,
                from: data
            )
    }
    
    
}


final class HoroscopeAI {


    static func generate(
        sign: ZodiacSign
    ) async throws -> String {


        try await AIService.shared.ask(

            prompt: """
Create today's horoscope.

Zodiac sign:
\(sign.title)

Include:
- general energy
- love
- career
- advice

Keep it under 200 words.
"""

        )

    }

}


final class MoonAIService {


    static let shared =
    MoonAIService()


    private init(){}



    func generate(
        moon: MoonPhase,
        sign: String
    ) async throws -> String {


        try await AIService.shared.ask(

            prompt: """
The moon phase today is:

\(moon.name)

Sign is:

\(sign)

Illumination:
\(moon.illumination)%

Give a short astrology style
guidance for:
- emotions
- relationships
- productivity

Keep it under 120 words.
"""
        )

    }

}


final class MoonCalculator {


    static let shared =
    MoonCalculator()


    private init(){}



    func calculate(
        date: Date = Date()
    ) -> MoonPhase {


        let knownNewMoon =
        Calendar.current.date(
            from:
            DateComponents(
                year:2024,
                month:1,
                day:11
            )
        )!



        let days =
        Int(
            date.timeIntervalSince(
                knownNewMoon
            )
            /
            86400
        )


        let age =
        days % 29



        switch age {


        case 0...1:

            return MoonPhase(

                name:"New Moon",

                emoji:"moonphase.full.moon.inverse",

                illumination:0,

                age:age,

                description:
                "A time for new beginnings."
            )



        case 2...7:

            return MoonPhase(

                name:"Waxing Crescent",

                emoji:"moonphase.waxing.crescent",

                illumination:25,

                age:age,

                description:
                "Growth and intention energy."
            )



        case 8...15:

            return MoonPhase(

                name:"Full Moon",

                emoji:"moonphase.new.moon.inverse",

                illumination:100,

                age:age,

                description:
                "Peak emotional energy."
            )



        default:

            return MoonPhase(

                name:"Waning Moon",

                emoji:"moonphase.waning.crescent",

                illumination:60,

                age:age,

                description:
                "Reflection and release."
            )
        }
    }

}


final class NatalChartCalculator {

    static let shared =
    NatalChartCalculator()

    private init() {}

    func calculate(
        user: UserProfile
    ) -> BirthChartReading {

        let signs =
        ZodiacSign.allCases
            .map(\.title)

        let moon =
        signs.randomElement() ?? "Virgo"

        let rising =
        signs.randomElement() ?? "Leo"

        return BirthChartReading(

            sun: user.zodiac.title,

            moon: moon,

            rising: rising,

            mercury: moon,

            venus: rising,

            mars: user.zodiac.title,

            reading: ""
        )
    }
}

extension BirthChartReading {

    static var schema: JSONSchema {

        JSONSchema(

            name: "birth_chart",

            strict: true,

            schema: Schema(

                type: "object",
                additionalProperties:false,
                properties: [

                    "sun":
                        Property(type:"string"),

                    "moon":
                        Property(type:"string"),

                    "rising":
                        Property(type:"string"),

                    "mercury":
                        Property(type:"string"),

                    "venus":
                        Property(type:"string"),

                    "mars":
                        Property(type:"string"),

                    "reading":
                        Property(type:"string")
                ],

                required: [

                    "sun",
                    "moon",
                    "rising",
                    "mercury",
                    "venus",
                    "mars",
                    "reading"
                ]
            )
        )
    }
}


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


struct OpenAIErrorResponse: Decodable {

    let error: ErrorDetail


    struct ErrorDetail: Decodable {

        let message: String

        let type: String?

    }
}

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

struct MainTabView: View {

    var body: some View {

        TabView {

            HomeView()
                .tabItem {
                    Label(
                        "Home",
                        systemImage: "sparkles"
                    )
                }

            HoroscopeView()
                .tabItem {
                    Label(
                        "Horoscope",
                        systemImage: "moon.stars"
                    )
                }

            CompatibilityView()
                .tabItem {
                    Label(
                        "Match",
                        systemImage: "heart.circle"
                    )
                }

            AIChatView()
                .tabItem {
                    Label(
                        "Astrologer",
                        systemImage: "wand.and.stars"
                    )
                }
            
            BirthChartView()
                .tabItem {

                    Label(
                        "Chart",
                        systemImage:
                        "gauge.chart.leftthird.topthird.rightthird"
                    )

                }


        }
        //.tint(AppColors.blue)
        .tint(.white)
    }
}

