//
//  so01Parse.swift
//  wiDash
//
//  Created by Peter Xie on 21/10/2023.
//

import Foundation

import Combine
import Charts



class IdentifiableData: Identifiable {
    let id = UUID()
    let data: [depalData]
    
    init(data: [depalData]) {
        self.data = data
    }
}

class depalData: Identifiable{
    let date: String
    let amount: Int
    let id = UUID()
       
       init(date: String, amount: Int) {
           self.date = date
           self.amount = amount
       }
}



class so01Parse {
    

    
    
    
  
    // depal performance overview
    
    func depalPerformance (originaldata: [[String]]) -> [IdentifiableData] {
        
        var appending :[depalData] = []
        
        var parsedstorage: [IdentifiableData] = []
        
        print("This is your original data")
        
        print(originaldata)
        
        
        for element in originaldata {
            
            if element.count > 36{
                
               
                
                
         
                
               
                    // to get date and depal stat
                
                if let intValue = Int(element[36]) {
                    
                    if intValue > 0 {
                        if let date = element[1] as? String {
                            if appending.count < 4 {
                                
                                appending.append(depalData(date:date, amount: intValue))
                            }
                            else{
                                appending.append(depalData(date:date , amount: intValue))
                                parsedstorage.append(IdentifiableData(data:appending))
                                appending = []
                                
                            }
                            
                        }
                    }
                }
                
              
               
            }
        }
        
        
        print("THIS IS PARSED STORAGE")
        print(parsedstorage)
        
        
        return parsedstorage
        
    }
    
    
    // com permormance overview
    
    
    

    // performance overview //
    
    func percentagesPicking(data: [[String]]) -> [[Double]] {
        var parsedstorage: [[Double]] = []
        
        // Skip the first two rows
        for i in 2..<data.count-1 {
            var parsedDoubles: [Double] = []
            
            
            
            // Skip the first two columns
            for j in 0..<16 {
                
                if i == 2 || i == 3 {
                    continue
                }
                
                
                else{
                    
                    
                    
                    if let doubleValue = Double(data[i][j]) {
                        parsedDoubles.append(doubleValue)
                    } else {
                     
                    }
                }
            }
            
            parsedstorage.append(parsedDoubles)
        }
        
        
        
        var percentagesArray : [[Double]] = [[]]
        
        
        for array in parsedstorage {
            
            
            var appending : [Double] = []
            
            
            if array.count == 13 {
                
             
                
                let comPercent = array[3] / (array[3] + array[8])
                
                
                
                
                
                let cpsPercent = array[4] / (array[4] + array[9])
                let lpsPercent = array[5] / (array[5] + array[10])
                let aioPercent = array[6] / (array[6] + array[11])
                
                appending.append(array[0])
                appending.append(comPercent)
                appending.append(array[3])
                appending.append(cpsPercent)
                appending.append(array[4])
                appending.append(lpsPercent)
                appending.append(array[5])
                appending.append(aioPercent)
                appending.append(array[6])
                
                
  
                
                
            }
            
            percentagesArray.append(appending)
            
        }
        
        
        print("PERCENTAGES ARRAY")
        
        print(percentagesArray)
        
        
        
        print("PARSED STORAGE ARRAY")
        print(parsedstorage)
        
        
      
        
        
     
        
        
        
        
        return percentagesArray
    }
    
    
    func indexPrioDate (data:[[String]],index: Double) -> String {
        
        var prioDate:String = ""
        
        
        for element in data {
            
            if Double(element[0]) == index {
                prioDate = element[1]
                return prioDate
                
            }
            
        }
        
        
        
        
        return prioDate
        
    }
    
    
    

    
    
    
    
    
    
    
    // crane occupations //
    
    
    
    func craneOcc(data:[[String]]) -> [[String]]{
        var craneArray: [[String]] = []
        
        for i in data{
            var newArray:[String] = []
            
            if data.endIndex > 6{
                if let lastElement = i.last, lastElement.contains("All") || lastElement.contains("Module A (TCRA001-TCRA010)") || lastElement.contains("Module B (TCRA011-TCRA020)") || lastElement.contains("Module C (TCRA101-TCRA110)") || lastElement.contains("Module D (TCRA111-TCRA120)") || lastElement.contains("Module O (TCRA021-TCRA030)") || lastElement.contains("Module P (TCRA031-TCRA040)") || lastElement.contains("Module Q (TCRA121-TCRA130)") || lastElement.contains("Module R (TCRA131-TCRA140)") || lastElement.contains("ModuleGroup xLxx (TCRA001-TCRA120)") || lastElement.contains("ModuleGroup xRxx (TCRA021-TCRA140)"){
                    
                    
                    let regexPattern = "\\(([^)]+)\\)"
                    
                    
                    if lastElement.contains("(") && lastElement.contains(")") {
                        
                        do {
                            let regex = try NSRegularExpression(pattern: regexPattern)
                            let matches = regex.matches(in: lastElement, range: NSRange(lastElement.startIndex..., in: lastElement))
                            
                            
                            if let match = matches.first, let range = Range(match.range(at: 1), in: lastElement) {
                                newArray.append(String(lastElement[range]+": "))
                                
                            } else {
                                print("No match found within parentheses.")
                            }
                        } catch {
                            print("Error creating or running the regular expression: \(error)")
                        }
                    }
                    else{
                        newArray.append(String(lastElement.dropLast(1)+": "))
                    }
                    
                    
                    
                    if !i[i.count-5].isEmpty{
                        newArray.append(i[i.count-5])
                    }
                    
                    if !i[i.count-4].isEmpty{
                        newArray.append(i[i.count-4])
                    }
                    
                    if !i[i.count-3].isEmpty{
                        newArray.append(i[i.count-3])
                    }
                    
                    if ![i.count-2].isEmpty{
                        newArray.append(i[i.count-2])
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                if !newArray.isEmpty{
                    craneArray.append(newArray)
                    
                }
            }
        }
        
        
        
        
        var chanTry: [String] = []
        var locTry: [String] = []
        var chanHBW : [String] = []
        var locHBW : [String] = []
        
    
        
        for i in craneArray {
            if !i[1].contains(" "){
                locTry.append(i[0]+i[1])
            }
            if !i[2].contains(" "){
                chanTry.append(i[0]+i[2])
            }
            if !i[3].contains(" "){
                locHBW.append(i[0]+i[3])
            }
            if !i[4].contains(" "){
                chanHBW.append(i[0]+i[4])
            }
            
            
            
            
        }
        
        
        var returnArray: [[String]] = []
        
        for index in 0...2 {
            
            
            
            locHBW[index] = locHBW[index].replacingOccurrences(of: "TCRA001-TCRA120", with:  "ModuleGroup xLxx")
            locHBW[index] = locHBW[index].replacingOccurrences(of: "TCRA021-TCRA140", with:  "ModuleGroup xRxx")
            chanHBW[index] = chanHBW[index].replacingOccurrences(of: "TCRA001-TCRA120", with: "ModuleGroup xLxx")
            
            
            chanHBW[index] = chanHBW[index].replacingOccurrences(of: "TCRA021-TCRA140", with: "ModuleGroup xRxx")
            
            
            
            
            
            
            print(chanHBW[index])
            
        }
     
      
        
        
        returnArray.append(locTry)
        returnArray.append(chanTry)
        returnArray.append(locHBW)
        returnArray.append(chanHBW)
        
        
        
        
        
        return returnArray
    }
}
    
    
