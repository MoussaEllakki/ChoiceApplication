

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
                    .font(.largeTitle)
                
             
                
                     if (showRAllParticipant == true){
                         
                       
                         ScrollView{
                       
                         
                         
                             Text("\(setAndGetData.allParticipant.count) Participant have polled of \(setAndGetData.countOfparticipant)")
                             .padding(.vertical, 10.0)
                     
                      
                             
                         
                             
                         
                             
                             ForEach(setAndGetData.allParticipant, id : \.self) { participant in
                             
                             
                                 Text(participant)
                                     .frame(width: 300, height: 30)
              
                                     .background(Color.white)
                                     .cornerRadius(10)
                                 
                             }
                         
                   
                      
                         
                         
                     
                         
                         
                         
                     
                         }
                 
                     
                     }
                
            
                
                Spacer(minLength: 150)
                
            }.onAppear(perform: {
                
                showRAllParticipant = false
                
                setAndGetData.getCountOfParticipant(electionId: electionId){
                  
                    setAndGetData.getAllParticiPant(electionId: electionId){
                        
                        showRAllParticipant = true
                        
                    }
                    
                }
           
                
                
            })
            
            
            
        }
        
      
        
        
        
    }
}

struct AllParticipantView_Previews: PreviewProvider {
    static var previews: some View {
        AllParticipantView()
    }
}
