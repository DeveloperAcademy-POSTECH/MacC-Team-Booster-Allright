//
//  TabView.swift
//  Allright
//
//  Created by 최진용 on 2023/09/16.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            TabView {
                HomeView()
                    .tabItem {
                        Text("home")
                    }
                RecordView()
                    .tabItem {
                        Text("record")
                    }
            }
        }
    }
}

struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
