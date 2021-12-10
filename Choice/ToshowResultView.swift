import SwiftUI

struct ToshowResultView: View {
    
    
    
    @State private var electionId = ""
    
   
    
    
    @Binding var goToResultView  : Bool
    
    
    @State private var toResultView = false
    
    
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
                
                
                
                
                NavigationLink(destination: ResultView(goBackToRootView: $goToResultView), isActive: $toResultView){
                    
                   
                    
                    Button(action: {
                
                      toResultView = true
                        
                    }){
                        
                        ButtonView(buttonText: "See Result")
                        
                    }
                 
                    
                }.padding(30)
                
              
                
                
                Spacer(minLength: 350)
               
                
                
                
            }
            
               
               
               
              
            
        }
            
            
            
            }
        
        
        }
        
 

struct ToshowResultView_Previews: PreviewProvider {
    static var previews: some View {
        ToshowResultView( goToResultView: .constant(false))
    }
}
