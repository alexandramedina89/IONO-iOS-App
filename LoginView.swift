//
//  LoginView.swift
//  IONO
//
//  Created by Alexandra Medina on 10/4/21.
//

import UIKit
import Foundation
import Alamofire


class LoginView: UIViewController {
    
    
    

let URL_USER_LOGIN = URL(string: "http://10.0.1.34/MyWebService/api/login.php")

//the defaultvalues to store user data
let defaultValues = UserDefaults.standard

//the connected views


    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    


 //   @IBAction func loginSubmitFinal(_ sender: UIButton) {
 
    func login(){
    
    //getting the username and password
    let parameters: Parameters=[
        "email":emailTextField.text!,
        "password":passwordTextField.text!
    ]
    
    //making a post request
    Alamofire.request(URL_USER_LOGIN!, method: .post, parameters: parameters).responseJSON
        {
            response in
            //printing response
            print(response)
            
            //getting the json value from the server
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                
                //if there is no error
                if(!(jsonData.value(forKey: "error") as! Bool)){
                    
                    //getting the user from response
                    let user = jsonData.value(forKey: "user") as! NSDictionary
                    
                    //getting user values
                    let userId = user.value(forKey: "id") as! Int
                   // let userName = user.value(forKey: "l_name") as! String
                    let userEmail = user.value(forKey: "email") as! String
                    let userPhone = user.value(forKey: "phone") as! String
                    
                    //saving user values to defaults
                    self.defaultValues.set(userId, forKey: "userid")
                   // self.defaultValues.set(userName, forKey: "username")
                    self.defaultValues.set(userEmail, forKey: "useremail")
                    self.defaultValues.set(userPhone, forKey: "userphone")
                    
                    //switching the screen
                    let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "firstViewController") as! firstView
                                            self.navigationController?.pushViewController(profileViewController, animated: true)
                                            
                                            self.dismiss(animated: false, completion: nil)

                }


                else{
                    //error message in case of invalid credential
                    self.labelMessage.text = "Invalid username or password"
                }
            }
    }
        
}
    
    
    @IBAction func loginSubmitBTN(_ sender: Any) {
        login()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hiding the navigation button
  /*      let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
                navigationItem.leftBarButtonItem = backButton

                // Do any additional setup after loading the view, typically from a nib.
                
                //if user is already logged in switching to profile screen
            if defaultValues.string(forKey: "email") != nil{
                let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "firstViewController") as! firstView
                    self.navigationController?.pushViewController(profileViewController, animated: true)

    }
  */

}

}
