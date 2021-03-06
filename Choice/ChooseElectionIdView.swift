

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
                
                Text("πΎππππ ππππ π°π« πππ ππππ ππππ").font(.title3).padding(20)
                
                Text("πΎππππ ππππ π°π«").font(.title3)
                TextField("π·πππ π°π«", text: $electionId)
                    .padding(.leading, 4.0)
                    .frame(width: 300.0, height: 30.0)
                    .keyboardType(.numberPad)
                    .background(Color.white)
                    .cornerRadius(10)
                
                
                Text("πΎππππ ππππ ππππ").font(.title3)
                TextField("π΅πππ", text: $nameOfPolledPerson)
                    .padding(.leading, 4.0)
                    .frame(width: 300.0, height: 30.0)
                  
                    .background(Color.white)
                    .cornerRadius(10)
                NavigationLink(destination: VoteView(creatorElectionId: "", goBackToRootView: $goBackToRootView, userElectionId: electionId , setAndGetData: setAndGetData, nameOfParticipant:nameOfPolledPerson) , isActive: $goToVoteView){
                    
                    
                    Button(action: {
                        
                        controlInputAndElectionID()
                        
                    }) {
                        ButtonViewGreen(buttonText: "π±πππ ππππ").padding(20).shadow(radius: 15)
                        
                    }.alert(messageToUser, isPresented :$isShowingAlert ){
                        
                        Button("πΆπ²") {
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
                        
                        messageToUser = "π΅π π°πππππππ"
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
                                
                                messageToUser = "πππ πͺππππππ ππ πππ π±πππ"
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
                                
                  
                                messageToUser = "πΎππππ ππππ π°π«"
                                isShowingAlert = true
                            }
                            
                        }
                        
                    }
                    
                }
                
                
            }
            
            
            else {
                
                messageToUser = "πππ ππππ πππππππ ππππππ"
                isShowingAlert = true
                
            }
            
        }
        
        
        else {
            
            messageToUser = "πΎππππ ππππ π°π« πππ πππ ππππ ππππt!"
            isShowingAlert = true
            
        }
        
    }
    
}


struct ChooseElectionIdView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseElectionIdView(goBackToRootView: .constant(false))
    }
}
