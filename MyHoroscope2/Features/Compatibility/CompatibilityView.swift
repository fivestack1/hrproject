import SwiftUI


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
