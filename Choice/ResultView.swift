
import SwiftUI

struct ResultView: View {
    
    
 
    
    @Binding var  goBackToRootView  : Bool
    
    @State private var goToAllParticipantView = false
    
    @ObservedObject var setAndGetData = SetAndGetData()
    
    @State var electionId = ""

    @State private var isShowingAlertForLogOut = false
    
    @State private var isShowingAlert = false
    
    @State private var showResult = false
    
   @State var isCreatorHereInThisView = false
    
   @State var  hideBackButton = true
    
    var body: some View {
        
        
        
        ZStack{
            
           BackgroundView()
           
            VStack{
                
                
                Spacer(minLength: 50)
                
                
                HStack{
                    Text("𝑷𝒐𝒍𝒍 𝑰𝑫:")
                    Text("\(electionId)")
                        .frame(width: 100, height: 20)
                        .background(Color.white)
                        .cornerRadius(10)
                }.padding()
                
                  
                if (showResult == true){
                    
            
                    let allChoices =  setAndGetData.allChoices.sorted(by: { $0.votes > $1.votes })
                    
                
                
                    ForEach(allChoices.indices){ index in
                    
                    
                
                    HStack{
                        
       
                       Text("\(index + 1)").padding(2)
                        
                        if (allChoices[index].votes == 1){
                            
                        Text("\(allChoices[index].name)  \(allChoices[index].votes)  Vote")
                        .frame(width: 310.0, height: 30.0)
                        .background(Color.yellow)
                        .cornerRadius(15)
                            
                            
                        }
                        
                        else{
                            
                            Text("\(allChoices[index].name)  \(allChoices[index].votes)  Votes")
                            .frame(width: 310.0, height: 30.0)
                            .background(Color.yellow)
                            .cornerRadius(15)
                        }
                       
                        
                  
                        
                      
                 
                        
                        
                        
                    }
                        
                    
                }
                   
                }
                
                VStack{
                    
                
                
                NavigationLink(destination:AllParticipantView(setAndGetData: setAndGetData, electionId: electionId), isActive: $goToAllParticipantView){
                        
                        Button(action: {
                            
                      
                      
                            setAndGetData.getCountOfPolled(electionId: electionId){
                                
                                
                       
                                if(setAndGetData.countOfPolled == 0){
                                    
                          
                                    
                                   isShowingAlert = true
                                    
                                    
                                }
                                
                                else {
                                    
                          
                                    
                      
                                  showResult = false
                                  goToAllParticipantView = true
                       
                              
                                
                                
                                
                                    
                                }

                            }
                  
              

                            
                        }) {
                        ButtonView(buttonText: "𝑺𝒆𝒆 𝑨𝒍𝒍 𝑷𝒂𝒓𝒕𝒊𝒄𝒊𝒑𝒂𝒏𝒕")
                        }
                        
                        
                    }.padding().alert("𝑵𝒐 𝒐𝒏𝒆 𝒑𝒐𝒍𝒍𝒆𝒅 𝒚𝒆𝒕 𝒕𝒐𝒐 𝒔𝒆𝒆 𝒂𝒍𝒍 𝑷𝒂𝒓𝒕𝒊𝒄𝒊𝒑𝒂𝒏𝒕", isPresented :$isShowingAlert ){
                        
                        Button("𝑶𝑲") {
                    
                      
                            
                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                
            
                
                
                Button(action: {
                    
                
                isShowingAlertForLogOut = true
           
                    
                }) {
                    
                    ButtonView(buttonText: "𝑳𝒐𝒈 𝑶𝒖𝒕")
                    
                }.padding(.top).alert("𝑶𝑩𝑺: 𝒚𝒐𝒖 𝒔𝒉𝒐𝒖𝒍𝒅 𝒓𝒆𝒎𝒆𝒎𝒃𝒆𝒓 𝒚𝒐𝒖𝒓 𝒆𝒍𝒆𝒄𝒕𝒊𝒐𝒏 𝑰𝑫 \(electionId) 𝒊𝒇 𝒚𝒐𝒖 𝒘𝒂𝒏𝒕 𝒕𝒐 𝒍𝒐𝒈 𝒐𝒖𝒕", isPresented :$isShowingAlertForLogOut ){
                    
                    Button("𝑶𝒌 𝒍𝒐𝒈 𝒐𝒖𝒕", role: .destructive) {
                        
                      showResult = false
                        
                        goBackToRootView = false
                        
                        
                    }
                    
                    
                    
                    
                }
                
               
                }.padding(.leading, 15)
             
                
                
            Spacer(minLength: 300)
                
                
     
                    
                    .navigationBarBackButtonHidden(hideBackButton)

                
              
           
                
            }.onAppear(perform: {
                
                setAndGetData.uppdateAllChoices(electionId: electionId){
                    
              
                    
            

                    showResult = true
                    
                    
                }
                
                
            })
            
            
         }
        
        
    }
  
  
    
    
    
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(goBackToRootView: .constant(false))
    }
}
