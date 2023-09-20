//
//  TabView.swift
//  Allright
//
//  Created by 최진용 on 2023/09/16.
//

import SwiftUI

struct MainView: View {
    @State private(set) var selection = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selection) {
                    HomeView(selection: $selection)
                        .tag(0)
                        .tabItem {
                            Text("home")
                        }
                    RecordView()
                        .tag(1)
                        .tabItem {
                            Text("record")
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
