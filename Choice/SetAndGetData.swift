
import Foundation


import Firebase

class SetAndGetData : ObservableObject{
    
    var ref : DatabaseReference!


    
  @Published var existingElectionId = false
    
  @Published var allParticipant : [String] = []
    
  @Published var  isThereInternet = true
    
  @Published var allaChoices : [Choice] = []

    
    
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
            
            

            
            CountOfPolled = (snapshot.value as? Int)!
            
           CountOfPolled = CountOfPolled + 1
            
            
    
            ref.child("Election").child(electionId).child("CountsOfPolled").setValue(CountOfPolled)
            ref.child("Election").child(electionId).child("AllParticipant").child("ParticipantNumber\(CountOfPolled)").child("Name").setValue(NameOfParticipant)
            
            
            
        });
        
        
    }
 
    
    func getAllParticiPant (electionId : String){
        
        
        
        ref.child("Election").child(electionId).child("AllParticipant").child("Name").getData(completion:  { [self] error, snapshot in
            
            
            guard error == nil else {
                
                print(error!.localizedDescription)
                return;
            }
            
            
            
            
            for   alla in snapshot.children {
                
                
                let  partAsDataSnapshot =  allaChoices as! DataSnapshot
                
                let  part = partAsDataSnapshot.value as! String
                
                
              
     
        
                self.allParticipant.append(part)
         
             print(part)
                
        
                
                
        }
        
       
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
    
    

    
   /*
    func GetData (){
            
            
            
            ref = Database.database().reference()
            
            
            ref.child("Val").child(valId).child("AllaAlternativ").getData(completion:  { [self] error, snapshot in
                
                
                guard error == nil else {
                    
                    print(error!.localizedDescription)
                    return;
                }
                
                
                
                for allaVal in snapshot.children {
                    
                    
                    let  val1 =  allaVal as! DataSnapshot
                    
                    let  val2 = val1.value as! [String : Any]
                    
                    
                    
                    self.allaAlternativ.append(val2["Namn"]! as! String)
                    
                    
                    
                }
                
                
                
                
                
                
                
            });
            
            
            
            
        }
        */
        
        
                                        }

    
class Choice {
    
    
    var name = ""
    
    var votes = 0
    
    
    
}
    

    




