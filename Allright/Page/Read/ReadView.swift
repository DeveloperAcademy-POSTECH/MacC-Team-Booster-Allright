//
//  ReadView.swift
//  Allright
//
//  Created by 최진용 on 2023/09/16.
//

import SwiftUI

struct ReadView: View {
    let step: TrainingSteps
    @StateObject var readVM = ReadVM()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Colors.green400.ignoresSafeArea()
            VStack {
                Spacer().frame(height: UIScreen.getHeight(60))
                Text(step.description)
                    .font(.title1())
                    .foregroundColor(Colors.green800)
                Spacer()
            }
            VStack(spacing: 14) {
                wordCard
                progressbar
                Spacer().frame(height: UITabBarController().height)
            }
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: UIScreen.getWidth(106), height: UIScreen.getWidth(106))
                    .foregroundColor(Colors.orange)
                    .overlay {
                        Image(systemName: "play.fill")
                            .font(.playImage())
                            .foregroundColor(Colors.white)
                    }
                Spacer().frame(height: UITabBarController().height)
            }
        }
        .navigationTitle(step.title)
        .navigationBarBackButtonHidden(true)
        .navigationBarColor(backgroundColor: .clear, titleColor: UIColor.white)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                soundButton
            }
        }
    }
    
    
    //MARK: - UIComponents
    
    var progressbar: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 100)
                .frame(width: UIScreen.getWidth(280), height: UIScreen.getHeight(4))
                .foregroundColor(Colors.green600)
            RoundedRectangle(cornerRadius: 100)
                .frame(width: UIScreen.getWidth(280) / CGFloat(step.wordCard.count) * CGFloat(readVM.currentCard), height: UIScreen.getHeight(4))
                .foregroundColor(Colors.green100)
        }
    }
    
    var soundButton: some View {
        Button {
            readVM.isSoundOn.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 100)
                .frame(width: UIScreen.getWidth(97), height: UIScreen.getHeight(38))
                .foregroundColor(Colors.green500)
                .overlay {
                    HStack {
                        if readVM.isSoundOn {
                            Text("소리켜기")
                            Image(systemName: "speaker.wave.3.fill")
                        }
                        else {
                            Text("소리끄기")
                            Image(systemName: "speaker.slash.fill")
                        }
                    }
                    .font(.caption1())
                    .foregroundColor(Colors.white)
                }
        }
    }
    
    var wordCard: some View {
        ScrollViewReader { idx in
            ScrollView(.horizontal) {
                HStack(spacing: UIScreen.getWidth(16)) {
                    ForEach(step.wordCard, id: \.self) { word in
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: UIScreen.getWidth(290), height: UIScreen.getHeight(301))
                            .foregroundColor(Colors.white)
                            .overlay {
                                Text(word)
                                    .font(.cardBig())
                                    .multilineTextAlignment(.center)
                            }
                    }
                }
                .onAppear {
                    UIScrollView.appearance().isPagingEnabled = true
                }
//                .onChange(of: idx) {
//                    readVM.currentCard = idx
//                }
            }
        }.scrollIndicators(.hidden)
    }
    
    var backButton: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.backward")
                .foregroundColor(Colors.white)
        }
    }
}


struct RowView_Preview: PreviewProvider {
    static var previews: some View {
        ReadView(step: .step1)
    }
}
