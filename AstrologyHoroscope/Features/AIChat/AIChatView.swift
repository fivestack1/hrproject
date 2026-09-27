import SwiftUI
import SwiftData



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
