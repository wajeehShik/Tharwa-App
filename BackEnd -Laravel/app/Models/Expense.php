<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Expense extends Model
{
protected $fillable = ['amount', 'date', 'description', 'type', 'user_id'];

public function user() {
    return $this->belongsTo(User::class);
}
}
