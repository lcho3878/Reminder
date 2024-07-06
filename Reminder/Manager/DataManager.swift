//
//  BaseViewController+Extension.swift
//  Reminder
//
//  Created by 이찬호 on 7/6/24.
//

import UIKit

final class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    func saveImageToDocument(image: UIImage?, filename: String) {
        
        guard let image else { return }
           
           guard let documentDirectory = FileManager.default.urls(
               for: .documentDirectory,
               in: .userDomainMask).first else { return }

           let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")

           guard let data = image.jpegData(compressionQuality: 0.5) else { return }

           do {
               try data.write(to: fileURL)
           } catch {
               print("file save error", error)
           }
       }
    
    func loadImageToDocument(filename: String) -> UIImage? {
         
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return nil }
         
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        //이 경로에 실제로 파일이 존재하는 지 확인
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        } else {
            return nil
        }
        
    }
    
    func removeImageFromDocument(filename: String) {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }

        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            
            do {
                try FileManager.default.removeItem(atPath: fileURL.path())
            } catch {
                print("file remove error", error)
            }
            
        } else {
            print("file no exist")
        }
        
    }
    
    
}
