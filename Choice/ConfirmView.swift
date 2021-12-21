

import SwiftUI

struct ConfirmView: View {
    
    
    @Binding  var goBackToRootView : Bool
    
    @State var nameOfParticipant = ""
    
    @State var  isShowingAlertForLogOut  = false
    
    @State var  isShowingAlert = false
    
    @State  var electionId = ""
    
    @ObservedObject var setAndGetData = SetAndGetData()
    
    @State private var goToResultView = false
    
    var body: some View {
        
        ZStack{
            
            BackgroundView()
            
            
            VStack{
               
                
                
                Spacer(minLength: 30)
                
                HStack{
                    Text("𝑷𝒐𝒍𝒍 𝑰𝑫:")
                    Text("\(electionId)")
                        .frame(width: 100, height: 20)
                        .background(Color.white)
                        .cornerRadius(10)
                }.padding()
             
                ZStack(alignment: .bottom){




                    Text(nameOfParticipant).font(.title2).padding().foregroundColor(Color.purple)
       
                              
                    LottieView(animationName: "thanks", loopMode: .loop)  .frame(width:200, height: 200 )


                }.frame(width: 200 , height: 200).background(Color.white).cornerRadius(150)
                
         
                Spacer(minLength: 30)
                
                
                NavigationLink(destination: ResultView(goBackToRootView: $goBackToRootView, electionId : electionId), isActive: $goToResultView){
                    
                    Button(action: {
                        
                      
                      
                            
                            goToResultView = true

                        
                        
                
                 
                        
                        
                    }) {
                        
                        ButtonView(buttonText: "𝑺𝒆𝒆 𝑹𝒆𝒔𝒖𝒍𝒕")
                        
                    }
                    
                    
                }
              
                
                Spacer(minLength: 30)
                
                Button(action: {
                    
                
                   isShowingAlertForLogOut = true
           
                    
                }) {
                    
                    ButtonView(buttonText: "Log Out")
                    
                }.padding(.bottom, 20.0).alert("OBS: you should remember your election iD \(electionId) if you want to log out", isPresented :$isShowingAlertForLogOut ){
                    
                    Button("Ok Log Out", role: .destructive) {
                
                        goBackToRootView = false
                        
                    }
                    
                    
                    }
                
                
                
                
                
                Spacer(minLength: 180)
                
                
            }
            
            
            
            .navigationBarBackButtonHidden(true)
        }
        
   
    }
}

struct ConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmView(goBackToRootView: .constant(false))
    }
}
