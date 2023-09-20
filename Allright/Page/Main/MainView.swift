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
                    .tag(0)
                    .tabItem {
                        VStack {
                            Image(systemName: "house")
                            Text("홈")
                        }
                    }
                RecordView()
                    .tag(1)
                    .tabItem {
                        VStack {
                            Image(systemName: "recordingtape")
                            Text("녹음기록")
                        }
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
