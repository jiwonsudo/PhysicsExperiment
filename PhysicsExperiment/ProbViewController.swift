//
//  ProbViewController.swift
//  PhysicsExperiment
//
//  Created by 정지원 on 2021/12/22.
//

// 답: 4 (ㄱ,ㄴ)

import UIKit

class ProbViewController: UIViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    @IBOutlet var lblAns: UILabel!
    @IBOutlet var tfAns: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnShowAns(_ sender: UIButton) {
        let Ans = Int(tfAns.text!) ?? 0
        if Ans == 4 {
            lblAns.text = "정답입니다. 축하합니다!"
        } else if Ans == 0 {
            lblAns.text = "답을 입력하고 채점해 주세요."
        } else {
            lblAns.text = "오답입니다. 정답: 4(ㄱ,ㄴ)"
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
