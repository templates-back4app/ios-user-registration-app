//
//  ViewController.swift
//  DSSUserSignUp
//
//  Created by David Quispe Aruquipa on 15/07/22.
//

import UIKit
import ParseSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add additional code if needed
    }

    // Called when the user taps on the signUpButton
    @IBAction func handleSignUp(_ sender: Any) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            return showMessage(title: "Error", message: "The credentials are no valid.")
        }
        
        signUp(username: username, email: emailTextField.text, password: password)
    }
    
    // This method prepares and registers the new user
    private func signUp(username: String, email: String?, password: String) {
        var newUser = User(username: username, email: email, password: password)
        newUser.age = 25; #warning("This should be entered by the user, not hardcoded")
        
        // Registers the user asynchronously and returns the updated User object (stored on your Back4App application) wrapped in a Result<User, ParseError> object
        newUser.signup { [weak self] result in
            switch result {
            case .success(let user):
                self?.showMessage(title: "Signup succeeded", message: "\(user)")
                self?.usernameTextField.text = nil
                self?.emailTextField.text = nil
                self?.passwordTextField.text = nil
            case .failure(let error):
                self?.showMessage(title: "Error", message: error.message)
            }
        }
    }
    
    // Presents an alert with a title, a message and a back button
    func showMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Back", style: .cancel))
        
        present(alertController, animated: true)
    }
}
