//
//  AllrightApp.swift
//  Allright
//
//  Created by 조기연 on 2023/09/15.
//

import SwiftUI
import AVFAudio

@main
struct AllrightApp: App {
    func requestMicrophonePermission(){
         AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
             if granted {
                 print("Mic: 권한 허용")
             } else {
                 print("Mic: 권한 거부")
             }
         })
     }
    
    var body: some Scene {
        WindowGroup {
//            HomeView()
            RecordView()
                .onAppear {
                    requestMicrophonePermission()
                }
        }
    }
}
