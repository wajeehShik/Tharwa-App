<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DebtPayment extends Model
{
    protected $fillable = ['debt_id',
'amount_paid',
'payment_date',];
    public function dept(){
        return $this->belongsTo(Debt::class);
    }
}
