

import SwiftUI
import Firebase

struct FillChoicesView: View {
    
    @State private var ref : DatabaseReference!
    
    @State  private var allChoices : [String] = []
    
    @State private var goToShowElectionView = false
    
    @State  private var isShowingAlert = false
    
    @State var countOfChoices = ""
    
    @State var countOfParticipant = ""
    
    @State  private var messageToUser = ""
    
    @State  private var electionId = ""
    
    @State private var setAndGetData = SetAndGetData()
    
    @Binding var goBackToRootView : Bool
    
    
    var body: some View {
        
        
        ZStack{
            
            BackgroundView()
            
           
                  
            VStack{
                
                Spacer(minLength: 100)
                
                  ForEach(0..<allChoices.count , id: \.self) {
                    
                  TextField("Choice \($0 + 1 )", text: $allChoices[$0])
                    
                    }.padding(.leading, 4.0)
                    .frame(width: 300.0, height: 35.0)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                
                
                
                
                NavigationLink(destination: ShowElectionview(allChoices: allChoices, electionId : electionId, goBackToRootView: $goBackToRootView ), isActive: $goToShowElectionView ){
                    
                    
                    
                           Button(action: {
                       
                               
                              getChoices()
                               
                           }) {
                               
                               ButtonView(buttonText: "Create")
                               
                           }
                           .alert(messageToUser, isPresented :$isShowingAlert ){
                               
                               Button("Ok") {
                                   
                           }
                               
                               
                           }.padding(15)
                    
                }
                
        
                
                Spacer(minLength: 200)
              
              
                
           }
            
            
            
            
            
            
        }.onAppear(perform: {
            
            ref = Database.database().reference()
            
            var CountOfChoicesAsinteger = Int (countOfChoices)
            
            let count = 1...CountOfChoicesAsinteger!
            
            for  number in count {
                
                allChoices .append("")
                
            }
            
           })
        
        
        
        
        
        
        }
    
    
    
    
    func getChoices (){
        
        
        
        for ii in allChoices{
            
            print(" before\(ii)")
            
            let i = ii.trimmingCharacters(in: .whitespacesAndNewlines)
            
            print(" efter \(i)")
            
            if (i == "" || i == "" || i == "" ){
                
                print("look  \(i)")
                
                messageToUser = "Fill all Choices first"
                
                isShowingAlert = true
                
                return
            }
            
        }
        
        
      controlDublicateElectionId()
      
      
    }
    
    
   
    
    func controlDublicateElectionId (){
        
        let randomNummer = Int.random(in: 100000...999999)
       
      
          electionId = String(randomNummer)
        

        
        ref.child("AllElections").getData(completion:  { [self] error, snapshot in
            
            
               
               
            guard error == nil else {
                
           
                messageToUser = "No internet"
                
                isShowingAlert = true
                print(error!.localizedDescription)
                
                return;
            }
            
            
            
            for allElection in snapshot.children {
                
       
                
                let  electionStep1   =  allElection as! DataSnapshot
                
                let  electionStep2  =  electionStep1.value as! String
                
          
                if (electionId == electionStep2){
                    
                    print(electionId)
                    
                 controlDublicateElectionId()
           
                   
                    
                    return
                    
                    
                    
                }
                
                
            }
            
            
              
            
           let countOfParticipantToInteger = Int (countOfParticipant)
            
               
            setAndGetData.creatElection(electionId: electionId, countsOfParticipant: countOfParticipantToInteger!, allChoices: allChoices)
               
            goToShowElectionView =  true
              
            
          });
        
        
        
    }
    
   
    
    
    
    
}


struct FillChoicesView_Previews: PreviewProvider {
    static var previews: some View {
        FillChoicesView( goBackToRootView: .constant(false))
    }
}
