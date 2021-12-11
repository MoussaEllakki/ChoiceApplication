
import SwiftUI

struct VoteView: View {
    
    @State private var ispolled = false
    
    @State private var whichChoice  = -10
    
    @State private var whichColor = Color.red
    
    @State  var creatorElectionId = ""
    
    @Binding  var goBackToRootView : Bool
    
    @State  var userElectionId = ""
    
    @State private var electionId = ""
    
    @ObservedObject var setAndGetData = SetAndGetData()
    
   @State private var goToConfirmView = false
    
    @State var nameOfParticipant = ""
    
    @State var messageToUser = ""
    
    @State private var isShowingAlert = false
    
    @State private var isShowingAlertForLogOut = false
    
    var body: some View {
        
        
        ZStack{
            
            BackgroundView()
            
            VStack{
                
                Spacer(minLength: 50)

                
                
                
                Text("Election id is  \(electionId)").padding()
               
                
                
                
                ForEach(setAndGetData.allaChoices.indices) { index in
                    
                    
                    
                    Button(action: {
                        
                        
                   
                            
                            whichChoice = index
                            whichColor = Color.green
                            
                            
                        
                        
                        
                    }) {
                        
                        Text("\(setAndGetData.allaChoices[index].name)")
                            .frame(width: 300, height: 30 )
                            .background(whichChoice == index ? .green : .red)
                            .cornerRadius(10)
                    }
                    
                    
                    
                    
                }
                
                
                
                
                
                NavigationLink(destination: ConfirmView(goBackToRootView: $goBackToRootView, nameOfParticipant: nameOfParticipant, electionId : electionId), isActive: $goToConfirmView){
                    
                    Button(action: {
                        
                        
                    
                        poll()
                 
                        
                        
                    }) {
                        
                        ButtonView(buttonText: "Poll")
                        
                    }.alert(messageToUser, isPresented :$isShowingAlert){
                        
                        Button("Ok") {
                            
                        }
                        
                    }
                    
                    
                }
           
                
                
                
                
                
                Button(action: {
                    
                
                   isShowingAlertForLogOut = true
           
                    
                }) {
                    
                    ButtonView(buttonText: "Log Out")
                    
                }.padding(20).alert("OBS: you should remember your election id if you want to log out", isPresented :$isShowingAlertForLogOut ){
                    
                    Button("Ok Log out", role: .destructive) {
                
                        goBackToRootView = false
                        
                    }
                    
                    
                    
                    
                }
                
                
                
                
                
                
                .navigationBarBackButtonHidden(true)
                
                Spacer(minLength: 300)
                
               }.onAppear(perform: {
                
                
                if (creatorElectionId != ""){
                    
                    
                    electionId = creatorElectionId
                    
                    
                }
                
                
                else {
                    
                    electionId = userElectionId
                    
                    
                }
                
            })
            
            
            
            
        }
        
        
        
    }
    
    
    
    func poll (){
        
    
        
        if (whichChoice < 0){
            
            messageToUser = "Choose choice first"
            isShowingAlert = true
            
        }
        
        else {
            
                       setAndGetData.poll(electionId: electionId, whichChoice: whichChoice)
                     setAndGetData.AddVoteAndNameOfParticipant(electionId: electionId, NameOfParticipant: nameOfParticipant)
            
                      goToConfirmView = true
            
                        
            }
      

    
    
    
}

    
}
struct VoteView_Previews: PreviewProvider {
    static var previews: some View {
        VoteView(goBackToRootView: .constant(false))
    }
}
