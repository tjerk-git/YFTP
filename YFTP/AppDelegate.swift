import Foundation
import SwiftUI



class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
//    func application(_ application: UIApplication,
//                     open url: URL,
//                     options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
//        
//        // Determine who sent the URL.
//        let sendingAppID = options[.sourceApplication]
//        print("source application = \(sendingAppID ?? "Unknown")")
//        
//        // Process the URL.
//        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
//            //let albumPath = components.path,
//            let params = components.queryItems else {
//                print("Invalid URL or album path missing")
//                return false
//        }
//        
////        if let photoIndex = params.first(where: { $0.name == "index" })?.value {
////            print("albumPath = \(albumPath)")
////            print("photoIndex = \(photoIndex)")
////            return true
////        } else {
////            print("Photo index missing")
////            return false
////        }
//        return true
//    }
//    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        
//        guard url.pathExtension == "yftp" else { return false }
//
//        self.importJSON(url: url)
//                
//        return true
//    }
//    
//    func importJSON (url : URL) {
//        do {
//            var urlToOpen = url
//
//            if url.startAccessingSecurityScopedResource() {
//            
//                // Als nodig kopieren
//                let tmpDirURL = FileManager.default.temporaryDirectory
//                let temporaryFilename = ProcessInfo().globallyUniqueString
//                
//                let temporaryFileURL =
//                tmpDirURL.appendingPathComponent(temporaryFilename)
//
//                
//                try FileManager.default.copyItem(at: url, to: temporaryFileURL)
//
//                urlToOpen = temporaryFileURL
//                url.stopAccessingSecurityScopedResource()
//            }
//
//            let decoder = JSONDecoder()
//            let data = try Data(contentsOf: urlToOpen, options: .mappedIfSafe)
//            
//            if let message = try? decoder.decode([messageJSON].self, from: data) {
//                print ("Decoded")
//                print(message)
//                //Messages.sendMessage(message.body)
//            }
//        }
//        catch let error{
//            print (error)
//            print ("Gaat niet goed nie")
//        }
//
//    }
//    
//    private func getDocumentsDirectory() -> URL {
//        // find all possible documents directories for this user
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//
//        // just send back the first one, which ought to be the only one
//        return paths[0]
//    }
//    
//    private func writeToTempFile (data : String) -> URL {
//        let url = self.getDocumentsDirectory().appendingPathComponent("message.json")
//
//        do {
//            try data.write(to: url, atomically: true, encoding: .utf8)
//        }
//        catch {
//            
//        }
//        return url
//    }
//    
}
