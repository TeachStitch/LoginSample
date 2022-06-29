//
//  ValidationService.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import Foundation

protocol ValidationServiceContext {
    func validate(_ text: String, type: ValidationService.ValidationType) throws
}

class ValidationService: ValidationServiceContext {
    
    struct ValidationError: Error {
        let reason: String
        
        init(_ reason: String) {
            self.reason = reason
        }
    }
    
    func validate(_ text: String, type: ValidationType) throws {
        guard !text.isEmpty else { throw ValidationError("\(type.description) is required") }
        
        guard text.range(of: type.pattern, options: .regularExpression) != nil else {
            throw handleError(of: type)
        }
    }
    
    private func handleError(of type: ValidationType) -> ValidationError {
        switch type {
        case .email(_):
            return ValidationError("Email doesn't exist")
        case .password(_):
            return ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
        case .fullName(_):
            return ValidationError("Full name might be incorrect")
        }
    }
}

extension ValidationService {
    enum ValidationType: CustomStringConvertible {
        case email(Pattern)
        case password(Pattern)
        case fullName(Pattern)
        
        enum Pattern {
            case `default`
            case custom(String)
        }
        
        var pattern: String {
            switch self {
            case .email(let pattern):
                switch pattern {
                case .default:
                    return "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
                case .custom(let string):
                    return string
                }
            case .password(let pattern):
                switch pattern {
                case .default:
                    return "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
                case .custom(let string):
                    return string
                }
            case .fullName(let pattern):
                switch pattern {
                case .default:
                    return "^[a-zA-Z-]{4,}(?: [a-zA-Z-]+){0,2}$"
                case .custom(let string):
                    return string
                }
            }
        }
        
        var description: String {
            switch self {
            case .email(_):
                return "Email"
            case .password(_):
                return "Password"
            case .fullName(_):
                return "Full name"
            }
        }
    }
}
