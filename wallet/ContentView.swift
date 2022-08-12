//
//  ContentView.swift
//  wallet
//
//  Created by lichongbing on 2022/8/10.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import AuthenticationServices
import JWTDecode
struct ContentView: View {
    @AppStorage("login") private var login = false
    init(){
        guard let token = UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "token") else{
            return
        }
        let expiration = try! decode(jwt: token as! String).expiresAt
        let now = Date()
        if(now >= expiration!){
            self.login = false
        }else{
            self.login = true
        }
    }
    var body: some View {
        VStack {
            if(login){
                PortalView()
            }else{
                Text("个人财物管理软件")
                signInWithApple
            }
        }
    }
    var signInWithApple: some View {
        SignInWithAppleButton(
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                switch result {
                    case .success(let authResults):
                    switch authResults.credential {
                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                            let uID = appleIDCredential.user
                            let identityToken = appleIDCredential.identityToken
                            let authorizationCode = appleIDCredential.authorizationCode
                            struct AppleToken: Encodable {
                                           let user: String
                                           let identityToken: Data
                                           let authorizationCode: Data
                                       }
                            let baseurl = Config.pro
                            let appleToken = AppleToken(user: uID, identityToken: identityToken!,authorizationCode: authorizationCode!)
                            let headers: HTTPHeaders = [
                                               "Content-Type": "application/json;charset=UTF-8"
                                           ]
                            AF.request("\(baseurl)/users/registerlogin", method: .post,
                            parameters: appleToken, encoder: JSONParameterEncoder.default, headers: headers).response
                            { response in
                              let token =  (response.response?.headers.value(for: "token"))! as String
                              let userdefault =  UserDefaults.init(suiteName: "group.com.lichongbing.lyoggl")
                             userdefault?.set(token, forKey: "token")
                                               print(appleToken)
                                               print(token)
                                self.login = true
                           }
                        default:
                            break
                        }
                    case .failure(let error):
                        print("failure", error)
                }
            }
        ).signInWithAppleButtonStyle(.black)
         .frame(width:180,height:40)
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
