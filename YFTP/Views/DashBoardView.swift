//
//  DashBoardView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 04/04/2021.
//

import SwiftUI

struct DashBoardView: View {
    var viewModel : MessageContainerViewModel
    
    var body: some View {
        HStack {
            
            VStack(alignment: .center){
                
                GreetingView()
                //random stat component
                Text("You probably did something yesterday")
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundColor(Color("Color"))
                    .multilineTextAlignment(.leading)
                    .padding(.top)
                
                Spacer()
                
                // cards
                StackExampleView()
            }
           

        //controls
        Spacer()
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }
}

struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardView(viewModel : MessageContainerViewModel())
    }
}
