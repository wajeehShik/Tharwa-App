<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Debt extends Model {
    protected $fillable = ['creditor_name', 'total_amount','total_paid', 'description', 'due_date', 'type', 'user_id'];
    // لضمان ظهور الحقول الوهمية عند تحويل الموديل لـ JSON
    protected $appends = ['total_paid', 'remaining_amount', 'is_settled'];

    public function payments() {
        return $this->hasMany(DebtPayment::class);
    }
    /**
     * إجمالي المبلغ الذي تم سداده حتى الآن
     */
    public function getTotalPaidAttribute() {
        return $this->payments()->sum('amount_paid');
    }
    public function getRemainingAmountAttribute() {
        return $this->total_amount - $this->total_paid;
    }
    public function getIsSettledAttribute() {
        return $this->remaining_amount <= 0;
    }
}
