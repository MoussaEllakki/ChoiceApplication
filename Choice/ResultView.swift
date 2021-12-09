
import SwiftUI

struct ResultView: View {
    
    
 
    
    @Binding var goToResultView  : Bool
    
    var body: some View {
        
        
        ZStack{
            
           BackgroundView()
           
            VStack{
                
                Button(action: {
                    
                    
                   goToResultView = false
                    
                    
                    
                }) {
                    SmallButtonView(buttonText: "Home")
                    
                }
                
                
                Text("Result view")
                
             
                
                
            
                
                
                
            .navigationBarBackButtonHidden(true)
                
            }
            
            
         }
        
        
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(goToResultView: .constant(false))
    }
}
