//
//  ContentView.swift
//  Allright
//
//  Created by 조기연 on 2023/09/15.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeVM()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: UIScreen.getHeight(16)) {
                topBanner
                Spacer().frame(height: UIScreen.getHeight(60))
                HomeStepCard(step: .syllable)
                HomeStepCard(step: .sentance)
                Spacer()
            }
        }
    }
//MARK: - UI
    var topBanner: some View {
        Rectangle()
            .ignoresSafeArea()
            .foregroundColor(Colors.gray700)
            .frame(height: UIScreen.getHeight(155))
            .overlay {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Spacer()
                        Text(homeVM.today)
                            .font(Font.body())
                        Text("발음 연습")
                            .font(Font.largeTitle())
                    }.padding(.bottom, 20)
                    Spacer()
                }.padding()
            }.foregroundColor(Colors.white)
    }
    
    
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
