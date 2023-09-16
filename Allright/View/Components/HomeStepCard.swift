//
//  HomeStepCard.swift
//  Allright
//
//  Created by 최진용 on 2023/09/16.
//

import SwiftUI

enum TrainingSteps {
    case syllable, sentance
    
    var title: String {
        switch self {
        case .syllable: return "음절읽기"
        case .sentance: return "문장읽기"
        }
    }
    
    var description: String {
        switch self {
        case .syllable: return "기초를 탄탄히"
        case .sentance: return "하루 한 문장 도전"
        }
    }
    var destination: any View {
        switch self {
        case .syllable: return Text("some")
        case .sentance: return Text("hi")
        }
    }
}



struct HomeStepCard: View {
    let step: TrainingSteps
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: UIScreen.getWidth(342), height: UIScreen.getHeight(180))
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
            VStack(alignment: .leading, spacing: 10) {
                Text(step.title)
                    .font(Font.largeTitle())
                    .foregroundColor(Colors.gray700)
                Text(step.description)
                    .font(Font.title2())
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
                    case .syllable: Text("hi")
                    case .sentance: Text("sent")
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 1000)
                        .frame(width: UIScreen.getWidth(128), height: UIScreen.getHeight(52))
                        .foregroundColor(Colors.green400)
                        .shadow(radius: 1)
                        .overlay {
                            HStack {
                                Text("연습하기")
                                    .foregroundColor(Colors.white)
                                    .font(Font.title1())
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
        HomeStepCard(step: .syllable)
    }
}
