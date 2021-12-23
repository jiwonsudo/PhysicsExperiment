//
//  CalcViewController.swift
//  PhysicsExperiment
//
//  Created by 정지원 on 2021/12/22.
//

import UIKit

class CalcViewController: UIViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    @IBOutlet var tfN1: UITextField!
    @IBOutlet var tfN2: UITextField!
    @IBOutlet var tfInputCeta: UITextField!
    
    @IBOutlet var lblRefN: UILabel!
    @IBOutlet var lblRefrectAngle: UILabel!
    @IBOutlet var lblReflectAngle: UILabel!
    @IBOutlet var lblCriticalAngle: UILabel!
   
    @IBOutlet var lblArrow: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnSolve(_ sender: UIButton) {
        
        let n1 = Double(tfN1.text!) ?? 0 //매질1 굴절률
        let n2 = Double(tfN2.text!) ?? 0 //매질2 굴절률
        let refN = Double(n2 / n1) //상대 굴절률
        
        //입사각 좌표 구하기
        let ceta1 = Double(tfInputCeta.text!) ?? 0 //입사각

        //굴절각 좌표 구하기
        let sinCeta1 = sin(ceta1 * Double.pi / 180) //sin 입사각
        let sinCeta2 = Double(sinCeta1 / refN) //sin 입사각 / 상대굴절률 = sin 굴절각
        let ceta2 = asin(sinCeta2) * 180 / Double.pi //굴절각
        let criticalAngle = asin(refN) * 180 / Double.pi //임계각
        
        if n1 > n2 { //매질1 굴절률이 매질2 굴절률보다 클 시 : 밀한 매질에서 소한 매질 진행시
            lblArrow.text = "<-"
            lblRefN.text = "상대 굴절률: " + String(refN)
            lblRefrectAngle.text = "굴절각: " + String(ceta2)
            lblReflectAngle.text = "반사각: " + String(ceta1)
            lblCriticalAngle.text = "임계각: " + String(criticalAngle)
            if sinCeta1 > refN { //입사각 > 임계각 (전반사될 경우)
                lblRefN.text = "상대 굴절률: " + String(refN)
                lblRefrectAngle.text = "굴절각: " + "없음"
                lblReflectAngle.text = "반사각: " + String(ceta1)
                lblCriticalAngle.text = "임계각: " + String(criticalAngle)
            }
        } else {
            lblArrow.text = "->"
            lblRefN.text = "상대 굴절률: " + String(refN)
            lblRefrectAngle.text = "굴절각: " + String(ceta2)
            lblReflectAngle.text = "반사각: " + String(ceta1)
            lblCriticalAngle.text = "임계각: " + "없음"
        }
    }
}
