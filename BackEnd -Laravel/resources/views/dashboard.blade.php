<x-dashborad-component>

        
<main class="flex-1 overflow-y-auto p-8">
            
            <div class="flex items-center justify-between mb-10">
                <div>
                    <h2 class="text-2xl font-bold text-slate-800">إحصائيات المنصة</h2>
                    <div class="h-1 w-12 bg-green-400 mt-2 rounded-full"></div>
                </div>
                <button class="bg-green-500 hover:bg-green-600 text-white px-5 py-2.5 rounded-xl text-xs font-bold shadow-md shadow-green-100 transition-all flex items-center gap-2">
                    <i class="fas fa-plus"></i> إضافة بيان جديد
                </button>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-10">
                <div class="card p-6 relative overflow-hidden group hover:border-green-200 transition-all cursor-default">
                    <i class="fas fa-users stat-icon text-green-500"></i>
                    <h3 class="text-[11px] font-bold text-gray-400 uppercase tracking-widest">إجمالي الأعضاء</h3>
                    <p class="text-3xl font-black mt-2 text-slate-800">{{$users}}</p>
                    <span class="inline-flex items-center px-2 py-1 bg-green-50 text-green-600 rounded text-[10px] font-bold mt-3">
                        <i class="fas fa-arrow-up ml-1"></i> 12% هذا الشهر
                    </span>
                </div>

                <div class="card p-6 relative overflow-hidden group hover:border-green-200 transition-all">
                    <i class="fas fa-wallet stat-icon text-green-400"></i>
                    <h3 class="text-[11px] font-bold text-gray-400 uppercase tracking-widest">الميزانية الحالية</h3>
                    <p class="text-3xl font-black mt-2 text-slate-800">120k <span class="text-sm font-medium text-gray-300">ر.س</span></p>
                    <p class="text-[10px] text-gray-400 mt-3">تحديث تلقائي كل 5 دقائق</p>
                </div>

                <div class="card p-6 relative overflow-hidden">
                    <i class="fas fa-chart-line stat-icon text-orange-400"></i>
                    <h3 class="text-[11px] font-bold text-gray-400 uppercase tracking-widest">الأهداف المحققة</h3>
                    <p class="text-3xl font-black mt-2 text-slate-800">85%</p>
                    <div class="w-full bg-gray-50 h-1.5 mt-4 rounded-full overflow-hidden">
                        <div class="bg-orange-400 h-full w-[85%]"></div>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-2 gap-10">
                
                <div class="card overflow-hidden">
                    <div class="p-5 border-b border-gray-50 flex justify-between items-center bg-white/50">
                        <h3 class="font-bold text-slate-800 text-sm">السجل المالي</h3>
                        <button class="text-green-500 text-[10px] font-bold hover:text-green-700">تصدير PDF</button>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full text-xs text-right">
                            <thead class="bg-gray-50/50 text-gray-400">
                                <tr>
                                    <th class="px-6 py-4 font-bold uppercase">العميل</th>
                                    <th class="px-6 py-4 font-bold uppercase">الحالة</th>
                                    <th class="px-6 py-4 font-bold uppercase">المبلغ</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-50">
                                <tr class="hover:bg-green-50/20 transition-colors">
                                    <td class="px-6 py-4 font-bold text-slate-700">أحمد المحمد</td>
                                    <td class="px-6 py-4"><span class="px-2 py-1 bg-green-100/50 text-green-600 rounded text-[9px] font-bold">مكتمل</span></td>
                                    <td class="px-6 py-4 font-black">540.00</td>
                                </tr>
                                <tr class="hover:bg-green-50/20 transition-colors">
                                    <td class="px-6 py-4 font-bold text-slate-700">سارة فهد</td>
                                    <td class="px-6 py-4"><span class="px-2 py-1 bg-orange-100/50 text-orange-600 rounded text-[9px] font-bold">قيد المعالجة</span></td>
                                    <td class="px-6 py-4 font-black">1,200.00</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="card p-6">
                    <h3 class="font-bold text-slate-800 text-sm mb-6">نشاط المستخدمين</h3>
                    <div class="space-y-6">
                        <div class="flex items-center justify-between">
                            <div class="flex items-center gap-3">
                                <div class="w-8 h-8 rounded-full bg-blue-50 text-blue-500 flex items-center justify-center text-xs font-bold">م</div>
                                <div>
                                    <p class="text-xs font-bold text-slate-700">محمد علي</p>
                                    <p class="text-[9px] text-gray-400">قام بتسجيل الدخول</p>
                                </div>
                            </div>
                            <span class="text-[9px] text-gray-300">منذ دقيقتين</span>
                        </div>
                        <div class="flex items-center justify-between">
                            <div class="flex items-center gap-3">
                                <div class="w-8 h-8 rounded-full bg-purple-50 text-purple-500 flex items-center justify-center text-xs font-bold">ن</div>
                                <div>
                                    <p class="text-xs font-bold text-slate-700">نورة خالد</p>
                                    <p class="text-[9px] text-gray-400">حدثت الملف الشخصي</p>
                                </div>
                            </div>
                            <span class="text-[9px] text-gray-300">منذ ساعة</span>
                        </div>
                    </div>
                </div>

            </div>
        </main>
</x-dashborad-component>


