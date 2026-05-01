<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Expense;
use Illuminate\Http\Request;
use App\Http\Requests\Api\ExpenseRequest;

class ExpenseController extends Controller
{
    public function index(Request $request)
    {
        return $request->user()->expenses()->latest()->get();
    }
    public function store(ExpenseRequest $request)
    {
        $data['amount']=$request->post('amount');
        $data['date']=$request->post('date');
        $data['description']=$request->post('description');
        $data['type']=$request->post('type');
        $expense = $request->user()->expenses()->create($data);

        return response($expense, 201);
    }
    public function show(Expense $expense)
    {
        $this->authorizeOwner($expense);
        return $expense;
    }
    public function update(ExpenseRequest $request, Expense $expense)
    {
        $data['amount']=$request->post('amount');
        $data['date']=$request->post('date');
        $data['description']=$request->post('description');
        $data['type']=$request->post('type');
        $expense->update($data);
        return $expense;
    }
    public function destroy(Expense $expense)
    {
        $this->authorizeOwner($expense);
        $expense->delete();
        return ['message' => 'تم الحذف بنجاح'];
    }
    private function authorizeOwner(Expense $expense)
    {
        if (auth()->id() !== $expense->user_id) {
            abort(403, 'غير مصرح لك بالوصول لهذا المصروف');
        }
    }
}
