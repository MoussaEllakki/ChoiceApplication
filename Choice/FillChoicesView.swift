

import SwiftUI
import Firebase

struct FillChoicesView: View {
    
    @State private var ref : DatabaseReference!
    @State private var allChoices : [String] = []
    @State private var goToShowElectionView = false
    @State private var isShowingAlert = false
    @State var countOfChoices = ""
    @State var countOfParticipant = ""
    @State private var messageToUser = ""
    @State private var electionId = ""
    @State private var setAndGetData = SetAndGetData()
    @State private var pollName = ""
    @Binding var goBackToRootView : Bool
    
    
    var body: some View {
        
        ZStack{
            BackgroundView()
            ScrollView{
                VStack{
                    Spacer(minLength: 50)
                    Text("𝑻𝒊𝒕𝒍𝒆 𝒐𝒇 𝒕𝒉𝒆 𝒑𝒐𝒍𝒍").font(.title3)
                    TextField("𝑻𝒊𝒕𝒍𝒆", text: $pollName)
                        .padding(.leading, 4.0)
                        .frame(width: 300.0, height: 30)
                        .background(Color.white)
                        .cornerRadius(7)
                    Text("𝑪𝒓𝒆𝒂𝒕𝒆 𝑪𝒉𝒐𝒊𝒄𝒆𝒔") .font(.title3)
                    ForEach(0..<allChoices.count , id: \.self) {
                        
                        TextField("𝐶ℎ𝑜𝑖𝑐𝑒 \($0 + 1 )", text: $allChoices[$0])
                    }.padding(.leading, 4.0)
                        .frame(width: 300.0, height: 30)
                        .background(Color.white)
                        .cornerRadius(7)
                    NavigationLink(destination: ShowElectionview(allChoices: allChoices, electionId : electionId, goBackToRootView: $goBackToRootView ), isActive: $goToShowElectionView ){
                        Button(action: {
                            getChoices()
                            
                        }) {
                            ButtonViewGreen(buttonText: "𝑪𝒓𝒆𝒂𝒕𝒆").shadow(radius: 15)
                        }.alert(messageToUser, isPresented :$isShowingAlert ){
                            Button("𝑶𝒌") {
                            }
                            
                        }.padding(15)
                    }
                    Spacer()
                }
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
        
        for choice in allChoices{
            let choiceAfterTrim = choice.trimmingCharacters(in: .whitespacesAndNewlines)
            if (choiceAfterTrim == "" ){
                messageToUser = "𝑭𝒊𝒍𝒍 𝒊𝒏 𝒂𝒍𝒍 𝑪𝒉𝒐𝒊𝒄𝒆𝒔 𝒇𝒊𝒓𝒔𝒕"
                isShowingAlert = true
                return
            }
        }
        
        let pollNameAfterTrim = pollName.trimmingCharacters(in: .whitespacesAndNewlines)
        if(pollNameAfterTrim == ""){
            messageToUser = "𝑭𝒊𝒍𝒍 𝒊𝒏 𝒕𝒊𝒕𝒍𝒆 𝒐𝒇 𝒕𝒉𝒆 𝒑𝒐𝒍𝒍 𝒇𝒊𝒓𝒔𝒕"
            isShowingAlert = true
        }
        
        else {
            controlDublicateElectionId()
        }
    }
    
    func controlDublicateElectionId (){
        
        let randomNummer = Int.random(in: 100000...999999)
        electionId = String(randomNummer)
        ref.child("AllElections").getData(completion:  { [self] error, snapshot in
            
            guard error == nil else {
                messageToUser = "𝑵𝒐 𝒊𝒏𝒕𝒆𝒓𝒏𝒆𝒕 𝒄𝒐𝒏𝒏𝒆𝒄𝒕𝒊𝒐𝒏"
                isShowingAlert = true
                print(error!.localizedDescription)
                return;
            }
            
            for allElectionID in snapshot.children {
                let  electionAsSnapShot   =  allElectionID as! DataSnapshot
                let  electionID  =  electionAsSnapShot.value as! String
                
                if (electionId == electionID){
                    controlDublicateElectionId()
                    return
                }
            }
            
            let countOfParticipantToInteger = Int (countOfParticipant)
            setAndGetData.creatElection(electionId: electionId, countsOfParticipant: countOfParticipantToInteger!, allChoices: allChoices, pollName: pollName)
            goToShowElectionView =  true
        });
    }
}

struct FillChoicesView_Previews: PreviewProvider {
    static var previews: some View {
        FillChoicesView( goBackToRootView: .constant(false))
    }
}
