//
//  RecordListCard.swift
//  Allright
//
//  Created by 송재훈 on 2023/09/18.
//

import SwiftUI

struct RecordListCard: View {
    let record: Voicerecord
    @ObservedObject var player: VoicePlayer
    
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
                            switch player.playerState {
                            case .play:
                                player.stopPlaying(.pause)
                            case .pause:
                                player.playOffset = value.location.x
                            case .stop: break
                            }
                        }
                        .onEnded { value in
                            switch player.playerState {
                            case .play: break
                            case .pause:
                                player.playOffset = value.location.x
                                player.startPlaying(record: record)
                            case .stop: break
                            }
                        }
                )
                .mask {
                    if record.fileURL == player.playingURL {
                        Color.black
                            .frame(width: UIScreen.getWidth(player.playOffset))
                            .frame(minWidth: 0, maxWidth: UIScreen.getWidth(342), alignment: .leading)
                    }
                } //: - Mask
        }
        .onDisappear {
            player.stopPlaying()
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
                if player.playingURL == record.fileURL {
                    switch player.playerState {
                    case .play: return player.stopPlaying(.pause)
                    case .pause: return player.startPlaying(record: record, state: .pause)
                    case .stop: return player.startPlaying(record: record)
                    }
                }
                else {
                    switch player.playerState {
                    case .play: return player.startPlaying(record: record)
                    case .pause: return player.startPlaying(record: record)
                    case .stop: return player.startPlaying(record: record)
                    }
                }
            } label: {
                if player.playerState == .play && player.playingURL == record.fileURL {
                    Image(systemName: "pause.fill")
                }
                else {
                    Image(systemName: "play.fill")
                }
            }
        }
        .foregroundColor(color)
        .font(Font.title2())
    }
}
