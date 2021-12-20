
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
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                BackgroundView()
                
                ScrollView{
                    
                    Text("𝑪𝒉𝒐𝒊𝒄𝒆")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer(minLength: 50)
                    
                    HStack{
                        
                        Spacer(minLength: 10)
                        Text("𝑪𝒐𝒖𝒏𝒕 𝒐𝒇 𝑷𝒂𝒓𝒕𝒊𝒄𝒊𝒑𝒂𝒏𝒕")
                        Spacer(minLength: 5)
                        Text("𝑪𝒐𝒖𝒏𝒕 𝒐𝒇 𝑪𝒉𝒐𝒊𝒄𝒆𝒔")
                        Spacer(minLength: 40)
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
                    
                    Spacer(minLength: 40)
                    
                    NavigationLink(destination: FillChoicesView(countOfChoices: countOfChoices, countOfParticipant: countOfParticipant, goBackToRootView: $goBackToRootView), isActive: $goBackToRootView ){
                        Button(action: {
                            
                            ControlInput()
                            
                        }){
                            ButtonView(buttonText: "𝑪𝒓𝒆𝒂𝒕 𝑬𝒍𝒆𝒄𝒕𝒊𝒐𝒏")
                        }.padding(.bottom, 40.0).alert(messageToTheUser, isPresented :$isShowingAlert ){
                            Button("Ok") {
                                
                            }
                        }
                    }
                    
                    
                    NavigationLink(destination: ChooseElectionIdView(goBackToRootView: $goToChooseElectionIdView), isActive: $goToChooseElectionIdView){
                        
                        Button(action: {
                            goToChooseElectionIdView = true
                        }){
                            ButtonView(buttonText: "𝑱𝒐𝒊𝒏/𝑷𝒐𝒍𝒍")
                        }.padding(.bottom, 40.0)
                    }
                    
                    
                    NavigationLink(destination: ToshowResultView(goToResultView: $goToResultView), isActive: $goToResultView){
                        
                        Button(action: {
                            
                            goToResultView = true
                            
                        }){
                            ButtonView(buttonText: "𝑺𝒆𝒆 𝑹𝒆𝒔𝒖𝒍𝒕")
                        }   .padding(.bottom, 20.0)
                    }
                    
                    Spacer(minLength: 150)
                }
                
            }.onAppear(perform: {
                
                goBackToRootView = false
                countOfChoices = ""
                countOfParticipant = ""
            })
            
        }.accentColor( .black)
    }
    
    
    func ControlInput (){
        
        if (countOfParticipant != "" && countOfChoices != ""){
            
            let countOfParticipantToInteger = Int (countOfParticipant)
            let  countOfChoicesToInteger = Int (countOfChoices)
            
            if (countOfParticipantToInteger! < 2 ){
                messageToTheUser = "Minimum 2 Participant"
                isShowingAlert = true
            }
            
            else {
                
                if ( countOfChoicesToInteger! < 2 ||  countOfChoicesToInteger! > 5){
                    
                    messageToTheUser = " Choices min 2 and max 5"
                    isShowingAlert = true
                }
                
                else {
                    
                    goBackToRootView = true
                    
                }
            }
            
        }
        
        else {
            
            messageToTheUser = "Fill information first"
            isShowingAlert = true
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
