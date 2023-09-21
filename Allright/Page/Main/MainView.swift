//
//  TabView.swift
//  Allright
//
//  Created by 최진용 on 2023/09/16.
//

import SwiftUI

struct MainView: View {
    @State private(set) var selection = 0
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor(Colors.gray300)
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                HomeView(selection: $selection)
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
            .tint(Colors.gray800)
        }
    }
}

struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
