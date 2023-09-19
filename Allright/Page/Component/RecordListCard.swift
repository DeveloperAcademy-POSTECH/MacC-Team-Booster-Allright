//
//  RecordListCard.swift
//  Allright
//
//  Created by 송재훈 on 2023/09/18.
//

import SwiftUI

struct RecordListCard: View {
    @State var recordOffset: CGFloat = .zero
    @State var rectangleColor: Color = Colors.green400
    
    var body: some View {
        // MARK: - Rectangle
        ZStack {
            recordRectangle(Colors.white)
            recordRectangle(rectangleColor)
                .mask(alignment: .leading) {
                    rectangleColor
                        .frame(width: UIScreen.getWidth(recordOffset))
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            recordOffset = value.location.x
                        }
                )
        } //: - Rectangle
        // MARK: - Components
        .overlay {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    recordListSyllable1Block
                    
                    ZStack {
                        recordDate(Colors.gray500)
                        recordDate(Colors.white)
                            .mask(alignment: .leading) {
                                Colors.white
                                    .frame(width: UIScreen.getWidth(recordOffset - 16))
                            }
                    }
                }
                Spacer()
                
                ZStack {
                    recordPlayStatus(Colors.gray700)
                    recordPlayStatus(Colors.white)
                        .mask(alignment: .leading) {
                            Colors.white
                                .frame(width: UIScreen.getWidth(recordOffset - 245))
                        }
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 28)
        } //: - Components
    }
    
    func recordRectangle(_ color: Color) -> some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(width: UIScreen.getWidth(342), height: UIScreen.getHeight(70))
            .foregroundColor(color)
    }
    
    var recordListSyllable1Block: some View {
        RoundedRectangle(cornerRadius: 4)
            .foregroundColor(Colors.gray50)
            .frame(width: UIScreen.getWidth(52), height: UIScreen.getHeight(22))
            .overlay {
                HStack {
                    Text("음절")
                    Image(systemName: "1.circle.fill")
                }
                .foregroundColor(Colors.green400)
                .font(Font.caption1())
            }
    }
    
    var recordListSyllable2Block: some View {
        RoundedRectangle(cornerRadius: 4)
            .foregroundColor(Colors.gray50)
            .frame(width: UIScreen.getWidth(52), height: UIScreen.getHeight(22))
            .overlay {
                HStack {
                    Text("음절")
                    Image(systemName: "2.circle.fill")
                }
                .foregroundColor(Colors.green600)
                .font(Font.caption1())
            }
    }
    
    var recordListSenteceBlock: some View {
        RoundedRectangle(cornerRadius: 4)
            .foregroundColor(Colors.gray50)
            .frame(width: UIScreen.getWidth(38), height: UIScreen.getHeight(22))
            .overlay {
                Text("문장")
                    .foregroundColor(Colors.green700)
                    .font(Font.caption1())
            }
    }
    
    func recordDate(_ color: Color) -> some View {
        Text("2023.05.15.")
            .foregroundColor(color)
            .font(Font.body())
    }
    
    func recordPlayStatus(_ color: Color) -> some View {
        HStack(spacing: 15) {
            Text("02:32")
            Image(systemName: "play.fill")
        }
        .foregroundColor(color)
        .font(Font.title2())
    }
}

struct RecordListCard_Previews: PreviewProvider {
    static var previews: some View {
        RecordListCard()
    }
}
