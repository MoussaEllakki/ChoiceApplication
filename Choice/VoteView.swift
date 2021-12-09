
import SwiftUI

struct VoteView: View {
    

    
    @State private var isVotet = false
    
    @State private var whichChoice  = -10
    
    @State private var whichColor = Color.red
    
    @State  var creatorElectionId = ""
    
    @State  var userElectionId = ""
    
    @State private var electionId = ""
    
    @State var setAndGetData = SetAndGetData()
    
    @State var nickName = ""
    
    var body: some View {
        
        
        ZStack{
            
           BackgroundView()
            
         
        
            VStack{
             
                Text("Election id is  \(electionId)").padding()
                
                Text(nickName).padding()
                
                
                ForEach(setAndGetData.allaChoices.indices) { index in
                
                
                 
                    
                Button(action: {
                    
                    
                    
                    if (isVotet == true){
                     
                       
                        
                    }
                    
                    else {
                        
                        
                        whichChoice = index
                       
                     

                     whichColor = Color.green
                      
                        
                    }
                    
                    
                }) {
                    
                    Text("\(setAndGetData.allaChoices[index].name)  \(setAndGetData.allaChoices[index].votes)")
                        .frame(width: 300, height: 30 )
                        .cornerRadius(25)
                        .background(whichChoice == index ? .green : .red)
                    
                    
                    
                    
                }
                
                
                
                
            }
        
                
                Spacer(minLength: 400)
        
            }
          
            
            
            
            
        }  .onAppear(perform: {
            
        
            if (creatorElectionId != ""){
                
                
               electionId = creatorElectionId
                
                
            }
            
            
            else {
                
                electionId = userElectionId
                
                
            }
            
            })
        
        
        
    }
}

struct VoteView_Previews: PreviewProvider {
    static var previews: some View {
        VoteView()
    }
}
