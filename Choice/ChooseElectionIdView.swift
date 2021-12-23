

import SwiftUI

struct ChooseElectionIdView: View {
    
    @State private var messageToUser = ""
    @State private var electionId = ""
    @State private var  goToShowElectionView = false
    @State private var  isShowingAlert = false
    @State private var setAndGetData = SetAndGetData()
    @State private var goToVoteView = false
    @State private var nameOfPolledPerson = ""
    @Binding var goBackToRootView : Bool
    @State private var ispolled = false
    @State private var wantCreatorVote = true
    @State var creatorInThisView = false
    
    var body: some View {
        
        ZStack{
            
            BackgroundView()
            
            VStack{
                
                Spacer(minLength: 60)
                
                Text("𝑾𝒓𝒊𝒕𝒆 𝒑𝒐𝒍𝒍 𝑰𝑫 𝒂𝒏𝒅 𝒚𝒐𝒖𝒓 𝒏𝒂𝒎𝒆").padding(20)
                
                Text("𝑾𝒓𝒊𝒕𝒆 𝒑𝒐𝒍𝒍 𝑰𝑫")
                TextField("", text: $electionId)
                    .padding(.leading, 4.0)
                    .frame(width: 300.0, height: 30.0)
               
                    .keyboardType(.numberPad)
                    .background(Color.white)
                    .cornerRadius(10)
                Text("𝑾𝒓𝒊𝒕𝒆 𝒚𝒐𝒖𝒓 𝒏𝒂𝒎𝒆")
                TextField("", text: $nameOfPolledPerson)
                    .padding(.leading, 4.0)
                    .frame(width: 300.0, height: 30.0)
                  
                    .background(Color.white)
                    .cornerRadius(10)
                NavigationLink(destination: VoteView(creatorElectionId: "", goBackToRootView: $goBackToRootView, userElectionId: electionId , setAndGetData: setAndGetData, nameOfParticipant:nameOfPolledPerson) , isActive: $goToVoteView){
                    
                    
                    Button(action: {
                        
                        controlInputAndElectionID()
                        
                    }) {
                        ButtonView(buttonText: "𝑷𝒐𝒍𝒍").padding(20)
                        
                    }.alert(messageToUser, isPresented :$isShowingAlert ){
                        
                        Button("𝑶𝑲") {
                        }
                        
                    }
                    
                }
                
                Spacer(minLength: 200)
                
            }.padding()
        }
    }
    
    
    func controlInputAndElectionID (){
        
        let nameOfPolledPersonRemoveSpace = nameOfPolledPerson.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (electionId != "" && nameOfPolledPersonRemoveSpace != ""){
            
            ispolled = UserDefaults.standard.bool(forKey: electionId)
            
            if (ispolled == false){
                
                setAndGetData.controlElectionId(electionId: electionId){
                    
                    if (setAndGetData.isThereInternet == false){
                        
                        messageToUser = "𝑵𝒐 𝑰𝒏𝒕𝒆𝒓𝒏𝒆𝒕"
                        isShowingAlert = true
                        
                        return
                    }
                    
                    else {
                        
                        let controlIfCreatorInThisView = "\(electionId)1"
                        let controlIfCreatorWantTovote = "\(electionId)2"
                        
                        
                        creatorInThisView = UserDefaults.standard.bool(forKey: controlIfCreatorInThisView)
                        wantCreatorVote = UserDefaults.standard.bool(forKey: controlIfCreatorWantTovote)
                        
                        if (creatorInThisView == true){
                            
                            if (wantCreatorVote == true){
                                
                                setAndGetData.getallChoicesFromFb(electionId: electionId){
                                    
                                    goToVoteView = true
                                }
                            }
                            
                            else {
                                
                                messageToUser = "𝒀𝒐𝒖 𝑪𝒉𝒐𝒐𝒔𝒆𝒅 𝒕𝒐 𝒏𝒐𝒕 𝑱𝒐𝒊𝒏"
                                isShowingAlert = true
                                
                                return
                            }
                        }
                        
                        else {
                            
                            if(setAndGetData.existingElectionId == true){
                                
                                setAndGetData.getallChoicesFromFb(electionId: electionId){
                                    
                                    goToVoteView = true
                                    
                                }
                                
                            }
                            
                            
                            else if (setAndGetData.existingElectionId == false) {
                                
                  
                                messageToUser = "𝑾𝒓𝒐𝒏𝒈 𝒑𝒐𝒍𝒍 𝑰𝑫"
                                isShowingAlert = true
                            }
                            
                        }
                        
                    }
                    
                }
                
                
            }
            
            
            else {
                
                messageToUser = "𝒀𝒐𝒖 𝒉𝒂𝒗𝒆 𝒂𝒍𝒓𝒆𝒂𝒅𝒚 𝒑𝒐𝒍𝒍𝒆𝒅"
                isShowingAlert = true
                
            }
            
        }
        
        
        else {
            
            messageToUser = "𝑾𝒓𝒊𝒕𝒆 𝒑𝒐𝒍𝒍 𝑰𝑫 𝒂𝒏𝒅 𝒚𝒐𝒖 𝒏𝒂𝒎𝒆 𝒇𝒊𝒓𝒔t!"
            isShowingAlert = true
            
        }
        
    }
    
}


struct ChooseElectionIdView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseElectionIdView(goBackToRootView: .constant(false))
    }
}
