//
//  ViewModifier.swift
//  YeoWooSimpleView
//
//  Created by 정회승 on 2023/07/14.
//

import SwiftUI


struct CardViewModifier: ViewModifier {
    //default 값 65 설정
    var height: CGFloat = 65
    
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.main.bounds.width - 30, height: height)
            .background(RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray, lineWidth: 1)
                    .opacity(0.5)
                    
            )
    }
}
    
