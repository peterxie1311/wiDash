import SwiftUI




struct dispatchPopup: View {
    
    let data: [[String]] // Add an array property to hold the data
    let retrieval : [[String]]
    let percentage : [[String]]
    let date : String
    
    @State private var searchText = ""
    @State private var matchedIndices: [Int] = []
    
    
    
    
    // Define an initializer that accepts an array
    init(data: [[String]], percentage: [[String]],retrieval : [[String]], date : String) {
        self.data = data
        self.date = date
        self.percentage = percentage
        self.retrieval = retrieval
        
        
      
        
    }
    
    var body: some View {
        ScrollView{
            Text("Dispatch")
                .bold()
                .font(.system(size: 35))
                .underline(true, color: .blue)
                .padding()
            
            Text(date)
            
            
            // Add a search bar
            TextField("Search", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            
            
            
            VStack{
                
                Text("TU Open - Load End")
                    .bold()
                    .font(.system(size: 25))
                
                ForEach(percentage, id: \.self) { row in
                    
                    HStack{
                        
                        BubbleViewBold(text:  Array(row.prefix(2)), font: 10, color: Color.blue)
                        
                        
                        if let unwrappedString = row.last {
                            if let progress = Double(unwrappedString) {
                                DonutChartViewUnBind(progress: progress, strokeWidth: 10, strokeColor: .purple)
                            }
                        }
                        
                        
                        
                        
                    }
                    
                    
                }
                
                
            }
            
            
          
            LazyVStack {
                
                Text("Retrievals Active: ")
                    .bold()
                    .font(.system(size: 25))
                
                ForEach(0..<retrieval.count, id: \.self) { index in
                    if searchText.isEmpty || retrieval[index].joined().localizedCaseInsensitiveContains(searchText) {
                        BubbleViewBold(text: retrieval[index], font: 10, color: matchedIndices.contains(index) ? Color.yellow : Color.gray)
                    }
                }
            }
        }
        .onChange(of: searchText) { newValue in
            search(for: newValue)
        }
       
     
    }
    
    private func search(for query: String) {
        if query.isEmpty {
            matchedIndices = []
            return
        }
        
        var indices: [Int] = []
        for (index, item) in retrieval.enumerated() {
            if item.joined().localizedCaseInsensitiveContains(query) {
                indices.append(index)
            }
        }
        matchedIndices = indices
    }
}
