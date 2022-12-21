//
//  AudioRecorder.swift
//  ppts
//
//  Created by lichongbing on 2022/12/9.
//

import Foundation
import CoreAudioTypes

protocol AudioRecorderDelegate: class {
    func audioRecorder(_ recorder: AudioRecorder, receive buffer: AudioBuffer)
}

class AudioRecorder {

    let sampleRate: Int
    let fileURL: URL?
    let bgmFileURL: URL?

    weak var delegate: AudioRecorderDelegate?

    init(sampleRate: Int, fileURL: URL?, bgmFileURL: URL?) {
        self.sampleRate = sampleRate
        self.fileURL = fileURL
        self.bgmFileURL = bgmFileURL
    }
    
    func startRecording() {}
    
    func stopRecording() {}
    
}
