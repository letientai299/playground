package com.birthday

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.ImageView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity

class DiceActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_dice)
    }

    fun rollDice(view: View) {
        val res = when ((1..6).random()) {
            1 -> R.drawable.dice_1
            2 -> R.drawable.dice_2
            3 -> R.drawable.dice_3
            4 -> R.drawable.dice_4
            5 -> R.drawable.dice_5
            else -> R.drawable.dice_6
        }

        val dice: ImageView = findViewById(R.id.diceImg)
        dice.setImageResource(res)
        Toast.makeText(this, "Dice Rolled!", Toast.LENGTH_SHORT).show()
    }


    fun nextScreen(view: View) = startActivity(Intent(this, TipActivity::class.java))
}