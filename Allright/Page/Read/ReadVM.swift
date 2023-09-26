//
//  ReadVM.swift
//  Allright
//
//  Created by 최진용 on 2023/09/18.
//

import SwiftUI


class ReadVM: ObservableObject {
    
    var step: TrainingSteps?
    var step2SoloLineAnimation: DispatchWorkItem?
    var step2FirstLineAnimation: DispatchWorkItem?
    var step2SecondLineAnimation: DispatchWorkItem?
    var step2ThirdLineAnimation: DispatchWorkItem?
    
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
    @Published var animationFirstLineWidthGague = 0.0
    @Published var animationSecondLineWidthGague = 0.0
    @Published var animationThirdLineWidthGague = 0.0
    
    let recoder = VoicerecordVM()
    
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
        animationWidthGague = 0
        animationFirstLineWidthGague = 0
        animationSecondLineWidthGague = 0
        animationThirdLineWidthGague = 0
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
                step2SoloLineAnimation?.cancel()
                step2FirstLineAnimation?.cancel()
                step2SecondLineAnimation?.cancel()
                step2ThirdLineAnimation?.cancel()
            }
            isPaused = true
            self.currentIndex -= 1
            recoder.pauseRecording()
        }
    }
    
    func startAnimation() {
        isPlaying = true
        self.animationWidthGague = 0
        
        if currentIndex == 0 {
            withAnimation(.linear(duration: 1.0)) {
                self.animationWidthGague = 1.0
            }
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { localTimer in
            self.animationWidthGague = 0
            
            if !self.isPlaying {
                localTimer.invalidate()
                self.stopAnimation()
            }
            else if self.startCountDown > 1, self.currentIndex == 0 {
                self.startCountDown -= 1
                withAnimation(.linear(duration: 1.0)) {
                    self.animationWidthGague = 1.0
                }
            }
            else {
                localTimer.invalidate()
                
                if self.currentIndex == 0 {
                    withAnimation(.linear(duration: 0.4)) {
                        self.currentIndex += 1
                    }
                }
                
                guard let step = self.step else { return }
                switch step {
                case .step1: self.step1Animation()
                case .step2: self.step2Animation()
                case .sentence: self.sentenceAnimation()
                }
            }
        }
    }
    
    func step1Animation() {
        self.animationWidthGague = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            if self.isPlaying {
                withAnimation(.linear(duration: 1.0)) {
                    self.animationWidthGague = 1.0
                }
            }
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.6, repeats: true) { localTimer in
            self.animationWidthGague = 0
            
            if !self.isPlaying {
                localTimer.invalidate()
                self.stopAnimation()
            }
            else if (self.currentIndex != self.numberOfWords - 1) {
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
                localTimer.invalidate()
                self.stopAnimation()
            }
        }
    }
    
    func step2Animation() {
        self.animationWidthGague = 0
        self.animationFirstLineWidthGague = 0
        self.animationSecondLineWidthGague = 0
        self.animationThirdLineWidthGague = 0.25
        
        step2SoloLineAnimation = DispatchWorkItem {
            if self.isPlaying {
                withAnimation(.linear(duration: 2.4)) {
                    self.animationWidthGague = 1.0
                }
            }
        }
        step2FirstLineAnimation = DispatchWorkItem {
            if self.isPlaying {
                withAnimation(.linear(duration: 2.4)) {
                    self.animationFirstLineWidthGague = 1.0
                }
            }
        }
        step2SecondLineAnimation = DispatchWorkItem {
            if self.isPlaying {
                withAnimation(.linear(duration: 2.4)) {
                    self.animationSecondLineWidthGague = 1.0
                }
            }
        }
        step2ThirdLineAnimation = DispatchWorkItem {
            if self.isPlaying {
                withAnimation(.linear(duration: 1.2)) {
                    self.animationThirdLineWidthGague = 0.75
                }
            }
        }
        
        var animationTimeInterval = 7.0
        
        if self.currentIndex.quotientAndRemainder(dividingBy: 2).remainder == 0 {
            animationTimeInterval = 3.0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: self.step2SoloLineAnimation!)
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: self.step2FirstLineAnimation!)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8, execute: self.step2SecondLineAnimation!)
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.2, execute: self.step2ThirdLineAnimation!)
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: animationTimeInterval, repeats: true) { localTimer in
            self.animationWidthGague = 0
            self.animationFirstLineWidthGague = 0
            self.animationSecondLineWidthGague = 0
            self.animationThirdLineWidthGague = 0.25
            
            if !self.isPlaying {
                localTimer.invalidate()
            }
            else if (self.currentIndex != self.numberOfWords - 1) {
                guard let step = self.step else { return }
                
                if self.currentIndex == 1 {
                    self.recoder.startRecording(typeIs: step.type)
                }
                else {
                    self.isPaused = false
                    self.recoder.resumeRecording()
                }
                
                localTimer.invalidate()
                
                withAnimation(.linear(duration: 0.4)) {
                    self.currentIndex += 1
                }
                
                self.step2Animation()
            }
            else {
                localTimer.invalidate()
                self.stopAnimation()
            }
        }
    }
    
    func sentenceAnimation() {
        guard let step = self.step else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: CGFloat(step.wordCard[self.currentIndex].count) + 0.6, repeats: true) { localTimer in
            if !self.isPlaying {
                localTimer.invalidate()
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
