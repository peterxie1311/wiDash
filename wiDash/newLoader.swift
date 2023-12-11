//
//  newLoader.swift
//  wiDash
//
//  Created by Peter Xie on 20/10/2023.
//


   
import Foundation
import Combine


class newLoader : ObservableObject {
    
    @Published var data: [[String]] = [[]]
    @Published var date: String = ""
    var report: String = ""
    
    
    
    
    private func search(imap: MCOIMAPSession,report: String ,completion: @escaping (MCOIndexSet?) -> Void) {
        let subjectCriteria = MCOIMAPSearchExpression.searchSubject(report)
        let bodyCriteria = MCOIMAPSearchExpression.searchContent(report)
        let searchExpression = MCOIMAPSearchExpression.searchOr(subjectCriteria, other: bodyCriteria)
        
       // print("Enting search")

        if let searchOperation = imap.searchExpressionOperation(withFolder: "INBOX", expression: searchExpression) {
            searchOperation.start { error, result in
                if let error = error {
                    print("Error searching emails: \(error.localizedDescription)")
                    completion(nil) // Notify completion with nil result in case of an error
                } else if let result = result as? MCOIndexSet {
                  //  print("Search results: \(result)")
                    completion(result) // Notify completion with the search result
                }
            }
        } else {
            completion(nil) // Notify completion with nil result if the search operation couldn't be created
        }
    }
    
    
    func getMostRecentEmailUID(indexSet: MCOIndexSet) -> UInt32 {
        // Convert the MCOIndexSet to an array of integers
        var mostRecentUID: UInt64 = 0
        
        
        indexSet.enumerate { uid in
               if uid > mostRecentUID {
                   mostRecentUID = uid
               }
           }
        
   
        
        
        let nullPointer = UInt32(0)
        
        
      
        if mostRecentUID <= UInt64(UInt32.max) {
            let uint32Value = UInt32(mostRecentUID)
            return uint32Value
            // Now, uint32Value contains the casted value
           // print(uint32Value)
        } else {
            // Handle the overflow case here
            print("Overflow: Cannot cast UInt64 to UInt32 without losing data.")
        }
        
    
       return nullPointer
    }
    
    func getDate(imap: MCOIMAPSession, forUID uid: UInt32, completion: @escaping (String?) -> Void) {
        let fetchOperation = imap.fetchMessageOperation(withFolder: "INBOX", uid: uid)

        fetchOperation?.start { error, data in
            if let error = error {
                print("Error fetching email: \(error.localizedDescription)")
                completion(nil)
                return
            }

            if let data = data {
                if let dateString = String(data: data, encoding: .utf8) {
                  //  print(dateString)

                    let pattern = "Date:.*"
                    do {
                        let regex = try NSRegularExpression(pattern: pattern, options: [])
                        if let match = regex.firstMatch(in: dateString, options: [], range: NSRange(location: 0, length: dateString.utf8.count)) {
                            if let range = Range(match.range, in: dateString) {
                                let extractedText = String(dateString[range])
                               // print(extractedText)
                                completion(extractedText) // Return the extracted text using the completion handler
                            }
                        } else {
                            print("No match found.")
                            completion(nil) // Notify that no match was found
                        }
                    } catch {
                        print("Error creating or using the regular expression: \(error)")
                        completion(nil) // Notify of an error
                    }
                } else {
                    completion(nil) // Notify of decoding error
                }
            } else {
                completion(nil) // Notify of a data error
            }
        }
    }

    
    
    func downloadAttachment(imap: MCOIMAPSession, forUID uid: UInt32, completion: @escaping (String?) -> Void){
        
        let folder = "INBOX" // The folder where the email is located.
        
        
        
        
        let attachmentOperation = imap.fetchMessageAttachmentOperation(withFolder: "INBOX", uid: uid, partID: "2", encoding: MCOEncoding.encodingBase64)
        
        
        attachmentOperation?.start{
            error, attachment in
            
            if let error = error {
                print("Error fetching email: \(error.localizedDescription)")
                return
            }
            
            else{
                
                
                
                if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    
                    
                    let randomString = UUID().uuidString
                    
                    let attachmentFilename = self.report + randomString
                    let fileURL = documentsDirectory.appendingPathComponent(attachmentFilename)
                    
                    if FileManager.default.fileExists(atPath: fileURL.path) {
                        do {
                            // If a file with the same name exists, remove it first
                            try FileManager.default.removeItem(at: fileURL)
                            
                         //   print("removed!")
                        } catch {
                            print("Error removing existing file: \(error.localizedDescription)")
                        }
                    }
                    
                    do {
                        try attachment!.write(to: fileURL)
                        print("Attachment saved to: \(fileURL.path)")
                        completion(fileURL.absoluteString)
                    } catch {
                        print("Error saving attachment: \(error.localizedDescription)")
                    }
                }
                
                
                
            }
            
            
            
            
        }
            
        }
    
    
    
    func csvParse(String url: String) -> [[String]]{
        var parsedData: [[String]] = []
        
    //    print("csv parsing")
      

           do {
               let csvData = try String(contentsOfFile: url, encoding: .windowsCP1252)
               let rows = csvData.components(separatedBy: "\n")
               
               
               for row in rows {
            
                   
                   
                   let columns = row.components(separatedBy: ";")
           
                   parsedData.append(columns)
               }
               
           } catch {
               print("Error reading CSV file: \(error)")
           }
        
        return parsedData
    }
    
    
    
    typealias SearchCompletion = (MCOIndexSet?) -> Void
       typealias DateCompletion = (String?) -> Void
       typealias AttachmentCompletion = (String?) -> Void
    
    
    
    func initialize(report: String, completion: @escaping () -> Void) {
        
        let fromEmail = "witrondashboard@gmail.com"
        let fromName = "pdawg"
        let toEmail = "witrondashboard@gmail.com"
        let password = "uopkwapubpzkotyh"
        let session = MCOIMAPSession()
        
        session.isVoIPEnabled = false
        session.hostname = "imap.gmail.com"
        session.port = 993
        session.username = fromEmail
        session.password = password
        session.connectionType = .TLS
        
      //  print("I AM INITIALISED ")
        
        self.report =  report
        
        
        search(imap: session, report: report){ result in
            if let result = result {
               // print("Received search result: \(result)")
                let stuff : UInt32 = self.getMostRecentEmailUID(indexSet: result)
               // print(type(of: result))
                
                self.getDate(imap: session, forUID: stuff){date in
                    if let text = date {
                        self.date = text
                    }
                    else {
                     //   print("ERROR OCCURED GETTING DATE")
                    }
                }
                
                
                self.downloadAttachment(imap: session, forUID: stuff){ csv in
                    
                    if let csv = csv {
                        let csvurl = String(csv.dropFirst(7))
                    
                        
                        self.data = self.csvParse(String: csvurl)
                     //   print("THIS IS YOUR DATA")
                     //   print(self.data)
                        
                        completion()
 
                        
                    }
                    
                    
                    
                }
                
                
                
                
            }
            
        }
        

        
    }
    
    
    
}
