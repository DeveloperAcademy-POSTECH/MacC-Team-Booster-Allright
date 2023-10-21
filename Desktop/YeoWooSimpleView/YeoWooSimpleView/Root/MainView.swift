//
//  MainView.swift
//  YeoWooSimpleView
//
//  Created by 정회승 on 2023/07/14.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            Text("invitation")
                .tabItem{
                    Image(systemName: "person.3")
                }
            NotificationView()
                .tabItem{
                    Image(systemName: "bell")
                }
            SettingView()
                .tabItem{
                    Image(systemName: "gear")
                }
        }
        .accentColor(.mainColor)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
