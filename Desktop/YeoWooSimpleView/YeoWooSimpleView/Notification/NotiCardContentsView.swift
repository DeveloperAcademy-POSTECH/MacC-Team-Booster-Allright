//
//  NotiCardContentsView.swift
//  YeoWooSimpleView
//
//  Created by 정회승 on 2023/07/14.
//

import SwiftUI

struct NotiCardContentsView: View {
    
    @State private var buddyName = "Pin"
    @State private var buddyImage = "Pin"
    @State private var travelPlace = "제주도"
    
    
    var body: some View {
        NavigationLink{
            
        }label: {
            Image(buddyImage)
                .resizable()
                .scaledToFit()
                .frame(width: 42, height: 42)
                .background(Color.mainColor)
                .clipShape(Circle())
                .padding(.horizontal, 10 )
            
            HStack{
                VStack(alignment: .leading){
                    Text("\(buddyName)이 \(travelPlace) 여행에 초대했어요")
                        .font(.headline)
                    
                }
                
                Spacer()
                
                Button{
                    
                } label: {
                    Image(systemName: "chevron.right")
                        .imageScale(.large)
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 20)
            }
        }
    }
}

struct NotiCardContentsView_Previews: PreviewProvider {
    static var previews: some View {
        NotiCardContentsView()
    }
}
