

import SwiftUI

struct ShowElectionview: View {
    
    @State  var allChoices : [String] = [""]
    
    @State var electionId = ""
    
    @State var goToVoteView = false
    
    @State var   isShowingAlertForDeleteelectionId = false
    
    @State var   isShowingAlertForLogOut = false
    
    @State var   isShowingAlert = false
    
    @Binding  var goBackToRootView : Bool
    
    @ObservedObject var setAndGetData = SetAndGetData()
    
    @State private var goToResultView = false
    
    @State private var nameOfPolledPerson = ""
    
    @State private var wantCreatorVote = true
    
    @State private var isCreatorInThisView = false
    
    @State var  isShowingAlertIfCreatorWantJoin = false
    
    var body: some View {
        
        
        ZStack{
            
            BackgroundView()
            
            
   
         

            VStack{
                
                Spacer(minLength: 60)
          
                
                
                
         
               Spacer()
                
                Text("𝑨𝒍𝒍 𝑪𝒉𝒐𝒊𝒄𝒆𝒔 𝑭𝒐𝒓 𝑬𝒍𝒆𝒄𝒕𝒊𝒐𝒏 𝑰𝑫: \(electionId)")
                
                
                
                
                
                
                ForEach(allChoices.indices){ index in
                    
                    HStack{
                        
                    Text("\(index + 1)")
                    
                    Text(allChoices[index])
              
                    .frame(width: 310.0, height: 30.0)
                  
                    .background(Color.yellow)
                    .cornerRadius(10)
                        
                    
                    }
                   
                    
                }
                
                
                if (wantCreatorVote == true){
                    
                    Text("𝑻𝒂𝒑 𝒚𝒐𝒖𝒓 𝒏𝒂𝒎𝒆 𝒊𝒇 𝒚𝒐𝒖 𝒘𝒂𝒏𝒕 𝒕𝒐 𝒑𝒐𝒍𝒍")
                    Text("𝒕𝒉𝒆𝒏 𝒑𝒓𝒆𝒔𝒔 𝒘𝒂𝒏𝒕 𝒑𝒐𝒍𝒍! 𝑶𝒕𝒉𝒆𝒓𝒘𝒊𝒔𝒆 𝒕𝒂𝒑 X")
                    
                    HStack{
                        
                    
                        TextField("Name", text: $nameOfPolledPerson)
                        .padding(.leading, 4.0)
                        .frame(width: 220, height: 30)
                        .background(Color.white)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    
                        
                        
                        Button(action: {
                            
                            nameOfPolledPerson = ""
                            wantCreatorVote = false
                            
                            
                            
                        }) {
                            Text("X")
                          
                            
                        }
                        
                        
                    }
                    
                    
                    
                }
                
             
                VStack{
                    
                
                    
                
                
                NavigationLink(destination: VoteView( creatorElectionId: electionId, goBackToRootView: $goBackToRootView, userElectionId:"" , setAndGetData:setAndGetData,nameOfParticipant: nameOfPolledPerson), isActive: $goToVoteView){
                    
                    
                    
                    
                    Button(action: {
                        
                        wantCreatorVote = true
                        
                        let nameOfPolledPersonRemoveSpace = nameOfPolledPerson.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        if (nameOfPolledPersonRemoveSpace != ""){
                            
                            
                            
                               setAndGetData.getallChoicesFromFb(electionId:electionId){
                                
                            
                                   
                                goToVoteView = true
                                
                                
                                
                            }
                            
                        }
                        
                        
                        
                    }) {
                        
                        ButtonView(buttonText: "Want poll")
                            .padding(.bottom)
                           
                        
                    }.alert("Write your name first", isPresented :$isShowingAlert ){
                        
                        Button("Ok") {
                    
               
                            
                        }
                        
                        
                        }
                   
                    
                    
                    
                    
                }
                
                
                
                if (wantCreatorVote == false){
                    
                Button(action: {
                    
                    isShowingAlertForDeleteelectionId =  true
                    
                }) {
                    
                    ButtonView(buttonText: "Create new")
                    
                }.padding(.bottom, 10.0).alert("Are you sure? you going to delete your already created current Election!", isPresented :$isShowingAlertForDeleteelectionId ){
                    
                    Button("Delete anyway" , role: .destructive) {
                        
                        setAndGetData.deleteElectionId(electionId: electionId)
                        goBackToRootView = false
                        
                    }
                    
                    
                    
                    
                }
                
               
                
                NavigationLink(destination: ResultView(goBackToRootView: $goBackToRootView, electionId: electionId, hideBackButton: false), isActive: $goToResultView){
                    
                    Button(action: {
                        
                        
                      
                            
                isShowingAlertIfCreatorWantJoin = true

                        
                        
                        
                    }) {
                        ButtonView(buttonText: "See Result")
                    }
                    .padding(.bottom, 10.0).alert("You cant see result before you have polled! If you dont want to join/poll tap i will not join", isPresented :$isShowingAlertIfCreatorWantJoin  ){
                        
                        Button("I will not join" , role: .destructive) {
                            
                            wantCreatorVote = false
                            
                            let controlIfCreatorWantTovote = "\(electionId)2"
                            
                            UserDefaults.standard.set(wantCreatorVote , forKey: controlIfCreatorWantTovote)
                            
                            goToResultView = true

                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                }
                
                
                
                
            
                
                
                Button(action: {
                    
                
                   isShowingAlertForLogOut = true
           
                    
                }) {
                    
                    ButtonView(buttonText: "Log Out")
                    
                }
                .padding(.bottom, 10.0)
                .alert("OBS: you should remember your election iD \(electionId) if you want to log out", isPresented :$isShowingAlertForLogOut ){
                    
                    Button("Ok Log Out", role: .destructive) {
                        
                        wantCreatorVote = true
                        
                        let controlIfCreatorWantTovote = "\(electionId)2"
                        
                        UserDefaults.standard.set(wantCreatorVote , forKey: controlIfCreatorWantTovote)
                        goBackToRootView = false
                        
                    }
                    
                    
                    }
                
           
                }
                    
                }
                .padding(.leading, 15)

                Spacer(minLength: 145)
                
                    .navigationBarBackButtonHidden(true)
                
                

            }.onAppear(perform: {
                
                
                isCreatorInThisView = true
                let controlIfCreatorInThisView = "\(electionId)1"
                
                UserDefaults.standard.set(isCreatorInThisView, forKey: controlIfCreatorInThisView)
                
                nameOfPolledPerson = ""
                wantCreatorVote = false
                
                
            })
            
        
            
        }
        
    }
    
    
}




struct ShowElectionview_Previews: PreviewProvider {
    static var previews: some View {
        ShowElectionview(goBackToRootView: .constant(false))
    }
}
