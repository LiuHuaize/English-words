import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    // 开发环境使用 localhost，生产环境需要改为真实服务器地址
    private let baseURL = "http://localhost:3000/api"
    
    private init() {}
    
    // 统一的响应格式
    struct APIResponse<T: Codable>: Codable {
        let success: Bool
        let message: String
        let user: T?
    }
    
    struct User: Codable {
        let id: Int
        let username: String
        let createdAt: String
    }
    
    enum NetworkError: LocalizedError {
        case invalidURL
        case noData
        case decodingError
        case serverError(String)
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "网络地址错误"
            case .noData:
                return "没有收到数据"
            case .decodingError:
                return "数据格式错误"
            case .serverError(let message):
                return message
            }
        }
    }
    
    // 注册用户
    func register(username: String, password: String) async throws -> User {
        guard let url = URL(string: "\(baseURL)/register") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["username": username, "password": password]
        request.httpBody = try? JSONEncoder().encode(body)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.serverError("网络连接失败")
            }
            
            let decoder = JSONDecoder()
            let apiResponse = try decoder.decode(APIResponse<User>.self, from: data)
            
            if apiResponse.success {
                guard let user = apiResponse.user else {
                    throw NetworkError.noData
                }
                return user
            } else {
                throw NetworkError.serverError(apiResponse.message)
            }
            
        } catch let error as NetworkError {
            throw error
        } catch {
            // 如果是网络连接错误
            if error._domain == NSURLErrorDomain {
                throw NetworkError.serverError("无法连接到服务器，请确保后端服务正在运行")
            }
            throw NetworkError.serverError("注册失败，请稍后再试")
        }
    }
    
    // 登录用户
    func login(username: String, password: String) async throws -> User {
        guard let url = URL(string: "\(baseURL)/login") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["username": username, "password": password]
        request.httpBody = try? JSONEncoder().encode(body)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.serverError("网络连接失败")
            }
            
            let decoder = JSONDecoder()
            let apiResponse = try decoder.decode(APIResponse<User>.self, from: data)
            
            if apiResponse.success {
                guard let user = apiResponse.user else {
                    throw NetworkError.noData
                }
                return user
            } else {
                throw NetworkError.serverError(apiResponse.message)
            }
            
        } catch let error as NetworkError {
            throw error
        } catch {
            // 如果是网络连接错误
            if error._domain == NSURLErrorDomain {
                throw NetworkError.serverError("无法连接到服务器，请确保后端服务正在运行")
            }
            throw NetworkError.serverError("登录失败，请稍后再试")
        }
    }
    
    // 测试数据库连接
    func testConnection() async -> Bool {
        guard let url = URL(string: "\(baseURL)/test") else {
            return false
        }
        
        do {
            let (_, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                return false
            }
            return httpResponse.statusCode == 200
        } catch {
            return false
        }
    }
}