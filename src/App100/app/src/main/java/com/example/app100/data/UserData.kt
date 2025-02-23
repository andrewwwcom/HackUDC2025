package com.example.app100.data

// Updated UserData class to include email and phone

data class UserData(
    val id: String,
    val name: String,
    val lastName: String,
    val hash: String,
    val value1: Int,
    val value2: Int,
    val email: String?,
    val phone:String?
)