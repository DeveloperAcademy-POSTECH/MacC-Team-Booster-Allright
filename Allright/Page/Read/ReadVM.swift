//
//  ReadVM.swift
//  Allright
//
//  Created by 최진용 on 2023/09/18.
//

import SwiftUI


class ReadVM: ObservableObject {
    @Published var isSoundOn = false
    @Published var numberOfWords: Int = 0
    @Published var currentIndex: Int = 0
    @GestureState var dragOffset = 0
    @Published var isPlay = false
    @Published var startCountDown = 3
    private var workItem: DispatchWorkItem?
    
    
    
    
    
    
    @Published var isPlaying = false
    @Published var timer: Timer?
    
    func startAnima() {
        isPlaying = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.isPlaying {
                withAnimation(.linear(duration: 0.4)) {
                    self.currentIndex += 1
                }
            }
        }
    }
    
    func stopAnima() {
        isPlaying = false
        timer!.invalidate()
    }
    
    
    
    
    
    
    
    
    func startCardAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.startCountDown -= 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.startCountDown -= 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.startCountDown -= 1
                    withAnimation(.linear(duration: 0.4)) {
                        self.currentIndex += 1
                    }
                }
            }
        }
    }
    
    func startLoopCardAnimation() {
        workItem = DispatchWorkItem {
            withAnimation(.linear(duration: 0.4)) {
                if self.isPlay {
                    self.currentIndex += 1
                }
            }
        }
        if currentIndex != numberOfWords - 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: workItem!)
        }
    }
}
