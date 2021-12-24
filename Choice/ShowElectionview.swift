

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
                
                

                
              
                
      
                
                
                if(wantCreatorVote == false){
                    
                    
                
                    
                    HStack{
                        
                        Text("𝑺𝒉𝒂𝒓𝒆 𝒑𝒐𝒍𝒍 𝑰𝑫")
                        Text("\(electionId)")
                            .frame(width: 100, height: 20)
                            .background(Color.white)
                            .cornerRadius(10)
                     }
                    
                    
                    HStack{
                        
                    
                Spacer()
                        
                        ScrollView(.horizontal){
                            
                            Text(setAndGetData.pollName).padding()
                        
                            
                        }.frame(width: 300.0, height: 30.0)
                    
                    Spacer()
                          
                    }
               
                        
                    
                    
                    ForEach(allChoices.indices){ index in
                       
                        
                        
                        HStack{
                            
                            Text("\(index + 1)")

                            ScrollView (.horizontal){
                                
                            
                            
                           
                            
                            Text(allChoices[index])
                        
                            }
                            .padding(.leading, 10)
                            .frame(width: 300.0, height: 30.0)
                            .background(Color.white)
                            .cornerRadius(10)
                            

                        }
                        
                        
                    }
                        
                    
                    
                }
                
                
                
                
                
                
                if (wantCreatorVote == true){
                    
                    
                    Spacer(minLength: 70)
                    
                    Text("𝑾𝒓𝒊𝒕𝒆 𝒚𝒐𝒖 𝒏𝒂𝒎𝒆 𝒕𝒐 𝒋𝒐𝒊𝒏 𝒑𝒐𝒍𝒍")
                    
                    HStack{
                        
                        
                             TextField("𝑵𝒂𝒎𝒆", text: $nameOfPolledPerson)
                            .padding(.leading, 4.0)
                            .frame(width: 220, height: 30)
                            .background(Color.white)
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        
                        
                        
                        
                       }
                    
                    
                    
                    
                }
                
                
                VStack{
                    
                    
                    
                    
                    
                    NavigationLink(destination: VoteView( creatorElectionId: electionId, goBackToRootView: $goBackToRootView, userElectionId:"" , setAndGetData:setAndGetData,nameOfParticipant: nameOfPolledPerson), isActive: $goToVoteView){
                        
                        
                        
                        
                        Button(action: {
                            
                            wantCreatorVote = true
                            
                            let nameOfPolledPersonRemoveSpace = nameOfPolledPerson.trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            if (nameOfPolledPersonRemoveSpace != ""){
                                
                                
                                
                                
                                setAndGetData.getallChoicesFromFb(electionId:electionId){
                                    
                                    
                                    if(setAndGetData.isThereInternet == true){
                                        
                                        
                                    
                                        
                                        goToVoteView = true
                                        
                                    }
                                    
                                    
                                    
                                    else  if (setAndGetData.isThereInternet == false){
                                        
                                        
                                        
                                        isShowingAlert = true
                                        
                                    }
                             
                               
                                    
                                    
                                    
                                    
                                }
                                
                        }
                            
                            
                    }) {
                            
                            ButtonView(buttonText: "𝑷𝒐𝒍𝒍")
                            
                        }.padding(.vertical).alert("𝑵𝒐 𝒊𝒏𝒕𝒆𝒓𝒏𝒆𝒕 𝒄𝒐𝒏𝒏𝒆𝒄𝒕𝒊𝒐𝒏", isPresented :$isShowingAlert ){
                            
                            Button("𝑶𝒌 " ) {
                                
                        
                                
                            }
                      
                        
                        
                        
                        
                        
                        
                    }
                    
                    }
                    
                       if  (wantCreatorVote == true){
                        
                        Button(action: {
                            
                            nameOfPolledPerson = ""
                            wantCreatorVote = false
                            
                            
                            
                        }) {
                            Text("Cancel")
                                .frame(width: 300, height: 35)
                                .background(Color.red)
                                .foregroundColor(Color.white)
                                .cornerRadius(20)
                        }.padding()
                        
                    }
                    
                    
                    
                    
                    if (wantCreatorVote == false){
                        
                        Button(action: {
                            
                            isShowingAlertForDeleteelectionId =  true
                            
                        }) {
                            
                            ButtonView(buttonText: "𝑪𝒓𝒆𝒂𝒕𝒆 𝑵𝒆𝒘 𝒑𝒐𝒍𝒍")
                            
                        }.padding(.bottom, 10.0).alert("𝑨𝒓𝒆 𝒚𝒐𝒖 𝒔𝒖𝒓𝒆? 𝒀𝒐𝒖 are 𝒈𝒐𝒊𝒏𝒈 𝒕𝒐 𝒅𝒆𝒍𝒆𝒕𝒆 𝒚𝒐𝒖𝒓 𝒂𝒍𝒓𝒆𝒂𝒅𝒚 𝒄𝒓𝒆𝒂𝒕𝒆𝒅 𝒑𝒐𝒍𝒍", isPresented :$isShowingAlertForDeleteelectionId ){
                            
                            Button("𝑫𝒆𝒍𝒆𝒕𝒆 𝒂𝒏𝒚𝒘𝒂𝒚" , role: .destructive) {
                                
                                setAndGetData.deleteElectionId(electionId: electionId)
                                goBackToRootView = false
                                
                            }
                            
                            
                            
                            
                        }
                        
                        
                        
                        NavigationLink(destination: ResultView(goBackToRootView: $goBackToRootView, electionId: electionId), isActive: $goToResultView){
                            
                            Button(action: {
                                
                                
                                
                                
                                isShowingAlertIfCreatorWantJoin = true
                                
                                
                                
                                
                            }) {
                                ButtonView(buttonText: "𝑺𝒆𝒆 𝒓𝒆𝒔𝒖𝒍𝒕 ")
                            }
                            .padding(.bottom, 10.0).alert("𝒀𝒐𝒖 𝒄𝒂𝒏𝒕 𝒔𝒆𝒆 𝒕𝒉𝒆 𝒓𝒆𝒔𝒖𝒍𝒕 𝒃𝒆𝒇𝒐𝒓𝒆 𝒚𝒐𝒖 𝒉𝒂𝒗𝒆 𝒑𝒐𝒍𝒍𝒆𝒅! 𝑰𝒇 𝒚𝒐𝒖 𝒅𝒐𝒏𝒕 𝒘𝒂𝒏𝒕 𝒕𝒐 𝒑𝒐𝒍𝒍 𝒕𝒂𝒑 𝒊 𝒘𝒊𝒍𝒍 𝒏𝒐𝒕 𝒋𝒐𝒊𝒏. 𝑰𝒇 𝒚𝒐𝒖 𝒕𝒂𝒑 𝑰 𝒘𝒊𝒍𝒍 𝒏𝒐𝒕 𝒋𝒐𝒊𝒏, 𝒚𝒐𝒖 𝒄𝒂𝒏'𝒕 𝒑𝒐𝒍𝒍 𝒍𝒂𝒕𝒆𝒓", isPresented :$isShowingAlertIfCreatorWantJoin  ){
                                
                                Button("𝑰 𝒘𝒊𝒍𝒍 𝒏𝒐𝒕 𝒋𝒐𝒊𝒏" , role: .destructive) {
                                    
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
                            
                            ButtonView(buttonText: "𝑳𝒐𝒈 𝑶𝒖𝒕")
                            
                        }
                        .padding(.bottom, 10.0)
                        .alert("𝒀𝒐𝒖 𝒔𝒉𝒐𝒖𝒍𝒅 𝒓𝒆𝒎𝒆𝒎𝒃𝒆𝒓 𝒚𝒐𝒖𝒓 𝒑𝒐𝒍𝒍 𝑰𝑫 \(electionId) 𝒊𝒇 𝒚𝒐𝒖 𝒘𝒂𝒏𝒕 𝒕𝒐 𝒍𝒐𝒈 𝒐𝒖𝒕", isPresented :$isShowingAlertForLogOut ){
                            
                            Button("𝑶𝒌 𝑳𝒐𝒈 𝑶𝒖𝒕", role: .destructive) {
                                
                                wantCreatorVote = true
                                
                                let controlIfCreatorWantTovote = "\(electionId)2"
                                
                                UserDefaults.standard.set(wantCreatorVote , forKey: controlIfCreatorWantTovote)
                                goBackToRootView = false
                                
                            }
                            
                            
                        }
                        
                        
                    }
                    
                    Spacer(minLength: 145)
                    
                }
                .padding(.leading, 15)
                
                
                
                .navigationBarBackButtonHidden(true)
                
                
                
            }.onAppear(perform: {
                
                
                isCreatorInThisView = true
                let controlIfCreatorInThisView = "\(electionId)1"
                
                UserDefaults.standard.set(isCreatorInThisView, forKey: controlIfCreatorInThisView)
                
                nameOfPolledPerson = ""
                wantCreatorVote = false
                
                setAndGetData.getPollName(electionId: electionId){
                    
                    
                }
                
                
            })
            
            
            
        }
        
    }
    
    
}




struct ShowElectionview_Previews: PreviewProvider {
    static var previews: some View {
        ShowElectionview(goBackToRootView: .constant(false))
    }
}
