//
//  HomeStepCard.swift
//  Allright
//
//  Created by 최진용 on 2023/09/16.
//

import SwiftUI


 

struct HomeStepCard: View {
    let step: TrainingSteps
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: UIScreen.getWidth(342), height: UIScreen.getHeight(128))
            .foregroundColor(Colors.gray100)
            .overlay {
                ZStack {
                    titles
                    practiceButton
                    
                }
            }
    }
//MARK: - UIcomponents
    var titles: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(step.title)
                    .font(.selectionTitle())
                    .foregroundColor(Colors.gray700)
                Text(step.description)
                    .font(.title2())
                    .foregroundColor(Colors.gray500)
                Spacer()
            }
            .padding(.top, 10)
            .padding(.leading, 5)
            Spacer()
        }.padding()
    }
    var practiceButton: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                NavigationLink {
                    switch step {
                    case .step1: ReadView(step: step)
                    case .step2: ReadView(step: step)
                    case .sentance: ReadView(step: step)
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 1000)
                        .frame(width: UIScreen.getWidth(109), height: UIScreen.getHeight(42))
                        .foregroundColor(Colors.green400)
                        .shadow(radius: 1)
                        .overlay {
                            HStack {
                                Text("연습하기")
                                    .foregroundColor(Colors.white)
                                    .font(Font.title2())
                                Image(systemName: "play.fill")
                                    .foregroundColor(Colors.white)
                            }
                        }
                }
                
            }
            .padding()
        }
    }
    

}


struct HomeStepCardView_Preview: PreviewProvider {
    static var previews: some View {
        HomeStepCard(step: .sentance)
    }
}
