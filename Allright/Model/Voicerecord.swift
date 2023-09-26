//
//  VoiceRecords.swift
//  Allright
//
//  Created by 송재훈 on 2023/09/18.
//

import SwiftUI

struct Voicerecord: Equatable, Hashable {
    let fileURL: URL
    let createdAt: String
    let type: TrainingSteps
    let playtime: String
}
