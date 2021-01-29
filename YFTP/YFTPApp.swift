//
//  YFTPApp.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 05/12/2020.
//

import SwiftUI
import UserNotifications

struct messageJSON : Codable {
    var body : String
    var sender : String
    var date : Double
}

@main
struct YFTPApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject var messages = Messages()
    @State var showingDetail : Bool = false
    @State var receivedMessage = ""
    @State var sender = ""
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(messages)
                .onOpenURL { url in
                    self.importJSON(url: url)
                    //self.downloadJSONFromScheme(url : url)
                }.sheet(isPresented: $showingDetail) {
                    MessageReceivedView(showingDetail: $showingDetail, message: receivedMessage, sender: sender)
                }
    
        }
    }
    
//    func downloadJSONFromScheme( url : URL){
//
//        let downloadTask = URLSession.shared.downloadTask(with: url) {
//            urlOrNil, responseOrNil, errorOrNil in
//            // check for and handle errors:
//            // * errorOrNil should be nil
//            // * responseOrNil should be an HTTPURLResponse with statusCode in 200..<299
//
//            guard let fileURL = urlOrNil else { return }
//            do {
//                let documentsURL = try
//                    FileManager.default.url(for: .documentDirectory,
//                                            in: .userDomainMask,
//                                            appropriateFor: nil,
//                                            create: false)
//                let savedURL = documentsURL.appendingPathComponent(fileURL.lastPathComponent)
//                try FileManager.default.moveItem(at: fileURL, to: savedURL)
//            } catch {
//                print ("file error: \(error)")
//            }
//        }
//
//        downloadTask.resume()
//    }
//
    
    func importJSON (url : URL) {
        do {
            var urlToOpen = url
            if url.startAccessingSecurityScopedResource() {
            
                // Als nodig kopieren
                let tmpDirURL = FileManager.default.temporaryDirectory
                let temporaryFilename = ProcessInfo().globallyUniqueString
                
                let temporaryFileURL =
                tmpDirURL.appendingPathComponent(temporaryFilename)

                try FileManager.default.copyItem(at: url, to: temporaryFileURL)

                urlToOpen = temporaryFileURL
                url.stopAccessingSecurityScopedResource()
            }

            let decoder = JSONDecoder()
            let data = try Data(contentsOf: urlToOpen, options: .mappedIfSafe)
            
            if let message = try? decoder.decode(messageJSON.self, from: data) {
                receivedMessage = message.body
                sender = message.sender
                let gift = 1

                if(message.date != 0.0){
                    let convertedDate = Date(timeIntervalSinceReferenceDate: message.date)
                    messages.sendMessageWithDate(message: message.body, sender: message.sender, sendDate: convertedDate, isGift: gift)
                }
                
                messages.sendMessage(message: message.body, sender: sender, isGift: gift)
                showingDetail = true
            }
        }
        catch let error{
            print (error)
            print ("Gaat niet goed nie")
        }

    }
    
    private func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    private func writeToTempFile (data : String) -> URL {
        let url = self.getDocumentsDirectory().appendingPathComponent("message.json")

        do {
            try data.write(to: url, atomically: true, encoding: .utf8)
        }
        catch {
            
        }
        return url
    }
    

}
