import Foundation

enum NetworkError: Error, LocalizedError {
    case badURL
    case noData
    case badResponse(statusCode: Int)
    case decodingError
    case offline
    case timeout
    case unknown(Error)
    case notFoundPlayerID
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Ошибка в адресе запроса"
        case .noData:
            return "Сервер не прислал данные"
        case .badResponse(statusCode: let code):
            return "Ошибка сервера (Код: \(code))"
        case .decodingError:
            return "Не удалось обработать данные от сервера"
        case .offline:
            return "Отсутствует интернет-соединение"
        case .timeout:
            return "Время ожидания истекло, попробуйте снова"
        case .unknown(let error):
            return "Неизвестная ошибка: \(error.localizedDescription)"
        case .notFoundPlayerID:
            return "Игрок с такими ID не найден"
        }
    }
}


