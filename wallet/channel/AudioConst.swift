//
//  AudioConst.swift
//  ppts
//
//  Created by lichongbing on 2022/12/6.
//

import Foundation
import AudioUnit

//var WSBufferDuration: Int {
//    get {
//        var value = UserDefaults.standard.integer(forKey: "key_WSBufferDuration")
//        if value == 0{
//            value = 16
//        }
//        return value
//    }
//    set { UserDefaults.standard.set(newValue, forKey: "WSBufferDuration") }
//}
let sampleMinValue = 64
var WSBufferDuration = 16
var audioPlayCacheBufferLen = 5
var WSmDataByteSize: Int = 4096

struct AudioConst {
    static let SampleRate: Int = 48000//44100
    static let Channels: UInt32 = 1
    static let InputBus: AudioUnitElement = 1
    static let OutputBus: AudioUnitElement = 0
    static let mBitsPerChannel: UInt32 = 16
}
