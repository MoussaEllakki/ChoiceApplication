

import SwiftUI

struct ShowElectionview: View {
    
    @State  var allChoices : [String] = [""]
    
    @State var electionId = ""
    
    @State var goToVoteView = false
    
    @State var   isShowingAlertForDeleteelectionId = false
    
    @State var   isShowingAlertForLogOut = false
    
    @Binding  var goBackToRootView : Bool
    
    @State private var setAndGetData = SetAndGetData()
    
    @State private var goToResultView = false
    
    @State private var nameOfPolledPerson = ""
    
    @State private var wantCreatorVote = false
    
    
    var body: some View {
        
        
        ZStack{
            
            BackgroundView()
            
            
            
            VStack{
                
                
                
                Spacer(minLength: 120)
                
                
                Text("Share Election ID \(electionId)")
                
                
                
                if (wantCreatorVote == true){
                    
                    Text("Write a nickname").padding()
                    
                    HStack{
                        
                        
                        TextField("Write NickName", text: $nameOfPolledPerson)
                            .padding(.leading, 6.0)
                            .frame(width: 270, height: 35.0)
                            .background(Color.yellow)
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        
                        
                        
                        Button(action: {
                            
                            nameOfPolledPerson = ""
                            wantCreatorVote = false
                            
                            
                            
                        }) {
                            SmallButtonView(buttonText: "I wont")
                            
                        }
                        
                        
                    }
                    
                    
                    
                }
                
                
                
                
                
                
                
                ForEach(allChoices.indices){ index in
                    
                    
                    
                    Text(allChoices[index])
                        .frame(width: 350.0, height: 35.0)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    
                    
                    
                }
                
                
                NavigationLink(destination: VoteView( creatorElectionId: electionId, goBackToRootView: $goBackToRootView, userElectionId:"" , setAndGetData:setAndGetData,nameOfParticipant: nameOfPolledPerson), isActive: $goToVoteView){
                    
                    
                    
                    
                    Button(action: {
                        
                        wantCreatorVote = true
                        
                        if (nameOfPolledPerson != ""){
                            
                            
                            
                               setAndGetData.getallChoicesFromFb(electionId:electionId){
                                
                                goToVoteView = true
                                
                                
                                
                            }
                            
                        }
                        
                        
                    }) {
                        
                        ButtonView(buttonText: "Poll")
                        
                    }
                    .padding()
                    
                    
                    
                }
                
                
                
                Button(action: {
                    
                    isShowingAlertForDeleteelectionId =  true
                    
                }) {
                    
                    ButtonView(buttonText: "Create new")
                    
                }.alert("Are you sure? you going to delete your already created current Election!", isPresented :$isShowingAlertForDeleteelectionId ){
                    
                    Button("Delete anyway" , role: .destructive) {
                        
                        setAndGetData.deleteElectionId(electionId: electionId)
                        goBackToRootView = false
                        
                    }
                    
                    
                    
                    
                }
                
               
                
                NavigationLink(destination: ResultView(goBackToRootView: $goBackToRootView), isActive: $goToResultView){
                    
                    Button(action: {
                        
                        
                        goToResultView = true
                        
                    }) {
                        ButtonView(buttonText: "See Result")
                    }
                    
                    
                }.padding()
                
                
                
                
            
                
                
                Button(action: {
                    
                
                   isShowingAlertForLogOut = true
           
                    
                }) {
                    
                    ButtonView(buttonText: "Log Out")
                    
                }.alert("OBS: you should remember your election id if you want to log out", isPresented :$isShowingAlertForLogOut ){
                    
                    Button("Ok Log Out", role: .destructive) {
                
                        goBackToRootView = false
                        
                    }
                    
                    
                    }
                
                
                    .navigationBarBackButtonHidden(true)
                
                
                Spacer(minLength: 100)
                
            }.onAppear(perform: {
                
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
