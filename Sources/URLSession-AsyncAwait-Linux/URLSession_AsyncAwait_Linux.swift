import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public extension URLSession {
    enum URLSessionError: Error {
        case unknownError
    }
    
    // MARK: - Data
    
    /// Convenience method to load data using an URL, creates and resumes an URLSessionDataTask internally.
    ///
    /// - Parameter url: The URL for which to load data.
    /// - Parameter delegate: Task-specific delegate.
    /// - Returns: Data and response.
    func data(from url : URL) async throws -> (Data, URLResponse) {
        if #available(iOSApplicationExtension 15.0, *) {
            try await withCheckedThrowingContinuation { continuation in
                dataTask(with: url) { data, response, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let data = data, let response = response {
                        continuation.resume(returning: (data, response))
                    } else {
                        continuation.resume(throwing: URLSessionError.unknownError)
                    }
                }.resume()
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    /// Convenience method to load data using an URLRequest, creates and resumes an URLSessionDataTask internally.
    ///
    /// - Parameter request: The URLRequest for which to load data.
    /// - Parameter delegate: Task-specific delegate.
    /// - Returns: Data and response.
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(throwing: URLSessionError.unknownError)
                }
            }.resume()
        }
    }
    
    // MARK: - Download
    
    /// Convenience method to download using an URL, creates and resumes an URLSessionDownloadTask internally.
    ///
    /// - Parameter url: The URL for which to download.
    /// - Parameter delegate: Task-specific delegate.
    /// - Returns: Downloaded file URL and response. The file will not be removed automatically.
    func download(from url: URL) async throws -> (URL, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            downloadTask(with: url) { url, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let url = url, let response = response {
                    continuation.resume(returning: (url, response))
                } else {
                    continuation.resume(throwing: URLSessionError.unknownError)
                }
            }.resume()
        }
    }
    
    /// Convenience method to download using an URLRequest, creates and resumes an URLSessionDownloadTask internally.
    ///
    /// - Parameter request: The URLRequest for which to download.
    /// - Parameter delegate: Task-specific delegate.
    /// - Returns: Downloaded file URL and response. The file will not be removed automatically.
    func download(for request: URLRequest, delegate: URLSessionTaskDelegate? = nil) async throws -> (URL, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            downloadTask(with: request) { url, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let url = url, let response = response {
                    continuation.resume(returning: (url, response))
                } else {
                    continuation.resume(throwing: URLSessionError.unknownError)
                }
            }.resume()
        }
    }
    
    // MARK: - Upload
    
    /// Convenience method to upload data using an URLRequest, creates and resumes an URLSessionUploadTask internally.
    ///
    /// - Parameter request: The URLRequest for which to upload data.
    /// - Parameter fileURL: File to upload.
    /// - Parameter delegate: Task-specific delegate.
    /// - Returns: Data and response.
    func upload(for request: URLRequest, fromFile fileURL: URL) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            uploadTask(with: request, fromFile: fileURL) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(throwing: URLSessionError.unknownError)
                }
            }.resume()
        }
    }

    /// Convenience method to upload data using an URLRequest, creates and resumes an URLSessionUploadTask internally.
    ///
    /// - Parameter request: The URLRequest for which to upload data.
    /// - Parameter bodyData: Data to upload.
    /// - Parameter delegate: Task-specific delegate.
    /// - Returns: Data and response.
    func upload(for request: URLRequest, from bodyData: Data) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            uploadTask(with: request, from: bodyData) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(throwing: URLSessionError.unknownError)
                }
            }.resume()
        }
    }
}
