<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>مساعد مالي - تسجيل الدخول</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Cairo', 'sans-serif'],
                    },
                    colors: {
                        brand: {
                            50: '#f0f5ff',
                            100: '#e5edff',
                            500: '#3b82f6',
                            600: '#2563eb',
                        }
                    }
                }
            }
        }
    </script>
    <style>
        body { font-family: 'Cairo', sans-serif; background-color: #f8fafc; }
        .glass-effect {
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
    </style>
</head>
<body class="text-slate-800 antialiased min-h-screen flex items-center justify-center p-4">
    <div class="fixed inset-0 z-0 overflow-hidden pointer-events-none">
        <div class="absolute -top-[10%] -right-[10%] w-[40%] h-[40%] bg-brand-100 rounded-full blur-3xl opacity-50"></div>
        <div class="absolute -bottom-[10%] -left-[10%] w-[40%] h-[40%] bg-blue-50 rounded-full blur-3xl opacity-50"></div>
    </div>
    <main class="w-full max-w-md z-10">
        <div class="text-center mb-8">
            <div class="inline-flex  text-white  rounded-2xl  ">
                <img src="{{asset('logo.png')}}">
            </div>
        </div>
        <div class="bg-white rounded-[2.5rem] p-8 shadow-xl shadow-slate-200/60 border border-slate-100 relative">
            <form action="{{route('login')}}" method="POST" class="space-y-6">
                @csrf
                <div class="space-y-2">
                    <label class="text-sm font-bold text-slate-700 mr-1">البريد الإلكتروني</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 right-0 pr-4 flex items-center pointer-events-none text-slate-400">
                            <i class="fa-regular fa-envelope"></i>
                        </div>
                        <input type="email" name="email" placeholder="name@example.com" 
                            class="w-full bg-slate-50 border-none text-slate-800 rounded-2xl py-4 pr-11 pl-4 focus:ring-2 focus:ring-brand-500 transition-all outline-none font-medium">
                    </div>
                </div>

                <div class="space-y-2">
                    <div class="flex justify-between items-center px-1">
                        <label class="text-sm font-bold text-slate-700">كلمة المرور</label>
                    </div>
                    <div class="relative">
                        <div class="absolute inset-y-0 right-0 pr-4 flex items-center pointer-events-none text-slate-400">
                            <i class="fa-solid fa-lock"></i>
                        </div>
                        <input type="password" name="password"
                            class="w-full bg-slate-50 border-none text-slate-800 rounded-2xl py-4 pr-11 pl-4 focus:ring-2 focus:ring-brand-500 transition-all outline-none font-medium">
                        <div class="absolute inset-y-0 left-0 pl-4 flex items-center cursor-pointer text-slate-400 hover:text-brand-600">
                            <i class="fa-regular fa-eye-slash"></i>
                        </div>
                    </div>
                </div>

                <div class="flex items-center gap-2 px-1">
                    <input type="checkbox" id="remember" class="w-4 h-4 rounded border-slate-300 text-brand-600 focus:ring-brand-500">
                    <label for="remember" class="text-sm font-semibold text-slate-500 cursor-pointer">تذكرني على هذا الجهاز</label>
                </div>

                <button type="submit"   style="    background: linear-gradient(135deg, #4ade80 0%, #22c55e 100%);"
                    class="w-full bg-brand-600 hover:bg-brand-700 text-white font-bold py-4 rounded-2xl shadow-lg shadow-brand-200 transition-all active:scale-[0.98] flex items-center justify-center gap-2">
                    تسجيل الدخول
                    <i class="fa-solid fa-arrow-left"></i>
                </button>
            </form>
            <div class="relative my-8 text-center">
                <hr class="border-slate-100">
                <span class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 bg-white px-4 text-xs font-bold text-slate-400 uppercase tracking-wider">أو المتابعة بواسطة</span>
            </div>

        </div>
    
    </main>
</body>
</html>