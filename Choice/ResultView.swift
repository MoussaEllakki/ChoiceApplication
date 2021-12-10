
import SwiftUI

struct ResultView: View {
    
    
 
    
    @Binding var  goBackToRootView  : Bool
    
    @State private var goToAllParticipantView = false
    
    @State private var setAndGetData = SetAndGetData()
    
    
    var body: some View {
        
        
        ZStack{
            
           BackgroundView()
           
            VStack{
                
                
                Spacer(minLength: 50)
                
                
                Text("result view")
                
                
                HStack{
                    
                Spacer(minLength: 20)
                    
                Button(action: {
                    
                    
                    goBackToRootView = false
                    
                    
                    
                }) {
                    SmallButtonView(buttonText: "Home")
                    
                }
                 
                    
                    
                    
                   
                    
                    NavigationLink(destination:AllParticipantView(), isActive: $goToAllParticipantView){
                        
                        Button(action: {
                            
                      
                            
                  
                            goToAllParticipantView = true
                            
                        }) {
                            SmallButtonView(buttonText: "All Participant")
                        }
                        
                        
                    }.padding()
                    
                    
                 Spacer(minLength: 20)
                    
                }
                
               
                
             
                
                
            Spacer(minLength: 600)
                
                
                
            .navigationBarBackButtonHidden(true)
                
            }
            
            
         }
        
        
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(goBackToRootView: .constant(false))
    }
}
