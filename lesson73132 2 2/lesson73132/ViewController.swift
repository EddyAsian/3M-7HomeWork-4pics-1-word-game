//
//  ViewController.swift
//  lesson73132
//
//  Created by User on 12/8/22.
//



//            return guessWord[currentLevel].count менять на +1 и reloaddata
//    массив моделей level correctword   очищать guess word и массив предложенные буквы



import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageViewOne: UIImageView!
    
    @IBOutlet weak var imageViewTwo: UIImageView!
    
    @IBOutlet weak var imageViewThree: UIImageView!
    
    @IBOutlet weak var imageViewFour: UIImageView!
    
    @IBOutlet weak var wordCollectionView: UICollectionView!
    
    
    @IBOutlet weak var lettersCollectionView: UICollectionView!
    
    
    @IBOutlet weak var deleteImageView: UIImageView!
    
    
    @IBOutlet weak var scoreLabelView: UILabel!
    
    
    @IBOutlet weak var tryNext: UILabel!
    
    
    
    
    
    
    
    
    
    var data: [Model] = [
        Model(image: ["суши", "сакура", "гора", "рука"], letters: ["Ь", "О", "Ц", "Х", "И", "Я", "П", "Д", "И", "Н", "Я"], correctWord: ["Я", "П", "О", "Н", "И", "Я"]),
        
    
        
        Model(image: ["суши", "сакура", "гора", "рука"], letters: ["О", "Р", "Е", "Ь", "Г", "Ь", "Д", "Ш", "В", "В", "О", "К"], correctWord: ["Г", "О", "Р", "Ь", "К", "О"]),
        
        
        
        Model(image: ["суши", "сакура", "гора", "рука"], letters: ["М", "М", "Ц", "П", "И", "З", "Р", "В", "Т", "А", "З", "А"], correctWord: ["В", "А", "М", "П", "И", "Р"]),
        
//        Model(image: ["суши", "сакура", "гора", "рука"], letters: ["Г", "И", "Е", "Р", "А", "Д", "Ц", "Д", "У", "Р", "Я", "Й"], correctWord: ["Г", "P", "А", "Ц", "И", "Я"])
        
        Model(image: ["суши", "сакура", "гора", "рука"], letters: ["Г", "И", "Е", "Р", "А", "Д", "Ц", "Д", "У", "Р", "Я", "Й"], correctWord: ["Г", "Р", "А", "Ц", "И", "Я"])
        
        
    ]
    
    
    
    var filtered = [Model]()
    
    var guessWord: [String] = []
    
    var currentLevel: Int = 0
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //        wordCollectionView.register(LetterCell.self, forCellWithReuseIdentifier: "word_cell")
        lettersCollectionView.backgroundColor = .none
        wordCollectionView.backgroundColor = .none
        
        filtered = data

            
       
        imageViewOne.image = UIImage(named: "суши")
        imageViewTwo.image = UIImage(named: "сакура")
        imageViewThree.image = UIImage(named: "гора")
        imageViewFour.image = UIImage(named: "рука")
            
       
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTap))
        
        deleteImageView.addGestureRecognizer(tap)
        
        
        //       tryNext.layer.cornerRadius = 240 / 3
//                scoreLabelView.layer.cornerRadius = 25
//        scoreLabelView.backgroundColor = .gray
        
    }
    
    
    
    @objc func likeTap() {
        
        guessWord = []
       
        
       
//        let letter = filtered[currentLevel].letters
//        return letter
//        lettersCollectionView.reloadData()
        wordCollectionView.reloadData()
        
    }
    
}
    

    



extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == wordCollectionView {
            return guessWord.count
//            return 20
            

       
        } else {
            return filtered[currentLevel].letters.count
//            return 20
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == wordCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "word_cell", for: indexPath) as! WordCell
            cell.wordLabel.text = guessWord[indexPath.row]
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "letter_cell", for: indexPath) as! LetterCell
            
            cell.letterLabel.text = filtered[currentLevel].letters[indexPath.row]
            cell.backgroundColor = .green
            
            return cell
        }
    }
    

    //если убрать скролл, это можно закомментить и/или удалить
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//        if !guessWord.isEmpty {
//            if guessWord.contains(letters[indexPath.row]) {
//                cell.backgroundColor = .gray
//                cell.isUserInteractionEnabled = false
//            } else {
//                cell.backgroundColor = .green
//                cell.isUserInteractionEnabled = true
//            }
//        } else {
//            cell.backgroundColor = .green
//        }
//    }
    
    
    
    
    
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 55, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == lettersCollectionView {
            let letter = filtered[currentLevel].letters[indexPath.row]
            guessWord.append(letter)
            
            let cell = lettersCollectionView.cellForItem(at: indexPath) as! LetterCell
            cell.backgroundColor = .none
            cell.layer.opacity = 0
            
            //            так не писать так как тогда варианты новых букв окажутся пустые местами
            //            cell.layer.isHidden = true
            //            cell.isUserInteractionEnabled = false
            
            wordCollectionView.reloadData()
           
                
                
                let correctWord = filtered[currentLevel].correctWord
//                print("\(correctWord)")
                if guessWord == correctWord {
                    let alert = UIAlertController(title: "Поздравляем!", message: "Перейти к следующему слову?", preferredStyle: .alert)
                    
                    let yesAction = UIAlertAction(title: "ДА", style: .default) { [self] action in
                        ()
                        self.currentLevel += 1
                        
                        
                        if currentLevel == 1 {
                            
                            scoreLabelView.text = "Уровень 2 🎖️🎖️"
                            imageViewOne.image = UIImage(named: "грейпфрут")
                            imageViewTwo.image = UIImage(named: "кофе")
                            imageViewThree.image = UIImage(named: "морщится")
                            imageViewFour.image = UIImage(named: "лекарство")
                            
                        }else if
                            
                            currentLevel == 2 {
                            scoreLabelView.text = "Уровень 3 🎖️🎖️🎖️"
                            imageViewOne.image = UIImage(named: "дракула")
                            imageViewTwo.image = UIImage(named: "летучая")
                            imageViewThree.image = UIImage(named: "вампиры")
                            imageViewFour.image = UIImage(named: "кровь")
                            
                        } else if
                            
                            currentLevel == 3 {
                            scoreLabelView.text = "Уровень 4 🎖️🎖️🎖️🎖️"
                            imageViewOne.image = UIImage(named: "балерина")
                            imageViewTwo.image = UIImage(named: "лебеди")
                            imageViewThree.image = UIImage(named: "косуля")
                            imageViewFour.image = UIImage(named: "катание")
                        }
                        
                        guessWord = []
                        wordCollectionView.reloadData()
                        
                        lettersCollectionView.reloadData()
                        
                        //                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "letter_cell", for: indexPath) as! LetterCell
                        //
                        //                    cell.letterLabel.text = filtered[currentLevel].letters[indexPath.row]
                        //                    cell.backgroundColor = .green
                        //
                        //
                        //                    self.lettersCollectionView.reloadData()
                    }
                    
                    let noAction = UIAlertAction(title: "НЕТ", style: .destructive) { action in
                        ()
                    }
                    
                    alert.addAction(yesAction)
                    alert.addAction(noAction)
                    
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    
    
    
}


