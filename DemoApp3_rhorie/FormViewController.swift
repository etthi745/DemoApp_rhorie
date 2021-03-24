//
//  FormViewController.swift
//  DemoApp3_rhorie
//
//  Created by rhorie on 2021/03/11.
//

import UIKit

class FormViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBAction func nameTextField(_ sender: UITextField) {
        nameTextField.text = sender.text
    }
    @IBOutlet weak var nameTextField: UITextField!
    
    let check_on = UIImage(named:"check_on")!
    let check_off = UIImage(named:"check_off")!
    @IBOutlet weak var menButton: UIButton!
    @IBOutlet weak var womanButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        menButton.setImage(check_off, for: .normal)
        womanButton.setImage(check_off, for: .normal)
        otherButton.setImage(check_off, for: .normal)
        ans1Button.setImage(check_off, for: .normal)
        ans2Button.setImage(check_off, for: .normal)
        ans3Button.setImage(check_off, for: .normal)
        ans4Button.setImage(check_off, for: .normal)
        ans5Button.setImage(check_off, for: .normal)
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        yearPicker.delegate = self
        yearPicker.dataSource = self
        monthPicker.delegate = self
        monthPicker.dataSource = self
        dayPicker.delegate = self
        dayPicker.dataSource = self
        toolbar.setItems([doneButton], animated: true)
        self.yearField.inputView = yearPicker
        self.yearField.inputAccessoryView = toolbar
        self.monthField.inputView = monthPicker
        self.monthField.inputAccessoryView = toolbar
        self.dayField.inputView = dayPicker
        self.dayField.inputAccessoryView = toolbar
        
    }
    //性別選択-------------------------------------------
    var gender = ""
    @IBAction func menButton(_ sender: Any) {
        menButton.setImage(check_on, for: .selected)
        gender = "男"
        menButton.isSelected = true
        if womanButton.isSelected {
            womanButton.isSelected = false
        }
        if otherButton.isSelected {
            otherButton.isSelected = false
        }
    }
    
    @IBAction func womanButton(_ sender: Any) {
        womanButton.setImage(check_on, for: .selected)
        gender = "女"
        womanButton.isSelected = true
        if menButton.isSelected {
            menButton.isSelected = false
        }
        if otherButton.isSelected {
            otherButton.isSelected = false
        }
    }
    
    @IBAction func otherButton(_ sender: Any) {
        otherButton.setImage(check_on, for: .selected)
        gender = "その他"
        otherButton.isSelected = true
        if menButton.isSelected {
            menButton.isSelected = false
        }
        if womanButton.isSelected {
            womanButton.isSelected = false
        }
    }
    //性別選択ここまでーーーーーーーーーーーーーーーーーーーーーーーーーーー
    
    //生年月日ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    var birthdayYear = 0
    var birthdayMonth = 0
    var birthday = 0
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var monthField: UITextField!
    @IBOutlet weak var dayField: UITextField!
    let yearPicker: UIPickerView = UIPickerView()
    let year = [Int](1900...2100)
    let monthPicker: UIPickerView = UIPickerView()
    let month = [Int](1...12)
    let dayPicker: UIPickerView = UIPickerView()
    let day = [Int](1...31)
    @IBOutlet weak var ageField: UITextView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == yearPicker{
            return year.count
        } else if pickerView == monthPicker {
            return month.count
        } else if pickerView == dayPicker {
            return day.count
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == yearPicker{
            return String(year[row])
        } else if pickerView == monthPicker {
            return String(month[row])
        } else if pickerView == dayPicker {
            return String(day[row])
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == yearPicker{
            self.yearField.text = String(year[row])
            birthdayYear = year[row]
        } else if pickerView == monthPicker {
            self.monthField.text = String(month[row])
            birthdayMonth = month[row]
        } else if pickerView == dayPicker {
            self.dayField.text = String(day[row])
            birthday = day[row]
        }
    }
    
    @objc func done() {
        self.nameTextField.endEditing(true)
        self.yearField.endEditing(true)
        self.monthField.endEditing(true)
        self.dayField.endEditing(true)
        ageCalc()
    }

    //年齢計算
    var age = ""
    func ageCalc(){
        if yearField.text != "" && monthField.text != "" && dayField.text != ""{
            var birthdate = DateComponents(year: birthdayYear, month: birthdayMonth, day: birthday)
            var age: Int
            let calendar = Calendar.current
            let now = calendar.dateComponents([.year, .month, .day], from: Date())
            let ageComponents = calendar.dateComponents([.year], from: birthdate, to: now)
            age = ageComponents.year!
            self.ageField.text = String(age)
        }
    }
    
    //生年月日のキー入力を禁止
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField != nameTextField{
            return false
        } else {
            return true
        }
    }
    //生年月日ここまでーーーーーーーーーーーーーーーーーーーーーーーーーーー
    //あんけーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    var ans:[String] = []
    @IBOutlet weak var ans1Button: UIButton! //いんたーねっと
    @IBOutlet weak var ans2Button: UIButton! //雑誌
    @IBOutlet weak var ans3Button: UIButton! //友人
    @IBOutlet weak var ans4Button: UIButton! //セミナー
    @IBOutlet weak var ans5Button: UIButton! //その他
    
    @IBAction func ans1Button(_ sender: Any) {
        if ans1Button.isSelected == false{
            ans1Button.setImage(check_on, for: .selected)
            ans.append("インターネット")
            ans1Button.isSelected = true
        } else {
            ans1Button.isSelected = false
            ans.removeAll(where: {$0 == "インターネット"})
        }
    }
    @IBAction func ans2Button(_ sender: Any) {
        if ans2Button.isSelected == false{
            ans2Button.setImage(check_on, for: .selected)
            ans.append("雑誌記事")
            ans2Button.isSelected = true
        } else {
            ans2Button.isSelected = false
            ans.removeAll(where: {$0 == "雑誌記事"})
        }
    }
    @IBAction func ans3Button(_ sender: Any) {
        if ans3Button.isSelected == false{
            ans3Button.setImage(check_on, for: .selected)
            ans.append("友人")
            ans3Button.isSelected = true
        } else {
            ans3Button.isSelected = false
            ans.removeAll(where: {$0 == "友人"})
        }
    }
    @IBAction func ans4Button(_ sender: Any) {
        if ans4Button.isSelected == false{
            ans4Button.setImage(check_on, for: .selected)
            ans.append("セミナー")
            ans4Button.isSelected = true
        } else {
            ans4Button.isSelected = false
            ans.removeAll(where: {$0 == "セミナー"})
        }
    }
    @IBAction func ans5Button(_ sender: Any) {
        if ans5Button.isSelected == false{
            ans5Button.setImage(check_on, for: .selected)
            ans.append("その他")
            ans5Button.isSelected = true
        } else {
            ans5Button.isSelected = false
            ans.removeAll(where: {$0 == "その他"})
        }
    }
    //あんけここまでーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    //ツールバーのサイズ指定
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
            return CGRect(x: x, y: y, width: width, height: height)
    }
    //データ送信
    var ansText = ""
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResultSegue" {
            let nextView = segue.destination as! ResultViewController
            nextView.nameString = nameTextField.text!
            nextView.genderString = gender
            nextView.year = String(birthdayYear)
            nextView.month = String(birthdayMonth)
            nextView.day = String(birthday)
            nextView.ageString = ageField.text
            ansSet()
            nextView.ansString = ansText
        }
    }
    
    func ansSet(){
        let result = ans.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
        for i in 0..<result.count{
            ansText = ansText + "\(result[i])、"
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
