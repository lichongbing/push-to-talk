//
//  PortalView.swift
//  wallet
//
//  Created by lichongbing on 2022/8/10.
//

import SwiftUI

struct PortalView: View {
    let tags = ["月报","收支","账单","卡片"]
    let imgs = ["flag.circle","list.bullet.circle","tag.circle","creditcard.circle"]
    @State     var index = 0
    var body: some View {
       Text("hello")
    }
}
struct PortalView_Previews: PreviewProvider {
    static var previews: some View {
        PortalView()
    }
}
