//
//  RecordView.swift
//  Allright
//
//  Created by 최진용 on 2023/09/16.
//

import SwiftUI

struct RecordView: View {
    @StateObject var recordVM = RecordVM()
    
    var body: some View {
        Colors.gray100.ignoresSafeArea()
            .overlay(alignment: .top) {
                VStack(spacing: 0) {
                    topBanner
                    
                    VStack {
                        recordList
                        recordList
                        recordList
                        recordList
                        recordList
                        recordList
                        recordList
                        recordList
                    }
                }
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
                    Button("취소", role: .cancel) {
                        
                    }
                    Button("확인", role: .destructive) {
                        
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
        ZStack {
            if recordVM.isEditMode {
                Button {
                    recordVM.isEditMode = false
                } label: {
                    editButtonText("취소")
                }
            }
            else {
                Button {
                    recordVM.isEditMode = true
                } label: {
                    editButtonText("편집")
                }
            }
        }
    }
    
    func editButtonText(_ str: String) -> some View {
        Text(str)
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
    
    var radioButton: some View {
        ZStack {
            Ellipse()
                .foregroundColor(recordVM.isEditMode ? Colors.orange : Colors.white)
            Ellipse()
                .stroke(lineWidth: 2)
                .foregroundColor(recordVM.isEditMode ? Colors.orange : Colors.gray300)
            Image(systemName: "checkmark")
                .resizable()
                .bold()
                .foregroundColor(recordVM.isEditMode ? Colors.white : Color.clear)
                .frame(width: UIScreen.getWidth(10), height: UIScreen.getHeight(10))
        }
        .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
    }
    
    var recordList: some View {
        HStack {
            if recordVM.isEditMode {
                radioButton
                    .padding(.leading, 8)
            }
            RecordListCard()
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
