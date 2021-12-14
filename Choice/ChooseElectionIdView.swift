

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
    
    var body: some View {
        
        
        ZStack{
            
            
            BackgroundView()
            
            VStack{
                
                Spacer(minLength: 60)
                
                Text("Write election id and you name").padding(20)
                
                TextField("Write Election Id", text: $electionId)
                .padding(.leading, 4.0)
                .frame(width: 300.0, height: 35.0)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .keyboardType(.numberPad)
               
                
                TextField("Write your name", text: $nameOfPolledPerson)
                .padding(.leading, 4.0)
                .frame(width: 300.0, height: 35.0)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                
                NavigationLink(destination: VoteView(creatorElectionId: "", goBackToRootView: $goBackToRootView, userElectionId: electionId , setAndGetData: setAndGetData, nameOfParticipant:nameOfPolledPerson) , isActive: $goToVoteView){
                    
                    
                
                    
                    Button(action: {
                        
                  
                        
                        controlInputAndElectionID()
                        
                    }) {
                        
                        ButtonView(buttonText: "Poll").padding(20)
                        
                    }.alert(messageToUser, isPresented :$isShowingAlert ){
                        
                        Button("Ok") {
                            
                        }
                        
                  }

        
            }
            
            
                Spacer(minLength: 300)
            
            
            
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
                
            
               messageToUser = "No Internet"
               isShowingAlert = true
                
               return
                
            }
            
            else {
                
                
                if(setAndGetData.existingElectionId == true){
                    
                    
                    setAndGetData.getallChoicesFromFb(electionId: electionId){
                        
              
                        goToVoteView = true
                        
                    }
             
                    
                    
                }
                
                else if (setAndGetData.existingElectionId == false) {
                    
                    print("fel id")
                    messageToUser = "Wrong election ID"
                    
                    isShowingAlert = true
                    
                }
              
                
                
            }
            
            }
            
        
        }
        
            else {
                
                messageToUser = "You have polled"
                
                isShowingAlert = true
                
                
                
            }
            
            
            
        
        
        
        
        }
        
        
    
        else {
            
            
          messageToUser = "Write Election ID and you name firs!"
          
            isShowingAlert = true
            
        }
    
        
        
        
        
        
        
        
    
    }
    
  
    
   
    
    
    

}
    
    
struct ChooseElectionIdView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseElectionIdView(goBackToRootView: .constant(false))
    }
}
