//
//  NotifcationCardView.swift
//  YeoWooSimpleView
//
//  Created by 정회승 on 2023/07/14.
//

import SwiftUI

struct NotiCardView: View {
    @State var dayNotiNum: Int = 1
    //NotiCardView생성날짜 저장

    
    var body: some View {
        
            HStack{
                NotiCardContentsView()
            }
            .modifier(CardViewModifier(height: CGFloat(65 * dayNotiNum)))
            .accentColor(.black)
    }
}

struct NotiCardView_Previews: PreviewProvider {
    static var previews: some View {
        NotiCardView(dayNotiNum: 3)
    }
}
