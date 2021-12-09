

import SwiftUI



struct ChooseElectionIdView: View {
    
    @State private var messageToUser = ""
    
    @State private var electionId = ""
    
    @State private var  goToShowElectionView = false
    
    @State private var  isShowingAlert = false
    
    @State private var setAndGetData = SetAndGetData()
    
    @State private var goToVoteView = false
    
    @State private var nickName = ""
    
    var body: some View {
        
        
        ZStack{
            
            
            BackgroundView()
            
            VStack{
                
                Spacer(minLength: 60)
                
                Text("Write election id")
                
                TextField("Write Election Id", text: $electionId)
                .padding(.leading, 4.0)
                .frame(width: 300.0, height: 35.0)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
     
                  Spacer(minLength: 10)
                
                TextField("Write nickname", text: $nickName)
                .padding(.leading, 4.0)
                .frame(width: 300.0, height: 35.0)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                
                NavigationLink(destination: VoteView(creatorElectionId: "", userElectionId: electionId , setAndGetData: setAndGetData, nickName: nickName) , isActive: $goToVoteView){
                    
                    
                
                    
                    Button(action: {
                        
                  
                        controlInputAndElectionID()
                        
                    }) {
                        
                        ButtonView(buttonText: "Vote").padding(20)
                        
                    }.alert(messageToUser, isPresented :$isShowingAlert ){
                        
                        Button("Ok") {
                            
                        }
                        
                  }

        
            }
            
            
                Spacer(minLength: 600)
            
            
            
            }.padding()
        
        
        }
        
    }
    
    
   
    
    func controlInputAndElectionID (){
        
        if (electionId != "" && nickName != ""){
            
         
      
            //1
       
            print("one")
            
            setAndGetData.controlElectionId(electionId: electionId){
                
            print("seven o sist")
            
            //4
            
          // 6 sists med comprehanion
            
            if (setAndGetData.isThereInternet == false){
                
                print("ingen  internet")
               messageToUser = "No Internet"
               isShowingAlert = true
                
               return
                
            }
            
            else {
                
                
                if(setAndGetData.existingElectionId == true){
                    
                    
                    setAndGetData.getallChoicesFromFb(electionId: electionId){
                        
                        print("rätt id ")
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
            
            
          messageToUser = "Write Election ID and you name firs!"
          
            isShowingAlert = true
            
        }
    
        
        
        
        
        
        
        
    
    }
    
    
    

}
    
    
struct ChooseElectionIdView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseElectionIdView()
    }
}
