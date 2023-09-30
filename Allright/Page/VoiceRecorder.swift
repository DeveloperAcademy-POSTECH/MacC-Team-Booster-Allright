//
//  VoiceRecorder.swift
//  Allright
//
//  Created by 송재훈 on 2023/09/18.
//

import Foundation
import AVFoundation

class VoiceRecorder: NSObject, ObservableObject {
    var audioRecorder = AVAudioRecorder()
    
    @Published var isRecording: Bool = false
    @Published var voicerecordList: [Voicerecord] = []
    
    override init() {
        super.init()
        fetchVoicerecordFile()
    }
    
    static func requestMicrophonePermission() {
        AVAudioSession.sharedInstance().requestRecordPermission { (granted: Bool) -> Void in
            if granted { return }
            else {
                print("Permission Deny")
            }
        }
    }
    
    func fetchVoicerecordFile() {
        voicerecordList = []
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        
        let _ = directoryContents.map {
            if !$0.lastPathComponent.contains(".IMA4") { return }
            
            var type: TrainingSteps
            
            if $0.lastPathComponent.contains("Step1") {
                type = TrainingSteps.step1
            }
            else if $0.lastPathComponent.contains("Step2") {
                type = TrainingSteps.step2
            }
            else if $0.lastPathComponent.contains("Sentence") {
                type = TrainingSteps.sentence
            }
            else {
                return
            }
            
            var playtime: String = ""
            
            do {
                let duration: Double = try AVAudioPlayer(contentsOf: $0).duration
                
                let playtimeMin = Int(duration).quotientAndRemainder(dividingBy: 60).quotient
                let playtimeSec = Int(duration).quotientAndRemainder(dividingBy: 60).remainder
                
                playtime = "\(playtimeMin):\(playtimeSec)"
            } catch {
                print("Playtime parse failed")
            }
            
            voicerecordList.append(Voicerecord(fileURL: $0, createdAt: getFileDate(for: $0), type: type, playtime: playtime))
        }
        
        voicerecordList.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending })
    }
    
    
    func startRecording(typeIs type: String) {
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Cannot setup the Recording")
        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let dateFommater = DateFormatter()
        dateFommater.dateFormat = "yyyy.MM.dd_HHmmss"
        let dateString = dateFommater.string(from: Date())
        
        let fileName = path.appendingPathComponent("\(type)_\(dateString).IMA4")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatAppleIMA4),
            AVSampleRateKey: 32000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            isRecording = true
        } catch {
            print("Failed to Setup the Recording")
        }
    }
    
    func pauseRecording() {
        audioRecorder.pause()
        isRecording = false
    }
    
    func resumeRecording() {
        audioRecorder.record()
        isRecording = true
    }
    
    func stopRecording() {
        audioRecorder.stop()
        VoicePlayer.setSession()
        isRecording = false
        fetchVoicerecordFile()
    }
    
    func deleteRecording(_ url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Can't delete")
        }
        
        fetchVoicerecordFile()
    }
    
    func getFileDate(for file: URL) -> String {
        if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
           let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yy-MM-dd HH:mm:ss"
            
            return dateFormatter.string(from: creationDate)
        } else {
            return "00-00-00 00:00:00"
        }
    }
}
