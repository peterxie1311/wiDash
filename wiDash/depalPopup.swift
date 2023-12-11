import SwiftUI
import Charts

struct depalPopup: View {
    let data: [IdentifiableData]

    var body: some View {
        ScrollView {
            Text("Depal Performance Overview")
                .bold()
                .font(.system(size: 35))
                .underline(true, color: .blue)
                .padding()

            if #available(iOS 16.0, *) {
                
                    ForEach(data) { d in
                        Chart {
                        ForEach(d.data) { i in
                            BarMark(
                                x: .value("Hour", i.date),
                                y: .value("Depalletized", i.amount)
                            )
                        }
                    }
                }
            }
            
            
            LazyVStack{
                
                ForEach(data) { d in
                    
                    var counter = 0
                    
                    ForEach(d.data){ i in
                        
                        
                        
                        
                            
                            
                      
                                BubbleViewBold(
                                    text: ["Date: \(i.date)", "Amount: \(i.amount)"],
                                    font: 10,
                                    color: .blue
                                )
                    
                            
                            
                        
                        
                        
                    }
                    
                    
                    
                    
                }
                
            }
            
        }
    }
}




