//
//  Ext+View.swift
//  Allright
//
//  Created by 최진용 on 2023/09/18.
//

import SwiftUI


extension View {
    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }
}
