//
//  RecordListCard.swift
//  Allright
//
//  Created by 송재훈 on 2023/09/18.
//

import SwiftUI

struct RecordListCard: View {
    let record: Voicerecord
    @State var isEditMode: Bool
    @EnvironmentObject var playerVM: VoicePlayerVM
    
    var body: some View {
        ZStack {
            recordRectangle(Colors.white)
                .overlay {
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            recordListBlock
                            recordDate(Colors.gray500)
                        }
                        Spacer()
                        recordPlayStatus(Colors.gray700)
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 28)
                }
            
            // MARK: - Mask
            recordRectangle(record.type.blockColor)
                .overlay {
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            recordListBlock
                            recordDate(Colors.white)
                        }
                        Spacer()
                        recordPlayStatus(Colors.white)
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 28)
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            switch playerVM.playerState {
                            case .play:
                                playerVM.stopPlaying(.pause)
                            case .pause:
                                playerVM.playOffset = value.location.x
                            case .stop: break
                            }
                        }
                        .onEnded { value in
                            switch playerVM.playerState {
                            case .play: break
                            case .pause:
                                playerVM.playOffset = value.location.x
                                playerVM.startPlaying(record: record)
                            case .stop: break
                            }
                        }
                )
                .mask {
                    Color.black
                        .frame(width: UIScreen.getWidth(playerVM.playOffset))
                        .frame(minWidth: 0, maxWidth: UIScreen.getWidth(342), alignment: .leading)
                } //: - Mask
        }
        .onDisappear {
            playerVM.stopPlaying()
        }
    }
    
    func recordRectangle(_ color: Color) -> some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(width: UIScreen.getWidth(342), height: UIScreen.getHeight(70))
            .foregroundColor(color)
    }
    
    var recordListBlock: some View {
        RoundedRectangle(cornerRadius: 4)
            .foregroundColor(Colors.gray50)
            .frame(width: UIScreen.getWidth(record.type.blockSize.width), height: UIScreen.getHeight(record.type.blockSize.height))
            .overlay {
                HStack {
                    Text(record.type.blockWord)
                    record.type.blockImage
                }
                .foregroundColor(record.type.blockColor)
                .font(Font.caption1())
            }
    }
    
    func recordDate(_ color: Color) -> some View {
        Text(record.createdAt.description)
            .foregroundColor(color)
            .font(Font.body())
    }
    
    func recordPlayStatus(_ color: Color) -> some View {
        HStack(spacing: 15) {
            Text(record.playtime)
            
            Button {
                switch playerVM.playerState {
                case .play: return playerVM.stopPlaying()
                case .pause: return playerVM.startPlaying(record: record)
                case .stop: return playerVM.startPlaying(record: record)
                }
            } label: {
                playerVM.playerState.labelImage
            }
        }
        .foregroundColor(color)
        .font(Font.title2())
    }
}
