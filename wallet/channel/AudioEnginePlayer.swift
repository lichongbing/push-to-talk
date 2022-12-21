//
//  AudioEnginePlayer.swift
//  ppts
//
//  Created by lichongbing on 2022/12/9.
//

import Foundation
import AVFoundation
class AudioEnginePlayer {
    
    private let fileURL: URL
    private var file: AVAudioFile?

    private let engine = AVAudioEngine()
    private let filePlayer = AVAudioPlayerNode()
    private let delayEffect = AVAudioUnitDelay()
    
    init(fileURL: URL) {
        self.fileURL = fileURL
        setupFilePlayer()
        setupAudioEngine()
    }

    func play() {
        do {
          try engine.start()
        } catch let error {
            print("Could not start AVAudioEngine \(error.localizedDescription)")
            exit(1)
        }
        scheduleAudioFile()
        filePlayer.play()
        print("start audio recording")
    }
    func stop() {
        filePlayer.stop()
        engine.stop()
        print("stops audio recording")
    }
    private func setupAudioEngine() {
        delayEffect.delayTime = 0.8
        delayEffect.feedback = 80
        delayEffect.wetDryMix = 50
        engine.mainMixerNode.outputVolume = 5.0
        engine.attach(filePlayer)
        engine.attach(delayEffect)
        engine.connect(filePlayer, to: delayEffect, format: nil)
        engine.connect(delayEffect, to: engine.mainMixerNode, format: nil)
        engine.prepare()
    }
        
    private func setupFilePlayer() {
        file = try? AVAudioFile(forReading: fileURL)
    }
    
    private func scheduleAudioFile() {
        guard let file = file else { return }

        filePlayer.scheduleFile(file, at: nil) { [weak self] in
            self?.scheduleAudioFile()
        }
    }

}
