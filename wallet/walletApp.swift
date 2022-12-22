//
//  walletApp.swift
//  wallet
//
//  Created by lichongbing on 2022/8/10.
//

import SwiftUI
import PushToTalk
import AVFAudio
import Alamofire
import SwiftyJSON
import AudioToolbox
import AVFoundation
@main
struct walletApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate,PTChannelManagerDelegate,PTChannelRestorationDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate{
    static var channelManager: PTChannelManager?
    var channelDescriptor: PTChannelDescriptor?
    static var channelUUID: UUID?
    var audioPlayer: AVAudioPlayer!
    var recorder: AVAudioRecorder!
    static var file_path:String!
    static var recordSetting:[String: Any]!
    var debugInput: String?
    var audioStatus: AudioStatus = AudioStatus.stopped
    let baseurl = Config.pro
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)  -> Bool {
        Task{
            try await setupChannelManager()
        }
        registerNotification(application)
        //micaudio()
        //audioSetting()
        let token =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "tokenA") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8",
            "token": token
        ]
        let item  = "kkk"
        AF.request("\(baseurl)/channel/apnspro",
                   method: .post,
                   parameters: item, encoder: JSONParameterEncoder.default,
                   headers: headers).response
        { response in
            debugPrint(response)
        }
        return true
    }
  
    func registerNotification(_ application: UIApplication) {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted: Bool, error: Error?) in
            DispatchQueue.main.async {
                if granted { application.registerForRemoteNotifications() }
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.reduce("") { partialResult, uintNum in
            partialResult + String(format: "%02x", uintNum)
        }
        UserDefaults.init(suiteName: "group.com.lichongbing.lyoggl")?.set(token, forKey: "deviceTokens")
        print("DEVICE TOKEN: \(token)\n")
    }
    //MARK: Work with Error
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Remote Notification Error Description: \(error.localizedDescription)")
    }
    func setupChannelManager() async throws {
        AppDelegate.channelManager = try await PTChannelManager.channelManager(delegate: self,restorationDelegate: self)
        print(AppDelegate.channelManager)
    }
    func joinChannel(channelUUID: UUID) {
        AppDelegate.channelUUID = channelUUID
        let channelImage = UIImage(systemName: "mic.and.signal.meter")
        channelDescriptor = PTChannelDescriptor(name: "测试", image: channelImage)
      
        // Ensure that your channel descriptor and UUID are persisted to disk for later use.
        AppDelegate.channelManager?.requestJoinChannel(channelUUID: channelUUID,
                                                       descriptor: channelDescriptor!)

    }
    
    func leaveChannel(channelUUID: UUID){
        AppDelegate.channelManager?.leaveChannel(channelUUID: channelUUID)
       
    }
    func channelManager(_ channelManager: PTChannelManager,didLeaveChannel channelUUID: UUID,reason: PTChannelLeaveReason){
        // Process leaving the channel
        print("Left channel with UUID: \(channelUUID)")
    }
    
    func leaveChannels(channelUUID: UUID){
        let item  =  Channel(id: channelUUID, uid: "String", title: "fullname", des: "String")
        let token =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "tokenA") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8",
            "token": token
        ]
        AF.request("\(baseurl)/channel/leaveChannel",
                   method: .post,
                   parameters: item, encoder: JSONParameterEncoder.default,
                   headers: headers).response
        { response in
            debugPrint(response)
        }
    }
    
    func channelManager(_ channelManager: PTChannelManager, didJoinChannel channelUUID: UUID, reason: PTChannelJoinReason) {
        Task{
            try await channelManager.setTransmissionMode(.fullDuplex,
                                                         channelUUID: channelUUID)
            try  await reportServiceIsConnected(channelUUID: channelUUID)
            let token =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "tokenA") as! String
            let pushtoken =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "pushtoken") as! String
            let headers: HTTPHeaders = [
                "Content-Type": "application/json;charset=UTF-8",
                "token": token
            ]
            let item  = JoinChannelToken(id: AppDelegate.channelUUID ?? UUID(), deviceToken: pushtoken)
            AF.request("\(baseurl)/channel/joinChannel",
                       method: .post,
                       parameters: item, encoder: JSONParameterEncoder.default,
                       headers: headers).response
            { response in
                debugPrint(response)
            }
        }
       
        print("Joined channel with UUID: \(channelUUID)")
    }
    func reportServiceIsReconnecting(channelUUID: UUID) async throws {
        try await AppDelegate.channelManager!.setServiceStatus(.connecting, channelUUID: channelUUID)
    }
    func reportServiceIsConnected(channelUUID: UUID) async throws {
        try await AppDelegate.channelManager!.setServiceStatus(.ready, channelUUID: channelUUID)
    }
    
    func startTransmitting(channelUUID: UUID) {
        AppDelegate.channelManager!.requestBeginTransmitting(channelUUID:channelUUID )
        print("requestBeginTransmitting")
    }
    func channelManager(_ channelManager: PTChannelManager,
                        channelUUID: UUID,
                        didBeginTransmittingFrom source: PTChannelTransmitRequestSource) {
        print("Did begin transmission from: \(source)")
        //micaudio()
       // startRecording()
        
    }
    func channelManager(_ channelManager: PTChannelManager,
                        channelUUID: UUID,
                        didEndTransmittingFrom source: PTChannelTransmitRequestSource) {
        let url = getURLforMemo()
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(url, withName: "multiFile")
        }, to: "https://channel.lichongbing.com/audio/uploadAudio/\(channelUUID)")
            .response
        { response in
            debugPrint(response)
        }

        let token =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "tokenA") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8",
            "token": token
        ]
        let item  = JoinChannelToken(id: AppDelegate.channelUUID!, deviceToken: token)
        AF.request("\(baseurl)/channel/apnspro",
                   method: .post,
                   parameters: item, encoder: JSONParameterEncoder.default,
                   headers: headers).response
        { response in
            debugPrint(response)
        }
        print("Did end transmission from: \(source)")
    }
    func channelManager(_ channelManager: PTChannelManager,
                        failedToBeginTransmittingInChannel channelUUID: UUID,
                        error: Error)
    {
        let error = error as NSError

        switch error.code {
        case PTChannelError.callActive.rawValue:
            print("The system has another ongoing call that is preventing transmission.")
        default:
            break
        }
    }

    func channelManager(_ channelManager: PTChannelManager,
                        receivedEphemeralPushToken pushToken: Data) {
        let pushtoken = pushToken.reduce("") { partialResult, uintNum in
            partialResult + String(format: "%02x", uintNum)
        }
        UserDefaults.init(suiteName: "group.com.lichongbing.lyoggl")?.set(pushtoken, forKey: "pushtoken")
     
    }
    func channelManager(_ channelManager: PTChannelManager,
                        failedToJoinChannel channelUUID: UUID,
                        error: Error) {
        let error = error as NSError
        switch error.code {
        case PTChannelError.channelLimitReached.rawValue:
            print("The user has already joined a channel")
        default:
            break
        }
    }
    
    func channelDescriptor(restoredChannelUUID channelUUID: UUID) -> PTChannelDescriptor {
        let channelImage = UIImage(named: "ChannelIcon")
        channelDescriptor = PTChannelDescriptor(name: "Awesome Crew", image: channelImage)
       // return getCachedChannelDescriptor(channelUUID)
        return PTChannelDescriptor(name: "Awesome Crew", image: channelImage)
    }
    func updateChannel(_ channelDescriptor: PTChannelDescriptor) async throws {
        try await AppDelegate.channelManager!.setChannelDescriptor(channelDescriptor,
                                                                   channelUUID: AppDelegate.channelUUID ?? UUID())
    }
    //中途被打断停止传输
    func stopTransmitting(channelUUID:UUID) {
        print("stopTransmitting")
        AppDelegate.channelManager!.stopTransmitting(channelUUID: channelUUID)
    }
    func channelManager(_ channelManager: PTChannelManager,failedToStopTransmittingInChannel channelUUID: UUID,
                        error: Error) {
        let error = error as NSError
        switch error.code {
        case PTChannelError.transmissionNotFound.rawValue:
            
            print("The user was not in a transmitting state")
        default:
            break
        }
    }
    
   
    func channelManager(_ channelManager: PTChannelManager,
                        didActivate audioSession: AVAudioSession) {
        
        print("Did begin transmission from active")
     
        // Configure your audio session and begin recording
        do{
            try audioSession.setCategory(.playAndRecord,options: [.defaultToSpeaker])
            audioSession.requestRecordPermission { status in
                if status {
                    appHasMicAccess = true
                }
                else{
                    appHasMicAccess = false
                }
            }
            
        }catch let err {
            print(err.localizedDescription)
        }
        
        if appHasMicAccess{
            let fileURL = getURLforMemo()
            let recordSettings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                ] as [String : Any]
            do{
                let recorders =  try AVAudioRecorder(url: fileURL, settings: recordSettings)
                recorder = recorders
                audioStatus = .recording
                recorder.delegate = self
                recorder.record()
                print(recorder.isRecording)}
            catch let err {
            print("录音失败:\(err.localizedDescription)")
            }
        }
      
        
    }
  
    func channelManager(_ channelManager: PTChannelManager,
                        didDeactivate audioSession: AVAudioSession) {
        print("Did deactivate audio session")
        
        stopRecording()
        
       
    }
    
    func incomingPushResult(channelManager: PTChannelManager, channelUUID: UUID, pushPayload: [String : Any]) -> PTPushResult {
        //
           guard let activeSpeaker = pushPayload["activeSpeaker"] as? String else {
               // If no active speaker is set, the only other valid operation
               // is to leave the channel
               return .leaveChannel
           }
          // let activeSpeakerImage = getActiveSpeakerImage(activeSpeaker)
           let participant = PTParticipant(name: activeSpeaker, image: UIImage(systemName:"mic.and.signal.meter"))
           return .activeRemoteParticipant(participant)
    }
    func stopReceivingAudio() {
        AppDelegate.channelManager!.setActiveRemoteParticipant(nil, channelUUID: AppDelegate.channelUUID ?? UUID())
    }
    func startRecording(){
        let session =   AVAudioSession.sharedInstance()
        let fileURL = getURLforMemo()
        let recordSettings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ] as [String : Any]
        do {
            try session.setCategory(.playAndRecord,options: [.defaultToSpeaker])
            session.requestRecordPermission{(status) in
                print(status)
            }
            try session.setActive(true)
            let recorders =  try AVAudioRecorder(url: fileURL, settings: recordSettings)
            recorder = recorders
            audioStatus = .recording
            print(recorder)
            recorder.delegate = self
            recorder.record()
            print(recorder.isRecording)
            print("startRecording")
            } catch let err {
            print("录音失败:\(err.localizedDescription)")
            }
    }
    

    
    func stopRecording() {
        audioStatus = .stopped
        recorder.stop()
        recorder.url
        print("stopRecording")
        print(recorder)
    }
    
    func getURLforMemo() -> URL {
        let tempDir = NSTemporaryDirectory()
        let filePath = tempDir + "/TempMemo.m4a"
        return URL(fileURLWithPath: filePath)
    }
    
    func play() {
        print("audio Player")
        let fileURL = getURLforMemo()
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer.delegate = self
            if audioPlayer.duration > 0.0 {
                audioPlayer.play()
                audioStatus = .playing
            }
        } catch {
            print("Error loading audio Player")
        }
    }
    
    func stopPlayback() {
        audioStatus = .stopped
        audioPlayer.stop()
    }
    
    
    func onRecord(){
        if appHasMicAccess == true {
            switch audioStatus {
            case .stopped:
                startRecording()
            case .recording:
                stopRecording()
            case .playing:
                stopPlayback()
            default:
                ()
            }
            
        }
    }
  
}
