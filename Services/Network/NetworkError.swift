enum NetworkError: Error {
    case noData
    case decodingError
    case notFoundPlayerID
    case badURL
    case badResponse
}


func handleError(error: NetworkError) -> String {
    switch error {
    case .notFoundPlayerID:
        return "Профиль не найден"
    case .noData:
        return "Нет данных"
    case .decodingError:
        return "Ошибка декодирования"
    case .badURL:
        return "Неверный URL"
    case .badResponse:
        return "Неверный ответ сервера"
    }
}
