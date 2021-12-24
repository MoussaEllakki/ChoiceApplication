
import SwiftUI

struct BackgroundView: View {
    var body: some View {
        
        
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [.purple,.purple,.purple , .purple, .purple ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        }
        
    }
}

struct ButtonView: View {
    
    @State var buttonText = ""
    
    var body: some View {
        
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [.yellow]), startPoint: .topTrailing, endPoint: .topLeading)
                .cornerRadius(10)
            Text(buttonText)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
        }.frame(width: 300, height: 35)
        
    }
    
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
        
    }
}
