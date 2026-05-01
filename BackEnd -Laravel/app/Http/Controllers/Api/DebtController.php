<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\DebtRequest;
use Illuminate\Support\Facades\Validator;
use App\Models\Debt;
use Illuminate\Http\Request;

class DebtController extends Controller
{
    public function index(Request $request)
    {
        $debts = $request->user()->debts()->with('payments')->latest()->get();
        return response()->json(['status' => true, 'data' => $debts]);
    }

    public function store(DebtRequest $request){

    
        $debt = $request->user()->debts()->create($request->all());

        return response()->json(['status' => true, 'message' => 'تم تسجيل الدين بنجاح', 'data' => $debt], 201);
    }

    public function show(Debt $debt)
    {
        if (auth()->id() !== $debt->user_id) {
            return response()->json(['status' => false, 'message' => 'غير مصرح لك'], 403);
        }

        return response()->json(['status' => true, 'data' => $debt->load('payments')]);
    }

    public function addPayment(Request $request, Debt $debt)
    {
        if (auth()->id() !== $debt->user_id) {
            return response()->json(['status' => false, 'message' => 'غير مصرح لك'], 403);
        }

        $validator = Validator::make($request->all(), [
            'amount_paid'  => 'required|numeric|min:0.5',
            'payment_date' => 'required|date'
        ]);

        if ($validator->fails()) {
            return response()->json(['status' => false, 'errors' => $validator->errors()], 422);
        }

        if ($request->amount_paid > $debt->remaining_amount) {
            return response()->json([
                'status' => false, 
                'message' => 'المبلغ المدفوع (' . $request->amount_paid . ') أكبر من المتبقي (' . $debt->remaining_amount . ')'
            ], 422);
        }

        $payment = $debt->payments()->create($request->all());

        return response()->json([
            'status' => true,
            'message' => 'تم تسجيل عملية السداد',
            'data' => [
                'payment' => $payment,
                'remaining_amount' => $debt->fresh()->remaining_amount // المتبقي بعد التحديث
            ]
        ]);
    }

    public function destroy(Debt $debt)
    {
        if (auth()->id() !== $debt->user_id) {
            return response()->json(['status' => false, 'message' => 'غير مصرح لك'], 403);
        }

        $debt->delete();
        return response()->json(['status' => true, 'message' => 'تم حذف الدين وسجلاته بنجاح']);
    }
}
