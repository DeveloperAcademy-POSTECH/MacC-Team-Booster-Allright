//
//  ReadVM.swift
//  Allright
//
//  Created by 최진용 on 2023/09/18.
//

import SwiftUI


class ReadVM: ObservableObject {

    var step: TrainingSteps?
    @Published var isSoundOn = false
    @Published var numberOfWords: Int = 0
    @Published var currentIndex: Int = 0
    @GestureState var dragOffset = 0
    @Published var startCountDown = 3
    @Published var isPlaying = false
    @Published var timer: Timer?
    @Published var isFinished = false
    @Published var isPaused = false
    
    let recoder = VoicerecordVM()
    
    // 현재 stop 됐을때, numberofwords != currentIdx면, 알람창을띄워줌, 현재 녹음중인데 중단하시겠어요?, 취소면 재계 아니면 화면 나감.
    // NOW가 currentIdx면 녹음이 완료 되었습니다. 상태창 띄워주기
    func toggleAnimation() {
        if self.isPlaying {
            stopAnimation()
        }
        else {
            startAnimation()
        }
    }
    
    func resetReadVM() {
        currentIndex = 0
        startCountDown = 3
        stopAnimation()
    }
    
    func startAnimation() {
        isPlaying = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.startCountDown > 0 {
                self.startCountDown -= 1
            }
            else if self.startCountDown == 0, self.isPlaying, (self.currentIndex != self.numberOfWords - 1) {
                guard let step = self.step else { return }
                if self.currentIndex == 1 {
                    self.recoder.startRecording(typeIs: step.type)
                }
                else {
                    self.isPaused = false
                    self.recoder.resumeRecording()
                }
                withAnimation(.linear(duration: 0.4)) {
                    self.currentIndex += 1
                }
            }
            else {
                self.stopAnimation()
            }
        }
    }
    
    func stopAnimation() {
        isPlaying = false
        timer!.invalidate()
        if self.currentIndex == numberOfWords - 1 {
            isFinished  = true
            recoder.stopRecording()
        }
        else if self.currentIndex >= 1, currentIndex != numberOfWords - 1 {
            isPaused = true
            recoder.pauseRecording()
        }
    }
}
