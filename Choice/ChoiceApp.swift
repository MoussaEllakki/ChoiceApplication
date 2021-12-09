
import SwiftUI
import Firebase
@main
struct ChoiceApp: App {
    
    init(){
        
        FirebaseApp.configure()
        
    }
    
    
    var body: some Scene {
        
        
        
        WindowGroup {
            MainView()
            
            
        }
    }
}
