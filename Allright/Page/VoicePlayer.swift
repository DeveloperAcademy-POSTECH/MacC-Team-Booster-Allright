//
//  VoicePlayer.swift
//  Allright
//
//  Created by 송재훈 on 2023/09/20.
//

import Foundation
import AVFoundation
import UIKit

class VoicePlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    var audioPlayer = AVAudioPlayer()
    
    @Published var currentPlayingURL: URL?
    @Published var playingURL: URL?
    @Published var playerState: PlayerState = .stop
    @Published var playOffset: CGFloat = 0
    @Published var currentTime: TimeInterval = 0.0
    @Published var timer : Timer?
    
    override init() {
        super.init()
    }
    
    static func setSession() {
        let playSession = AVAudioSession.sharedInstance()
        
        do {
            try playSession.setCategory(.playAndRecord, mode: .default, options: [.allowBluetooth, .allowBluetoothA2DP])
            try playSession.overrideOutputAudioPort(.none)
            try playSession.setActive(true)
            
        } catch {
            print("Playing failed in Device")
        }
    }
    
    func startPlaying(record: Voicerecord, state: PlayerState? = nil) {
        if playerState == .play {
            if playingURL == URL(string: "") { return }
            if playingURL != record.fileURL {
                playStopSetting()
            }
        }
        playingURL = record.fileURL
        if currentPlayingURL != playingURL {
            playingURL = record.fileURL
            currentPlayingURL = playingURL
            playOffset = 0
            currentTime = 0
        }
        
        let playSession = AVAudioSession.sharedInstance()
        
        do {
            try playSession.setCategory(.playAndRecord, mode: .default, options: [.allowBluetooth, .allowBluetoothA2DP, .defaultToSpeaker])
        } catch {
            print("Playing failed in Device")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: playingURL!)
            
            if playerState == .pause {
                currentTime = (playOffset / UIScreen.getWidth(342)) * audioPlayer.duration
                audioPlayer.currentTime = currentTime
            }
            
            playerState = .play
            
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (value) in
                self.currentTime = self.audioPlayer.currentTime
                self.playOffset = (self.audioPlayer.currentTime / self.audioPlayer.duration) * UIScreen.getWidth(342)
            }
        } catch {
            print("Playing failed")
        }
    }
    
    func stopPlaying(_ state: PlayerState? = nil) {
        if playerState == .stop { return }
        
        if state == .pause {
            playerState = .pause
            
            self.currentTime = 0
            timer!.invalidate()
            audioPlayer.stop()
        }
        else {
            playerState = .stop
            
            playStopSetting()
            audioPlayer.stop()
        }
    }
}

extension VoicePlayer {
    func playStopSetting() {
        self.playOffset = 0.0
        self.currentTime = 0
        timer!.invalidate()
        playingURL = URL(string: "")
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playerState = .stop
        playStopSetting()
    }
}
