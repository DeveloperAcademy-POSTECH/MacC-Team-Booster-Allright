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
    
    func startPlaying(step: TrainingSteps, index: Int, isSoundOn: Bool) {
        do {
            switch step {
            case .step1: player = try AVAudioPlayer(contentsOf: step1PlayList[index - 1])
            case .step2: player = try AVAudioPlayer(contentsOf: step2PlayList[index - 1])
            case .sentence: return
            }
            if isSoundOn {
                self.soundOn()
            }
            else {
                self.soundOff()
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
    
    func soundOn() {
        player.setVolume(1.0, fadeDuration: 0)
    }
    
    func soundOff() {
        player.setVolume(0.0, fadeDuration: 0)
    }
}
