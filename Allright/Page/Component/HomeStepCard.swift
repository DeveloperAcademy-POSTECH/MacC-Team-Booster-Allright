//
//  HomeStepCard.swift
//  Allright
//
//  Created by 최진용 on 2023/09/16.
//

import SwiftUI


 

struct HomeStepCard: View {
    let step: TrainingSteps
    @Binding var selection: Int
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: UIScreen.getWidth(342), height: UIScreen.getHeight(128))
            .foregroundColor(Colors.gray100)
            .overlay {
                HStack(alignment: .center) {
                    titles
                    Spacer()
                    practiceButton
                }
            }
    }
    //MARK: - UIcomponents
    var titles: some View {
            VStack(alignment: .leading, spacing: 5) {
                Text(step.title)
                    .font(.selectionTitle())
                    .foregroundColor(Colors.gray700)
                Text(step.description)
                    .font(.title2())
                    .foregroundColor(Colors.gray500)
        }.padding()
    }
    var practiceButton: some View {
        NavigationLink {
            switch step {
            case .step1: ReadView(step: step, selection: $selection)
            case .step2: ReadView(step: step, selection: $selection)
            case .sentence: ReadView(step: step, selection: $selection)
            }
        } label: {
            RoundedRectangle(cornerRadius: 1000)
                .frame(width: UIScreen.getWidth(109), height: UIScreen.getHeight(42))
                .foregroundColor(step.blockColor)
                .padding()
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
}


struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        @State var selection = 1
        HomeStepCard(step: .step1, selection: $selection)
    }
}
