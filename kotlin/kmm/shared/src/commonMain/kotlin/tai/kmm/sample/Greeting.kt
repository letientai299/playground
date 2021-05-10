package tai.kmm.sample

class Greeting {
    fun greeting(): String {
        return "Hello, ${Platform().platform}! From KMM again."
    }
}