//
//  SendMessageView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 08/12/2020.
//

import SwiftUI
import AVFoundation


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

let scaffold = [
    "What does your future self need to know?",
    "Any lyrics from a song that inspire you?",
    "Be your own best friend",
    "Thinking is listening to yourself",
    "What was good about today?",
    "The present can change the past and future",
    "Anything you write here is good",
    "Memory is the past guide to the future",
]


//struct MessageJSON : Codable {
//    var body : String
//    var date : Double
//    var sender : String
//    var isGift : Int
//}
  

struct ComposeMessageView: View {
    let defaults = UserDefaults.standard
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var messages = Messages.standard
    var viewModel : MessageContainerViewModel
    
    @Binding var showModal: Bool
    @State var message: String = "Start typing here..."
    @State private var showingAlert = false
    @State private var showGif = false
    @State var randomIndex = Int.random(in: 0..<scaffold.count)
    @State var scaffoldMessage: String = scaffold[Int.random(in: 0..<scaffold.count)]
    @State private var username: String = ""
    @State private var pickADate = false
    @State var selectedDate = Date()
    @State private var isSharePresented: Bool = false
    @State private var isEditing = false
    @State private var showGift = false

    
    
    var body: some View {
        
        HStack() {
            VStack(alignment: .center) {
                
                if(showGif == true){
                    SendingMessageView()
                }
              
                if(showGif == false){
                    Spacer()
                    Text("'\(scaffoldMessage)'")
                        .transition(.opacity)
                        .animation(.default)
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(hue: 0.4, saturation: 0.0, brightness: 0.764))
                        .multilineTextAlignment(.center)
                        .onReceive(timer) { input in
                            scaffoldMessage = scaffold[randomIndex]
                        }.padding(10)
                    Spacer()
                    TextEditor(text: $message)
                        .onTapGesture {
                            if (message == "Start typing here..."){
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
                        .font(.title3)
                        .background(Color("Color"))
                        .foregroundColor(Color.blue)
                        .opacity(6)
                        .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 0)
                        .cornerRadius(15)
                        .padding(10)
                    
                    Toggle("This message is a gift", isOn: $showGift).padding(10)
                        
                    if(!showGift){
                        Button(action: {
                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                            if !message.isEmpty {
                                // viewModel.messageContainerState = .sending
                                addMessage(body: message)
                                showGif = true
    
                                // go forward after x seconds
                                let _ = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false, block: { timer in
                                    showGif = false
                                    self.showModal.toggle()
                                })
                            
                                
                            } else {
                                self.showingAlert = true
                            }
                        }){
                     
                        Image(systemName: "hourglass").font(.largeTitle).foregroundColor(Color("Color"))
                        Text("Send into the future")
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

                    if showGift {
                       Toggle(isOn: $pickADate) {
                                       Text("Select a time")
                                   }.padding()

                       if(self.pickADate){
                           DatePicker("When do you want to it to arrive?", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                       }
                        
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
                    }
                }
            }
            Spacer()
        }
    }
    
    func addMessage(body : String) {
        let defaults = UserDefaults.standard
        let sender = defaults.string(forKey: "Name") ?? "You"
        
        messages.sendMessage(message: body, sender: sender, isGift: 0)
    }
    
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

extension ComposeMessageView {
    func shareApp(url: URL) {
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        let viewController = Coordinator.topViewController()
        activityViewController.popoverPresentationController?.sourceView = viewController?.view
        viewController?.present(activityViewController, animated: true, completion: nil)
  }
}





//struct ComposeMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ComposeMessageView(viewModel : MessageContainerViewModel(), messages: Messages())
//    }
//}

//extension UITextField{
//    @IBInspectable var doneAccessory: Bool{
//        get{
//            return self.doneAccessory
//        }
//        set (hasDone) {
//            if hasDone{
//                addDoneButtonOnKeyboard()
//            }
//        }
//    }
//
//    func addDoneButtonOnKeyboard()
//    {
//        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
//        doneToolbar.barStyle = .default
//
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
//
//        let items = [flexSpace, done]
//        doneToolbar.items = items
//        doneToolbar.sizeToFit()
//
//        self.inputAccessoryView = doneToolbar
//    }
//
//    @objc func doneButtonAction()
//    {
//        self.resignFirstResponder()
//    }
//}
//
//
//extension UIApplication {
//    func endEditing() {
//        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}
