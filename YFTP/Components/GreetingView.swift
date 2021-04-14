//
//  GreetingView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 14/04/2021.
//

import SwiftUI

struct GreetingView: View {

    var body: some View {
        HStack(alignment: .center){
            VStack(alignment: .leading){
                Text("Hey,").font(.title).fontWeight(.bold).foregroundColor(.blue).multilineTextAlignment(.leading)
            }
            VStack(alignment: .leading){
                Text("it's monday, psyche its friday.").font(.headline).foregroundColor(Color("Color")).multilineTextAlignment(.leading).padding([.top, .trailing], 10.0)
            }
        }
        .padding(.all, 10.0)
    }

    struct GreetingView_Previews: PreviewProvider {
        static var previews: some View {
            GreetingView()
        }
    }
}
