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
                
                Text("πΎππππ ππππ π°π«").font(.title3)
                TextField("", text: $electionId)
                    .padding(.leading, 4.0)
                    .frame(width: 300.0, height: 30.0)
                
                    .keyboardType(.numberPad)
                    .background(Color.white)
                    .cornerRadius(10)
                
                
                
                NavigationLink(destination: ResultView(goBackToRootView: $goToResultView, setAndGetData: setAndGetData, electionId : electionId), isActive: $toResultView){
                    
                    
                    
                    Button(action: {
                        
                        
                        controlInputandelectionId()
                        
                    }){
                        
                        ButtonView(buttonText: "πΊππ ππππππ").shadow(radius: 15)
                        
                    }.alert(messageToUser, isPresented :$isShowingAlert){
                        
                        Button("πΆπ²") {
                            
                            
                            
                        }
                        
                        if (creatorInThisView == true && ispolled == false){
                            
                            
                            Button("π° ππππ πππ ππππ") {
                                
                                
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
                    
                    messageToUser = "π΅π ππππππππ ππππππππππ"
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
                            
                            messageToUser = "πππ πͺπππ πππ πππ ππππππ ππππππ πππ ππππ ππππππ,ππ πππ πππ π ππππ πππ ππππ, ππππ πππ ππππ ππππ, πππππππππ ππππ πππππ ππππ πππ πππ πππ πππ ππππππ"
                            
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
                        
                        messageToUser = "πππ ππππ πππ πππ ππππππ ππππππ πππ ππππ ππππππ"
                        isShowingAlert = true
                        
                    }
                    
                }
                else {
                    
                    messageToUser = "πΎππππ ππππ π°π«"
                    isShowingAlert = true
                    
                }
                
                
            }
            
            
        }
        
        else{
            
            messageToUser = "πΎππππ ππππ π°π« πππππ"
            isShowingAlert = true
            
        }
        
        
    }
    
    
    
    
}



struct ToshowResultView_Previews: PreviewProvider {
    static var previews: some View {
        ToshowResultView( goToResultView: .constant(false))
    }
}
