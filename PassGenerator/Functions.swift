//
//  Functions.swift
//  PassGenerator
//
//  Created by Sebastian San Blas on 20/06/2021.
//

import Foundation
import UIKit
// Modified code from @brennanMKE - https://gist.github.com/brennanMKE

public typealias CharactersArray = [Character]
public typealias CharactersHash = [CharactersGroup : CharactersArray]

public enum CharactersGroup {
    case LettersLower
    case LettersUpper
    case Numbers
    case Punctuation
    case Symbols
    
    public static var groups: [CharactersGroup] {
        get {
            return [.LettersLower, .LettersUpper, .Numbers, .Punctuation, .Symbols]
        }
    }

    private static func charactersString(group: CharactersGroup) -> String {
        switch group {
        case .LettersLower:
            return "abcdefghijklmnopqrstuvwxyz"
        case .LettersUpper:
            return "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        case .Numbers:
            return "0123456789"
        case .Punctuation:
            return ".!?"
        case .Symbols:
            return ";,&%$@#^*~"
        }
    }

    private static func characters(group: CharactersGroup) -> CharactersArray {
        var array: CharactersArray = []

        let string = charactersString(group: group)
        assert(string.count > 0)
        var index = string.startIndex

        while index != string.endIndex {
            let character = string[index]
            array.append(character)
            index = string.index(index, offsetBy: 1)
        }
        
        return array
    }

    public static var hash: CharactersHash {
        get {
            var hash: CharactersHash = [:]
            for group in groups {
                hash[group] = characters(group: group)
            }
            return hash
        }
    }

}

public class PasswordGenerator {

    private var hash: CharactersHash = [:]

    public static let sharedInstance = PasswordGenerator()

    private init() {
        self.hash = CharactersGroup.hash
    }

    private func charactersForGroup(group: CharactersGroup) -> CharactersArray {
        if let characters = hash[group] {
            return characters
        }
        assertionFailure("Characters should always be defined")
        return []
    }

    public func generatePassword(includeLower: Bool,
                                 includeUpper: Bool,
                                 includeNumbers: Bool,
                                 includePunctuation: Bool,
                                 includeSymbols: Bool,
                                 length: Int) -> String {

        var characters: CharactersArray = []

//        characters.append(contentsOf: charactersForGroup(group: .Letters))
        if includeLower {
            characters.append(contentsOf: charactersForGroup(group: .LettersLower))
        }
        if includeUpper {
            characters.append(contentsOf: charactersForGroup(group: .LettersUpper))
        }
        if includeNumbers {
            characters.append(contentsOf: charactersForGroup(group: .Numbers))
        }
        if includePunctuation {
            characters.append(contentsOf: charactersForGroup(group: .Punctuation))
        }
        if includeSymbols {
            characters.append(contentsOf: charactersForGroup(group: .Symbols))
        }

        var passwordArray: CharactersArray = []
        
        guard characters.isEmpty == false else {
            return ""
        }
        
        while passwordArray.count < length {
            let index = Int(arc4random()) % (characters.count - 1)
            passwordArray.append(characters[index])
        }

        let password = String(passwordArray)

        return password
    }

}
