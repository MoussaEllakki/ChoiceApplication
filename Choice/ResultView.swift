
import SwiftUI

struct ResultView: View {
    
    
 
    
    @Binding var  goBackToRootView  : Bool
    
    @State private var goToAllParticipantView = false
    
    @ObservedObject var setAndGetData = SetAndGetData()
    
    @State var electionId = ""

    @State private var isShowingAlertForLogOut = false
    
    @State private var isShowingAlert = false
    
    @State private var showResult = false
    
    
    var body: some View {
        
        
        ZStack{
            
           BackgroundView()
           
            VStack{
                
                
                Spacer(minLength: 60)
                
                
                Text("Election ID: \(electionId)").padding()
                
                
                  
                if (showResult == true){
                    
                
                
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
                   
                }
                    NavigationLink(destination:AllParticipantView(setAndGetData: setAndGetData), isActive: $goToAllParticipantView){
                        
                        Button(action: {
                            
                      
                      
                            setAndGetData.getCountOfPolled(electionId: electionId){
                                
                                
                                print("1")
                                print("")
                                print("count of polled are  \(setAndGetData.countOfPolled)")
                                print("")
                                print("2")
                                if(setAndGetData.countOfPolled == 0){
                                    
                                    print("")
                                    print("")
                                    print("count of polled are  \(setAndGetData.countOfPolled)")
                                    print("")
                                    print("")
                                    
                                   isShowingAlert = true
                                    
                                    
                                }
                                
                                else {
                                    
                                    print("inneeeee")
                                    
                                setAndGetData.getAllParticiPant(electionId: electionId){
                                    
                      
                                  showResult = false
                                    goToAllParticipantView = true
                       
                              
                                }
                                
                                }

                            }
                  
              

                            
                        }) {
                        ButtonView(buttonText: "All Participant")
                        }
                        
                        
                    }.padding().alert("no one polled yet", isPresented :$isShowingAlert ){
                        
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
                    
                }.alert("OBS: you should remember your election id if you want to log out", isPresented :$isShowingAlertForLogOut ){
                    
                    Button("Ok Log out", role: .destructive) {
                
                        goBackToRootView = false
                        
                        
                    }
                    
                    
                    
                    
                }
                
               
                
             
                
                
            Spacer(minLength: 400)
                
                
                
            .navigationBarBackButtonHidden(true)
                
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
