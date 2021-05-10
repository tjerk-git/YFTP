//
//  YFTPApp.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 05/12/2020.
//

import SwiftUI

struct messageJSON : Codable {
    var body : String
    var sender : String
    var date : Double
}

@main
struct YFTPApp: App {

    var messages = Messages.standard
    
    @State var showingDetail : Bool = false
    @State var receivedMessage = ""
    @State var sender = ""
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onOpenURL { url in
                    self.importJSON(url: url)
                }.sheet(isPresented: $showingDetail) {
                    MessageReceivedView(showingDetail: $showingDetail, message: receivedMessage, sender: sender)
                }
    
        }
    }

    
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

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
