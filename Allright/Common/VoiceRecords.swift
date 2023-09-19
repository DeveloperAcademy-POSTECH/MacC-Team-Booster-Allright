//
//  VoiceRecords.swift
//  Allright
//
//  Created by 송재훈 on 2023/09/18.
//

import SwiftUI

struct VoiceRecord : Equatable {
    let fileURL : URL
    let createdAt : Date
    var isPlaying : Bool
}
