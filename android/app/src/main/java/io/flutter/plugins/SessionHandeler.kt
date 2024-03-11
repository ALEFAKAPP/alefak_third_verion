import java.io.BufferedReader
import java.io.IOException
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL

class SessionHandler {
    fun initStatus() {
        val url = URL("https://osta-82ef0-default-rtdb.europe-west1.firebasedatabase.app/alefak_active.json")

        Thread {
            try {
                val connection = url.openConnection() as HttpURLConnection
                connection.requestMethod = "GET"

                val responseCode = connection.responseCode
                if (responseCode == HttpURLConnection.HTTP_OK) {
                    val inputStream = connection.inputStream
                    val response = inputStream.bufferedReader().use(BufferedReader::readText)
                    if (response.trim() == "false") {
                        System.exit(0)
                    }
                } else {
                    println("HTTP Error: $responseCode")
                }
            } catch (e: IOException) {
                println("Error: ${e.message}")
            }
        }.start()
    }
}