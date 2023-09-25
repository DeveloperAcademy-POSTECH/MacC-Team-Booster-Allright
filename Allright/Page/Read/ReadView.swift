//
//  ReadView.swift
//  Allright
//
//  Created by 최진용 on 2023/09/16.
//

import Lottie
import SwiftUI

struct ReadView: View {
    let step: TrainingSteps
    @Binding var selection: Int
    @StateObject private var readVM = ReadVM()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    @StateObject var voicerecordVM = VoicerecordVM()
    
    var body: some View {
        ZStack {
            background.ignoresSafeArea()
            VStack {
                Spacer().frame(height: UIScreen.getHeight(60))
                Text(step.description)
                    .font(.title1())
                    .foregroundColor(Colors.white)
                Spacer()
            }
            VStack(spacing: 14) {
                wordCard
                progressbar
                Spacer().frame(height: UITabBarController().height)
            }
            VStack {
                Spacer()
                LottieView(isPlay: $readVM.isPlaying)
                    .frame(width: UIScreen.getWidth(200), height: UIScreen.getHeight(200))
            }
            VStack {
                Spacer()
                playButton
                Spacer().frame(height: UITabBarController().height)
            }
        }
        .alert("연습이 완료되었어요!", isPresented: $readVM.isFinished, actions: {
            Button("녹음듣기", role: .none) {
                readVM.resetReadVM()
                selection = 1
                self.presentationMode.wrappedValue.dismiss()
            }
            Button("완료", role: .cancel) {
                readVM.resetReadVM()
            }
        }, message: {
            Text("녹음기록을 바로 들어볼까요?")
        })
        .alert("연습을 중단할까요?", isPresented: $readVM.isPaused, actions: {
            Button("취소", role: .none) {
                readVM.isPlaying = true
                //                readVM.startAnimation()
                readVM.startCountdownAnimation()
            }
            Button("중단하기", role: .cancel) {
                readVM.resetReadVM()
            }
        }, message: {
            Text("현재까지의 녹음 기록은 저장돼요")
        })
        .onAppear {
            readVM.numberOfWords = step.wordCard.count
            readVM.step = step
        }
        .onDisappear {
            guard let timer = readVM.timer else { return }
            timer.invalidate()
            readVM.recoder.stopRecording()
        }
        .navigationTitle(step.title)
        .navigationBarBackButtonHidden(true)
        .navigationBarColor(backgroundColor: .clear, titleColor: UIColor.white)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                soundButton
            }
        }
    }
    
    
    //MARK: - UIComponents
    var timerNumberView: some View {
        switch step {
        case .step1:
            return Text("\(readVM.startCountDown)")
                .font(.cardBig())
        case .step2:
            return Text("\(readVM.startCountDown)")
                .font(.cardBig())
        case .sentence:
            return Text("\(readVM.startCountDown)")
                .font(.cardBig())
        }
    }
    
    var background: some View {
        switch step {
        case .step1:
            return Colors.green400
        case .step2:
            return Colors.green600
        case .sentence:
            return Colors.green700
        }
    }
    
    
    var playButton: some View {
        Button {
            readVM.toggleAnimation()
        } label: {
            RoundedRectangle(cornerRadius: 100)
                .frame(width: UIScreen.getWidth(106), height: UIScreen.getWidth(106))
                .foregroundColor(readVM.isPlaying ? Colors.white : Colors.orange)
                .overlay {
                    if !readVM.isPlaying {
                        Image(systemName: "play.fill")
                            .font(.playImage())
                            .foregroundColor(Colors.white)
                    }
                    else {
                        Image(systemName: "mic.fill")
                            .font(.playImage())
                            .foregroundColor(Colors.orange)
                    }
                }
        }
    }
    
    var progressbar: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 100)
                .frame(width: UIScreen.getWidth(280), height: UIScreen.getHeight(4))
                .foregroundColor(Colors.green800)
            RoundedRectangle(cornerRadius: 100)
                .frame(width: UIScreen.getWidth(280) / CGFloat(step.wordCard.count - 1) * CGFloat(readVM.currentIndex), height: UIScreen.getHeight(4))
                .foregroundColor(Colors.green100)
        }
    }
    
    var soundButton: some View {
        Button {
            readVM.isSoundOn.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 100)
                .frame(width: UIScreen.getWidth(97), height: UIScreen.getHeight(38))
                .foregroundColor(Colors.green500)
                .overlay {
                    HStack {
                        if readVM.isSoundOn {
                            Text("소리켜기")
                                .font(.caption1())
                            Image(systemName: "speaker.wave.3.fill")
                        }
                        else {
                            Text("소리끄기")
                                .font(.caption1())
                            Image(systemName: "speaker.slash.fill")
                        }
                    }
                    .font(.caption1())
                    .foregroundColor(Colors.white)
                }
        }
    }
    
    var wordCard: some View {
        ZStack {
            ForEach(0..<step.wordCard.count, id: \.self) { idx in
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: UIScreen.getWidth(290), height: UIScreen.getHeight(301))
                    .foregroundColor(Colors.white)
                    .overlay {
                        if idx == 0 {
                            timerNumberView
                                .foregroundColor(Colors.black)
                            if readVM.currentIndex == idx {
                                timerNumberView
                                    .foregroundColor(Colors.orange)
                                    .mask {
                                        GeometryReader { proxy in
                                            Colors.orange
                                                .frame(width: proxy.frame(in: .local).width * readVM.animationWidthGague)
                                        }
                                    }
                            }
                        }
                        else {
                            switch step {
                            case .step1:
                                Text(step.wordCard[idx])
                                    .font(.cardBig())
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Colors.black)
                                if readVM.currentIndex == idx {
                                    Text(step.wordCard[idx])
                                        .font(.cardBig())
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Colors.orange)
                                        .mask {
                                            
                                            GeometryReader { proxy in
                                                Colors.orange
                                                    .frame(width: proxy.frame(in: .local).width * readVM.animationWidthGague)
                                            }
                                        }
                                }
                            case .step2:
                                Text(step.wordCard[idx])
                                    .font(.cardMedium())
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Colors.black)
                                    .padding()
                                if readVM.currentIndex == idx {
                                    Text(step.wordCard[idx])
                                        .font(.cardMedium())
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Colors.orange)
                                        .padding()
                                        .mask {
                                            
                                            GeometryReader { proxy in
                                                VStack(alignment: .leading) {
                                                    Colors.orange
                                                        .frame(width: proxy.frame(in: .local).width * readVM.animationWidthGague)
                                                    Colors.orange
                                                        .frame(width: proxy.frame(in: .local).width * readVM.animationSecondLineWidthGague)
                                                }
                                            }
                                        }
                                }
                            case .sentence:
                                Text(step.wordCard[idx])
                                    .font(.cardSmall())
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Colors.black)
                                    .padding()
                                if readVM.currentIndex == idx {
                                    Text(step.wordCard[idx])
                                        .font(.cardSmall())
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Colors.orange)
                                        .padding()
                                        .mask {
                                            GeometryReader { proxy in
                                                Colors.orange
                                                    .frame(width: proxy.frame(in: .local).width * readVM.animationWidthGague)
                                            }
                                        }
                                    
                                }
                            }
                        }
                    }
                    .opacity(readVM.currentIndex == idx ? 1.0 : 0.7)
                    .scaleEffect(readVM.currentIndex == idx ? 1 : 0.8)
                    .offset(x: CGFloat(idx - readVM.currentIndex) * UIScreen.getWidth(280) + CGFloat(readVM.dragOffset))
            }
        }
    }
    
    var backButton: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.backward")
                .foregroundColor(Colors.white)
        }
    }
}
