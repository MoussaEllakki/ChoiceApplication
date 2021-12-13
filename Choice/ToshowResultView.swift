import SwiftUI

struct ToshowResultView: View {
    
    
    
    @State private var electionId = ""
    
   
    @State private var isShowingAlert = false
    
    @Binding var goToResultView  : Bool
    
    @State private var messageToUser = ""
    
    @State private var toResultView = false
    
    @ObservedObject var setAndGetData = SetAndGetData()
    
    
    var body: some View {
        
        
           ZStack{
            
            
            BackgroundView()
            
               Spacer()
               
            VStack{
                
                Spacer(minLength: 60)
                
                Text("Write election id")
                
                TextField("Write Election Id", text: $electionId)
                .padding(.leading, 4.0)
                .frame(width: 300.0, height: 35.0)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .keyboardType(.numberPad)
                
                
                
                NavigationLink(destination: ResultView(goBackToRootView: $goToResultView, setAndGetData: setAndGetData, electionId : electionId), isActive: $toResultView){
                    
                   
                    
                    Button(action: {
                        
                        
                          controlInputandelectionId()
               
                    }){
                        
                        ButtonView(buttonText: "See Result")
                        
                    }.alert(messageToUser, isPresented :$isShowingAlert){
                        
                        Button("Ok") {
                            
                        }
                        
                    }
                 
                    
                }.padding(30)
                
              
                
                
                Spacer(minLength: 250)
               
                
                
                
            }
            
               
               
               
              
            
        }
            
            
            
            
    }
    
    
    func controlInputandelectionId (){
        
        
                
                
                if (electionId != ""){
                    
                    
                    setAndGetData.controlElectionId(electionId: electionId){
                        
                        if (setAndGetData.isThereInternet == false){
                            
                            messageToUser = "No internet"
                            isShowingAlert = true
                            
                            return
                            
                        }
                        
                        if (setAndGetData.existingElectionId == true){
                            
                            
                            setAndGetData.getallChoicesFromFb(electionId:electionId){
                                
                               toResultView = true
                        }
                            
                        }
                            else {
                                
                              messageToUser = "Wrong election id"
                              isShowingAlert = true
                                
                            }
                        
                        
                    }
                 
                    
                }
             
                else{
                    
                    messageToUser = "Write election id first"
                    isShowingAlert = true
                    
                }
        
        
    }
    
    
        
        
        }
        
 

struct ToshowResultView_Previews: PreviewProvider {
    static var previews: some View {
        ToshowResultView( goToResultView: .constant(false))
    }
}
