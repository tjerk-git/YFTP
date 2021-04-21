//
//  ApplicationFeature.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 25/01/2021.
//

import Foundation
import SwiftUI

struct ApplicationFeature : View {

    var featureTitle: String
    var featureDescription: String
    var featureImage: String
     init(
         featureTitle: String,
         featureDescription: String,
         featureImage: String
     ) {
         self.featureTitle = featureTitle
         self.featureDescription = featureDescription
         self.featureImage = featureImage
     }
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: self.featureImage)
                .foregroundColor(.black)
                .font(.title)
                .multilineTextAlignment(.leading)
                .padding(10)
            Text(self.featureTitle)
                .font(.subheadline)
                .foregroundColor(Color.black)
                .bold()
                .padding(.bottom)
            Text(self.featureDescription)
                .font(.body)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                .padding(20)
                .background(Color.white)
                .cornerRadius(15)
        }
        .padding(.leading, 36)
        .padding(.trailing, 36)
    }
}
