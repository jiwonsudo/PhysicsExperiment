//
//  CBEViewController.swift
//  PhysicsExperiment
//
//  Created by 정지원 on 2021/12/22.
//

import UIKit

class CBEViewController: UIViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblN: UILabel!
    @IBOutlet var lblShowIn: UILabel!
    @IBOutlet var lblShowOut: UILabel!
    @IBOutlet var lblCritical: UILabel!
    @IBOutlet var tfN1: UITextField!
    @IBOutlet var tfN2: UITextField!
    @IBOutlet var tfInputCeta: UITextField!
    
    /*
    let sinus = sin(90.0 * Double.pi / 180)
    let cosinus = cos(90 * Double.pi / 180)
    let tangent = tan(90 * Double.pi / 180)
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIGraphicsBeginImageContext(imgView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setLineWidth(1.5)
        context.setStrokeColor(UIColor.lightGray.cgColor)
        
        let ctrCircle = CGRect(x: 30, y: 160, width: 300, height: 300)
        context.addEllipse(in: ctrCircle)
        context.strokePath()
        
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.gray.cgColor)
        context.move(to: CGPoint(x: 180, y: 130)) //y축
        context.addLine(to: CGPoint(x: 180, y: 490))
        context.move(to: CGPoint(x: 10, y: 310)) //x축
        context.addLine(to: CGPoint(x: 360, y: 310))
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAdjust(_ sender: UIButton) {
        
        let n1 = Double(tfN1.text!) ?? 0 //매질1 굴절률
        let n2 = Double(tfN2.text!) ?? 0 //매질2 굴절률
        let refN = Double(n2 / n1) //상대 굴절률
        
        //입사각 좌표 구하기
        
        let ceta1 = Double(tfInputCeta.text!) ?? 0 //입사각
        let inCeta = 90 - ceta1 //90-입사각
        
        let sinInCeta :Double = sin(inCeta * Double.pi / 180) //sin 90-입사각
        let cosInCeta :Double = cos(inCeta * Double.pi / 180) //cos 90-입사각
        //입사점 좌표: (180-cosInCeta, 310-sinInCeta)
        
        //굴절각 좌표 구하기
        
        let sinCeta1 = sin(ceta1 * Double.pi / 180) //sin 입사각
        let sinCeta2 = Double(sinCeta1 / refN) //sin 입사각 / 상대굴절률 = sin 굴절각
        let ceta2 = asin(sinCeta2) * 180 / Double.pi //굴절각
        let outCeta = 90 - ceta2 //90-굴절각
        
        let sinOutCeta :Double = sin(outCeta * Double.pi / 180) //sin 90-굴절각
        let cosOutCeta :Double = cos(outCeta * Double.pi / 180) //cos 90-굴절각
        //굴절점 좌표: (180+cosOutCeta, 310+sinOutCeta)
        
        UIGraphicsBeginImageContext(imgView.frame.size) //그림그리기
        let context = UIGraphicsGetCurrentContext()!
        
        //중심원 그리기 (중심 = (180, 310))
        context.setLineWidth(1.3)
        context.setStrokeColor(UIColor.lightGray.cgColor)
        let ctrCircle = CGRect(x: 30, y: 160, width: 300, height: 300)
        context.addEllipse(in: ctrCircle)
        context.strokePath()
        
        //x축, y축 그리기
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.gray.cgColor)
        context.move(to: CGPoint(x: 180, y: 130)) //y축
        context.addLine(to: CGPoint(x: 180, y: 490))
        context.move(to: CGPoint(x: 10, y: 310)) //x축
        context.addLine(to: CGPoint(x: 360, y: 310))
        context.strokePath()
        
        //입사, 굴절선 그리기
        let multipleNum = 200.0 //선 길이 증폭 = multipleNum 배
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.red.cgColor) //입사선 그림
        context.move(to: CGPoint(x: 180, y: 310))
        context.addLine(to: CGPoint(x: (180 - multipleNum*cosInCeta), y: (310 - multipleNum*sinInCeta) ))
        context.strokePath()
        
        context.setStrokeColor(UIColor.blue.cgColor) //굴절선 그림
        context.move(to: CGPoint(x: 180, y: 310))
        if n1 > n2 { //매질1 굴절률이 매질2 굴절률보다 클 시 : 밀한 매질에서 소한 매질 진행시
            let criticalAngle = asin(refN) * 180 / Double.pi //임계각
            lblCritical.text = "임계각: " + String(criticalAngle)
            context.addLine(to: CGPoint(x: (180 + multipleNum*cosOutCeta), y: (310 + multipleNum*sinOutCeta)))
            if sinCeta1 > refN { //입사각 > 임계각 (전반사될 경우)
                context.addLine(to: CGPoint(x: (180 + multipleNum*cosInCeta), y: (310 - multipleNum*sinInCeta)))
            }
        } else {
            context.addLine(to: CGPoint(x: (180 + multipleNum*cosOutCeta), y: (310 + multipleNum*sinOutCeta)))
            lblCritical.text = "임계각: " + "소->밀 진행"
        }
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lblN.text = "상대굴절률: " + String(refN)
        lblShowIn.text = "입사각: " + String(ceta1)
        lblShowOut.text = "굴절각: " + String(ceta2)

    }

}
