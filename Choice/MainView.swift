
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
                
                VStack{
                    
         
                    
                    
                    Spacer(minLength: 30)
                    
                    Text("Choice")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    
                    
                    HStack(spacing: 10){
                        
                        Spacer()
                        
                        TextField("Count of Participant", text: $countOfParticipant)
                            .padding(.leading, 4.0)
                            .frame(width: 160, height: 35)
                            .border(Color.black, width: 1)
                            .keyboardType(.numberPad)
                            .cornerRadius(2)
                        
                        
                        TextField("Count of choices", text: $countOfChoices)
                            .padding(.leading, 4.0)
                            .frame(width: 160, height: 35)
                            .border(Color.black, width: 1)
                            .keyboardType(.numberPad)
                            .cornerRadius(2)
                        Spacer()
                        
                    }
                    
                    .padding(30)
                    
                    NavigationLink(destination: FillChoicesView(countOfChoices: countOfChoices, countOfParticipant: countOfParticipant, goBackToRootView: $goBackToRootView), isActive: $goBackToRootView ){
                        
                        
                        Button(action: {
                            
                            ControlInput()
                            
                        }){
                            
                            ButtonView(buttonText: "Create Election")
                            
                        }.alert(messageToTheUser, isPresented :$isShowingAlert ){
                            
                            Button("Ok") {
                                
                            }
                            
                        }
                        
                        
                        
                    }
                    
                    
                    
               
                    
                    NavigationLink(destination: ChooseElectionIdView(goBackToRootView: $goToChooseElectionIdView), isActive: $goToChooseElectionIdView){
                        
                        
                        Button(action: {
                            
                            
                            goToChooseElectionIdView = true
                            
                        }){
                            
                            ButtonView(buttonText: "Poll")
                            
                        }
                        
                    }
                    
                    
                    .padding(30)
                    
                    
                    
                    
                    
                    NavigationLink(destination: ToshowResultView(goToResultView: $goToResultView), isActive: $goToResultView){
                        
                        
                        Button(action: {
                            
                         goToResultView = true
                            
                        }){
                            
                            ButtonView(buttonText: "See Result")
                            
                        }
                        
                    }
                    
                    
                    Spacer(minLength:200)
                    
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
