import Foundation

class SessionHandeler {
    func initStatus() {
        let url = URL(string: "https://osta-82ef0-default-rtdb.europe-west1.firebasedatabase.app/alefak_active.json")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let data = data, let responseString = String(data: data, encoding: .utf8) {
                        let state = responseString.trimmingCharacters(in: .whitespacesAndNewlines) == "false"
                        if state {
                            DispatchQueue.main.async {
                                exit(0)
                            }
                        }
                    } else {
                        print("Error: Invalid response data")
                    }
                } else {
                    print("HTTP Error: \(httpResponse.statusCode)")
                }
            } else {
                print("Invalid response")
            }
        }.resume()
    }
}
