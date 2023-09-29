//
//  ContentView.swift
//  Allright
//
//  Created by 조기연 on 2023/09/15.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeVM = HomeVM()
    @Binding var selection: Int
    
    var body: some View {
        ZStack {
            Colors.white
            VStack(spacing: UIScreen.getHeight(16)) {
                topBanner
                Spacer()
                ForEach(TrainingSteps.allCases, id: \.self) {
                    HomeStepCard(step: $0, selection: $selection)
                }
                Spacer()
                Spacer().frame(height: UITabBarController().height)
            }
        }
        .overlay(alignment: .bottom) {
            Divider()
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
