import SwiftUI

struct ToshowResultView: View {
    
    
    
    @State private var electionId = ""
    
   
    @State private var isShowingAlert = false
    
    @Binding var goToResultView  : Bool
    
    
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
                
                        if (electionId != ""){
                            
                            setAndGetData.getallChoicesFromFb(electionId:electionId){
                                
                               toResultView = true

                            }
                            
                        }
                     
                        else{
                            
                            isShowingAlert = true
                            
                        }
                        
                    }){
                        
                        ButtonView(buttonText: "See Result")
                        
                    }.alert("Write election id first", isPresented :$isShowingAlert){
                        
                        Button("Ok") {
                            
                        }
                        
                    }
                 
                    
                }.padding(30)
                
              
                
                
                Spacer(minLength: 250)
               
                
                
                
            }
            
               
               
               
              
            
        }
            
            
            
            }
        
        
        }
        
 

struct ToshowResultView_Previews: PreviewProvider {
    static var previews: some View {
        ToshowResultView( goToResultView: .constant(false))
    }
}
