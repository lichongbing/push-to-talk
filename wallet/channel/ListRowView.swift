//
//  ListRowView.swift
//  ppts
//
//  Created by lichongbing on 2022/12/2.
//

import SwiftUI
struct ListRowView: View {
    let item: Channel
    var body: some View {
        HStack {
            Image(systemName:"waveform.and.mic")
                .foregroundColor(.green)
            Text(item.title)
            Spacer()
         
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

struct ListRowView_Previews: PreviewProvider {
    
    static var item1 = Channel(id: UUID(), uid: "String", title: "String", des: "1")
    static var item2 = Channel(id: UUID(), uid: "String", title: "String", des: "1")
    static var previews: some View {
        Group {
            ListRowView(item: item1)
            ListRowView(item: item2)
        }
        .previewLayout(.sizeThatFits)
        
    }
}
