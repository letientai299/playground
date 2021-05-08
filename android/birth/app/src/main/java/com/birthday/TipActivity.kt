package com.birthday

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.core.widget.doOnTextChanged
import com.birthday.databinding.ActivityTipBinding
import java.text.NumberFormat
import kotlin.math.ceil

class TipActivity : AppCompatActivity() {
    private lateinit var binding: ActivityTipBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityTipBinding.inflate(layoutInflater)
        setContentView(binding.root)


        val btnCalc = binding.tipButtonCalc
        btnCalc.setOnClickListener { calcTip() }

        binding.tipCost.doOnTextChanged { text, _, _, _ ->
            btnCalc.isEnabled = text?.length != 0
        }
    }

    private fun calcTip() {
        val costString = binding.tipCost.text.toString()
        val cost = costString.toDouble()
        val percent = when (binding.tipOptions.checkedRadioButtonId) {
            R.id.tip_option15 -> 0.15
            R.id.tip_option18 -> 0.18
            else -> 0.20
        }

        var tip = percent * cost
        if (binding.tipRound.isChecked) {
            tip = ceil(tip)
        }

        val fmtCurrency = NumberFormat.getCurrencyInstance()
        val formattedTip = fmtCurrency.format(tip)
        binding.tipAmount.text = getString(R.string.tip_amount, formattedTip)
    }
}