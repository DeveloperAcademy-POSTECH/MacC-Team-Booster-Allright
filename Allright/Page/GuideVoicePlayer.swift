//
//  GuideVoicePlayer.swift
//  Allright
//
//  Created by 송재훈 on 2023/09/25.
//

import Foundation
import AVFoundation
import UIKit

class GuideVoicePlayer: NSObject, ObservableObject {
    var player = AVAudioPlayer()
    var step1PlayList: [URL] = []
    var step2PlayList: [URL] = []
    
    static let shared = GuideVoicePlayer()
    
    override init() {
        for idx in 1...196 {
            let path = Bundle.main.path(forResource: "Step1_\(idx).mp3", ofType: nil)!
            step1PlayList.append(URL(filePath: path))
        }
        for idx in 1...28 {
            let path = Bundle.main.path(forResource: "Step2_\(idx).mp3", ofType: nil)!
            step2PlayList.append(URL(filePath: path))
        }
    }
    
    func startPlaying(step: TrainingSteps, index: Int) {
        do {
            switch step {
            case .step1: player = try AVAudioPlayer(contentsOf: step1PlayList[index - 1])
            case .step2: player = try AVAudioPlayer(contentsOf: step2PlayList[index - 1])
            case .sentence: return
            }
            
            player.prepareToPlay()
            player.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func stopPlaying() {
        player.stop()
    }
}
