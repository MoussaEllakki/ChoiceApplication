import SwiftUI

struct ToshowResultView: View {
    
    
    
    @State private var electionId = ""
    
   
    @State private var isShowingAlert = false
    
    
    @Binding var goToResultView  : Bool
    
    @State private var messageToUser = ""
    
    @State private var toResultView = false
    
    @ObservedObject var setAndGetData = SetAndGetData()
    
    @State private var ispolled = false
    
    @State var creatorInThisView = false
    
    @State private var wantCreatorVote = true
    
    var body: some View {
        
        
           ZStack{
            
            
            BackgroundView()
            
               Spacer()
               
            VStack{
                
                Spacer(minLength: 100)
                
                Text("Write election id")
                
                TextField("Write Election Id", text: $electionId)
                .padding(.leading, 4.0)
                .frame(width: 300.0, height: 35.0)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .keyboardType(.numberPad)
                
                
                
                NavigationLink(destination: ResultView(goBackToRootView: $goToResultView, setAndGetData: setAndGetData, electionId : electionId), isActive: $toResultView){
                    
                   
                    
                    Button(action: {
                        
                        
                          controlInputandelectionId()
               
                    }){
                        
                        ButtonView(buttonText: "See Result")
                        
                    }.alert(messageToUser, isPresented :$isShowingAlert){
                        
                        Button("Ok") {
                            
                            
                            
                        }
                        
                        if (creatorInThisView == true && ispolled == false){
                            
                        
                        Button("I will not poll") {
                            
                            
                            wantCreatorVote = false
                            
                            let controlIfCreatorWantTovote = "\(electionId)2"
                            
                            UserDefaults.standard.set(wantCreatorVote , forKey: controlIfCreatorWantTovote)
                            
                           toResultView = true
                            
                        }
                     
                        }
                    }
                 
                        
                    
                }.padding(30)
                
              
                
                
                Spacer(minLength: 300)
               
                
                
                
            }
            
               
               
               
              
            
        }
            
            
            
            
    }
    
    
    func controlInputandelectionId (){
        
        
                
                
                if (electionId != ""){
                    
                    
                    setAndGetData.controlElectionId(electionId: electionId){
                        
                        if (setAndGetData.isThereInternet == false){
                            
                            messageToUser = "No internet"
                            isShowingAlert = true
                            
                            return
                            
                        }
                        
                        if (setAndGetData.existingElectionId == true){
                            
                            
                      
                              
                        let controlIfCreatorInThisView = "\(electionId)1"
                          
                        let controlIfCreatorWantTovote = "\(electionId)2"

                                
                             print("\(controlIfCreatorInThisView) look  \(electionId) ")
                            
                            creatorInThisView = UserDefaults.standard.bool(forKey: controlIfCreatorInThisView)
                                
                         
                                
                                ispolled = UserDefaults.standard.bool(forKey: electionId)
                                
                                
                                if (creatorInThisView == true ){
                                    
                        
                                    
                                    wantCreatorVote = UserDefaults.standard.bool(forKey: controlIfCreatorWantTovote)
                                
                                    
                                     if (wantCreatorVote == true && ispolled == false){
                                       
                                       messageToUser = "You Cant see the result before you have polled, if you tap i will not poll then you cant poll this election, otherwise poll first to see the result"
                                        
                                        print("Creator want to join but he didnt polled yet")
                                        isShowingAlert = true
                                        
                                    }
                                    
                                    
                                    
                                    
                                    else if (ispolled == true){  //1
                                        
                                        
                                        print(" want to join \(wantCreatorVote)")
                                        print("Creator want to join and he polled")
                                        setAndGetData.getallChoicesFromFb(electionId:electionId){
                                        toResultView = true
                                        
                                        }
                                    }
                               
                                    else if (wantCreatorVote == false){
                                        
                                        print(" want to join \(wantCreatorVote)")
                                    print("creator will not join and dosent polled")
                                        setAndGetData.getallChoicesFromFb(electionId:electionId){
                                        toResultView = true
                                        
                                        }
                                    
                                }
                         
                        
                                
                                
                                
                        }
                            
                            
                            else if (creatorInThisView == false && ispolled == true){
                                setAndGetData.getallChoicesFromFb(electionId:electionId){
                                    
                                toResultView = true
                                
                                }
                                
                                
                            }
                            
                            
                            else {
                                
                               messageToUser = "You cant see result before you have vote"
                                isShowingAlert = true
                                
                            }
                            
                        }
                            else {
                                
                              messageToUser = "Wrong election id"
                              isShowingAlert = true
                                
                            }
                        
                        
                    }
                 
                    
                }
             
                else{
                    
                    messageToUser = "Write election id first"
                    isShowingAlert = true
                    
                }
        
        
    }
    
    
        
        
        }
        
 

struct ToshowResultView_Previews: PreviewProvider {
    static var previews: some View {
        ToshowResultView( goToResultView: .constant(false))
    }
}
