package com.example.app100.ui.gallery

import android.content.Context
import android.content.SharedPreferences
import android.graphics.Color
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import com.example.app100.R
import com.example.app100.databinding.FragmentGalleryBinding
import com.example.app100.ui.home.UserViewModel
import org.json.JSONArray

class GalleryFragment : Fragment() {

    private var _binding: FragmentGalleryBinding? = null
    private val binding get() = _binding!!
    private lateinit var sharedPreferences: SharedPreferences
    private var isEditMode = false

    private lateinit var checklistContainer: LinearLayout
    private lateinit var checklistButtonsContainer: LinearLayout
    private lateinit var addChecklistButton: Button

    private lateinit var habilidadesContainer: LinearLayout
    private lateinit var habilidadesButtonsContainer: LinearLayout
    private lateinit var addHabilidadButton: Button
    private lateinit var dniEditText: EditText

    // Get an instance of the UserViewModel
    private val userViewModel: UserViewModel by activityViewModels()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?
    ): View {
        _binding = FragmentGalleryBinding.inflate(inflater, container, false)
        val root: View = binding.root

        sharedPreferences = requireActivity().getPreferences(Context.MODE_PRIVATE)

        val nameEditText: EditText = binding.nameEditText
        val emailEditText: EditText = binding.emailEditText
        val phoneEditText: EditText = binding.phoneEditText
        dniEditText = binding.dniEditText
        val editButton: Button = binding.editButton
        val saveButton: Button = binding.saveButton

        checklistContainer = binding.checklistContainer
        checklistButtonsContainer = binding.checklistButtonsContainer
        addChecklistButton = binding.addChecklistButton

        habilidadesContainer = binding.habilidadesContainer
        habilidadesButtonsContainer = binding.habilidadesButtonsContainer
        addHabilidadButton = binding.addHabilidadButton

        val user = loadUserData()
        nameEditText.setText(user.name)
        emailEditText.setText(user.email)
        phoneEditText.setText(user.phone)
        //dniEditText.setText(user.dni) // Remove this line

        nameEditText.isEnabled = false
        dniEditText.isEnabled = false

        editButton.setOnClickListener {
            toggleEditMode(emailEditText, phoneEditText, editButton, saveButton)
        }

        saveButton.setOnClickListener {
            saveUserData(emailEditText.text.toString(), phoneEditText.text.toString())
            saveChecklistItems()
            saveHabilidadesItems()
            toggleEditMode(emailEditText, phoneEditText, editButton, saveButton)
        }

        addChecklistButton.setOnClickListener {
            addChecklistItem(checklistContainer, "Nuevo conocimiento", "")
        }

        addHabilidadButton.setOnClickListener {
            addChecklistItem(habilidadesContainer, "Nueva habilidad", "")
        }

        loadChecklistItems()
        loadHabilidadesItems()

        return root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        // Observe the loggedInDni from the UserViewModel
        userViewModel.loggedInDni.observe(viewLifecycleOwner) { dni ->
            dniEditText.setText(dni)
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    private fun toggleEditMode(
        emailEditText: EditText, phoneEditText: EditText, editButton: Button, saveButton: Button
    ) {
        isEditMode = !isEditMode
        emailEditText.isEnabled = isEditMode
        phoneEditText.isEnabled = isEditMode

        editButton.visibility = if (isEditMode) View.GONE else View.VISIBLE
        saveButton.visibility = if (isEditMode) View.VISIBLE else View.GONE
        checklistButtonsContainer.visibility = if (isEditMode) View.VISIBLE else View.GONE
        habilidadesButtonsContainer.visibility = if (isEditMode) View.VISIBLE else View.GONE

        setChecklistEditable(checklistContainer)
        setChecklistEditable(habilidadesContainer)
    }

    private fun saveUserData(email: String, phone: String) {
        with(sharedPreferences.edit()) {
            putString("email", email)
            putString("phone", phone)
            apply()
        }
    }

    private fun loadUserData(): User {
        return User(
            sharedPreferences.getString("name", "Nombre Apellidos") ?: "Nombre Apellidos",
            sharedPreferences.getString("email", "example@example.com") ?: "example@example.com",
            sharedPreferences.getString("phone", "") ?: "",
            sharedPreferences.getString("dni", "12345678A") ?: "12345678A"
        )
    }

    private fun addChecklistItem(container: LinearLayout, hint: String, text: String) {
        val itemLayout = LinearLayout(requireContext()).apply {
            orientation = LinearLayout.HORIZONTAL
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            )
            setPadding(8, 8, 8, 8)
        }

        val deleteButton = ImageButton(requireContext()).apply {
            setImageResource(android.R.drawable.ic_delete)
            setBackgroundColor(Color.TRANSPARENT)
            visibility = if (isEditMode) View.VISIBLE else View.GONE
            setOnClickListener {
                container.removeView(itemLayout)
            }
        }

        val editText = EditText(requireContext()).apply {
            setHint(hint)
            setText(text)
            layoutParams = LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f)
            isEnabled = isEditMode
        }

        itemLayout.addView(deleteButton)
        itemLayout.addView(editText)
        container.addView(itemLayout)
    }

    private fun setChecklistEditable(container: LinearLayout) {
        for (i in 0 until container.childCount) {
            val itemLayout = container.getChildAt(i) as LinearLayout
            val editText = itemLayout.getChildAt(1) as EditText
            val deleteButton = itemLayout.getChildAt(0) as ImageButton
            editText.isEnabled = isEditMode
            deleteButton.visibility = if (isEditMode) View.VISIBLE else View.GONE
        }
    }

    private fun saveChecklistItems() {
        saveItems("checklist_items", checklistContainer)
    }

    private fun saveHabilidadesItems() {
        saveItems("habilidades_items", habilidadesContainer)
    }

    private fun saveItems(key: String, container: LinearLayout) {
        val itemsArray = JSONArray()
        for (i in 0 until container.childCount) {
            val itemLayout = container.getChildAt(i) as LinearLayout
            val editText = itemLayout.getChildAt(1) as EditText
            itemsArray.put(editText.text.toString())
        }
        with(sharedPreferences.edit()) {
            putString(key, itemsArray.toString())
            apply()
        }
    }

    private fun loadChecklistItems() {
        loadItems("checklist_items", checklistContainer, "Nuevo conocimiento")
    }

    private fun loadHabilidadesItems() {
        loadItems("habilidades_items", habilidadesContainer, "Nueva habilidad")
    }

    private fun loadItems(key: String, container: LinearLayout, hint: String) {
        val itemsString = sharedPreferences.getString(key, null)
        itemsString?.let {
            val itemsArray = JSONArray(it)
            for (i in 0 until itemsArray.length()) {
                addChecklistItem(container, hint, itemsArray.getString(i))
            }
        }
    }

    data class User(
        var name: String,
        var email: String,
        var phone: String,
        var dni: String
    )
}