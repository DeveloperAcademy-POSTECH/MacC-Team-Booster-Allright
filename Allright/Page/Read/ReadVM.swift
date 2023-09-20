//
//  ReadVM.swift
//  Allright
//
//  Created by 최진용 on 2023/09/18.
//

import SwiftUI


class ReadVM: ObservableObject {
    @Published var isSoundOn = false
    @Published var currentCard = 0
    @Published var currentIndex: Int = 0
    @GestureState var dragOffset = 0
    @Published var isPlayLottie = false
//    280/totalcount * current
}
