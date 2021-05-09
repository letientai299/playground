//
//  ViewController.swift
//  Quiz
//
//  Created by Le Tien Tai on 9/5/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = questions[curQuestionId]
    }

    @IBAction func showNextQuestion(_ sender: UIButton) {
        curQuestionId += 1
        if curQuestionId == questions.count {
            curQuestionId = 0
        }

        let q = questions[curQuestionId]
        questionLabel.text = q
        answerLabel.text = "???"
    }

    @IBAction func showAnsswer(_ sender: UIButton) {
        let a = answers[curQuestionId]
        answerLabel.text = a
    }

    let questions: [String] = [
        "What is 7+7?",
        "What is the capital of Vermont?",
        "What is cognac made from?"
    ]

    let answers: [String] = [
        "14",
        "Montpelier",
        "Grapes"
    ]

    var curQuestionId = 0
}

