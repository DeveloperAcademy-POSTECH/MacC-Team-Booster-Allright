//
//  AllrightApp.swift
//  Allright
//
//  Created by 조기연 on 2023/09/15.
//

import SwiftUI

@main
struct AllrightApp: App {
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear {
                    VoicerecordVM.requestMicrophonePermission()
                }
        }
    }
}
