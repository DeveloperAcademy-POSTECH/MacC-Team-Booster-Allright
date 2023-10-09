//
//  RecordView.swift
//  Allright
//
//  Created by 최진용 on 2023/09/16.
//

import SwiftUI

struct RecordView: View {
    @StateObject var recordVM = RecordVM()
    @StateObject var voicerecord = VoiceRecorder()
    @StateObject var player = VoicePlayer()
    
    var body: some View {
        ZStack {
            Colors.gray100.ignoresSafeArea()
            VStack(spacing: 0) {
                topBanner
                listView
            }
        }
        .overlay(alignment: .bottom) {
            Divider()
        }
        .onAppear {
            voicerecord.fetchVoicerecordFile()
        }
        .onDisappear {
            recordVM.reset()
        }
    }
    
    var listView: some View {
        ScrollView(.vertical) {
            VStack {
                if voicerecord.voicerecordList.count == 0 {
                    Spacer().frame(height: UIScreen.screenHeight * 0.22)
                    Text("아직 녹음기록이 없어요")
                        .font(.title2())
                        .foregroundColor(Colors.gray700)
                }
                else {
                    ForEach(0..<voicerecord.voicerecordList.count, id: \.self) { idx in
                        let url = voicerecord.voicerecordList[idx].fileURL
                        HStack {
                            if recordVM.isEditMode {
                                radioButton(url)
                                    .padding(.leading, 15)
                                    .padding(.trailing, -15)
                            }
                            ZStack {
                                RecordListCard(record: voicerecord.voicerecordList[idx], player: player)
                                if recordVM.isEditMode {
                                    blendButton
                                        .onTapGesture {
                                            recordVM.appendDelete(url)
                                        }
                                }
                            }
                        }
                    }
                }
            }
        }
        .scrollDisabled(voicerecord.voicerecordList.count == 0 ? true : false)
        .scrollIndicators(.hidden)
    }
    
    var blendButton: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(width: UIScreen.getWidth(342), height: UIScreen.getHeight(70))
            .blendMode(.destinationOver)
    }
    
    var topBanner: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Button {
                    recordVM.isAlertShow = true
                } label: {
                    deleteButton
                }
                .disabled(recordVM.isEditMode ? false : true)
                .opacity(recordVM.isEditMode ? 1 : 0)
                .alert("녹음기록을 삭제할까요?", isPresented: $recordVM.isAlertShow) {
                    Button("취소", role: .cancel) { }
                    Button("확인", role: .none) {
                        if !recordVM.deleteURLs.isEmpty {
                            let _ = recordVM.deleteURLs.map {
                                voicerecord.deleteRecording($0)
                            }
                            
                            recordVM.deleteURLs = []
                        }
                        
                        recordVM.isEditMode = false
                    }
                }
                if voicerecord.voicerecordList.count != 0 {
                    editButton
                }
                else {
                    Spacer()
                }
            }
            .padding(.top, 62)
            .padding(.bottom, 28)
            Text("셀프피드백")
                .foregroundColor(Colors.gray600)
                .font(Font.body())
                .padding(.bottom, 10)
                .padding(.leading, 2)
            Text("녹음기록")
                .foregroundColor(Colors.black)
                .font(Font.largeTitle())
        }
        .padding(.horizontal, 28)
        .frame(height: UIScreen.getHeight(182))
        .ignoresSafeArea()
    }
    
    var editButton: some View {
        Button {
            recordVM.isEditMode.toggle()
            player.stopPlaying()
        } label: {
            if recordVM.isEditMode {
                Text("취소")
            }
            else {
                Text("편집")
            }
        }
        .foregroundColor(Colors.orange)
        .font(Font.title2())
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    var deleteButton: some View {
        RoundedRectangle(cornerRadius: 100)
            .foregroundColor(Colors.orange)
            .frame(width: UIScreen.getWidth(97), height: UIScreen.getHeight(38))
            .overlay {
                HStack(spacing: 3) {
                    Image(systemName: "trash.fill")
                        .font(Font.caption1())
                    Text("삭제하기")
                        .font(Font.body())
                }
                .foregroundColor(Colors.white)
            }
    }
    
    func radioButton(_ url: URL) -> some View {
        ZStack {
            if recordVM.deleteURLs.contains(url) {
                Ellipse()
                    .foregroundColor(Colors.orange)
                Ellipse()
                    .stroke(lineWidth: 2)
                    .foregroundColor(Colors.orange)
                Image(systemName: "checkmark")
                    .resizable()
                    .bold()
                    .foregroundColor(Colors.white)
                    .frame(width: UIScreen.getWidth(10), height: UIScreen.getHeight(10))
            }
            else {
                Ellipse()
                    .foregroundColor(Colors.white)
                Ellipse()
                    .stroke(lineWidth: 2)
                    .foregroundColor(Colors.gray300)
                Image(systemName: "checkmark")
                    .resizable()
                    .bold()
                    .foregroundColor(Color.clear)
                    .frame(width: UIScreen.getWidth(10), height: UIScreen.getHeight(10))
            }
        }
        .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
        .onTapGesture {
            recordVM.appendDelete(url)
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
