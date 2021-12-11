
import Foundation


import Firebase

class SetAndGetData : ObservableObject{
    
    var ref : DatabaseReference!
    
    
    
    @Published var existingElectionId = false
    
    @Published var allParticipant : [String] = []
    
    @Published var  isThereInternet = true
    
    @Published var allaChoices : [Choice] = []
    
    @Published var  countOfPolled = 0
    
    @Published var countOfparticipant = 0
    
    init (){
        
        ref = Database.database().reference()
        
    }
    
    
    
    
    
    func creatElection ( electionId : String , countsOfParticipant: Int , allChoices : [String] ){
        
        ref.child("AllElections").child(electionId).setValue(electionId)
        ref.child("Election").child(electionId).child("ElectionID").setValue(electionId)
        ref.child("Election").child(electionId).child("CountsOfParticipant").setValue(countsOfParticipant)
        ref.child("Election").child(electionId).child("CountsOfPolled").setValue(0)
        
        
        
        var number = 1
        
        
        for  choice in allChoices {
            
            let choiceNumber = String("Choice\(number)")
            
            
            
            ref.child("Election").child(electionId).child("AllChoices").child(choiceNumber).child("Name").setValue(choice)
            ref.child("Election").child(electionId).child("AllChoices").child(choiceNumber).child("Value").setValue(0)
            ref
            
            
            number =  number + 1
            
        }
        
    }
    
    
    
    
    
    
    
    func deleteElectionId (electionId : String ){
        
        ref.child("AllElections").child(electionId).removeValue()
        ref.child("Election").child(electionId).removeValue()
        
    }
    
    
    
    
    func controlElectionId  (electionId : String ,  completionHandler: @escaping () -> ()){
        
        //2
        
        print("two")
        
        existingElectionId = false
        
        ref.child("AllElections").getData(completion:  { [self] error, snapshot in
            
            print("three")
            
            guard error == nil else {
                
                
                
                print("ingen internet")
                
                isThereInternet = false
                
                print(error!.localizedDescription)
                completionHandler()
                return;
                
                
                
            }
            
            
            print("four")
            
            for allElections in snapshot.children {
                
                
                let  electionAsDataSnapshot =   allElections  as! DataSnapshot
                
                let  election = electionAsDataSnapshot.value as! String
                
                
                if (electionId == election){
                    
                    
                    
                    
                    existingElectionId = true
                    
                    isThereInternet =  true
                    
                    completionHandler()
                    
                    return
                    print("inne i loop")
                    
                }
                
                
                //5
                
                print("five")
                
                
            }
            
            
            print("six")
            
            isThereInternet =  true
            
            
            completionHandler()
            
            print("six")
            
            // 6 sist
            
            
            
        });
        
        
        //3
        
        
    }
    
    
    
    
    
    
    
    func getallChoicesFromFb (electionId : String , completionHandler: @escaping () -> ()){
        
        self.allaChoices.removeAll()
        
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
                
                
                self.allaChoices.append(choiceAsObject)
                
                
                
                
                
            }
            
            completionHandler()
            
            
            
            
            
            
            
            
            
        });
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    func AddVoteAndNameOfParticipant(electionId : String, NameOfParticipant : String){
        
        
        var  CountOfPolled = 0
        
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
        
        print("1 - 1")
        ref.child("Election").child(electionId).child("CountsOfPolled").getData(completion:  { [self] error, snapshot in
            
            
            guard error == nil else {
                
                print(error!.localizedDescription)
                
                return;
            }
            
            
            
            
            self.countOfPolled = (snapshot.value as? Int)!
            
   
            print("1 - 2")
            completionHandler()
            print("1 -  3")
         
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
    
    
    func getAllParticiPant (electionId : String ,  completionHandler: @escaping () -> ()){
        
      
        self.allParticipant.removeAll()
        
        print("4 -  1")
        for number in 1...self.countOfPolled {
            
            
            
            
            ref.child("Election").child(electionId).child("AllParticipant").child("ParticipantNumber\(number)").getData(completion:  { [self] error, snapshot in
                
                
                guard error == nil else {
                    
                    print(error!.localizedDescription)
                    return;
                }
                
                
                
                let participantName =  snapshot.value as? String
                
                
                self.allParticipant.append(participantName!)
                

                
                
            });
            
            
            if(self.allParticipant.count == self.countOfPolled ){
                print("4 -  4")
                
                completionHandler()
                
                print("4 -  3")
            }
            
            
        }
        
        
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







