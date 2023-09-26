//
//  ReadVM.swift
//  Allright
//
//  Created by 최진용 on 2023/09/18.
//

import SwiftUI


class ReadVM: ObservableObject {
    
    var step: TrainingSteps?
    var upperAnimation: DispatchWorkItem?
    var lowerAnimation: DispatchWorkItem?
    
    @Published var isSoundOn = false
    @Published var numberOfWords: Int = 0
    @Published var currentIndex: Int = 0
    @GestureState var dragOffset = 0
    @Published var startCountDown = 3
    @Published var isPlaying = false
    @Published var timer: Timer?
    @Published var isFinished = false
    @Published var isPaused = false
    @Published var animationWidthGague = 0.0
    @Published var animationSecondLineWidthGague = 0.0
    
    let recoder = VoicerecordVM()
    
    func toggleAnimation() {
        if self.isPlaying {
            stopAnimation()
        }
        else {
            startCountdownAnimation()
        }
    }
    
    func resetReadVM() {
        currentIndex = 0
        startCountDown = 3
        animationWidthGague = 0
        animationSecondLineWidthGague = 0
        stopAnimation()
    }
    
    func stopAnimation() {
        isPlaying = false
        timer!.invalidate()
        if self.currentIndex == numberOfWords - 1 {
            isFinished = true
            recoder.stopRecording()
        }
        else if self.currentIndex >= 1, currentIndex != numberOfWords - 1 {
            if self.step == .step2 {
                upperAnimation?.cancel()
                lowerAnimation?.cancel()
            }
            isPaused = true
            self.currentIndex -= 1
            recoder.pauseRecording()
        }
    }
    
    func startCountdownAnimation() {
        isPlaying = true
        
        withAnimation(.linear(duration: 1.0)) {
            self.animationWidthGague = 1.0
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.animationWidthGague = 0
            self.animationSecondLineWidthGague = 0
            
            if !self.isPlaying {
                timer.invalidate()
            }
            else if self.startCountDown > 1, self.currentIndex == 0 {
                self.startCountDown -= 1
                
                withAnimation(.linear(duration: 1.0)) {
                    self.animationWidthGague = 1.0
                }
            }
            else {
                timer.invalidate()
                
                switch self.step {
                case .step1: self.startStep1Animation()
                case .step2: self.startStep2Animation()
                case .sentence: self.startSentenceAnimation()
                case .none: self.startStep1Animation()
                }
            }
        }
    }
    
    func startStep1Animation() {
        withAnimation(.linear(duration: 0.4)) {
            self.currentIndex += 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            if self.isPlaying {
                withAnimation(.linear(duration: 1.0)) {
                    self.animationWidthGague = 1.0
                }
            }
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
            self.animationWidthGague = 0
            
            if !self.isPlaying {
                timer.invalidate()
                self.stopAnimation()
            }
            else if self.startCountDown == 1, self.isPlaying, (self.currentIndex != self.numberOfWords - 1) {
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.linear(duration: 1.0)) {
                        self.animationWidthGague = 1.0
                    }
                }
            }
            else {
                self.stopAnimation()
            }
        }
    }
    
    func startStep2Animation() {
        withAnimation(.linear(duration: 0.4)) {
            self.currentIndex += 1
        }
        upperAnimation = DispatchWorkItem {
            if self.isPlaying {
                withAnimation(.linear(duration: 5)) {
                    self.animationWidthGague = 1.0
                }
            }
        }
        lowerAnimation = DispatchWorkItem {
            if self.isPlaying {
                withAnimation(.linear(duration: 5)) {
                    self.animationSecondLineWidthGague = 1.0
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: self.upperAnimation!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.4, execute: self.lowerAnimation!)
        
        timer = Timer.scheduledTimer(withTimeInterval: 10.5, repeats: true) { timer in
            self.animationWidthGague = 0
            self.animationSecondLineWidthGague = 0
            
            if !self.isPlaying {
                timer.invalidate()
            }
            else if self.startCountDown == 1, self.isPlaying, (self.currentIndex != self.numberOfWords - 1) {
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: self.upperAnimation!)
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.4, execute: self.lowerAnimation!)
            }
            else {
                self.stopAnimation()
            }
        }
    }
    
    func startSentenceAnimation() {
        withAnimation(.linear(duration: 0.4)) {
            self.currentIndex += 1
        }
        guard let step = self.step else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: CGFloat(step.wordCard[self.currentIndex].count) + 0.5, repeats: true) { timer in
            if !self.isPlaying {
                timer.invalidate()
            }
            else if self.startCountDown == 1, self.isPlaying, (self.currentIndex != self.numberOfWords - 1) {
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
}
