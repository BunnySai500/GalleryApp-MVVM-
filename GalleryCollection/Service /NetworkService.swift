 

import Foundation


//MARK: Networking sessions
class APIService
{
    class func getDataFromEndpoint(urlString u_str: URL, completion: @escaping (Error?, Data?) ->  Void)
    {
        let task = URLSession.shared.dataTask(with: u_str) { (data, response, error) in
            if let err = error
            {
            completion(err, nil)
            }
            if let objectdata = data
            {
            completion(nil, objectdata)
            }
        }
        task.resume()
    }
}

//MARK: Json parsing
class JsonParser {
    class func getJsonDataObjectsfromResponse<T: Decodable>(withData data: Data, type: T.Type, completion: @escaping (Error?, [T]?) -> Void)
    {
    let decoder = JSONDecoder()
        do {
        
            let allItems = try decoder.decode([T].self, from: data)
            completion(nil, allItems)
        } catch {
            print(error)
            completion(error, nil)
        }
    }
}
