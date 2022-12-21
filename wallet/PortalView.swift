//
//  PortalView.swift
//  wallet
//
//  Created by lichongbing on 2022/8/10.
//

import SwiftUI

struct PortalView: View {
    @StateObject var channels: ChannelDao = ChannelDao()
    @State     var index = 0
    var body: some View {
        TabView {
            NavigationView {
                ChannelListView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
              VStack {
                Image(systemName: "mic.and.signal.meter")
                Text("频道")
              }
            }
            .tag(0)
            .environmentObject(channels)
            NavigationView {
                Text("设置")
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
              VStack {
                Image(systemName: "iphone.gen1.radiowaves.left.and.right")
                Text("设置")
              }
            }
            .tag(1)
          
        }
        
     

    }
}
struct PortalView_Previews: PreviewProvider {
    static var previews: some View {
        PortalView()
    }
}
