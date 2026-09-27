//
//  QuestionView.swift
//  MyHoroscope2
//
//  Created by admin on 24.06.2026.
//


import SwiftUI

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
