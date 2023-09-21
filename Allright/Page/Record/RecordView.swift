//
//  RecordView.swift
//  Allright
//
//  Created by 최진용 on 2023/09/16.
//

import SwiftUI

struct RecordView: View {
    @StateObject var recordVM = RecordVM()
    @StateObject var voicerecordVM = VoicerecordVM()
    @StateObject var player = VoicePlayerVM()
    
    var body: some View {
        Colors.gray100.ignoresSafeArea()
            .overlay(alignment: .top) {
                VStack(spacing: 0) {
                    topBanner
                    
                    ScrollView(.vertical) {
                        VStack {
                            ForEach(0..<voicerecordVM.voicerecordList.count, id: \.self) { idx in
                                HStack {
                                    if recordVM.isEditMode {
                                        radioButton(voicerecordVM.voicerecordList[idx].fileURL)
                                            .padding(.leading, 8)
                                    }
                                    RecordListCard(record: voicerecordVM.voicerecordList[idx], playerVM: player)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                voicerecordVM.fetchVoicerecordFile()
            }
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
                                voicerecordVM.deleteRecording($0)
                            }
                            
                            recordVM.deleteURLs = []
                        }
                        
                        recordVM.isEditMode = false
                    }
                }
                
                editButton
            }
            .padding(.top, 62)
            .padding(.bottom, 28)
            Text("셀프피드백")
                .foregroundColor(Colors.gray600)
                .font(Font.body())
                .padding(.bottom, 17)
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
                HStack(spacing: 0) {
                    Image(systemName: "trash.fill")
                    Text("삭제하기")
                }
                .foregroundColor(Colors.white)
                .font(Font.title2())
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
