
import SwiftUI

struct ResultView: View {
    
    
 
    
    @Binding var  goBackToRootView  : Bool
    
    @State private var goToAllParticipantView = false
    
    @ObservedObject var setAndGetData = SetAndGetData()
    
    @State var electionId = ""

    @State private var isShowingAlertForLogOut = false
    
    @State private var isShowingAlert = false
    
    @State private var showResult = false
    
   @State var isCreatorHereInThisView = false
    
   @State var  hideBackButton = true
    
    var body: some View {
        
        
        
        ZStack{
            
           BackgroundView()
           
            VStack{
                
                
                Spacer(minLength: 100)
                
                
                Text("Election ID: \(electionId)").padding()
                
                
                  
                if (showResult == true){
                    
            
                    let allChoices =  setAndGetData.allChoices.sorted(by: { $0.votes > $1.votes })
                    
                
                
                    ForEach(allChoices.indices){ index in
                    
                    
                
                    HStack{
                        
       
                       Text("\(index + 1)").padding(2)
                        
                  
                        Text("\(allChoices[index].name)  \(allChoices[index].votes)")
                        
                       .frame(width: 330.0, height: 30.0)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .background(Color.purple)
                        .cornerRadius(3)
                    
                        
                      
                 
                        
                        
                        
                    }
                        
                    
                }
                   
                }
                
                VStack{
                    
                
                
                NavigationLink(destination:AllParticipantView(setAndGetData: setAndGetData, electionId: electionId), isActive: $goToAllParticipantView){
                        
                        Button(action: {
                            
                      
                      
                            setAndGetData.getCountOfPolled(electionId: electionId){
                                
                                
                       
                                if(setAndGetData.countOfPolled == 0){
                                    
                          
                                    
                                   isShowingAlert = true
                                    
                                    
                                }
                                
                                else {
                                    
                                  
                                setAndGetData.getCountOfParticipant(electionId : electionId){
                                        
                                    
                                setAndGetData.getAllParticiPant(electionId: electionId){
                                    
                      
                                  showResult = false
                                  goToAllParticipantView = true
                       
                              
                                }
                                
                                }
                                    
                                }

                            }
                  
              

                            
                        }) {
                        ButtonView(buttonText: "All Participant")
                        }
                        
                        
                    }.padding().alert("No one polled yet too see all Participant", isPresented :$isShowingAlert ){
                        
                        Button("Ok") {
                    
                      
                            
                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                
                
                Button(action: {
                    
                    showResult = false
                    
                    setAndGetData.getallChoicesFromFb(electionId:electionId){
                      showResult = true
  
                    }
                    
                    
                    
                }) {
                    ButtonView(buttonText: "Uppdate Result")
                }
                
                
                
                Button(action: {
                    
                
                isShowingAlertForLogOut = true
           
                    
                }) {
                    
                    ButtonView(buttonText: "Log Out")
                    
                }.padding(.top).alert("OBS: you should remember your election id if you want to log out", isPresented :$isShowingAlertForLogOut ){
                    
                    Button("Ok Log out", role: .destructive) {
                
                        goBackToRootView = false
                        
                        
                    }
                    
                    
                    
                    
                }
                
               
                }.padding(.leading, 15)
             
                
                
            Spacer(minLength: 300)
                
                
     
                    
                    .navigationBarBackButtonHidden(hideBackButton)

                
              
           
                
            }.onAppear(perform: {
                
                setAndGetData.getallChoicesFromFb(electionId: electionId){
                    
              
                    
               
           
                    
                    showResult = true
                    
                    
                }
                
                
            })
            
            
         }
        
        
    }
  
  
    
    
    
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(goBackToRootView: .constant(false))
    }
}
