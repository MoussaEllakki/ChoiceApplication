

import SwiftUI

struct ConfirmView: View {
    
    
    @Binding  var goBackToRootView : Bool
    
    @State var nameOfParticipant = ""
    
    @State var  isShowingAlertForLogOut  = false
    
    @State var  isShowingAlert = false
    
    @State  var electionId = ""
    
    @ObservedObject var setAndGetData = SetAndGetData()
    
    @State private var goToResultView = false
    
    var body: some View {
        
        ZStack{
            
            BackgroundView()
            
            
            VStack{
               
                
                
                Spacer(minLength: 100)
                
                Text("Election Id  \(electionId)").padding(.bottom, 20.0)
                Text("Thank you \(nameOfParticipant)").padding(.bottom, 20.0)
                
        
                
                
                NavigationLink(destination: ResultView(goBackToRootView: $goBackToRootView, electionId : electionId), isActive: $goToResultView){
                    
                    Button(action: {
                        
                      
                      
                            
                            goToResultView = true

                        
                        
                
                 
                        
                        
                    }) {
                        
                        ButtonView(buttonText: "See result")
                        
                    }.padding(.vertical, 20.0).alert("text", isPresented :$isShowingAlert){
                        
                        Button("Ok") {
                            
                        }
                        
                    }
                    
                    
                }
              
                Button(action: {
                    
                
                   isShowingAlertForLogOut = true
           
                    
                }) {
                    
                    ButtonView(buttonText: "Log Out")
                    
                }.padding(.bottom, 20.0).alert("OBS: you should remember your election id if you want to log out", isPresented :$isShowingAlertForLogOut ){
                    
                    Button("Ok Log Out", role: .destructive) {
                
                        goBackToRootView = false
                        
                    }
                    
                    
                    }
                
                
                
                
                
                Spacer(minLength: 500)
                
                
            }
            
            
            
            .navigationBarBackButtonHidden(true)
        }
        
   
    }
}

struct ConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmView(goBackToRootView: .constant(false))
    }
}
