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
                
                Text("𝑾𝒓𝒊𝒕𝒆 𝒑𝒐𝒍𝒍 𝑰𝑫")
                TextField("", text: $electionId)
                    .padding(.leading, 4.0)
                    .frame(width: 300.0, height: 35.0)
               
                    .keyboardType(.numberPad)
                    .background(Color.white)
                    .cornerRadius(10)
                
                
                
                NavigationLink(destination: ResultView(goBackToRootView: $goToResultView, setAndGetData: setAndGetData, electionId : electionId), isActive: $toResultView){
                    
                   
                    
                    Button(action: {
                        
                        
                          controlInputandelectionId()
               
                    }){
                        
                        ButtonView(buttonText: "𝑺𝒆𝒆 𝑹𝒆𝒔𝒖𝒍𝒕")
                        
                    }.alert(messageToUser, isPresented :$isShowingAlert){
                        
                        Button("𝑶𝑲") {
                            
                            
                            
                        }
                        
                        if (creatorInThisView == true && ispolled == false){
                            
                        
                        Button("𝑰 𝒘𝒊𝒍𝒍 𝒏𝒐𝒕 𝒑𝒐𝒍𝒍") {
                            
                            
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
                            
                            messageToUser = "𝑵𝒐 𝒊𝒏𝒕𝒆𝒓𝒏𝒆𝒕"
                            isShowingAlert = true
                            
                            return
                            
                        }
                        
                        if (setAndGetData.existingElectionId == true){
                            
                            
                      
                              
                        let controlIfCreatorInThisView = "\(electionId)1"
                          
                        let controlIfCreatorWantTovote = "\(electionId)2"

                                
                        
                            
                            creatorInThisView = UserDefaults.standard.bool(forKey: controlIfCreatorInThisView)
                                
                         
                                
                                ispolled = UserDefaults.standard.bool(forKey: electionId)
                                
                                
                                if (creatorInThisView == true ){
                                    
                        
                                    
                                    wantCreatorVote = UserDefaults.standard.bool(forKey: controlIfCreatorWantTovote)
                                
                                    
                                     if (wantCreatorVote == true && ispolled == false){
                                       
                                       messageToUser = "𝒀𝒐𝒖 𝑪𝒂𝒏𝒕 𝒔𝒆𝒆 𝒕𝒉𝒆 𝒓𝒆𝒔𝒖𝒍𝒕 𝒃𝒆𝒇𝒐𝒓𝒆 𝒚𝒐𝒖 𝒉𝒂𝒗𝒆 𝒑𝒐𝒍𝒍𝒆𝒅,𝒊𝒇 𝒚𝒐𝒖 𝒕𝒂𝒑 𝒊 𝒘𝒊𝒍𝒍 𝒏𝒐𝒕 𝒑𝒐𝒍𝒍, 𝒕𝒉𝒆𝒏 𝒚𝒐𝒖 𝒄𝒂𝒏𝒕 𝒑𝒐𝒍𝒍, 𝒐𝒕𝒉𝒆𝒓𝒘𝒊𝒔𝒆 𝒑𝒐𝒍𝒍 𝒇𝒊𝒓𝒔𝒕 𝒕𝒐 𝒔𝒆𝒆 𝒕𝒉𝒆 𝒓𝒆𝒔𝒖𝒍𝒕"
                             
                                        isShowingAlert = true
                                        
                                    }
                                    
                                    
                                    
                                    
                                    else if (ispolled == true){  //1
                                        
                                 
                                        setAndGetData.getallChoicesFromFb(electionId:electionId){
                                        toResultView = true
                                        
                                        }
                                    }
                               
                                    else if (wantCreatorVote == false){
                                        
                          
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
                                
                               messageToUser = "𝒀𝒐𝒖 𝒄𝒂𝒏𝒕 𝒔𝒆𝒆 𝒓𝒆𝒔𝒖𝒍𝒕 𝒃𝒆𝒇𝒐𝒓𝒆 𝒚𝒐𝒖 𝒉𝒂𝒗𝒆 𝒑𝒐𝒍𝒍𝒆𝒅"
                                isShowingAlert = true
                                
                            }
                            
                        }
                            else {
                                
                              messageToUser = "𝑾𝒓𝒐𝒏𝒈 𝒑𝒐𝒍𝒍 𝑰𝑫"
                              isShowingAlert = true
                                
                            }
                        
                        
                    }
                 
                    
                }
             
                else{
                    
                    messageToUser = "𝑾𝒓𝒊𝒕𝒆 𝒑𝒐𝒍𝒍 𝑰𝑫 𝒇𝒊𝒓𝒔𝒕"
                    isShowingAlert = true
                    
                }
        
        
    }
    
    
        
        
        }
        
 

struct ToshowResultView_Previews: PreviewProvider {
    static var previews: some View {
        ToshowResultView( goToResultView: .constant(false))
    }
}
