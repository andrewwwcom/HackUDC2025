package com.example.app100.data

data class UserResponse(
    val dni: String,
    val name: String,
    val surname: String,
    val passwordHash: String,
    val value1: Int,
    val value2: Int,
    val email: String,
    val phone: Int
)