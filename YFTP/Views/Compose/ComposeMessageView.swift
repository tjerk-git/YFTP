//
//  SendMessageView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 08/12/2020.
//

import SwiftUI
import AVFoundation

struct ComposeMessageView: View {
    @Binding var showModal: Bool
    @State var message: String = "Start typing here..."
    @State private var showingAlert = false
    @State private var showGif = false
    
    var viewModel : MessageContainerViewModel
    var messages : Messages
    
    var body: some View {
        HStack() {
            VStack(alignment: .center) {
                
                if(showGif == true){
                    SendingMessageView()
                }
              
                if(showGif == false){
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
              
            }
            Spacer()
        }
    }
    
    func addMessage(body : String) {
        let defaults = UserDefaults.standard
        let sender = defaults.string(forKey: "Name") ?? "You from the past"
        
        messages.sendMessage(message: body, sender: sender, isGift: 0)
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
