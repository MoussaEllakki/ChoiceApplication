

import SwiftUI

struct AllParticipantView: View {
    
    @State var setAndGetData = SetAndGetData()
    
    var body: some View {
        
        
        ZStack{
            
            
           BackgroundView()
            
            VStack{
                
                Spacer()
                
                Text("All participant")
                
                Text("is \(setAndGetData.countOfPolled)")
                
                ScrollView{
                    
                
                
                ForEach(setAndGetData.allParticipant.indices){ index in
                    
                    
                    
                    Text(setAndGetData.allParticipant[index])
                        .frame(width: 350.0, height: 35.0)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    
                    
                    
                }
                
                }
            
                Spacer(minLength: 300)
                
            }
            
            
            
        }
        
      
        
        
        
    }
}

struct AllParticipantView_Previews: PreviewProvider {
    static var previews: some View {
        AllParticipantView()
    }
}
