

import SwiftUI
import SwiftData

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
