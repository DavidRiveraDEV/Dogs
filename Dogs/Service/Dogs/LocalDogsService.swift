//
//  LocalDogsService.swift
//  Dogs
//
//  Created by David Rivera on 16/11/21.
//

import Foundation
import RealmSwift

class LocalDogsService {
    
    let realm: Realm?
    
    init() {
        self.realm = try? Realm()
    }
    
    func getDogs(onSuccess: @escaping (_ dogs: [Dog]) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        if let dogs: [Dog] = self.realm?.objects(StoredDog.self).compactMap({ self.getDog(from: $0) }) {
            onSuccess(dogs)
        } else {
            onFailed(FailedResponse(statusCode: .internalServerError, description: "Realm error", details: nil))
        }
    }
    
    func saveDogs(_ dogs: [Dog]) -> Bool {
        guard !dogs.isEmpty else { return false }
        let storedDogs = dogs.compactMap({ self.getStoredDog(from: $0) })
        do {
            try self.realm?.write() {
                storedDogs.forEach { self.realm?.add($0) }
            }
            return true
        } catch {
            return false
        }
    }
    
    func clearDogs() {
        if let realm = self.realm {
            try? realm.write {
                realm.delete(realm.objects(StoredDog.self))
            }
        }
    }

    private func getStoredDog(from dog: Dog) -> StoredDog {
        let storedDog = StoredDog()
        storedDog.dogName = dog.dogName
        storedDog.dogDescription = dog.dogDescription
        storedDog.age = dog.age
        storedDog.image = dog.image
        return storedDog
    }
    
    private func getDog(from storedDog: StoredDog) -> Dog {
        return Dog(dogName: storedDog.dogName, dogDescription: storedDog.dogDescription, age: storedDog.age, image: storedDog.image)
    }
}
