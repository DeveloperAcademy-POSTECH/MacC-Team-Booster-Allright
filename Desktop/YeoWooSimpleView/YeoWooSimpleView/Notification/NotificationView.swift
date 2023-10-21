//
//  NotificationView.swift
//  YeoWooSimpleView
//
//  Created by 정회승 on 2023/07/14.
//

import SwiftUI

struct NotificationView: View {

    
    var body: some View {
        NavigationStack{
            ScrollView{
                
                //받은 날짜 표시

                Text("2023.07.07")
                    .modifier(SubTitleFont())
                
                
                NotiCardView()
            }
            .navigationTitle("알림")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.backgroundGray)
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
