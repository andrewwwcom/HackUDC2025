package com.example.app100.network

import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Query

interface ApiService {
    @GET("search")
    suspend fun searchUsers(@Query("name") name: String): Response<List<List<Any>>>

    @GET("search")
    suspend fun searchUsersByCategory(@Query("habilidad") habilidad: Int): Response<List<List<Any>>>
}