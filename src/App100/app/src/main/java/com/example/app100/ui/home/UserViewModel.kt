package com.example.app100.ui.home

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class UserViewModel : ViewModel() {
    private val _loggedInDni = MutableLiveData<String?>()
    val loggedInDni: LiveData<String?> = _loggedInDni

    fun setLoggedInDni(dni: String?) {
        _loggedInDni.value = dni
    }
}