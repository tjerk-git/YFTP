//
//  ComposeGiftView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 08/12/2020.
//
import AVFoundation
import SwiftUI
import UIKit

enum Coordinator {
  static func topViewController(_ viewController: UIViewController? = nil) -> UIViewController? {
    let vc = viewController ?? UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController
    if let navigationController = vc as? UINavigationController {
      return topViewController(navigationController.topViewController)
    } else if let tabBarController = vc as? UITabBarController {
      return tabBarController.presentedViewController != nil ? topViewController(tabBarController.presentedViewController) : topViewController(tabBarController.selectedViewController)
      
    } else if let presentedViewController = vc?.presentedViewController {
      return topViewController(presentedViewController)
    }
    return vc
  }
}

struct MessageJSON : Codable {
    var body : String
    var date : Double
    var sender : String
    var isGift : Int
}
    
struct ComposeGiftView: View {
    
    var viewModel : MessageContainerViewModel
   
    @State var message: String = "Start typing here..."
    @State private var showingAlert = false
    @State private var pickADate = false
    @State var selectedDate = Date()
    @State private var isSharePresented: Bool = false
    @State private var username: String = ""
    @State private var isEditing = false

    let defaults = UserDefaults.standard
    var messages : Messages

    var body: some View {
        
        HStack() {
            VStack(alignment: .center) {
                TextEditor(text: $message)
                    .onTapGesture {
                        if(message == "Start typing here..."){
                            message = ""
                        }
                        
                        let keyWindow = UIApplication.shared.connectedScenes
                                           .filter({$0.activationState == .foregroundActive})
                                           .map({$0 as? UIWindowScene})
                                           .compactMap({$0})
                                           .first?.windows
                                           .filter({$0.isKeyWindow}).first
                        keyWindow!.endEditing(true)
                    }
                    .background(Color("Color"))
                    .foregroundColor(Color("Color"))
                    .opacity(6)
                    .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 0)
                    .cornerRadius(15)
                    .padding(10)
                
                VStack(alignment: .leading) {
                       Text("Message will come from: ")
                       TextField(
                           defaults.string(forKey: "Name") ?? "Username",
                                text: $username
                           ) { isEditing in
                               self.isEditing = isEditing
                       }.padding(10)
                           .autocapitalization(.none)
                           .disableAutocorrection(true)

                       Toggle(isOn: $pickADate) {
                                       Text("Select a time")
                                   }.padding()

                       if(self.pickADate){
                           DatePicker("When do you want to it to arrive?", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                       }
                    Spacer()
                }.padding(10)
          
                    Button(action: {
                        if !message.isEmpty {
                           username = defaults.string(forKey: "Name") ?? "Someone from the past"
                           if(pickADate){
                               self.GiftMessageWithDate(body: message, date: selectedDate, sender: username)
                           } else {
                               self.GiftMessage(body: message, sender: username)
                           }

                       } else {
                           self.showingAlert = true
                       }
                    }){
                 
                    Image(systemName: "gift").font(.largeTitle).foregroundColor(Color("Color"))
                    Text("Send to a friend")
                        .fontWeight(.bold)
                        .padding()
                        .overlay(
                            Capsule(style: .continuous).stroke(Color.blue, style: StrokeStyle(lineWidth: 3))
                        )
                        .foregroundColor(.blue).font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
                    
                }.alert(isPresented: $showingAlert, content: {
                    Alert(title: Text("Please fill in a message"), message: Text("Message can't be empty!"), dismissButton: .default(Text("Sorry, jeez")))
                })
                
                Spacer()
            }
            Spacer()
        }
    }
        
//
//        HStack() {
//            VStack(alignment: .leading, spacing: 20) {
//                ZStack(alignment: .leading) {
//                    ZStack {
//                        if message.isEmpty { Text("Tap here to start typing...").foregroundColor(.white).padding(10).background(Color.black) }
//
//                        TextEditor(text: $message)
//                            .background(Color.white)
//                            .foregroundColor(Color.white)
//                            .opacity(0.6)
//                            .cornerRadius(15)
//                    }
//                  }
//
//                VStack(alignment: .leading) {
//                    Form {
//                        Text("Message will come from: ")
//                        TextField(
//                            defaults.string(forKey: "Name") ?? "Username",
//                                 text: $username
//                            ) { isEditing in
//                                self.isEditing = isEditing
//                        }.padding(10)
//                            .autocapitalization(.none)
//                            .disableAutocorrection(true)
//
//                        Toggle(isOn: $pickADate) {
//                                        Text("Select a time")
//                                    }.padding()
//
//                        if(self.pickADate){
//                            DatePicker("When do you want to it to arrive?", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
//                        }
//                    }
//
//                    }
//
//                VStack(alignment: .center, content: {
//                    ZStack {
//
                        
//                        Button(action: {
//                            if !message.isEmpty {
//                                username = defaults.string(forKey: "Name") ?? "Someone from the past"
//                                if(pickADate){
//                                    self.GiftMessageWithDate(body: message, date: selectedDate, sender: username)
//                                } else {
//                                    self.GiftMessage(body: message, sender: username)
//                                }
//
//                            } else {
//                                self.showingAlert = true
//                            }
//                        }){
////
//                        Image(systemName: "hourglass").font(.largeTitle).foregroundColor(Color("Color"))
//                        Text("Send into the future")
//                            .fontWeight(.bold)
//                            .padding()
//                            .overlay(
//                                Capsule(style: .continuous).stroke(Color.blue, style: StrokeStyle(lineWidth: 3))
//                            )
//                            .foregroundColor(.blue).font(.subheadline)
//                        Button("🚀 BLAST OFF") {
//                            if !message.isEmpty {
//                                username = defaults.string(forKey: "Name") ?? "Someone from the past"
//                                if(pickADate){
//                                    self.GiftMessageWithDate(body: message, date: selectedDate, sender: username)
//                                } else {
//                                    self.GiftMessage(body: message, sender: username)
//                                }
//
//                            } else {
//                                self.showingAlert = true
//                            }
//                        }
//                        .frame(maxWidth: .infinity, maxHeight: 75, alignment: .center)
//                        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
//                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.purple/*@END_MENU_TOKEN@*/)
//                        .cornerRadius(10)
//                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
//                        .padding(30)
//                        .alert(isPresented: $showingAlert, content: {
//                            Alert(title: Text("Please fill in a message"), message: Text("Message can't be empty!"), dismissButton: .default(Text("Sorry, jeez")))
//                        })
//                    }
//
//                })
//
//                Spacer()
//            }
//        }

    
//    .onTapGesture {
//        let keyWindow = UIApplication.shared.connectedScenes
//                           .filter({$0.activationState == .foregroundActive})
//                           .map({$0 as? UIWindowScene})
//                           .compactMap({$0})
//                           .first?.windows
//                           .filter({$0.isKeyWindow}).first
//        keyWindow!.endEditing(true)
//    }
    
