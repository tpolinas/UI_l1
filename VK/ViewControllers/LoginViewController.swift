//
//  ViewController.swift
//  VK
//
//  Created by Polina Tikhomirova on 16.12.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var someImageView: UIImageView!
    @IBOutlet var loginButton: UIButton!
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        print(usernameTextField.text)
        print(passwordTextField.text)
    }
    
    
    @IBAction func unwindToMain(unwindSegue: UIStoryboardSegue) {
        navigationController?.popToRootViewController(animated: true)

    }

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView
            .addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self,
                    action: #selector(hideKeyboard)))
        
        animate()
        
        loginButton.layer.cornerRadius = 15
        loginButton.layer.masksToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWasShown),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillBeHidden(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Actions
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue)
            .cgRectValue
            .size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        UIView.animate(withDuration: 1) {
            self.scrollView.constraints
                .first(where: { $0.identifier == "keyboardShown" })?
                .priority = .required
            self.scrollView.constraints
                .first(where: { $0.identifier == "keyboardHide" })?
                .priority = .defaultHigh
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        UIView.animate(withDuration: 1) {
            self.scrollView.constraints
                .first(where: { $0.identifier == "keyboardShown" })?
                .priority = .defaultHigh
            self.scrollView.constraints
                .first(where: { $0.identifier == "keyboardHide" })?
                .priority = .required
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case "goToMain":
            if !checkUser() {
                presentAlert()
                return false
            } else {
                clearData()
                return true
            }
        default:
            return false
        }
        
    }
    
    // MARK: - Private methods
    private func checkUser() -> Bool {
        usernameTextField.text == "admin" && passwordTextField.text == "123"
    }
    
    private func presentAlert() {
        let alertController = UIAlertController(
            title: "Error",
            message: "Incorect username or password",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .cancel)
        alertController.addAction(action)
        present(alertController,
                animated: true)
    }
    
    private func clearData() {
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    func animate() {
        let someLayer = CAShapeLayer()
        someLayer.path = UIBezierPath.apple().cgPath
        someLayer.lineWidth = 5.0
        someLayer.strokeColor = UIColor.white.cgColor
        someLayer.fillColor = UIColor.clear.cgColor
        someLayer.strokeStart = 0.0
        someLayer.strokeEnd = 0.0
        
        someImageView.layer.addSublayer(someLayer)
        
        let strokeEndAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        strokeEndAnimation.fromValue = 1.0
        strokeEndAnimation.toValue = 1.0
        
        let strokeStartAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
        strokeStartAnimation.fromValue = -0.10
        strokeStartAnimation.toValue = 1
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.0
        animationGroup.repeatCount = 3
        animationGroup.animations = [
            strokeStartAnimation,
            strokeEndAnimation,
        ]
        
        someLayer.add(
            animationGroup,
            forKey: nil)
    }
}
