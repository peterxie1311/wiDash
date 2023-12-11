//
//  sdbParse.swift
//  wiDash
//
//  Created by Peter Xie on 27/10/2023.
//

import Foundation


class sdbParse{
    
    func retrival(data: [[String]]) -> [[String]]{

        var parsedData : [[String]] = []
        var moreData : [[[String]]] = []
        
        for array in data {
            if array[7] == "X" {
                parsedData.append(array)
            }
        }
        
        
        print(parsedData)
        
        for i in 0..<parsedData.count {
            
            for j in 0..<parsedData[i].count {
                let element = parsedData[i][j]
                
                if element != "" && element != " "{
                    if j==0{
                        parsedData[i][j] = "Row: " + parsedData[i][j]
                    }
                    
                    if j==1 {
                        parsedData[i][j] = "Buffer: " + parsedData[i][j]
                    }
                    
                    if j==2 {
                        parsedData[i][j] = "Load Start: " + parsedData[i][j]
                    }
                    if j==3 {
                        parsedData[i][j] = "Load End: " + parsedData[i][j]
                    }
                    if j==4 {
                        parsedData[i][j] = "Route Depart: " + parsedData[i][j]
                    }
                    if j==5 {
                        parsedData[i][j] = "Route Ref: " + parsedData[i][j]
                    }
                    if j==6 {
                        parsedData[i][j] = "Ident: " + parsedData[i][j]
                    }
                    if j==7 {
                        parsedData[i][j] = "Retr Active: " + parsedData[i][j]
                    }
                    if j==8 {
                        parsedData[i][j] = "Route Condensed: " + parsedData[i][j]
                    }
                    if j==9 {
                        parsedData[i][j] = "Buffer Allowed: " + parsedData[i][j]
                    }
                    if j==10 {
                        parsedData[i][j] = "Number of Stores: " + parsedData[i][j]
                    }
                    
                    if j==11 {
                        parsedData[i][j] = "Number of TU's: " + parsedData[i][j]
                    }
                    if j==12 {
                        parsedData[i][j] = "Tu's Open: " + parsedData[i][j]
                    }
                    if j==13 {
                        parsedData[i][j] = "Tu's in HBW: " + parsedData[i][j]
                    }
                    if j==14 {
                        parsedData[i][j] = "Tu's in Trans: " + parsedData[i][j]
                    }
                    if j==15 {
                        parsedData[i][j] = "Tu's in Buffer " + parsedData[i][j]
                    }
                    if j==16 {
                        parsedData[i][j] = "TU's on Lane: " + parsedData[i][j]
                    }
                    if j==17 {
                        parsedData[i][j] = "Tu's on Loc: " + parsedData[i][j]
                    }
                    if j==18 {
                        parsedData[i][j] = "Tu's Desp: " + parsedData[i][j]
                    }
                    if j==19 {
                        parsedData[i][j] = "COM #TU open: " + parsedData[i][j]
                    }
                    if j==20 {
                        parsedData[i][j] = "AIO #TU open: " + parsedData[i][j]
                    }
                    if j==21 {
                        parsedData[i][j] = "CPS #TU open: " + parsedData[i][j]
                    }
                    if j==22 {
                        parsedData[i][j] = "DG1 #TU open: " + parsedData[i][j]
                    }
                    if j==23 {
                        parsedData[i][j] = "PSM #TU open: " + parsedData[i][j]
                    }
                    if j==24 {
                        parsedData[i][j] = "FULL #TU open: " + parsedData[i][j]
                    }
                    if j==25 {
                        parsedData[i][j] = "LAY #TU open: " + parsedData[i][j]
                    }
                    if j==26 {
                        parsedData[i][j] = "Free Lane Cap: " + parsedData[i][j]
                    }
                    if j==27 {
                        parsedData[i][j] = "Planned Lanes: " + parsedData[i][j]
                    }
                    if j==28 {
                        parsedData[i][j] = "Dock: " + parsedData[i][j]
                    }
                    if j==29 {
                        parsedData[i][j] = "Block Reason: " + parsedData[i][j]
                    }
                    if j==30 {
                        parsedData[i][j] = "Reason for Last Block: " + parsedData[i][j]
                    }
                    if j==31 {
                        parsedData[i][j] = "Planned Outfeed: " + parsedData[i][j]
                    }
                    if j==32 {
                        parsedData[i][j] = "Outfeed in Use: " + parsedData[i][j]
                    }
                    
                
                
                    
                    
                    
                    
                    
                }
            }
            
            
            
        }
        
        
        
   
        return parsedData
    }
    
    func sortPercentageTime(percentageTime: [[String]]) -> [[String]] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        let sortedPercentageTime = percentageTime.sorted { (first, second) in
            if first.count >= 1 && second.count >= 1 {
                if let date1 = dateFormatter.date(from: first[0]),
                   let date2 = dateFormatter.date(from: second[0]) {
                    return date1 < date2
                }
            }
            return false // If parsing fails, maintain the original order
        }
        
        return sortedPercentageTime
    }

    
    
    func percentageGetter (data:[[String]]) -> [[String]] {
        
        var parsedData : [[String]] = []
        
        var times : [String] = []
        
        for array in data {
            times.append(array[4])
        }
        
        let uniqueTimes = Array(Set(times))
        
        var percentageTime : [[String]] = []
        
      
        
        
        for time in uniqueTimes {
            
            var tus : Double = 0
            var tusOpen : Double = 0
            
            
            for array in data {
              
                
                
                if array[4] == time {
                                if let tusValue = Double(array[11]) {
                                    
                                    tus += tusValue
                                }
                                if let tusOpenValue = Double(array[12]) {
                                    tusOpen += tusOpenValue
                                }
                            }
                
            }
            
            var percentNumber : [String] = []
            
            let percent : Double = tusOpen / tus
            
            
            
            
            
            if tusOpen != 0.0 {
                percentNumber.append(time)
                percentNumber.append("TU's Open: \(tusOpen)")
                percentNumber.append(String(percent))
                percentageTime.append(percentNumber)
                
            }
        }
        
        
        
        
        
        
        print("This is your times")
        print(percentageTime)
        
        
        

        
        
        
        return  sortPercentageTime(percentageTime:percentageTime)
        
        
    }
    
    
    func nullRemover (data: [[String]]) -> [[String]]{
        var parsedData : [[String]] = []
        
        
        for array in data {
            parsedData.append(array.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty })
        }
        
        
        return parsedData
    }
    
    
    
    
    
    func sdbSort(data: [[String]]) -> [[String]] {
        
        var parsedData: [[String]] = []
        
        
        for i in 0..<data.count-1 {
            
            var appending : [String] = []
            
                if let dataFirstValue = Int(data[i][0]), dataFirstValue != 0 {

                    for j in 0..<data[i].count-1 {
                        if j < 33 {
                            appending.append(data[i][j])
                        }
                    }
                    
                    
                    
                    
                } else {
                    print("CANNOT CONVERT TO INT SDB ERROR")
                }
                
            
            if appending != [] {
                parsedData.append(appending)
            }
        }
        
        
        print("THIS IS YOUR SDB DATA")
        print(parsedData)
        
        
        return parsedData
    }
    
}
