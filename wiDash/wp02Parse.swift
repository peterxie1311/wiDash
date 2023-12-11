//
//  wp02Parse.swift
//  wiDash
//
//  Created by Peter Xie on 28/10/2023.
//
// 0. row
// 1. no stock host
// 2. last request host
// 3. no stock
// 4. last request
// 5. host
// 6. man can cel req.
// 7. man spl it req.
// 8. no stock coral
// 9. m i s s i n g
// 10. m i s s i n g (Sum)
// 11. order start mode *
// 12. prio date actual
// 13. rouRef
// 14. profile key
// 15. wh area
// 16. strat sub *
// 17. disp strat
// 18. cust omer
// 19. o w n e r
// 20. product
// 21. um product description
// 22. hard break SKU *
// 23. hard break order line *
// 24. order key
// 25. prepick tu ident
// 26. prepick tu nveNo
// 27. prepick tu type
// 28. prepick tu state
// 29. prepick wh
// 30. prepick oh
// 31. prepick state
// 32. sap plant
// 33. sap wh
// 34. tu ident tray
// 35. tu coord tray
// 36. qState
// 37. stock strategy order line
// 38. stock strategy product
// 39. qty pick area
// 40. repl single total
// 41. tray loa ding ac tive
// 42. qty coral
// 43. qty blo ck ed hCom *
// 44. qty blo ck ed stock *
// 45. qty blo cked loc *
// 46. qty blo cked tu err *
// 47. qty blocked instr *
// 48. qty blocked sum *
// 49. qty res erv ed
// 50. qty or der ed
// 51. qty res erv ed prio
// 52. qty HBW L1
// 53. qty HBW L2
// 54. qty HBW blo cked L1
// 55. qty HBW blo cked L2
// 56. qty diff: HBW - miss ed
// 57. depal mode
// 58. ws type
// 59. r e p l
// 60. repl type
// 61. repl age [min]
// 62. repl prio
// 63. repl prio sub
// 64. repl state
// 65. repl error
// 66. repl tu ident *
// 67. repl cases *
// 68. repl dest *
// 69. repl coord
// 70. max tu age [h] *
// 71. all ow all oc sin gle
// 72. in bou nd fini shed
// 73. do not wait for stock
// 74. pen ding shor tage
// 75. wo le vel
// 76. cu st le vel
// 77. pi ck le vel
// 78. for ced le vel
// 79. co ral use all le vel
// 80. all ow pal let spl it
// 81. storage restriction *
// 82. repl flag *
// 83. del flag *
// 84. prod group
// 85. product group description
// 86. route
// 87. route info prj
// 88. prod class
// 89. prod set
// 90. prod set reason
// 91. order head
// 92. source tu ident
// 93. pr io
// 94. ol pr io
// 95. calc prio date
// 96. calc preview date
// 97. cohd act next proc date
// 98. pallet
// 99. work order
// 100. pick type
// 101. Cases on way to HBW
// 102. Cases on way to TRY
// 103. Cases Dep
// 104. ohRef
// 105. olRef
// 106. cpvRef
// 107. cpvrRef
// 108. cpvr info
// 109. co ra l



import Foundation

class wp02Parse {
    
    
    func indexer (data: [[String]]) -> [[String]]{
        var parsedData : [[String]] = []
        
        
        print("this is array [i]")
        
        for array in data{
            
            var data : [String] = []
            
            for i in 0..<array.count {
                
                let element = array[i]
                
                
                if element != "" && element != " "{
                    
                    if i==0{
                        data.append("No Stock: " + array[i])
                    }
                    if i==1{
                        data.append("Man Cancel Req: " + array[i])
                    }
                    if i==2{
                        data.append("Missing: " + array[i])
                    }
                    if i==3{
                        data.append("Missing (Sum): " + array[i])
                    }
                    if i==4{
                        data.append("Prio Date: " + array[i])
                    }
                    if i==5{
                        data.append("Route Ref: " + array[i])
                    }
                    if i==6{
                        data.append("UM #: " + array[i])
                    }
                    if i==7{
                        data.append("Product: " + array[i])
                    }
                    if i==8{
                        data.append("TU: " + array[i])
                    }
                    if i==9{
                        data.append("QTY Coral: " + array[i])
                    }
                    if i==10{
                        data.append("QTY Blocked Stock: " + array[i])
                    }
                    if i==11{
                        data.append("QTY Blocked Loc: " + array[i])
                    }
                    if i==12{
                        data.append("QTY Blocked TU Error: " + array[i])
                    }
                    if i==13{
                        data.append("QTY Blocked Instr: " + array[i])
                    }
                    if i==14{
                        data.append("Repl Type: " + array[i])
                    }
                    if i==15{
                        data.append("Repl Prio Sub: " + array[i])
                    }
                    if i==16{
                        data.append("Repl Error: " + array[i])
                    }
                    if i==17{
                        data.append("Repl Dest: " + array[i])
                    }
                    
                    
                }
                
            }
            
            
            if data != [] {
                parsedData.append(data)
            }
            
        }
        
        if !parsedData.isEmpty {
            parsedData.removeFirst()
        }
        
        print("THIS IS YOUR PARSED DATA LOLOLOL")
        
        print(parsedData)
        
        
        return parsedData
    }
    
    
    func percentages(data: [[String]]) -> [[String]]{
        
        var parsedData :[[String]] = []
        var times : [String] = []
        
        
    
        for array in data{
            times.append(array[4])
        }
        
        let uniqueTimes = Array(Set(times))
        
        for time in uniqueTimes {
            
            var missing : Double = 0
            var missingSum : Double = 0
            
            
            for array in data {
              
                
                
                if array[4] == time {
                                if let missingS = Double(array[3]) {
                                    
                                    
                                    missingSum += missingS
                                }
                                if let missingSingle = Double(array[2]) {
                                    missing += missingSingle
                                }
                            }
                
            }
            
            var percentNumber : [String] = []
            
            let percent : Double = missing / missingSum
            
            
            
            
            
            if missing != 0.0 {
                percentNumber.append(time)
                percentNumber.append("Missing Cases: \(missing)")
                percentNumber.append(String(percent))
                parsedData.append(percentNumber)
                
            }
        }
        
        
        
        print("THIS IS WP02 PARSED DATA")
        print(parsedData)
        
        return parsedData
    }
    
    
    
    func wp02Sort(data: [[String]]) -> [[String]] {
        
        var parsedData : [[String]] = []
        
        for array in data {
            
            var appending : [String] = []
            
            if array.count >= 67 {
                
                appending.append(array[3])
                appending.append(array[4])
                appending.append(array[7])
                appending.append(array[8])
                appending.append(array[10])
                appending.append(array[11])
                appending.append(array[20])
                appending.append(array[21])
                appending.append(array[34])
                appending.append(array[41])
                appending.append(array[43])
                appending.append(array[44])
                appending.append(array[45])
                appending.append(array[46])
                appending.append(array[59])
                appending.append(array[62])
                appending.append(array[64])
                appending.append(array[67])
                
                
            }
            
            if appending.count>0 {
                parsedData.append(appending)
            }
            
            
        }
    
        
        
        
        
        return parsedData
    }
    
}
