//
//  HomeVM.swift
//  Allright
//
//  Created by 최진용 on 2023/09/16.
//

import SwiftUI

final class HomeVM: ObservableObject {
    @Published var date = Date()
    @Published var some = 0
    
    var today: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 MM월 d일"
        return formatter.string(from: date)
    }
}
