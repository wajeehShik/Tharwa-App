<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ثروة - لوحة تحكم الإدارة المطورة</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body { font-family: 'Cairo', sans-serif; background-color: #f8faf9; }
        /* تحسين القائمة الجانبية بدرجات أخضر فاتحة ومنعشة */
        .sidebar-item {
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 4px;
            font-weight: 500;
            color: #64748b; /* لون نص رمادي هادئ */
        }
        .sidebar-item:hover {
            background-color: #f0fdf4; /* خلفية خضراء باهتة جداً */
            color: #22c55e; /* أخضر فاتح عند التمرير */
        }
        .sidebar-item.active {
            background: linear-gradient(135deg, #4ade80 0%, #22c55e 100%); /* تدرج أخضر فاتح ومشرق */
            color: white;
            box-shadow: 0 4px 15px rgba(74, 222, 128, 0.25);
        }
        
        .card { box-shadow: 0 4px 20px rgba(0,0,0,0.03); border-radius: 16px; background: white; border: 1px solid #f0fdf4; }
        
        .stat-icon { opacity: 0.1; font-size: 3rem; position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); }

        .badge-notify {
            background: #ff5f5f; color: white; font-size: 0.65rem; min-width: 18px; height: 18px;
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            position: absolute; top: -5px; left: -5px; font-weight: 700;
        }
    </style>
</head>

<body class="text-slate-800">

<div class="flex h-screen overflow-hidden">

    <aside class="w-64 bg-white border-l border-emerald-50 flex flex-col p-4 shadow-sm z-50">
        <div class="mb-8 px-2 flex items-center gap-3">
            <div class="w-10 h-10 bg-green-400 rounded-xl flex items-center justify-center text-white font-bold text-xl shadow-sm">ث</div>
            <h1 class="text-xl font-extrabold bg-gradient-to-l from-green-600 to-green-400 bg-clip-text text-transparent">ثروة Admin</h1>
        </div>
        <nav class="flex-1 space-y-1">
            <a href="#" class="sidebar-item active">
                <i class="fas fa-chart-pie w-5 text-center"></i>
                <span>لوحة التحكم</span>
            </a>
            <a href="admin.html" class="sidebar-item">
                <i class="fas fa-users w-5 text-center"></i>
                <span>المشرفين</span>
            </a>
            <a href="user.html" class="sidebar-item">
                <i class="fas fa-users w-5 text-center"></i>
                <span>المستخدمين</span>
            </a>
            <a href="#" class="sidebar-item">
                <i class="fas fa-money-bill-wave w-5 text-center"></i>
                <span>العمليات</span>
            </a>
            <a href="#" class="sidebar-item">
                <i class="fas fa-bell w-5 text-center"></i>
                <span>التنبيهات</span>
            </a>
            <a href="#" class="sidebar-item">
                <i class="fas fa-cog w-5 text-center"></i>
                <span>الإعدادات</span>
            </a>
            <form method="POST"  action="{{route("logout")}}">
                @csrf
            <button class="sidebar-item">
                <i class="fas fa-sign-out-alt w-5 text-center"></i>
                <span>تسجيل خروج</span>
            </button>
            </form>
        </nav>

        <div class="pt-4 border-t border-gray-50 text-center text-[10px] text-gray-300">
            نسخة مطورة 2024
        </div>
    </aside>

    <div class="flex-1 flex flex-col overflow-hidden">
        
        <header class="h-16 bg-white border-b border-emerald-50 flex items-center justify-between px-6">
            <div class="flex items-center gap-4 flex-1">
                <button class="text-gray-400 hover:text-green-500 transition-colors"><i class="fas fa-bars text-lg"></i></button>
                <div class="relative max-w-xs w-full hidden md:block">
                    <input type="text" placeholder="بحث ذكي..." class="w-full bg-gray-50 rounded-full px-4 py-2 text-xs focus:outline-none focus:ring-2 focus:ring-green-400/20 border border-gray-100">
                    <i class="fas fa-search absolute left-3 top-3 text-gray-300 text-[10px]"></i>
                </div>
            </div>

            <div class="flex items-center gap-5">
                <div class="flex items-center gap-3">
                    <button class="relative w-8 h-8 flex items-center justify-center text-gray-400 hover:bg-gray-50 rounded-full transition-all">
                        <i class="fas fa-bell"></i>
                        <span class="badge-notify">3</span>
                    </button>
                </div>
                <div class="h-6 w-px bg-gray-100"></div>
                <div class="flex items-center gap-3 cursor-pointer group">
                    <div class="text-right hidden sm:block">
                        <p class="text-xs font-bold text-slate-700 group-hover:text-green-500 transition-colors">أحمد الإداري</p>
                        <p class="text-[9px] text-gray-400 uppercase tracking-wider">Super Admin</p>
                    </div>
                    <div class="w-9 h-9 rounded-full bg-green-50 flex items-center justify-center text-green-500 font-bold border-2 border-white shadow-sm group-hover:border-green-200 transition-all">أ</div>
                </div>
            </div>
        </header>

        {{$slot}}
    </div>
</div>

</body>
</html>