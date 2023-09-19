//
//  WordCard.swift
//  Allright
//
//  Created by 최진용 on 2023/09/19.
//

import SwiftUI

struct WordCard: View {
    let step: TrainingSteps
    var body: some View {
        ZStack {
            Color.black
            ScrollView(.horizontal) {
                HStack {
                    ForEach(step.wordCard, id: \.self) { word in
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: UIScreen.getWidth(290), height: UIScreen.getHeight(301))
                            .foregroundColor(Colors.white)
                            .overlay {
                                Text(word)
                                    .multilineTextAlignment(.center)
                            }
                    }
                }
            }.scrollIndicators(.hidden)
        }
    }
}



struct cardView_Preview: PreviewProvider {
    static var previews: some View {
        WordCard(step: .sentance)
    }
}

