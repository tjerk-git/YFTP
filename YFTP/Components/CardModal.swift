//
//  CardModalComponent.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 16/04/2021.
//

import SwiftUI

struct CardModal: View {
   
    //var data: MessageCardData?
    @Binding var showModal: Bool
    
    @State private var showShareSheet = false
    @State private var loved = false
    @State public var sharedItems : [Any] = []
    
    var messages : Messages
    var id : String
    
    var body: some View {
        let message =  messages.getMessage(id: id)
        GeometryReader { geometry in
        VStack {
            HStack {
                Spacer()
                Text(message.dateAdded ?? Date(), style: .date).font(.footnote).fontWeight(.light).foregroundColor(.black)
            }
            .padding([.top, .trailing])
            HStack {
                 Text("- \(message.sender ?? "You")")
                .font(.subheadline).fontWeight(.semibold).foregroundColor(.black)
                Spacer()
            }
            .padding(.all)
            Spacer()
            HStack {
                Text("\(message.body ?? "")" ).font(.title2).fontWeight(.light).foregroundColor(.black).multilineTextAlignment(.center)
            }.padding(10)
            Spacer()
            HStack {
                Image(systemName: "square.and.arrow.up.fill").accentColor(Color("Color")).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .onTapGesture {
                    let image = self.takeScreenshot(origin: geometry.frame(in: .global).origin, size: geometry.size)
                    self.sharedItems = [image]
                    self.showShareSheet = true
                }.sheet(isPresented: $showShareSheet) {
                    CardShareSheet(activityItems: self.sharedItems)
                }
                Spacer()
                if(message.loved == true){
                    Image(systemName: "heart.fill").foregroundColor(.red).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).onTapGesture {
                        Vibration.success.vibrate()
                        // messages.toggleLoveState(message: message)
                        loved = false
                    }
                } else {
                    Image(systemName: "heart").accentColor(Color("Color")).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).onTapGesture {
                        Vibration.success.vibrate()
                      //  messages.toggleLoveState(message: message)
                        loved = true
                    }
                }
               
            }
            .padding(.all)
        }
        .background(Color.white)
    }
    }
}

extension UIView {
    var renderedImage: UIImage {
        // rect of capure
        let rect = self.bounds
        // create the context of bitmap
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        self.layer.render(in: context)
        // get a image from current context bitmap
        let capturedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return capturedImage
    }
}

extension View {
    func takeScreenshot(origin: CGPoint, size: CGSize) -> UIImage {
        let window = UIWindow(frame: CGRect(origin: origin, size: size))
        let hosting = UIHostingController(rootView: self)
        hosting.view.frame = window.frame
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        return hosting.view.renderedImage
    }
}

//struct CardModalComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        CardModalComponent(data: Data)
//    }
//}
