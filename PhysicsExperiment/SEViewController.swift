//
//  SEViewController.swift
//  PhysicsExperiment
//
//  Created by 정지원 on 2021/12/23.
//

import UIKit

class SEViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "SEbackground.png")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)

        
        UIGraphicsBeginImageContext(imgView.frame.size) //그림그리기
        let context = UIGraphicsGetCurrentContext()!
        
        let xCtr = 195
        let yCtr = 340
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.gray.cgColor)
        context.move(to: CGPoint(x: xCtr, y: 320)) //y축
        context.addLine(to: CGPoint(x: xCtr, y: 360))
        context.move(to: CGPoint(x: 175, y: yCtr)) //x축
        context.addLine(to: CGPoint(x: 215, y: yCtr))
        context.strokePath()
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func angleSlider(_ sender: UISlider) {
        let ceta = Double(sender.value)
        let refN = 1.3 //상대 굴절률
        let xCtr = 195
        let yCtr = 340
        
        //입사각 좌표 구하기
        
        let inCeta = 90 - ceta //90-입사각
        
        let sinInCeta :Double = sin(Double(inCeta) * Double.pi / 180) //sin 90-입사각
        let cosInCeta :Double = cos(Double(inCeta) * Double.pi / 180) //cos 90-입사각
        //입사점 좌표: (195-cosInCeta, 340-sinInCeta)
        
        //굴절각 좌표 구하기
        
        let sinCeta1 = sin(Double(ceta) * Double.pi / 180) //sin 입사각
        let sinCeta2 = Double(sinCeta1 / refN) //sin 입사각 / 상대굴절률 = sin 굴절각
        let ceta2 = asin(sinCeta2) * 180 / Double.pi //굴절각
        let outCeta = 90 - ceta2 //90-굴절각
        
        let sinOutCeta :Double = sin(outCeta * Double.pi / 180) //sin 90-굴절각
        let cosOutCeta :Double = cos(outCeta * Double.pi / 180) //cos 90-굴절각
        //굴절점 좌표: (195+cosOutCeta, 340+sinOutCeta)
        
        UIGraphicsBeginImageContext(imgView.frame.size) //그림그리기
        let context = UIGraphicsGetCurrentContext()!
        
        let multipleNum = 200.0 //선 길이 증폭 = multipleNum 배
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor) //입사선 그림
        context.move(to: CGPoint(x: xCtr, y: yCtr))
        context.addLine(to: CGPoint(x: ( Double(xCtr) - multipleNum*cosInCeta), y: (Double(yCtr) - multipleNum*sinInCeta) ))
        context.strokePath()
        
        context.setStrokeColor(UIColor.blue.cgColor) //굴절선 그림
        context.move(to: CGPoint(x: xCtr, y: yCtr))
        context.addLine(to: CGPoint(x: (Double(xCtr) + multipleNum*cosOutCeta), y: (Double(yCtr) + multipleNum*sinOutCeta)))
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
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
