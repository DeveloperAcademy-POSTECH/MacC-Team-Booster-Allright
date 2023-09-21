//
//  RecordVM.swift
//  Allright
//
//  Created by 송재훈 on 2023/09/18.
//

import SwiftUI

final class RecordVM: ObservableObject {
    @Published var isEditMode: Bool = false
    @Published var isAlertShow: Bool = false
    @Published var deleteURLs: [URL] = []
    
    func appendDelete(_ url: URL) {
        if self.deleteURLs.contains(url) {
            let _ = deleteURLs.enumerated().map {
                if $0.element == url {
                    deleteURLs.remove(at: $0.offset)
                }
            }
        }
        else {
            self.deleteURLs.append(url)
        }
    }
    
    func onDisappearFunc() {
        isEditMode = false
        isAlertShow = false
        deleteURLs = []
    }
}