    func GiftMessageWithDate(body : String, date : Date?, sender : String) {
        
        let messageGift: [String: Any] = [
            "body": body,
            "sender" : sender,
            "date" : date?.timeIntervalSinceReferenceDate ?? Date(),
            "isGift" : 1,
        ]
        
        self.convertToJSON(messageObject: messageGift)

    }
    
    func GiftMessage(body : String, sender : String) {
        
        let messageGift: [String: Any] = [
            "body": body,
            "sender" : sender,
            "date" : 0.0,
            "isGift" : 1,
        ]
        
        self.convertToJSON(messageObject: messageGift)
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func convertToJSON(messageObject: [ String: Any ]) {
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: messageObject, options: .prettyPrinted)
            let filename = "\(self.getDocumentsDirectory())/message-gift-\(self.randomString(length: 6)).yftp"
            let fileURL = URL(fileURLWithPath: filename)

            try jsonData.write(to: fileURL, options: .atomic)
            
            self.shareApp(url: fileURL)
        }
        catch{
            print("stuk")
        }
    }
    
    func getDocumentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

extension ComposeGiftView {
    func shareApp(url: URL) {
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        let viewController = Coordinator.topViewController()
        activityViewController.popoverPresentationController?.sourceView = viewController?.view
        viewController?.present(activityViewController, animated: true, completion: nil)
  }
}

struct ComposeGiftView_Previews: PreviewProvider {
    static var previews: some View {
        ComposeGiftView(viewModel : MessageContainerViewModel(), messages: Messages())
    }
}
