//
//  StorageManager.swift
//  AntPena
//
//  Created by Hevin Jant on 8/14/21.
//  Copyright © 2021 Hevin Jant. All rights reserved.
//

import Foundation
import FirebaseStorage

// Fetch and upload files to Firebase storage
final class StorageManager {
    
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    /// Uploads picture to Firebase storage and returns completion with url string to download
    public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping (Result<String,Error>) -> Void) {
        storage.child("image/\(fileName)").putData(data, metadata: nil) { [weak self] metadata, error in
            guard error == nil else {
                // failed
                print("Failed to upload data to Firebase for picture.")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self?.storage.child("image/\(fileName)").downloadURL { url, error in
                guard let url = url else {
                    print("Failed to get download url.")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("Download url return: \(urlString)")
                completion(.success(urlString))
            }
        }
    }
    
    /// Uploads attachment photo for conversation message
    public func uploadMessagePhoto(with data: Data, fileName: String, completion: @escaping (Result<String,Error>) -> Void) {
        storage.child("message_images/\(fileName)").putData(data, metadata: nil) { [weak self] metadata, error in
            guard error == nil else {
                // failed
                print("Failed to upload data to Firebase for picture.")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self?.storage.child("message_images/\(fileName)").downloadURL { url, error in
                guard let url = url else {
                    print("Failed to get download url.")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("Download url return: \(urlString)")
                completion(.success(urlString))
            }
        }
    }
    
    /// Uploads attachment video for conversation message
    public func uploadMessageVideo(with fileUrl: URL, fileName: String, completion: @escaping (Result<String,Error>) -> Void) {
        storage.child("message_videos/\(fileName)").putFile(from: fileUrl, metadata: nil) { [weak self] metadata, error in
            guard error == nil else {
                // failed
                print("Failed to upload video file to Firebase for video.")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self?.storage.child("message_videos/\(fileName)").downloadURL { url, error in
                guard let url = url else {
                    print("Failed to get download url.")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("Download url return: \(urlString)")
                completion(.success(urlString))
            }
        }
    }
    
    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let reference = storage.child(path)
        
        reference.downloadURL { url, error in
            guard let url = url, error == nil else {
                print("Reference failed to get download url.")
                completion(.failure(StorageErrors.failedToGetDownloadUrl))
                return
            }
            print("URL: \(url)")
            completion(.success(url))
        }
    }
    
    public enum StorageErrors: Error {
        case failedToUpload, failedToGetDownloadUrl
    }
    
}
