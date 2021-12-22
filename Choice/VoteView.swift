
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
    
    @State private var isAllPolled = false
    
    @State private var wantCreatorVote = true
    
    var body: some View {
        
        
        ZStack{
            
            BackgroundView()
            
            
         
            
            if (isAllPolled == true){
                
                VStack{
                    
             
                    
                    Spacer()
                    Text("𝑶𝑷𝑺!")
                    Text("𝑺𝒐𝒓𝒓𝒚 𝒚𝒐𝒖 𝒄𝒂𝒏𝒕 𝒋𝒐𝒊𝒏! 𝑩𝒆𝒄𝒂𝒖𝒔𝒆 𝒂𝒍𝒍 𝒑𝒂𝒓𝒕𝒊𝒄𝒊𝒑𝒂𝒏𝒕𝒔 𝒉𝒂𝒗𝒆 𝒑𝒐𝒍𝒍𝒆𝒅")
                        .lineLimit(3)
                        .padding(.horizontal, 20.0)
                 
                    
                    Button(action: {
                        
                        goBackToRootView = false
                        
                    }) {
                        
                      ButtonView(buttonText: "𝑶𝒌 𝑳𝒐𝒈 𝑶𝒖𝒕")
                    }.padding()
                        
                    
                 Spacer(minLength: 300)
                    
                 .navigationBarBackButtonHidden(true)
                    
                }
                
            }
            
                else {
                    
                
            VStack{
                
                Spacer(minLength: 50)

                
                
               
                
                
                HStack{
                    Text("𝑷𝒐𝒍𝒍 𝑰𝑫:")
                    Text("\(electionId)")
                        .frame(width: 100, height: 20)
                        .background(Color.white)
                        .cornerRadius(10)
                  }

               
                Text(setAndGetData.pollName)
                
            
                
               
                
                ForEach(setAndGetData.allChoices.indices) { index in
                    
                    
                    HStack{
                        
                
                        /*
                    Button(action: {
                        
                        
                   
                            
                            whichChoice = index
                            whichColor = Color.green
                            
                            
                        
                        
                        
                    }) {
                        
                        Text("\(setAndGetData.allChoices[index].name)")
                            .frame(width: 330, height: 30 )
                            .background(whichChoice == index ? .green : .red)
                            .cornerRadius(10)
                    }
                    */
                    
                        
                        ScrollView (.horizontal){
                            
                        
                        
                       
                        
                        Text("\(setAndGetData.allChoices[index].name)")
                    
                        }
                        .padding(.leading, 10)
                        .frame(width: 300.0, height: 30.0)
                        .background(whichChoice == index ? .green : .red)
                        .cornerRadius(10)
                        .onTapGesture {
                            whichChoice = index
                            whichColor = Color.green
                            
                        }
                    }
                    
                }
                
                
                
                VStack{
                    
                
                
                NavigationLink(destination: ConfirmView(goBackToRootView: $goBackToRootView, nameOfParticipant: nameOfParticipant, electionId : electionId), isActive: $goToConfirmView){
                    
                    Button(action: {
                        
                        
                    
                        poll()
                 
                        
                        
                    }) {
                        
                        ButtonView(buttonText: "𝑷𝒐𝒍𝒍")
                            .padding(.vertical, 20.0)
                        
                    }.alert(messageToUser, isPresented :$isShowingAlert){
                        
                        Button("𝑶𝑲") {
                            
                        }
                        
                    }
                    
                    
                }
           
                
                
                
                
                
                Button(action: {
                    
                
                   isShowingAlertForLogOut = true
           
                    
                }) {
                    
                    ButtonView(buttonText: "𝑳𝒐𝒈 𝑶𝒖𝒕")
                    
                }.alert("𝑶𝑩𝑺: 𝒀𝒐𝒖 𝒔𝒉𝒐𝒖𝒍𝒅 𝒓𝒆𝒎𝒆𝒎𝒃𝒆𝒓 𝒚𝒐𝒖𝒓 𝒑𝒐𝒍𝒍 𝑰𝑫 \(electionId) 𝒊𝒇 𝒚𝒐𝒖 𝒘𝒂𝒏𝒕 𝒕𝒐 𝒍𝒐𝒈 𝒐𝒖𝒕", isPresented :$isShowingAlertForLogOut ){
                    
                    Button("𝑶𝒌 𝑳𝒐𝒈 𝑶𝒖𝒕", role: .destructive) {
                
                        if (creatorElectionId != ""){
                            
                        
                            wantCreatorVote = true
                            
                            let controlIfCreatorWantTovote = "\(electionId)2"
                            
                            UserDefaults.standard.set(wantCreatorVote , forKey: controlIfCreatorWantTovote)
                            
                        }
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
                   
                   setAndGetData.getPollName(electionId: electionId){
                       
                       
                   }
                   
                   
                
            })
            
            
            
            
        }
        
        
        
    
    
    
    
    func poll (){
        
    
        
        if (whichChoice < 0){
            
            messageToUser = "𝑪𝒉𝒐𝒐𝒔𝒆 𝒄𝒉𝒐𝒊𝒄𝒆 𝒇𝒊𝒓𝒔𝒕"
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
