import SwiftUI


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
