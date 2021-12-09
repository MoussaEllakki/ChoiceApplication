
import SwiftUI


struct MainView: View {
    
    
    
    @State var countOfParticipant = ""
    
    @State var countOfChoices = ""
    
    @State var goBackToRootView : Bool =  false
    
    @State var goToChooseElectionIdView = false
    
    @State var goToShowElectionView = false
    
    @State var  goToshowResultView : Bool =  false
    
    @State var  goToResultView : Bool =  false
    
    
    @State var  isShowingAlert = false
    
    @State var message = ""
    
    
  
    
    @State var testText = ""
    
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                BackgroundView()
                
                VStack{
                    
                    Text(testText)
                    
                    
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
                            
                            ButtonView(buttonText: "Create Vote")
                            
                        }.alert(message, isPresented :$isShowingAlert ){
                            
                            Button("Ok") {
                                
                            }
                            
                        }
                        
                        
                        
                    }
                    
                    
                    
               
                    
                    NavigationLink(destination: ChooseElectionIdView(), isActive: $goToChooseElectionIdView){
                        
                        
                        Button(action: {
                            
                            
                            goToChooseElectionIdView = true
                            
                        }){
                            
                            ButtonView(buttonText: "Vote")
                            
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
                    
                    
                    Spacer(minLength:250)
                    
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
                
                message = "Minimum 2 Participant"
                
                isShowingAlert = true
            }
            
            else {
                
                if ( countOfChoicesToInteger! < 2 ||  countOfChoicesToInteger! > 5){
                    
                    
                    
                    message = " Choices min 2 and max 5"
                    
                    isShowingAlert = true
                    
                }
                
                
                
                else {
                    
                    
                    
                    goBackToRootView = true
                    
                    
                }
                
            }
            
            
            
            
        }
        
        
        
        
        
        else {
            
            message = "Fill information first"
            
            isShowingAlert = true
            
        }
        
        
        
        
        
        
        
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
