
import SwiftUI

struct VoteView: View {
    
    @State private var ispolled = false
    
    @State private var whichChoice  = -10
    
    @State private var whichColor = Color.purple
    
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
    
    @State private var isAllPolled = false
    
    var body: some View {
        
        
        ZStack{
            
            BackgroundView()
            
            
         
            
            if (isAllPolled == true){
                
                VStack{
                    
                    Spacer()
                    Text("Ops")
                    Text("Sorry you cant join this election because all participant have already polled")
                        .lineLimit(3)
                        .padding(.horizontal, 20.0)
                 
                    
                    Button(action: {
                        
                        goBackToRootView = false
                        
                    }) {
                        
                      ButtonView(buttonText: "Log out")
                    }.padding()
                        
                    
                 Spacer(minLength: 300)
                    
                 .navigationBarBackButtonHidden(true)
                    
                }
                
            }
            
                else {
                    
                
            VStack{
                
                Spacer(minLength: 50)

                
                
                
                Text("Election id  \(electionId)").padding()
               
                Text("Choose one of these choices").padding()
                
                
                
                ForEach(setAndGetData.allChoices.indices) { index in
                    
                    
                    HStack{
                        
                        Text("\(index + 1)")
                        
                    Button(action: {
                        
                        
                   
                            
                            whichChoice = index
                            whichColor = Color.green
                            
                            
                        
                        
                        
                    }) {
                        
                        Text("\(setAndGetData.allChoices[index].name)")
                            .frame(width: 330, height: 30 )
                            .background(whichChoice == index ? .green : .purple)
                            .cornerRadius(10)
                    }
                    
                    
                    }
                    
                }
                
                
                
                VStack{
                    
                
                
                NavigationLink(destination: ConfirmView(goBackToRootView: $goBackToRootView, nameOfParticipant: nameOfParticipant, electionId : electionId), isActive: $goToConfirmView){
                    
                    Button(action: {
                        
                        
                    
                        poll()
                 
                        
                        
                    }) {
                        
                        ButtonView(buttonText: "Poll")
                            .padding(.vertical, 20.0)
                        
                    }.alert(messageToUser, isPresented :$isShowingAlert){
                        
                        Button("Ok") {
                            
                        }
                        
                    }
                    
                    
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
               
                .navigationBarBackButtonHidden(true)
                
                    
                }.padding(.leading, 15)
                
                Spacer(minLength: 300)
            }
                    
                    
                 
                    
                    
            }
                
            
                
   
                
             
                
               }.onAppear(perform: {
                
                
              
                   
                if (creatorElectionId != ""){
                    
                    
                    electionId = creatorElectionId
                    
                    
                }
                
                
                else {
                    
                    electionId = userElectionId
                    
                    
                }
                   
                   setAndGetData.getCountOfParticipant(electionId: electionId){
                       
                       
                       setAndGetData.getCountOfPolled(electionId:electionId){
                           
                        
                           if (setAndGetData.countOfparticipant == setAndGetData.countOfPolled){
                               
                               isAllPolled = true
                               
                           }
                          
                      
                           
                       }
                       
                       
                   }
                   
                   
                   
                   
                
            })
            
            
            
            
        }
        
        
        
    
    
    
    
    func poll (){
        
    
        
        if (whichChoice < 0){
            
            messageToUser = "Choose choice first"
            isShowingAlert = true
            
        }
        
        else {
            
            if (ispolled == false){
                
                
            
            
                     setAndGetData.poll(electionId: electionId, whichChoice: whichChoice)
                     setAndGetData.AddVoteAndNameOfParticipant(electionId: electionId, NameOfParticipant: nameOfParticipant)
            
                    ispolled = true
                
                     UserDefaults.standard.set(ispolled, forKey: electionId)
                
       
                
                      goToConfirmView = true
                
                
                
            }
            
            
            
           
            
                        
            }
      

    
    
    
}

    
}
struct VoteView_Previews: PreviewProvider {
    static var previews: some View {
        VoteView(goBackToRootView: .constant(false))
    }
}
