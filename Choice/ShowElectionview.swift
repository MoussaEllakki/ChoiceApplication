

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
    
    @State private var wantCreatorVote = false
    
    
    var body: some View {
        
        
        ZStack{
            
            BackgroundView()
            
            
   
                            

            VStack{
                
                
                Spacer(minLength: 50)
                
                Text("Election ID: \(electionId)").padding()
                
         
               
                
                
                
                
                
                
                
                
                ForEach(allChoices.indices){ index in
                    
                    HStack{
                        
                    Text("\(index + 1)").padding(2)
                    
                    Text(allChoices[index])
                    .frame(width: 330.0, height: 30.0)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .background(Color.purple)
                    .cornerRadius(3)
                        
                    
                    }
                    
                }
                
                
                if (wantCreatorVote == true){
                    
                    Text("Tap your name if you want to poll")
                    Text("then press poll,  otherwise tap X")
                    
                    HStack{
                        
                    
                        TextField("Name", text: $nameOfPolledPerson)
                            .padding(.leading, 4.0)
                            .frame(width: 220, height: 30)
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    
                        
                        
                        Button(action: {
                            
                            nameOfPolledPerson = ""
                            wantCreatorVote = false
                            
                            
                            
                        }) {
                            Text("X")
                          
                            
                        }
                        
                        
                    }
                    
                    
                    
                }
                

                
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
                        
                        ButtonView(buttonText: "Poll")
                        
                    } .padding(.vertical, 10.0).alert("Write your name first", isPresented :$isShowingAlert ){
                        
                        Button("Ok") {
                    
               
                            
                        }
                        
                        
                        }
                   
                    
                    
                    
                    
                }
                
                
                
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
                
               
                
                NavigationLink(destination: ResultView(goBackToRootView: $goBackToRootView, electionId: electionId), isActive: $goToResultView){
                    
                    Button(action: {
                        
                        
                      
                            
                            goToResultView = true

                        
                        
                        
                    }) {
                        ButtonView(buttonText: "See Result")
                    }
                    .padding(.bottom, 10.0)
                    
                    
                }
                
                
                
                
            
                
                
                Button(action: {
                    
                
                   isShowingAlertForLogOut = true
           
                    
                }) {
                    
                    ButtonView(buttonText: "Log Out")
                    
                }
                .padding(.bottom, 10.0)
                .alert("OBS: you should remember your election id if you want to log out", isPresented :$isShowingAlertForLogOut ){
                    
                    Button("Ok Log Out", role: .destructive) {
                
                        goBackToRootView = false
                        
                    }
                    
                    
                    }
                
                    Spacer(minLength: 100)
                
                    .navigationBarBackButtonHidden(true)
                
                
           
                
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
