

import SwiftUI

struct ShowElectionview: View {
    
    @State  var allChoices : [String] = [""]
    
    @State var electionId = ""
    
    @State var goToVoteView = false
    
    @State var   isShowingAlert = false
    
    @Binding  var goBackToRootView : Bool
    
    @State private var setAndGetData = SetAndGetData()
    
    @State private var goToResultView = false
    
    @State private var nickName = ""
    
    @State private var wantCreatorVote = false
    
    var body: some View {
        
        
        ZStack{
            
            BackgroundView()
            
           
            
            VStack{
                
           
             
                Spacer(minLength: 140)
            
                
               Text("Share Election ID \(electionId)")
             
                
                
                if (wantCreatorVote == true){
                    
                    Text("Write a nickname").padding()
                    
                    HStack{
                        
                    
                    TextField("Write NickName", text: $nickName)
                    .padding(.leading, 4.0)
                    .frame(width: 270, height: 35.0)
                    .background(Color.yellow)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            
                     
                        
                        Button(action: {
                            
                            nickName = ""
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
                
                
                NavigationLink(destination: VoteView( creatorElectionId: electionId, userElectionId:"" , setAndGetData:setAndGetData, nickName: nickName), isActive: $goToVoteView){
                    
                    
                    
                    
                    Button(action: {
                        
                        wantCreatorVote = true
                        
                        if (nickName != ""){
                            
                        
                            
                        setAndGetData.getallChoicesFromFb(electionId:electionId){
                          
                            goToVoteView = true
                          
                   
                            
                        }
                            
                        }
         
                        
                    }) {
                        
                        ButtonView(buttonText: "Vote")
                        
                    }
                    .padding(.vertical, 20.0)
                
                   
                    
                }
                
          
                
                Button(action: {
                    
                    isShowingAlert =  true
                    
                }) {
                    
                    ButtonView(buttonText: "Create new")
                    
                }.padding(.bottom, 30.0).alert("Are you sure? you going to delete your already created current Election!", isPresented :$isShowingAlert ){
                    
                    Button("Delete anyway" , role: .destructive) {
                        
                        setAndGetData.deleteElectionId(electionId: electionId)
                        goBackToRootView = false
                        
                    }

                
            
                
            }
               
                
                
                NavigationLink(destination: ResultView(goToResultView: $goBackToRootView), isActive: $goToResultView){
                    
                    Button(action: {
                        
                        
                        goToResultView = true
                        
                    }) {
                      ButtonView(buttonText: "See Result")
                    }

                    
                }
               
                
                
                
                Spacer(minLength: 500)
          
                
                
                
                
            .navigationBarBackButtonHidden(true)

            
                Spacer()
                
            }.onAppear(perform: {
                
                nickName = ""
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
