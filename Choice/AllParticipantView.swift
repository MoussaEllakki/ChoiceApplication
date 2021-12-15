

import SwiftUI

struct AllParticipantView: View {
    
    @ObservedObject var setAndGetData = SetAndGetData()
    
    @State var electionId = ""
    
    @State private var showRAllParticipant = true
    
    @State private var countOfParticipant = 0
    

    
    var body: some View {
        
        
        ZStack{
            
            
           BackgroundView()
            
            VStack{
                
                Spacer(minLength: 50)
                
                
                
                Text("All participant")
                
                Text("\(setAndGetData.countOfPolled) Participant have polled of \(setAndGetData.countOfparticipant)")
                    .padding(.vertical, 10.0)
                
                if (showRAllParticipant == true){
                    
                ScrollView{
                    
                
                
                        
                    
                ForEach(setAndGetData.allParticipant.indices){ index in
                    
              
                    HStack{
                        
                    Text("\(index + 1)")
                    
                    Text(setAndGetData.allParticipant[index])
                        .frame(width: 320.0, height: 35.0)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .background(Color.purple)
                        .cornerRadius(3)
                   
                    }
                    
                    
                }
                    
                    
                    
                
                }
            
                }
                
                
                VStack{
                    
                
                
                Button(action: {
                    
                    showRAllParticipant = false
                    
                 
                        
                        
                        
                    
                    
                    setAndGetData.getCountOfPolled(electionId: electionId){
                        
                    
                    setAndGetData.getAllParticiPant(electionId: electionId){
                        
                        showRAllParticipant = true

  
                    }
                    
                    }
                        
                    
                    
                }) {
                    ButtonView(buttonText: "Uppdate All Participant")
                }
                .padding(.top, 20.0)
         
                }.padding(.leading, 15)
                
                Spacer(minLength: 150)
                
            }
            
            
            
        }
        
      
        
        
        
    }
}

struct AllParticipantView_Previews: PreviewProvider {
    static var previews: some View {
        AllParticipantView()
    }
}
