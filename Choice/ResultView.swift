
import SwiftUI

struct ResultView: View {
    
    
 
    
    @Binding var  goBackToRootView  : Bool
    
    @State private var goToAllParticipantView = false
    
    @State var setAndGetData = SetAndGetData()
    
    @State var electionId = ""
    
    
    var body: some View {
        
        
        ZStack{
            
           BackgroundView()
           
            VStack{
                
                
                Spacer(minLength: 60)
                
                
                Text("result view")
                
                
                HStack{
                    
                Spacer(minLength: 20)
                    
                Button(action: {
                    
                    
                    goBackToRootView = false
                    
                    
                    
                }) {
                    SmallButtonView(buttonText: "Home")
                    
                }
                 
                    Spacer(minLength: 250)
                
                }
                    
                
                ForEach(setAndGetData.allaChoices.indices){ index in
                    
                    HStack{
                        
                    
                    
                       Text(setAndGetData.allaChoices[index].name)
             
                    
                        
                        Text("\(setAndGetData.allaChoices[index].votes)")
                 
                        
                        
                    }
                        
                    
                }
                   
                    
                    NavigationLink(destination:AllParticipantView(setAndGetData: setAndGetData), isActive: $goToAllParticipantView){
                        
                        Button(action: {
                            
                      
                      
                            setAndGetData.getCountOfPolled(electionId: electionId){
                                
                     
                                setAndGetData.getAllParticiPant(electionId: electionId){
                                    
                      
                       
                                    goToAllParticipantView = true
                       
                              
                                }
                                
                               print("3")

                            }
                  
              

                            
                        }) {
                            SmallButtonView(buttonText: "All Participant")
                        }
                        
                        
                    }.padding()
                    
                    
                 Spacer(minLength: 20)
                
                }
                
               
                
             
                
                
            Spacer(minLength: 400)
                
                
                
            .navigationBarBackButtonHidden(true)
                
            }
            
            
         }
        
        
    
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(goBackToRootView: .constant(false))
    }
}
