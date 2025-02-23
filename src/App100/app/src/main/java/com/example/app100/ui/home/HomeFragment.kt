package com.example.app100.ui.home

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.navigation.fragment.findNavController
import com.example.app100.R
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.json.JSONObject
import java.net.HttpURLConnection
import java.net.URL
import kotlin.io.path.inputStream

class HomeFragment : Fragment() {

    private lateinit var editTextDNI: EditText
    private lateinit var editTextPassword: EditText
    private lateinit var buttonLogin: Button

    // Define the base URL for your server
    private val BASE_URL = "https://recently-loved-escargot.ngrok-free.app/" // Replace with your server's base URL

    // Variables to store the token and DNI
    private var accessToken: String? = null
    private var loggedInDni: String? = null

    // Get an instance of the UserViewModel
    private val userViewModel: UserViewModel by activityViewModels()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        // Inflar el layout para este fragmento
        val view = inflater.inflate(R.layout.fragment_home, container, false)

        // Inicializar las vistas
        editTextDNI = view.findViewById(R.id.editTextDNI)
        editTextPassword = view.findViewById(R.id.editTextPassword)
        buttonLogin = view.findViewById(R.id.buttonLogin)

        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        // Configurar el OnClickListener del botón "Login"
        buttonLogin.setOnClickListener {
            // Obtener las credenciales ingresadas por el usuario
            val dni = editTextDNI.text.toString()
            val password = editTextPassword.text.toString()

            // Call the new login function
            login(dni, password)
        }
    }

    private fun login(dni: String, password: String) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val url = URL("$BASE_URL/login")
                val connection = url.openConnection() as HttpURLConnection
                connection.requestMethod = "POST"
                connection.setRequestProperty("Content-Type", "application/json")
                connection.doOutput = true

                val jsonObject = JSONObject().apply {
                    put("dni", dni)
                    put("contraseña", password)
                }

                val outputStream = connection.outputStream
                outputStream.write(jsonObject.toString().toByteArray())
                outputStream.close()

                val responseCode = connection.responseCode
                val response = connection.inputStream.bufferedReader().use { it.readText() }

                withContext(Dispatchers.Main) {
                    val responseJson = JSONObject(response)
                    if (responseCode == HttpURLConnection.HTTP_OK) {
                        // Login successful
                        accessToken = responseJson.getString("access_token")
                        loggedInDni = responseJson.getString("dni")
                        // Update the ViewModel with the logged-in DNI
                        userViewModel.setLoggedInDni(loggedInDni)
                        Log.d("Login", "Login successful: $response")
                        Log.d("Login", "Access Token: $accessToken")
                        Log.d("Login", "Logged in DNI: $loggedInDni")
                        Toast.makeText(requireContext(), responseJson.getString("message"), Toast.LENGTH_SHORT).show()
                        // Navigate to loading screen
                        findNavController().navigate(R.id.loadingFragment)
                        // Call the function to check the private area
                        checkPrivateArea(loggedInDni!!)
                    } else {
                        // Login failed
                        Log.e("Login", "Login failed: $response")
                        val errorMessage = responseJson.getString("message")
                        Toast.makeText(requireContext(), errorMessage, Toast.LENGTH_SHORT).show()
                    }
                }
            } catch (e: Exception) {
                Log.e("Login", "Error during login", e)
                withContext(Dispatchers.Main) {
                    Toast.makeText(requireContext(), "Usuario o contraseñas incorrectos", Toast.LENGTH_SHORT).show()
                }
            }
        }
    }

    private fun checkPrivateArea(dni: String) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val url = URL("$BASE_URL/private?dni=$dni")
                val connection = url.openConnection() as HttpURLConnection
                connection.requestMethod = "GET"
                connection.setRequestProperty("Authorization", "Bearer $accessToken")

                val responseCode = connection.responseCode
                val response = connection.inputStream.bufferedReader().use { it.readText() }

                withContext(Dispatchers.Main) {
                    if (responseCode == HttpURLConnection.HTTP_OK) {
                        // Access to private area successful
                        Log.d("PrivateArea", "Access successful: $response")
                        Toast.makeText(requireContext(), "TOKEN correcto", Toast.LENGTH_SHORT).show()
                        // Navigate to profile (gallery)
                        findNavController().navigate(R.id.nav_gallery)
                    } else {
                        // Access to private area failed
                        Log.e("PrivateArea", "Access failed: $response")
                        val responseJson = JSONObject(response)
                        val errorMessage = responseJson.getString("error")
                        Toast.makeText(requireContext(), errorMessage, Toast.LENGTH_SHORT).show()
                        // Navigate back to login
                        findNavController().navigate(R.id.nav_home)
                    }
                }
            } catch (e: Exception) {
                Log.e("PrivateArea", "Error during private area check", e)
                withContext(Dispatchers.Main) {
                    Toast.makeText(requireContext(), "Error TOKEN", Toast.LENGTH_SHORT).show()
                    // Navigate back to login
                    findNavController().navigate(R.id.nav_home)
                }
            }
        }
    }
}