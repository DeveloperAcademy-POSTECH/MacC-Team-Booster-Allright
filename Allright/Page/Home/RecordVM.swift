//
//  RecordVM.swift
//  Allright
//
//  Created by 송재훈 on 2023/09/18.
//

import SwiftUI

final class RecordVM: ObservableObject {
    @Published var isEditMode: Bool = false
    @Published var isPlaying: Bool = false
    @Published var isAlertShow: Bool = false
}
