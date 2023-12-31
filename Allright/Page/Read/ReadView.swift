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
    //화면전환용 탭
    @Binding var selection: Int
    @StateObject private var readVM = ReadVM()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            background.ignoresSafeArea()
            VStack {
                Spacer().frame(height: UIScreen.getHeight(60))
                Text(step.description)
                    .font(.title1())
                    .foregroundColor(Colors.white)
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                Spacer()
            }
            VStack(spacing: 14) {
                ZStack {
                    wordCard
                    wordCardMask
                }
                if step != .sentence {
                    progressbar
                }
                if step == .sentence {
                    //빈 화면입니다. 높이 맞추기 위해서 추가했습니다.
                    HStack {
                        Spacer()
                        Text("스와이프해서 원래 문장보기 >>")
                            .font(.body())
                            .foregroundColor(Colors.green100)
                            .opacity(readVM.currentIndex == 1 ? 0 : 1)
                    }.padding(.trailing)
                }
                Spacer().frame(height: UITabBarController().height)
            }
            VStack {
                Spacer()
                ZStack {
                    LottieView(isPlay: $readVM.isPlaying)
                    playButton
                }
                .frame(width: UIScreen.getWidth(200), height: UIScreen.getHeight(200))
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
                readVM.startAnimation()
              }
              Button("중단하기", role: .cancel) {
                  if readVM.isGoBack {
                  self.presentationMode.wrappedValue.dismiss()
                }
                readVM.resetReadVM()
              }
            }, message: {
              Text("현재까지의 녹음 기록은 저장돼요")
            })
        .onAppear {
            VoiceRecorder.requestMicrophonePermission()
            readVM.numberOfWords = step.wordCard.count
            readVM.step = step
            readVM.voicePlayer.soundOff()
            readVM.randomCard = readVM.makeRandomCard()
        }
        .onDisappear {
            if step == .sentence {
                readVM.voicePlayer.stopPlaying()
                readVM.recoder.stopRecording()
            }
            guard let timer = readVM.timer else { return }
            timer.invalidate()
            readVM.voicePlayer.stopPlaying()
            readVM.recoder.stopRecording()
        }
        .navigationTitle(step.title).font(.title2())
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
            return Text("")
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
            readVM.toggleSound()
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
        .opacity(step == .sentence ? 0 : 1)
    }
    
    var wordCard: some View {
        ZStack {
            if step != .sentence {
                ForEach(0..<step.wordCard.count, id: \.self) { idx in
                    RoundedRectangle(cornerRadius: 20)
                        .gesture(
                            DragGesture()
                                .onEnded({ value in
                                    let threshold: CGFloat = 20
                                    if step.type == "Sentence", value.translation.width > threshold {
                                        withAnimation {
                                            readVM.currentIndex = max(0, readVM.currentIndex - 1)
                                        }
                                    } else if step.type == "Sentence", value.translation.width < -threshold {
                                        withAnimation {
                                            readVM.currentIndex = min(step.wordCard.count - 1, readVM.currentIndex + 1)
                                        }
                                    }
                                })
                        )
                        .frame(width: UIScreen.getWidth(290), height: UIScreen.getHeight(301))
                        .foregroundColor(Colors.white)
                        .overlay {
                            if idx == 0, step != TrainingSteps.sentence {
                                timerNumberView
                                    .foregroundColor(Colors.black)
                            }
                            else {
                                switch step {
                                case .step1:
                                    Text(step.wordCard[idx])
                                        .font(.cardBig())
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Colors.black)
                                case .step2:
                                    Text(step.wordCard[idx])
                                        .font(.cardMedium())
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Colors.black)
                                        .padding()
                                case .sentence:
                                    Text(step.wordCard[idx])
                                }
                            }
                        }
                        .opacity(readVM.currentIndex == idx ? 1.0 : 0.7)
                        .scaleEffect(readVM.currentIndex == idx ? 1 : 0.8)
                        .offset(x: CGFloat(idx - readVM.currentIndex) * UIScreen.getWidth(280) + CGFloat(readVM.dragOffset))
                }
            }
            else {
                ForEach(0..<readVM.randomCard.count, id: \.self) { idx in
                    RoundedRectangle(cornerRadius: 20)
                        .gesture(
                            DragGesture()
                                .onEnded({ value in
                                    let threshold: CGFloat = 20
                                    if step.type == "Sentence", value.translation.width > threshold {
                                        withAnimation {
                                            if readVM.currentIndex != 0 {
                                                readVM.currentIndex = 0
                                            }
                                        }
                                    } else if step.type == "Sentence", value.translation.width < -threshold {
                                        withAnimation {
                                            if readVM.currentIndex == 0 {
                                                readVM.currentIndex = 1
                                            }
                                        }
                                    }
                                })
                        )
                        .frame(width: UIScreen.getWidth(290), height: UIScreen.getHeight(301))
                        .foregroundColor(Colors.white)
                        .overlay {
                            Text("\(readVM.randomCard[idx])")
                                .font(.cardSmall())
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                                .foregroundColor(Colors.black)
                                .padding()
                                .gesture(
                                    DragGesture()
                                        .onEnded({ value in
                                            let threshold: CGFloat = 20
                                            if step.type == "Sentence", value.translation.width > threshold {
                                                withAnimation {
                                                    if readVM.currentIndex != 0 {
                                                        readVM.currentIndex = 0
                                                    }
                                                }
                                            }
                                            else if step.type == "Sentence", value.translation.width < -threshold {
                                                withAnimation {
                                                    if readVM.currentIndex == 0 {
                                                        readVM.currentIndex = 1
                                                    }
                                                }
                                            }
                                        })
                                )
                        }
                        .opacity(readVM.currentIndex == idx ? 1.0 : 0.7)
                        .scaleEffect(readVM.currentIndex == idx ? 1 : 0.8)
                        .offset(x: CGFloat(idx - readVM.currentIndex) * UIScreen.getWidth(280) + CGFloat(readVM.dragOffset))
                }
            }
        }
    }
    
    var wordCardMask: some View {
        ZStack {
            ForEach(0..<step.wordCard.count, id: \.self) { idx in
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: UIScreen.getWidth(290), height: UIScreen.getHeight(301))
                    .foregroundColor(.clear)
                    .overlay {
                        if readVM.currentIndex == idx, step != TrainingSteps.sentence {
                            if idx == 0  {
                                timerNumberView
                                    .mask {
                                        GeometryReader { proxy in
                                            Colors.orange
                                                .frame(width: CGFloat(proxy.frame(in: .local).width) * CGFloat(readVM.animationWidthGague))
                                        }
                                    }
                            }
                            else {
                                switch step {
                                case .step1:
                                    Text(step.wordCard[idx])
                                        .font(.cardBig())
                                        .multilineTextAlignment(.center)
                                        .mask {
                                            GeometryReader { proxy in
                                                Colors.orange
                                                    .frame(width: CGFloat(proxy.frame(in: .local).width) * CGFloat(readVM.animationWidthGague))
                                            }
                                        }
                                case .step2:
                                    Text(step.wordCard[idx])
                                        .font(.cardMedium())
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .mask {
                                            GeometryReader { proxy in
                                                VStack(alignment: .leading, spacing: 0) {
                                                    if readVM.currentIndex.quotientAndRemainder(dividingBy: 2).remainder == 0 {
                                                        Colors.orange
                                                            .frame(width: CGFloat(proxy.frame(in: .local).width) * CGFloat(readVM.animationWidthGague))
                                                    }
                                                    else {
                                                        Colors.orange
                                                            .frame(width: CGFloat(proxy.frame(in: .local).width) * CGFloat(readVM.animationFirstLineWidthGague))
                                                        Colors.orange
                                                            .frame(width: CGFloat(proxy.frame(in: .local).width) * CGFloat(readVM.animationSecondLineWidthGague))
                                                        Colors.orange
                                                            .frame(width: CGFloat(proxy.frame(in: .local).width) * CGFloat(readVM.animationThirdLineWidthGague))
                                                    }
                                                }
                                            }
                                        }
                                case .sentence:
                                    Text("")
                                }
                            }
                        }
                    }
                    .foregroundColor(Colors.orange)
                    .offset(x: CGFloat(idx - readVM.currentIndex) * UIScreen.getWidth(280) + CGFloat(readVM.dragOffset))
            }
        }
    }
    
    var backButton: some View {
        Button {
          if readVM.isPlaying {
            readVM.isPaused = true
            readVM.stopAnimation()
              readVM.isGoBack.toggle()
          }
          else {
            self.presentationMode.wrappedValue.dismiss()
          }
        } label: {
          Image(systemName: "chevron.backward")
            .foregroundColor(Colors.white)
        }
      }
}
