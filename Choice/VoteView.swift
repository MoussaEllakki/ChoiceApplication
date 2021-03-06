
import SwiftUI

struct VoteView: View {
    
    @State private var ispolled = false
    @State private var whichChoice  = -10
    @State private var whichColor = Color.red
    
    @State  var creatorElectionId = ""
    @Binding  var goBackToRootView : Bool
    
    @State  var userElectionId = ""
    
    @State private var electionId = ""
    
    @ObservedObject var setAndGetData = SetAndGetData()
    
    @State private var goToConfirmView = false
    
    @State var nameOfParticipant = ""
    
    @State var messageToUser = ""
    
    @State private var isShowingAlert = false
    
    @State private var isShowingAlertForLogOut = false
    
    @State private var isAllPolled = false
    
    @State private var wantCreatorVote = true
    
    var body: some View {
        
        
        ZStack{
            
            BackgroundView()
            
            
            
            
            if (isAllPolled == true){
                
                VStack{
                    
                    
                    
                    Spacer()
                    Text("πΆπ·πΊ!")
                    Text("πΊππππ πππ ππππ ππππ! π©ππππππ πππ ππππππππππππ ππππ ππππππ").font(.title3)
                        .lineLimit(3)
                        .padding(.horizontal, 20.0)
                    
                    
                    Button(action: {
                        
                        goBackToRootView = false
                        
                    }) {
                        
                        ButtonView(buttonText: "πΆπ πππ πππ")
                    }.padding()
                    
                    
                    Spacer(minLength: 300)
                    
                        .navigationBarBackButtonHidden(true)
                    
                }
                
            }
            
            else {
                
                
                VStack{
                    
                    Spacer(minLength: 50)
                    
                    
                    
                    
                    
                    
                    HStack{
                        Text("π·πππ π°π«:").font(.title3)
                        Text("\(electionId)")
                            .frame(width: 100, height: 25)
                            .background(Color.green)
                            .cornerRadius(5)
                    }
                    
                    
                    
                    
                    HStack{
                        
                        Spacer()
                        
                        ScrollView(.horizontal){
                            Text(setAndGetData.pollName).padding()
                            
                            
                            
                        }   .frame(width: 300.0, height: 30.0)
                        
                        Spacer()
                        
                    }
                    
                    
                    ForEach(setAndGetData.allChoices.indices) { index in
                        
                        
                        HStack{
                            
                            
                            Text("\(index + 1)")
                            
                            ScrollView (.horizontal){
                                
                                
                                
                                
                                
                                Text("\(setAndGetData.allChoices[index].name)")
                                
                            }
                            .padding(.leading, 10)
                            .frame(width: 300.0, height: 30.0)
                            .background(whichChoice == index ? .green : .red)
                            .cornerRadius(7)
                            .onTapGesture {
                                
                            whichChoice = index
                            whichColor = Color.green
                                
                            }
                        }
                        
                    }
                    
                    
                    
                    VStack{
                        
                        
                        
                        NavigationLink(destination: ConfirmView(goBackToRootView: $goBackToRootView, nameOfParticipant: nameOfParticipant, electionId : electionId), isActive: $goToConfirmView){
                            
                            Button(action: {
                                
                                
                                
                                poll()
                                
                                
                                
                            }) {
                                
                                ButtonView(buttonText: "π·πππ").shadow(radius: 15)
                                    .padding(.vertical, 20.0)
                                
                            }.alert(messageToUser, isPresented :$isShowingAlert){
                                
                                Button("πΆπ²") {
                                    
                                }
                                
                            }
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                        Button(action: {
                            
                            
                            isShowingAlertForLogOut = true
                            
                            
                        }) {
                            
                            ButtonView(buttonText: "π³ππ oππ").shadow(radius: 15)
                            
                        }.alert("πππ ππππππ ππππππππ ππππ ππππ π°π« \(electionId) ππ πππ ππππ ππ πππ πππ", isPresented :$isShowingAlertForLogOut ){
                            
                            Button("πΆπ π³ππ πΆππ", role: .destructive) {
                                
                                if (creatorElectionId != ""){
                                    
                                    
                                    wantCreatorVote = true
                                    
                                    let controlIfCreatorWantTovote = "\(electionId)2"
                                    
                                    UserDefaults.standard.set(wantCreatorVote , forKey: controlIfCreatorWantTovote)
                                    
                                }
                                goBackToRootView = false
                                
                                
                                
                            }
                            
                            
                            
                            
                        }
                        
                        .navigationBarBackButtonHidden(true)
                        
                        
                    }.padding(.leading, 15)
                    
                    Spacer(minLength: 250)
                }
                
                
                
                
                
            }
            
            
        }.onAppear(perform: {
            
            
            if (creatorElectionId != ""){
                
                
                electionId = creatorElectionId
                
                
            }
            
            
            else {
                
                electionId = userElectionId
                
                
            }
            
            setAndGetData.getCountOfParticipant(electionId: electionId){
                
                
                setAndGetData.getCountOfPolled(electionId:electionId){
                    
                    
                    if (setAndGetData.countOfparticipant == setAndGetData.countOfPolled){
                        
                        isAllPolled = true
                        
                    }
                    
                    
                    
                }
                
                
            }
            
            setAndGetData.getPollName(electionId: electionId){
                
                
            }
            
            
            
        })
        
        
        
        
    }
    
    
    
    
    
    
    
    func poll (){
        
        
        
        if (whichChoice < 0){
            
            messageToUser = "πͺπππππ ππππππ πππππ"
            isShowingAlert = true
            
        }
        
        else {
            
            if (ispolled == false){
                
                
                setAndGetData.poll(electionId: electionId, whichChoice: whichChoice)
                
                setAndGetData.AddVoteAndNameOfParticipant(electionId: electionId, NameOfParticipant: nameOfParticipant)
                
                ispolled = true
                
                UserDefaults.standard.set(ispolled, forKey: electionId)
                
                
                
                goToConfirmView = true
                
            }
            
        }
        
    }
    
    
}
struct VoteView_Previews: PreviewProvider {
    static var previews: some View {
        VoteView(goBackToRootView: .constant(false))
    }
}
