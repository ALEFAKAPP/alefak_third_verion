package com.alefakeltawinea.alefakaltawinea_animals_app

import SessionHandler
import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import android.os.Handler

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        SessionHandler().initStatus()
    }
}

