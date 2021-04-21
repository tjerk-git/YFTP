//
//  SendingMessageView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 11/12/2020.
//

import SwiftUI

struct SendingMessageView: View {
    var body: some View {
        HStack() {
            GIFView(gifName: "giphy")
        }.background(Color.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center).edgesIgnoringSafeArea(.all)
            .edgesIgnoringSafeArea(.all)
        }
}


//struct SendingMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        SendingMessageView(viewModel : MessageContainerViewModel())
//    }
//}
