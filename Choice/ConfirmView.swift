

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
                
            Text("Election Id is \(electionId)")
             Text("Thank you \(nameOfParticipant)")
                
                
                
                
                
                
                
                Button(action: {
                    
                
                   isShowingAlertForLogOut = true
           
                    
                }) {
                    
                    ButtonView(buttonText: "Log Out")
                    
                }.alert("OBS: you should remember your election id if you want to log out", isPresented :$isShowingAlertForLogOut ){
                    
                    Button("Ok Log Out", role: .destructive) {
                
                        goBackToRootView = false
                        
                    }
                    
                    
                    }
                
                
                
                
                
                NavigationLink(destination: ResultView(goBackToRootView: $goBackToRootView, setAndGetData: setAndGetData, electionId : electionId), isActive: $goToResultView){
                    
                    Button(action: {
                        
                      
                        setAndGetData.getallChoicesFromFb(electionId:electionId){
                            
                            goToResultView = true

                        }
                        
                
                 
                        
                        
                    }) {
                        
                        ButtonView(buttonText: "See result")
                        
                    }.alert("text", isPresented :$isShowingAlert){
                        
                        Button("Ok") {
                            
                        }
                        
                    }
                    
                    
                }
                
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
