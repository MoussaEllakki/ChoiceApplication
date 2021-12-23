
import SwiftUI

struct MainView: View {
    
    @State var countOfParticipant = ""
    @State var countOfChoices = ""
    @State var goBackToRootView : Bool =  false
    @State var goToChooseElectionIdView : Bool =  false
    @State var goToShowElectionView = false
    @State var  goToshowResultView : Bool =  false
    @State var  goToResultView : Bool =  false
    @State var  isShowingAlert = false
    @State  private var messageToTheUser = ""
    
    @State private var visa = false
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                BackgroundView()
                
                
                ScrollView{
                    
                   Spacer()
                        
                ZStack(alignment: .top){



                Text("𝑪𝒉𝒐𝒊𝒄𝒆")
                .font(.largeTitle)
                .fontWeight(.bold)


                    
                    if (visa == true){
                        
                        
                        LottieView(animationName: "jump", loopMode: .loop)  .frame(width:370, height: 140 )

                    }
                              
                  


                }
                   
                    
                    
                    
                    HStack{
                        
                        Spacer()
             
                        Text("𝑷𝒂𝒓𝒕𝒊𝒄𝒊𝒑𝒂𝒏𝒕 𝒄𝒐𝒖𝒏𝒕")
                        
           
                        Spacer()
                        
              
                        Text("𝑪𝒉𝒐𝒊𝒄𝒆 𝒄𝒐𝒖𝒏𝒕")
                            .padding(.trailing, 24.0)
                         
                     Spacer()
                    }
                    
                    
                    VStack{
                        
                        HStack(spacing: 10){
                            
                            Spacer()
                            
                            TextField("", text: $countOfParticipant)
                                .padding(.leading, 7.0)
                                .frame(width: 160, height: 30)
                                .background(Color.white)
                                .cornerRadius(6)
                                .keyboardType(.numberPad)
                            
                            TextField("", text: $countOfChoices)
                                .padding(.leading, 7.0)
                                .frame(width: 160, height: 30)
                                .background(Color.white)
                                .cornerRadius(6)
                                .keyboardType(.numberPad)
                            
                            Spacer()
                        }
                        
                    }
                    
                    Spacer(minLength: 20)
                    
                    VStack{
                        
                    
                    
                    NavigationLink(destination: FillChoicesView(countOfChoices: countOfChoices, countOfParticipant: countOfParticipant, goBackToRootView: $goBackToRootView), isActive: $goBackToRootView ){
                        Button(action: {
                            
                            ControlInput()
                            
                        }){
                            ButtonView(buttonText: "𝑪𝒓𝒆𝒂𝒕e 𝑷𝒐𝒍𝒍")
                        }.padding(.bottom, 20.0).alert(messageToTheUser, isPresented :$isShowingAlert ){
                            Button("𝑶𝒌") {
                                
                            }
                        }
                    }
                    
                    
                    NavigationLink(destination: ChooseElectionIdView(goBackToRootView: $goToChooseElectionIdView), isActive: $goToChooseElectionIdView){
                        
                        Button(action: {
                            goToChooseElectionIdView = true
                        }){
                            ButtonView(buttonText: "𝑱𝒐𝒊𝒏 𝑷𝒐𝒍𝒍")
                        }.padding(.bottom, 20.0)
                    }
                    
                    
                    NavigationLink(destination: ToshowResultView(goToResultView: $goToResultView), isActive: $goToResultView){
                        
                        Button(action: {
                            
                            goToResultView = true
                            
                        }){
                            ButtonView(buttonText: "𝑺𝒆𝒆 r𝒆𝒔𝒖𝒍𝒕")
                        }   .padding(.bottom, 20.0)
                    }
                    
                    
                    
                        

                    }
                
                    Spacer()
                    
                }
                
               
                
            }.onAppear(perform: {
                
             visa = true
                
                goBackToRootView = false
                countOfChoices = ""
                countOfParticipant = ""
            }).onDisappear(perform: {
                visa = false
                
            })
            
        }.accentColor( .black)
            .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    func ControlInput (){
        
        if (countOfParticipant != "" && countOfChoices != ""){
            
            let countOfParticipantToInteger = Int (countOfParticipant)
            let  countOfChoicesToInteger = Int (countOfChoices)
            
            if (countOfParticipantToInteger! < 2 ){
                messageToTheUser = "𝑴𝒊𝒏𝒊𝒎𝒖𝒎 2 𝑷𝒂𝒓𝒕𝒊𝒄𝒊𝒑𝒂𝒏𝒕𝒔"
                isShowingAlert = true
            }
            
            else {
                
                if ( countOfChoicesToInteger! < 2 ||  countOfChoicesToInteger! > 5){
                    
                    messageToTheUser = "𝑴𝒊𝒏𝒊𝒎𝒖𝒎 2 𝒂𝒏𝒅 𝒎𝒂𝒙𝒊𝒎𝒖𝒎 5 𝑪𝒉𝒐𝒊𝒄𝒆𝒔 "
                    isShowingAlert = true
                }
                
                else {
                    
                    goBackToRootView = true
                    
                }
            }
            
        }
        
        else {
            
            messageToTheUser = "𝑭𝒊𝒍𝒍 𝒊𝒏 𝒑𝒂𝒓𝒕𝒊𝒄𝒊𝒑𝒂𝒏𝒕 𝒄𝒐𝒖𝒏𝒕 𝒂𝒏𝒅 𝒄𝒉𝒐𝒊𝒄𝒆 𝒄𝒐𝒖𝒏𝒕 𝒊𝒏 𝒐𝒓𝒅𝒆𝒓 𝒕𝒐 𝒄𝒐𝒏𝒕𝒊𝒏𝒖𝒆"
            isShowingAlert = true
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
