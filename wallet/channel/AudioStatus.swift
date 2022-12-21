//
//  AudioStatus.swift
//  ppts
//
//  Created by lichongbing on 2022/12/6.
//

import Foundation
var appHasMicAccess = true

enum AudioStatus: Int, CustomStringConvertible {
    case stopped = 0, playing, recording, interruptionPlaying, interruptionRecording
    
    var audioName: String {
        let audioNames = [
            "Audio:  Stopped",
            "Audio:  Playing",
            "Audio:  Recording",
            "Audio:  interruptionPlaying",
            "Audio:  interruptionRecording"]
        return audioNames[rawValue]
    }
    
    
    //  CustomStringConvertible
    var description: String {
        return audioName
    }
}
