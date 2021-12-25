
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
    
    
    var body: some View {
        
        ZStack{
            
            BackgroundView()
            
            VStack{
                
                Spacer(minLength: 50)
                
                
                HStack{
                    Text("𝑷𝒐𝒍𝒍 𝑰𝑫:").font(.title3)
                    
                    Text("\(electionId)")
                        .frame(width: 100, height: 25)
                        .background(Color.green)
                        .cornerRadius(5)
                }.padding()
                
                if (showResult == true){
                    
                    let allChoices =  setAndGetData.allChoices.sorted(by: { $0.votes > $1.votes })
                    
                    HStack{
                        
                        Spacer()
                        
                        ScrollView(.horizontal){
                            
                            Text(setAndGetData.pollName).padding()
                            
                        }
                        .frame(width: 250.0, height: 30.0)
                        
                        
                        Text("𝑽𝒐𝒕𝒆𝒔")
                            .frame(width: 65.0, height: 25.0)
                            .background(Color.orange).cornerRadius(5)
                        
                        
                        Spacer()
                        
                    }
                    
                    
                    ForEach(allChoices.indices){ index in
                        
                        
                        HStack{
                            
                            HStack{
                                
                                Text("\(index + 1)").padding(2)
                                
                                
                                ScrollView (.horizontal){
                                    
                                    
                                    Text(allChoices[index].name)
                                }
                                .padding(.leading, 10.0)
                                .frame(width: 240.0, height: 30.0)
                                .background(Color.white)
                                .cornerRadius(5)
                                
                                
                            }
                            
                            Text("\(allChoices[index].votes)")
                                .frame(width: 75.0, height: 30.0)
                                .background(Color.white)
                                .cornerRadius(5)
                            
                        }.padding(.horizontal, 5.0)
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
                            ButtonView(buttonText: "𝑺𝒆𝒆 𝒂𝒍𝒍 𝒑𝒂𝒓𝒕𝒊𝒄𝒊𝒑𝒂𝒏𝒕𝒔").shadow(radius: 15)
                        }
                        
                        
                    }.padding().alert("𝑵𝒐 𝒐𝒏𝒆 𝒑𝒐𝒍𝒍𝒆𝒅 𝒚𝒆𝒕", isPresented :$isShowingAlert ){
                        
                        Button("𝑶𝑲") {
                        }
                        
                    }
                    
                    
                    Button(action: {
                        
                        isShowingAlertForLogOut = true
                        
                        
                    }) {
                        
                        ButtonView(buttonText: "𝑳𝒐𝒈 o𝒖𝒕")
                        
                    }.padding(.top).alert("𝒀𝒐𝒖 𝒔𝒉𝒐𝒖𝒍𝒅 𝒓𝒆𝒎𝒆𝒎𝒃𝒆𝒓 𝒚𝒐𝒖𝒓 𝒑𝒐𝒍𝒍 𝑰𝑫 \(electionId) 𝒊𝒇 𝒚𝒐𝒖 𝒘𝒂𝒏𝒕 𝒕𝒐 𝒍𝒐𝒈 𝒐𝒖𝒕", isPresented :$isShowingAlertForLogOut ){
                        
                        Button("𝑶𝒌 𝒍𝒐𝒈 𝒐𝒖𝒕", role: .destructive) {
                            
                            showResult = false
                            
                            goBackToRootView = false
                        }
                        
                    }
                    
                }.padding(.leading, 15)
                
                Spacer(minLength: 330)
                
                    .navigationBarBackButtonHidden(true)
                
            }.onAppear(perform: {
                
                setAndGetData.uppdateAllChoices(electionId: electionId){
                    
                    setAndGetData.getPollName(electionId: electionId){
                        
                        showResult = true
                    }
                    
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
