import SwiftUI

struct MissingStockItem: Identifiable {
    let id = UUID()
    let content: [String]
}


struct wp02Popup: View {
    let data: [[String]]
    let percentage: [[String]]
    let date: String
    let missingStock: [MissingStockItem]
    
    @State private var searchText = ""
    @State private var matchedIndices: [Int] = []
    @State private var currentIndex = 0

    init(data: [[String]], date: String, percentage: [[String]], missingStock: [MissingStockItem]) {
        self.missingStock = missingStock
        self.date = date
        self.data = data
        self.percentage = percentage
    }
    
    var body: some View {
        ScrollView {
            Text("Wp02")
                .bold()
                .font(.system(size: 35))
                .underline(true, color: .blue)
                .padding()
            Text(date)
            
            // Add a search bar
            TextField("Search", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            VStack {
                Text("Missing Stock - Prio Date")
                    .bold()
                    .font(.system(size: 25))
                
                ForEach(percentage, id: \.self) { row in
                    HStack {
                        BubbleViewBold(text: Array(row.prefix(row.count-1)), font: 10, color: Color.blue)
                        if let unwrappedString = row.last {
                            if let progress = Double(unwrappedString) {
                                DonutChartViewUnBind(progress: progress, strokeWidth: 10, strokeColor: .purple)
                            }
                        }
                    }
                }
            }

            LazyVStack {
                ForEach(0..<missingStock.count, id: \.self) { index in
                    if searchText.isEmpty || missingStock[index].content.joined().localizedCaseInsensitiveContains(searchText) {
                        BubbleViewBold(text: missingStock[index].content, font: 10, color: matchedIndices.contains(index) ? Color.yellow : Color.gray)
                    }
                }
            }
        }
        .onChange(of: searchText) { newValue in
            search(for: newValue)
        }
        .onChange(of: matchedIndices) { newValue in
            currentIndex = newValue.first ?? 0
        }
    }

    // Function to perform the search
    private func search(for query: String) {
        if query.isEmpty {
            matchedIndices = []
            return
        }
        
        var indices: [Int] = []
        for (index, item) in missingStock.enumerated() {
            if item.content.joined().localizedCaseInsensitiveContains(query) {
                indices.append(index)
            }
        }
        matchedIndices = indices
    }
}
