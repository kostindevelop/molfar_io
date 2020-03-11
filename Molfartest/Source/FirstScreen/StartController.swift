//
//  StartController.swift
//  Molfartest
//
//  Created by Konstantin Igorevich on 27.02.2020.
//  Copyright © 2020 Konstantin Igorevich. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class StartController: UIViewController {
    
    
    @IBOutlet private weak var tfAge: UITextField!

    @IBAction func didTapSearchButton(_ sender: UIButton) {
        if tfAge.text!.isEmpty {
            showError()
        } else {
            showTableController()
        }
    }
    
    private func showError() {
        let alert = UIAlertController(title: "Error", message: "Enter the age to search", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    private func showTableController() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(identifier: "TableController") as? TableViewController else { return }
        controller.modalPresentationStyle = .fullScreen
        controller.searchAge = tfAge.text!
        navigationController?.show(controller, sender: nil)
    }
}

