
import Foundation
import Firebase

class SetAndGetData : ObservableObject{
    
    var ref : DatabaseReference!
    
    @Published var existingElectionId = false
    @Published var allParticipant : [String] = []
    @Published var isThereInternet = true
    @Published var allChoices: [Choice] = []
    @Published var countOfPolled = 0
    @Published var countOfparticipant = 5
    
    
    init (){
        ref = Database.database().reference()
    }
    
    
    func creatElection ( electionId : String , countsOfParticipant: Int , allChoices : [String] ){
        
        ref.child("AllElections").child(electionId).setValue(electionId)
        ref.child("Election").child(electionId).child("CountsOfParticipant").setValue(countsOfParticipant)
        ref.child("Election").child(electionId).child("CountsOfPolled").setValue(0)
        
        var number = 1
        
        for choice in allChoices {
            
            let choiceNumber = String("Choice\(number)")
            
            ref.child("Election").child(electionId).child("AllChoices").child(choiceNumber).child("Name").setValue(choice)
            ref.child("Election").child(electionId).child("AllChoices").child(choiceNumber).child("Value").setValue(0)
            ref
            
            number = number + 1
        }
        
    }
    
    
    
    func deleteElectionId (electionId : String ){
        
        ref.child("AllElections").child(electionId).removeValue()
        ref.child("Election").child(electionId).removeValue()
        
    }
    
    
    
    func controlElectionId  (electionId : String ,  completionHandler: @escaping () -> ()){
        
        existingElectionId = false
        
        ref.child("AllElections").getData(completion:  { [self] error, snapshot in
            
            guard error == nil else {
                
                isThereInternet = false
                print(error!.localizedDescription)
                completionHandler()
                return;
            }
            
            
            for allElections in snapshot.children {
                
                let  electionAsDataSnapshot =   allElections  as! DataSnapshot
                let  election = electionAsDataSnapshot.value as! String
                
                if (electionId == election){
                    
                    existingElectionId = true
                    isThereInternet =  true
                    
                    completionHandler()
                    
                    return
                }
                
            }
            
            isThereInternet =  true
            
            completionHandler()
            
        });
        
    }
    
    
    
    func getallChoicesFromFb (electionId : String , completionHandler: @escaping () -> ()){
        
        self.allChoices.removeAll()
        
        ref.child("Election").child(electionId).child("AllChoices").getData(completion:  { [self] error, snapshot in
            
            guard error == nil else {
                
                print(error!.localizedDescription)
                return;
            }
            
            for   allaChoices in snapshot.children {
                
                let  choiceAsDataSnapshot =  allaChoices as! DataSnapshot
                let  choice = choiceAsDataSnapshot.value as! [String : Any]
                let choiceAsObject = Choice()
                
                choiceAsObject.name = choice["Name"] as! String
                choiceAsObject.votes = choice["Value"] as! Int
                self.allChoices.append(choiceAsObject)
            }
            
            completionHandler()
            
        });
        
    }
    
    
    
    func AddVoteAndNameOfParticipant(electionId : String, NameOfParticipant : String){
        
        var CountOfPolled = 0
        
        ref.child("Election").child(electionId).child("CountsOfPolled").getData(completion:  { [self] error, snapshot in
            
            guard error == nil else {
                
                print(error!.localizedDescription)
                
                return;
            }
            
            self.countOfPolled = (snapshot.value as? Int)!
            self.countOfPolled = self.countOfPolled + 1
            
            ref.child("Election").child(electionId).child("CountsOfPolled").setValue(self.countOfPolled)
            ref.child("Election").child(electionId).child("AllParticipant").child("ParticipantNumber\(self.countOfPolled)").setValue(NameOfParticipant)
            
        });
    }
    
    func getCountOfPolled (electionId : String , completionHandler: @escaping () -> ()){
        
        
        ref.child("Election").child(electionId).child("CountsOfPolled").getData(completion:  { [self] error, snapshot in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            
            self.countOfPolled = (snapshot.value as? Int)!
            
            completionHandler()
            
        });
    }
    
    
    
    func getCountOfParticipant (electionId : String , completionHandler: @escaping () -> ()){
        
        ref.child("Election").child(electionId).child("CountsOfParticipant").getData(completion:  { [self] error, snapshot in
            
            guard error == nil else {
                
                print(error!.localizedDescription)
                
                return;
            }
            
            self.countOfparticipant = (snapshot.value as? Int)!
            
            completionHandler()
            
        });
    }
    
    
    
    
    func uppdateAllChoices (electionId : String , completionHandler: @escaping () -> ()){
        
        
        ref.child("Election").child(electionId).child("AllChoices").observe(DataEventType.value, with: { snapshot in
            
            self.allChoices.removeAll()
            
            for   allaChoices in snapshot.children {
                
                let  choiceAsDataSnapshot =  allaChoices as! DataSnapshot
                let  choice = choiceAsDataSnapshot.value as! [String : Any]
                let choiceAsObject = Choice()
                
                choiceAsObject.name = choice["Name"] as! String
                choiceAsObject.votes = choice["Value"] as! Int
                
                self.allChoices.append(choiceAsObject)
            }
            
            completionHandler()
            
        });
        
    }
    
    
    
    
    
    func getAllParticiPant(electionId : String ,  completionHandler: @escaping () -> ()){
        
        
        ref.child("Election").child(electionId).child("AllParticipant").observe(DataEventType.value, with: { snapshot in
            
            self.allParticipant.removeAll()
            
            for   allParticipantAsCildren in snapshot.children {
                
                let  participantAsSnapShot =  allParticipantAsCildren as! DataSnapshot
                let  participant = participantAsSnapShot.value as! String
                
                self.allParticipant.append(participant)
            }
            
            completionHandler()
            
            
        });
        
    }
    
    
    func poll (electionId : String , whichChoice : Int ){
        
        
        var  ValueInFirebase = 0
        
        ref.child("Election").child(electionId).child("AllChoices").child("Choice\(whichChoice + 1)").child("Value").getData(completion:  { [self] error, snapshot in
            
            
            guard error == nil else {
                
                print(error!.localizedDescription)
                return;
            }
            
            
            ValueInFirebase = (snapshot.value as? Int)!
            
            
            ref.child("Election").child(electionId).child("AllChoices").child("Choice\(whichChoice + 1)").child("Value").setValue( ValueInFirebase + 1)
            
        });
    }
    
}


class Choice {
    var name = ""
    var votes = 0
    
}







