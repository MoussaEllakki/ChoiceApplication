
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
                    
                    
                ZStack(alignment: .top){



                Text("𝑪𝒉𝒐𝒊𝒄𝒆")
                .font(.largeTitle)
                .fontWeight(.bold)


                    
                    if (visa == true){
                        
                        
                        LottieView(animationName: "jump", loopMode: .loop)  .frame(width:370, height: 150 )

                    }
                              
                  


                }
                   
                    
                    HStack{
                        
                        Spacer(minLength: 5)
                        Text("𝑷𝒂𝒓𝒕𝒊𝒄𝒊𝒑𝒂𝒏𝒕 count")
                        Spacer(minLength: 5)
                        Text("𝑪𝒉𝒐𝒊𝒄𝒆 count")
                        Spacer(minLength: 70)
                    }
                    
                    
                    VStack{
                        
                        HStack(spacing: 10){
                            
                            Spacer()
                            
                            TextField("", text: $countOfParticipant)
                                .padding(.leading, 7.0)
                                .frame(width: 160, height: 35)
                                .background(Color.white)
                                .cornerRadius(6)
                                .keyboardType(.numberPad)
                            
                            TextField("", text: $countOfChoices)
                                .padding(.leading, 7.0)
                                .frame(width: 160, height: 35)
                                .background(Color.white)
                                .cornerRadius(6)
                                .keyboardType(.numberPad)
                            
                            Spacer()
                        }
                        
                    }
                    
                    Spacer(minLength: 30)
                    
                    NavigationLink(destination: FillChoicesView(countOfChoices: countOfChoices, countOfParticipant: countOfParticipant, goBackToRootView: $goBackToRootView), isActive: $goBackToRootView ){
                        Button(action: {
                            
                            ControlInput()
                            
                        }){
                            ButtonView(buttonText: "𝑪𝒓𝒆𝒂𝒕e 𝑷𝒐𝒍𝒍")
                        }.padding(.bottom, 30.0).alert(messageToTheUser, isPresented :$isShowingAlert ){
                            Button("Ok") {
                                
                            }
                        }
                    }
                    
                    
                    NavigationLink(destination: ChooseElectionIdView(goBackToRootView: $goToChooseElectionIdView), isActive: $goToChooseElectionIdView){
                        
                        Button(action: {
                            goToChooseElectionIdView = true
                        }){
                            ButtonView(buttonText: "𝑱𝒐𝒊𝒏 p𝒐𝒍𝒍")
                        }.padding(.bottom, 30.0)
                    }
                    
                    
                    NavigationLink(destination: ToshowResultView(goToResultView: $goToResultView), isActive: $goToResultView){
                        
                        Button(action: {
                            
                            goToResultView = true
                            
                        }){
                            ButtonView(buttonText: "𝑺𝒆𝒆 r𝒆𝒔𝒖𝒍𝒕")
                        }   .padding(.bottom, 20.0)
                    }
                    
               
                }
                
                Spacer(minLength: 300)
                
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
                messageToTheUser = "Minimum 2 Participants"
                isShowingAlert = true
            }
            
            else {
                
                if ( countOfChoicesToInteger! < 2 ||  countOfChoicesToInteger! > 5){
                    
                    messageToTheUser = " Choices minimum 2 and maximum 5"
                    isShowingAlert = true
                }
                
                else {
                    
                    goBackToRootView = true
                    
                }
            }
            
        }
        
        else {
            
            messageToTheUser = "Fill in participant count and choice count in order to continue"
            isShowingAlert = true
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
