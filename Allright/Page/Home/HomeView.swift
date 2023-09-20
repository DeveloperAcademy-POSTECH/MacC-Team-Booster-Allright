//
//  ContentView.swift
//  Allright
//
//  Created by 조기연 on 2023/09/15.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeVM = HomeVM()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: UIScreen.getHeight(16)) {
                topBanner
                Spacer()
                HomeStepCard(step: .step1)
                HomeStepCard(step: .step2)
                HomeStepCard(step: .sentance)
                Spacer()
                Spacer().frame(height: UITabBarController().height)
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
                    }.padding(.bottom, UIScreen.getHeight(20))
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
