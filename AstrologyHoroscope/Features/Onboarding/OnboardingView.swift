
import SwiftUI

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
