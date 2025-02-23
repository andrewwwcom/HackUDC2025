package com.example.app100.ui.slideshow

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment
import com.example.app100.databinding.FragmentSlideshowBinding
import com.example.app100.network.RetrofitInstance
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import com.example.app100.data.UserData

class SlideshowFragment : Fragment() {

    private var _binding: FragmentSlideshowBinding? = null
    private val binding get() = _binding!!

    private val universityMap = mapOf(
        1 to "Universidad Autonoma de Madrid",
        2 to "Universidad Politecnica de Valencia",
        3 to "Universidad de Salamanca (USAL)",
        4 to "Universidad Comlutense de Madrid",
        5 to "Universidad de Sevilla",
        6 to "Universidad de Zaragoza",
        7 to "Universidad de Valencia",
        8 to "Universiad de Granada",
        9 to "Universidad de Navarra",
        10 to "Universidad de Barcelona"
    )

    private val categoryMap = mapOf(
        1 to "Desarrollador Software",
        2 to "Programador Fullstack",
        3 to "Jefe de Ingeneria Software",
        4 to "Ingeneria de Datos",
        5 to "Desarrollo web",
        6 to "Ciberseguridad",
        7 to "Mantenimiento de Computadores",
        8 to "Inteligencia Artifical",
        9 to "Desarrollo de Aplicaciones Moviles",
        10 to "Computacion en la Nube",
        11 to "Programacion en Python"
    )

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentSlideshowBinding.inflate(inflater, container, false)
        val root: View = binding.root

        val spinner = binding.searchSpinner

        // Adaptador para el Spinner (búsqueda por habilidad)
        val categoryList = categoryMap.values.toList()
        val spinnerAdapter = ArrayAdapter(requireContext(), android.R.layout.simple_spinner_item, categoryList)
        spinnerAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        spinner.adapter = spinnerAdapter

        // Evento de búsqueda por habilidad
        spinner.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(parent: AdapterView<*>, view: View?, position: Int, id: Long) {
                val selectedCategoryName = parent.getItemAtPosition(position).toString()
                performCategorySearch(selectedCategoryName)
            }
            override fun onNothingSelected(parent: AdapterView<*>) {}
        }

        return root
    }

    private fun performCategorySearch(categoryName: String) {
        val categoryId = categoryMap.filterValues { it == categoryName }.keys.firstOrNull()

        if (categoryId == null) {
            Log.e("SlideshowFragment", "❌ No se encontró el ID de la habilidad seleccionada")
            return
        }

        CoroutineScope(Dispatchers.Main).launch {
            try {
                Log.d("SlideshowFragment", "🔍 Buscando por categoría: $categoryName (ID: $categoryId)")
                val response = RetrofitInstance.apiService.searchUsersByCategory(categoryId)

                if (response.isSuccessful) {
                    val data = response.body()
                    if (!data.isNullOrEmpty()) {
                        val users = parseUserData(data)
                        displayUserCards(users)
                    } else {
                        showNoResultsMessage()
                    }
                } else {
                    Log.e("SlideshowFragment", "❌ Error en la búsqueda por habilidad: ${response.message()}")
                    showNoResultsMessage()
                }
            } catch (e: Exception) {
                Log.e("SlideshowFragment", "⚠️ Error en la búsqueda por habilidad", e)
                showNoResultsMessage()
            }
        }
    }

    private fun displayUserCards(users: List<UserData>) {
        val container = binding.resultsContainer
        container.removeAllViews()

        if (users.isEmpty()) {
            showNoResultsMessage()
            return
        }

        users.forEach { user ->
            val universityName = universityMap[user.value1] ?: "Desconocida"
            val skillName = categoryMap[user.value2] ?: "Sin habilidad asignada"

            val userView = TextView(requireContext()).apply {
                text = """
                    👤 ${user.name} ${user.lastName}
                    🎓 Universidad: $universityName
                    💡 Habilidad: $skillName
                    📧 Email: ${user.email ?: "N/A"}
                    📞 Teléfono: ${user.phone ?: "N/A"}
                """.trimIndent()
                textSize = 16f
                setPadding(16, 8, 16, 8)
                setBackgroundColor(ContextCompat.getColor(requireContext(), android.R.color.white))
            }
            container.addView(userView)
        }
    }

    private fun showNoResultsMessage() {
        val container = binding.resultsContainer
        container.removeAllViews()

        val messageView = TextView(requireContext()).apply {
            text = "⚠️ No se encontraron resultados."
            textSize = 16f
            setPadding(16, 8, 16, 8)
            setTextColor(ContextCompat.getColor(requireContext(), android.R.color.holo_red_dark))
        }
        container.addView(messageView)
    }

    private fun parseUserData(data: List<List<Any>>): List<UserData> {
        return data.mapNotNull { item ->
            try {
                val rawPhone = item.getOrNull(7)
                val phone = when (rawPhone) {
                    is Double -> rawPhone.toLong().toString()
                    is Number -> rawPhone.toString()
                    else -> rawPhone?.toString() ?: ""
                }

                UserData(
                    id = item[0].toString(),
                    name = item[1].toString(),
                    lastName = item[2].toString(),
                    hash = item[3].toString(),
                    value1 = (item[4] as? Double)?.toInt() ?: 0,
                    value2 = (item[5] as? Double)?.toInt() ?: 0,
                    email = item.getOrNull(6)?.toString(),
                    phone = phone
                )
            } catch (e: Exception) {
                Log.e("SlideshowFragment", "Error al parsear datos de usuario", e)
                null
            }
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}