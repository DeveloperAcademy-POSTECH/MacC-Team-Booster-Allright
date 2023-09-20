//
//  PlayerState.swift
//  Allright
//
//  Created by 송재훈 on 2023/09/20.
//

import SwiftUI

enum PlayerState {
    case play, pause, stop
    
    var labelImage: Image {
        switch self {
        case .play: return Image(systemName: "pause.fill")
        case .pause: return Image(systemName: "play.fill")
        case .stop: return Image(systemName: "play.fill")
        }
    }
}

