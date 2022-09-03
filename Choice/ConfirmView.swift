

import SwiftUI

struct ConfirmView: View {
    
    
    @Binding var goBackToRootView : Bool
    @State var nameOfParticipant = ""
    @State var  isShowingAlertForLogOut  = false
    @State var  isShowingAlert = false
    @State var electionId = ""
    @ObservedObject var setAndGetData = SetAndGetData()
    @State private var goToResultView = false
    
    var body: some View {
        
        ZStack{
            
            BackgroundView()
            
            VStack{
                
                Spacer(minLength: 30)
                
                HStack{
                    Text("𝑷𝒐𝒍𝒍 𝑰𝑫:").font(.title3)
                    Text("\(electionId)")
                        .frame(width: 100, height: 25)
                        .background(Color.green)
                        .cornerRadius(5)
                }.padding()
                
                ZStack(alignment: .bottom){
                    Text(nameOfParticipant).font(.title3).padding().foregroundColor(Color.purple)
                    
                    LottieView(animationName: "thanks", loopMode: .loop)  .frame(width:200, height: 200 )
                }.frame(width: 250 , height: 250).background(Color.white).cornerRadius(125)
                Spacer(minLength: 30)
                
                NavigationLink(destination: ResultView(goBackToRootView: $goBackToRootView, electionId : electionId), isActive: $goToResultView){
                    
                    Button(action: {
                        
                        goToResultView = true
                        
                    }) {
                        ButtonView(buttonText: "𝑺𝒆𝒆 𝒓𝒆𝒔𝒖𝒍𝒕").shadow(radius: 15)
                    }
                }
                
                Spacer(minLength: 30)
                Button(action: {
                    isShowingAlertForLogOut = true
                }) {
                    
                    ButtonView(buttonText: "𝑳𝒐𝒈 o𝒖𝒕").shadow(radius: 15)
                    
                }.padding(.bottom, 20.0).alert("𝒀𝒐𝒖 𝒔𝒉𝒐𝒖𝒍𝒅 𝒓𝒆𝒎𝒆𝒎𝒃𝒆𝒓 𝒚𝒐𝒖𝒓 𝒑𝒐𝒍𝒍 𝑰𝑫 \(electionId) 𝒊𝒇 𝒚𝒐𝒖 𝒘𝒂𝒏𝒕 𝒕𝒐 𝒍𝒐𝒈 𝒐𝒖𝒕", isPresented :$isShowingAlertForLogOut ){
                    
                    Button("𝑶𝒌 𝑳𝒐𝒈 𝑶𝒖𝒕", role: .destructive) {
                        goBackToRootView = false
                    }
                }
                Spacer(minLength: 160)
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
