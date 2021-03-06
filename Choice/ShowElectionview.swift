

import SwiftUI

struct ShowElectionview: View {
    
    @State var allChoices : [String] = [""]
    @State var electionId = ""
    @State var goToVoteView = false
    @State var isShowingAlertForDeleteelectionId = false
    @State var isShowingAlertForLogOut = false
    @State var isShowingAlert = false
    
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
                        
                        Text("πΊππππ ππππ π°π«").font(.title3)
                        Text("\(electionId)")
                            .frame(width: 100, height: 25)
                            .background(Color.green)
                            .cornerRadius(5)
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
                    
                    Text("πΎππππ ππππ ππππ ππ ππππ ππππ").font(.title3)
                    
               
                        
                    VStack{
                        
                    
                        TextField("π΅πππ", text: $nameOfPolledPerson)
                            .padding(.leading, 4.0)
                            .frame(width: 300, height: 30)
                            .background(Color.white)
                            .cornerRadius(6)
                        
                    }
                    .padding(.leading, 15.0)
                    
                    
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
                            
                            ButtonViewGreen(buttonText: "π±πππ ππππ").shadow(radius: 15)
                            
                        }.padding(.vertical).alert("π΅π ππππππππ ππππππππππ", isPresented :$isShowingAlert ){
                            
                            Button("πΆπ") {
                                
                                
                                
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
                                .cornerRadius(10)
                        }.padding()
                        
                    }
                    
                    
                    
                    
                    if (wantCreatorVote == false){
                        
                        Button(action: {
                            
                            isShowingAlertForDeleteelectionId =  true
                            
                        }) {
                            
                            ButtonView(buttonText: "πͺπππππ πππ ππππ").shadow(radius: 15)
                            
                        }.padding(.bottom, 10.0).alert("π¨ππ πππ ππππ? πππ are πππππ ππ ππππππ ππππ πππππππ πππππππ ππππ", isPresented :$isShowingAlertForDeleteelectionId ){
                            
                            Button("π«πππππ ππππππ" , role: .destructive) {
                                
                                setAndGetData.deleteElectionId(electionId: electionId)
                                goBackToRootView = false
                                
                            }
                            
                            
                            
                            
                        }
                        
                        
                        
                        NavigationLink(destination: ResultView(goBackToRootView: $goBackToRootView, electionId: electionId), isActive: $goToResultView){
                            
                            Button(action: {
                                
                                
                                
                                
                                isShowingAlertIfCreatorWantJoin = true
                                
                                
                                
                                
                            }) {
                                ButtonView(buttonText: "πΊππ ππππππ ").shadow(radius: 15)
                            }
                            .padding(.bottom, 10.0).alert("πππ ππππ πππ πππ ππππππ ππππππ πππ ππππ ππππππ! π°π πππ ππππ ππππ ππ ππππ πππ π ππππ πππ ππππ. π°π πππ πππ π° ππππ πππ ππππ, πππ πππ'π ππππ πππππ", isPresented :$isShowingAlertIfCreatorWantJoin  ){
                                
                                Button("π° ππππ πππ ππππ" , role: .destructive) {
                                    
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
                            
                            ButtonView(buttonText: "π³ππ oππ").shadow(radius: 15)
                            
                        }
                        .padding(.bottom, 10.0)
                        .alert("πππ ππππππ ππππππππ ππππ ππππ π°π« \(electionId) ππ πππ ππππ ππ πππ πππ", isPresented :$isShowingAlertForLogOut ){
                            
                            Button("πΆπ π³ππ πΆππ", role: .destructive) {
                                
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
