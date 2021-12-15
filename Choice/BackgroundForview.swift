
import SwiftUI

struct BackgroundView: View {
    var body: some View {
        
    
        ZStack{
                    
            LinearGradient(gradient: Gradient(colors: [.blue  ,.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
             .edgesIgnoringSafeArea(.all)
             VStack{
               
                
            }
   
        }
        
    }
}



struct ButtonView: View {
    
    @State var buttonText = ""
    
    var body: some View {
        
        
        ZStack{
            
       
            LinearGradient(gradient: Gradient(colors: [.red  ,.purple]), startPoint: .topTrailing, endPoint: .topLeading)
                .cornerRadius(20)
            Text(buttonText)
                .font(.title2)
                .fontWeight(.bold)
        .foregroundColor(Color.black)
        }.frame(width: 300, height: 40)
        
    
        
    }
    
    
}




struct SmallButtonView: View {
    
    @State var buttonText = ""
    
    var body: some View {
        
        
        ZStack{
            
       
            LinearGradient(gradient: Gradient(colors: [.red  ,.purple]), startPoint: .topTrailing, endPoint: .topLeading)
                .cornerRadius(20)
            Text(buttonText)
                .font(.title3)
                .fontWeight(.bold)
        .foregroundColor(Color.black)
        }.frame(width: 80, height: 30)
        
    
        
    }
    
    
}




struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
      ButtonView()
        
    }
}
