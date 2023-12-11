import SwiftUI







struct ContentView: View {
    
    
    @StateObject var so01View = newLoader()
    @StateObject var dispatchView = newLoader()
    @StateObject var wp02View = newLoader()
    
    
    @State private var so01Date : String = ""
    @State private var dispatchDate : String = ""
    @State private var wp02Date : String = ""
    
    
    
    
    
    
    
    
    @State private var wp02Data : [[String]] = []
    @State private var wp02MissingStock :[MissingStockItem] = []
    @State private var isRefreshing = false
    @State private var sdbData : [[String]] = []
    @State private var craneOcc = [[""]]
    @State private var sdbRetrieval : [[String]] = []
    @State private var sdbPercentage : [[String]] = []
    @State private var wp02Percentage : [[String]] = []
    @State private var locationD : Double = 0
    @State private var channelD : Double = 0
    @State private var performacePercentage : [[Double]] = [[]]
    @State private var dispatchShowingPopup = false
    @State private var wp02ShowingPopup = false
    @State private var depalShowingPopup = false
    @State private var depalData : [IdentifiableData] = []
    
    

    
    
    var body: some View {
        NavigationView {
            if #available(iOS 15.0, *) {
                ScrollView {
                    Text("wiDash")
                        .bold()
                        .font(.system(size: 35))
                        .underline(true, color: .blue)
                        .padding()
                        .gesture(
                            DragGesture().onChanged { value in
                                if value.translation.height > 50 && !isRefreshing {
                                    isRefreshing = true
                                    refreshAction()
                                }
                            }
                        )
                    Spacer(minLength: 50)
                    
                    
                    
                    
                    Text(so01Date)
                    
                    
                  
                    
                    if craneOcc != [[""]]{
                        
                        VStack{
                            Text("Highbay Crane Occupancy:")
                                .bold()
                                .font(.system(size: 25))
                            
                            
                            
                        }
                        
                        //------ Channel ------//
                        
                        
                        HStack { // Use HStack to align views side by side
                            // First DonutChartView with BubbleView
                            VStack {
                                BubbleView(text: ["Location %"], font: 15, color: Color.gray)
                                DonutChartView(progress: $channelD, strokeWidth: 10, strokeColor: .green)
                            }
                            
                            // Second DonutChartView with BubbleView
                            VStack {
                                BubbleView(text: ["Channel %"], font: 15, color: Color.gray)
                                DonutChartView(progress: $locationD, strokeWidth: 10, strokeColor: .green)
                            }
                        }
                        
       
                      
                        
                       
                        
                        
                        
                        
                    }
                    
                    if performacePercentage != [[]] {
                        
                   
                        
                        VStack{
                            
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            
                            
                            
                            Text("Dock Due Times:")
                                .bold()
                                .font(.system(size: 30))
                                .underline(true, color: .blue)
                               
                            
                            Spacer()
                            Spacer()
                          
                            
                            
                            ForEach(0..<performacePercentage.count, id:\.self){ index in
                                let percentages = performacePercentage[index]
                                
                                if percentages.count >= 8 {
                                    
                                    let date = so01Parse().indexPrioDate(data: so01View.data, index: percentages[0])
                                    let comPercent =  percentages[1]
                                    let comNumber = percentages[2]
                                    let cpsPercent =  percentages[3]
                                    let cpsNumber = percentages[4]
                                    let lpsPercent =  percentages[5]
                                    let lpsNumber = percentages[6]
                                    let aioPercent =  percentages[7]
                                    let aioNumber = percentages[8]
                                    
                                    
                                    
                                    
                                    
                                    VStack{
                                        
                                        if !comPercent.isNaN &&  comPercent != 0 || !cpsPercent.isNaN &&  cpsPercent != 0 || !lpsPercent.isNaN &&  lpsPercent != 0 || !aioPercent.isNaN &&  aioPercent != 0
                                        {
                                            Spacer()
                                            Spacer()
                                            Text(date)
                                                .font(.system(size: 20, weight: .bold))
                                                
                                            
                                            
                                            Spacer()
                                            Spacer()
   
                                        }
                                        
                                        HStack{
                                            
                                            
                                            
                                            if !comPercent.isNaN &&  comPercent != 0 {
                                                Spacer()
                                                
                                                VStack{
                                                
                                                    BubbleViewBold(text: ["COM"], font: 15, color: Color.purple)
                                                    DonutChartViewUnBind(progress: comPercent, strokeWidth: 10, strokeColor: .purple)
                                                    BubbleViewBold(text: [String(format: "%.0f",comNumber)], font: 15, color: Color.purple)
                                                    
                                                  
                                              
       
                                                    
                                                }
                                                
                                                Spacer()
 
                                            }
                                            
                                    
                                            
                                            if !cpsPercent.isNaN &&  cpsPercent != 0 {
                                                Spacer()
                                                
                                                VStack{
                                                
                                                    BubbleViewBold(text: ["CPS"], font: 15, color: Color.orange)
                                                    DonutChartViewUnBind(progress: cpsPercent, strokeWidth: 10, strokeColor: .orange)
                                                    BubbleViewBold(text: [String(format: "%.0f",cpsNumber)], font: 15, color: Color.orange)
                                                    
       
                                                    
                                                }
                                                
                                                Spacer()
 
                                            }
                                            
                                       
                                            
                                            if !lpsPercent.isNaN &&  lpsPercent != 0 {
                                                Spacer()
                                                
                                                VStack{
                                                
                                                    BubbleViewBold(text: ["LPS"], font: 15, color: Color.red)
                                                    DonutChartViewUnBind(progress: lpsPercent, strokeWidth: 10, strokeColor: .red)
                                                    BubbleViewBold(text: [String(format: "%.0f",lpsNumber)], font: 15, color: Color.red)
       
                                                    
                                                }
                                                
                                                Spacer()
 
                                            }
                                     
                                            
                                            if !aioPercent.isNaN &&  aioPercent != 0 {
                                                Spacer()
                                                
                                                VStack{
                                                
                                                    BubbleViewBold(text: ["AIO"], font: 15, color: Color.brown)
                                                    DonutChartViewUnBind(progress: comPercent, strokeWidth: 10, strokeColor: .brown)
                                                    BubbleViewBold(text: [String(format: "%.0f",aioNumber)], font: 15, color: Color.brown)
       
                                                    
                                                }
                                                
                                                Spacer()
 
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    Spacer()
                    
                    
                    
                        HStack{
                            Button("Dispatch Retrievals"){
                                dispatchShowingPopup.toggle()
                            }
                            .popover(isPresented: $dispatchShowingPopup){
                                
                                dispatchPopup(data: sdbData,percentage: self.sdbPercentage , retrieval: self.sdbRetrieval , date: dispatchDate )
                            
                            }
                            
                            Button("Wp02"){
                                wp02ShowingPopup.toggle()
                            }
                            .popover(isPresented: $wp02ShowingPopup){
                                
                               wp02Popup(data: wp02Data, date: wp02Date, percentage: wp02Percentage , missingStock: wp02MissingStock )
                            
                            }
                            Button("Depal Performance Overview"){
                                depalShowingPopup.toggle()
                            }
                            .popover(isPresented: $depalShowingPopup){
                                
                               depalPopup(data: depalData)
                            
                            }
                        }
                        
   
                    
                    
                    
                    
                    
                    
                }
                .refreshable {
                    refreshAction()
                }
            } else {
                Text("PLEASE UPGRADE IOS 15>")
            }
        }
    }
    
    func refreshAction() {
       
        
        wp02View.initialize(report: "wp02"){
            self.wp02Data=wp02Parse().wp02Sort(data: self.wp02View.data)
            self.wp02Percentage = wp02Parse().percentages(data: self.wp02Data)
            self.wp02Date = wp02View.date
            
            
            
            
            
            
            var missingStockItems: [MissingStockItem] = []
            for item in wp02Parse().indexer(data: self.wp02Data) {
                let missingStockItem = MissingStockItem(content: item)
                missingStockItems.append(missingStockItem)
            }
            
            self.wp02MissingStock = missingStockItems
            
            
        }
        
        
        so01View.initialize(report: "SO01") {
            
            self.craneOcc = so01Parse().craneOcc(data: self.so01View.data)
            self.performacePercentage = so01Parse().percentagesPicking(data: so01View.data)
            self.so01Date = so01View.date
            
            self.depalData = so01Parse().depalPerformance(originaldata: self.so01View.data)
            
            
            
            
            // ------ setting so01 ------ ///
            
            let channel = craneOcc[craneOcc.count-1][0]
            let location = craneOcc[craneOcc.count-2][0]
            
            let scanner = Scanner(string: channel)
            scanner.scanUpToCharacters(from: .decimalDigits, into: nil)
            scanner.scanDouble(&channelD)
            let scanner1 = Scanner(string: location)
            scanner1.scanUpToCharacters(from: .decimalDigits, into: nil)
            scanner1.scanDouble(&locationD)
            
            
            channelD = channelD/100
            locationD = locationD/100
            
            
            
            //------ production stats ------- //
            

            
            //------- production stats -------//

            
            // ---------  END ------- //
            
   
           
        }
        // ------ SDB STUFF ------- //
        dispatchView.initialize(report: "sdb04"){
            self.sdbData = sdbParse().sdbSort(data: dispatchView.data)
            self.sdbPercentage = sdbParse().percentageGetter(data: self.sdbData)
            self.sdbRetrieval = sdbParse().nullRemover( data: sdbParse().retrival(data: self.sdbData))
            self.dispatchDate = dispatchView.date
            
            
        }
        
        // ------- SDB STUFF  ------ //
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // After refreshing, reset the isRefreshing flag
            isRefreshing = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
