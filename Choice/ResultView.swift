
import SwiftUI

struct ResultView: View {
    
    
 
    
    @Binding var  goBackToRootView  : Bool
    
    @State private var goToAllParticipantView = false
    
    @State var setAndGetData = SetAndGetData()
    
    @State var electionId = ""

   @State private var isShowingAlertForLogOut = false
    
    var body: some View {
        
        
        ZStack{
            
           BackgroundView()
           
            VStack{
                
                
                Spacer(minLength: 60)
                
                
                Text("result view")
                
                
                    
                
                ForEach(setAndGetData.allaChoices.indices){ index in
                    
                    HStack{
                        
                    
                        Text("\(index + 1)").padding(2)
                        
                  
                       Text("\(setAndGetData.allaChoices[index].name)  \(setAndGetData.allaChoices[index].votes)")
                       .frame(width: 330.0, height: 30.0)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .background(Color.purple)
                        .cornerRadius(3)
                    
                        
                      
                 
                        
                        
                        
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
                        ButtonView(buttonText: "All Participant")
                        }
                        
                        
                    }.padding()
                    
                    
                
                
                
                
                Button(action: {
                    
                
                isShowingAlertForLogOut = true
           
                    
                }) {
                    
                    ButtonView(buttonText: "Log Out")
                    
                }.alert("OBS: you should remember your election id if you want to log out", isPresented :$isShowingAlertForLogOut ){
                    
                    Button("Ok Log out", role: .destructive) {
                
                        goBackToRootView = false
                        
                        
                    }
                    
                    
                    
                    
                }
                
               
                
             
                
                
            Spacer(minLength: 400)
                
                
                
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
