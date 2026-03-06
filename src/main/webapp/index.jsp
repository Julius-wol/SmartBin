<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="dark" lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Smart Bin Dashboard</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap" rel="stylesheet"/>
    
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#2bee6c",
                        "background-dark": "#102216",
                    },
                    fontFamily: { "display": ["Space Grotesk"] }
                },
            },
        }
    </script>
    <style>
        body { font-family: 'Space Grotesk', sans-serif; }
        .transition-all { transition: all 0.5s ease-in-out; }
    </style>
</head>
<body class="bg-background-dark text-slate-100 antialiased">
    <div class="flex h-screen overflow-hidden">
        <aside class="w-64 flex-shrink-0 flex flex-col border-r border-primary/10 bg-background-dark">
            <div class="p-6 flex items-center gap-3">
                <div class="size-10 rounded-full bg-primary flex items-center justify-center text-background-dark">
                    <span class="material-symbols-outlined text-2xl font-bold">Logo</span>
                </div>
                <div>
                    <h1 class="text-lg font-bold leading-none">Smart Bin</h1>
                    <p class="text-xs text-primary/60">Hệ thống quản lý</p>
                </div>
            </div>
            <nav class="flex-1 px-4 py-4 space-y-2">
                <a class="flex items-center gap-3 px-3 py-2.5 rounded-lg bg-primary text-background-dark font-semibold" href="index.jsp">
                    <span class="material-symbols-outlined">Dashboard</span>
                </a>
                <a class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-primary/10 transition-colors" href="lich-su-hoat-dong">
                    <span class="material-symbols-outlined">History</span>
                </a>
            </nav>
            <div class="p-4 mt-auto">
                <div class="bg-primary/5 rounded-xl p-4 border border-primary/10">
                    <p class="text-xs font-bold text-primary mb-1 uppercase tracking-wider">Phiên bản 1.5</p>
                    <p class="text-sm text-slate-400">Dữ liệu được cập nhật tự động mỗi 3 giây.</p>
                </div>
            </div>
        </aside>

        <div class="flex-1 flex flex-col overflow-hidden">
            <header class="h-16 border-b border-primary/10 flex items-center justify-between px-8 bg-background-dark/50 backdrop-blur-md">
                <h2 class="text-xl font-bold tracking-tight">Smart Bin Dashboard</h2>
                <div class="flex items-center gap-6">
                    <div id="connection-status" class="flex items-center gap-2 px-3 py-1.5 rounded-full bg-primary/10 border border-primary/20">
                        <span class="size-2 rounded-full bg-primary animate-pulse"></span>
                        <span class="text-sm font-medium text-primary">Trực tuyến</span>
                    </div>
                </div>
            </header>

            <main class="flex-1 overflow-y-auto p-8 space-y-6">
                <section id="banner-status" class="bg-primary/10 border border-primary/20 rounded-xl p-6 flex items-center justify-between transition-all">
                    <div class="flex items-center gap-6">
                        <div id="banner-icon-box" class="size-16 rounded-full bg-primary flex items-center justify-center text-background-dark transition-all">
                            <span id="banner-icon" class="material-symbols-outlined text-4xl font-bold">check_circle</span>
                        </div>
                        <div>
                            <h3 id="banner-title" class="text-2xl font-bold text-primary transition-all">Hệ thống bình thường</h3>
                            <p id="banner-desc" class="text-slate-400">Tất cả cảm biến đang hoạt động ổn định.</p>
                        </div>
                    </div>
                    <button onclick="updateDashboard()" class="px-5 py-2.5 bg-primary/20 text-primary border border-primary/30 font-bold rounded-lg hover:bg-primary hover:text-black transition-all flex items-center gap-2">
                        <span class="material-symbols-outlined text-sm">refresh</span> 
                    </button>
                </section>

                <section class="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <div class="bg-slate-900/40 p-6 rounded-xl border border-primary/5 flex flex-col items-center">
                        <p class="text-sm text-slate-500 font-medium mb-4 self-start">Mức rác hiện tại</p>
                        <div class="relative size-32 flex items-center justify-center">
                            <svg class="size-full transform -rotate-90">
                                <circle class="text-slate-800" cx="64" cy="64" fill="transparent" r="58" stroke="currentColor" stroke-width="8"></circle>
                                <circle id="gauge-progress" class="text-primary transition-all duration-700" cx="64" cy="64" fill="transparent" r="58" stroke="currentColor" stroke-dasharray="364.4" stroke-dashoffset="364.4" stroke-width="8"></circle>
                            </svg>
                            <span id="fill-text" class="absolute text-3xl font-bold">0%</span>
                        </div>
                        <p id="fill-badge" class="mt-4 text-xs text-primary bg-primary/10 px-2 py-1 rounded">Đang cập nhật...</p>
                    </div>

                    <div class="bg-slate-900/40 p-6 rounded-xl border border-primary/5">
                        <p class="text-sm text-slate-500 font-medium mb-2">Nhiệt độ bên trong</p>
                        <div class="flex items-end gap-2">
                            <span id="temp-val" class="text-5xl font-bold">--</span>
                            <span class="text-2xl font-medium text-slate-400 mb-1">°C</span>
                        </div>
                        <div id="temp-status-box" class="mt-6 flex items-center gap-2 text-primary">
                            <span class="material-symbols-outlined text-sm">verified_user</span>
                            <span id="temp-status-text" class="text-sm font-medium">Mức an toàn</span>
                        </div>
                    </div>

                    <div class="bg-slate-900/40 p-6 rounded-xl border border-primary/5 flex flex-col items-center justify-center">
                        <p class="text-sm text-slate-500 font-medium mb-4 self-start">Tình trạng tổng quát</p>
                        <div id="cond-icon-box" class="size-14 rounded-full bg-primary/20 flex items-center justify-center text-primary mb-3">
                            <span id="cond-icon" class="material-symbols-outlined text-3xl font-bold">Img</span>
                        </div>
                        <p id="cond-text" class="text-2xl font-bold text-white">Tốt</p>
                    </div>
                </section>
                
                <section class="bg-slate-900/40 rounded-xl border border-primary/5 p-6">
                    <h4 class="font-bold flex items-center gap-2 mb-4">
                        <span class="material-symbols-outlined text-primary">Pets</span> Cảnh báo động vật
                    </h4>
                    <div id="animal-alert-box" class="hidden p-4 bg-orange-500/10 border border-orange-500/20 rounded-lg flex items-center gap-4 transition-all animate-bounce">
                        <span class="material-symbols-outlined text-orange-500">warning</span>
                        <p class="text-sm font-bold text-orange-500">Phát hiện động vật lạ quấy phá! Nắp đã đóng.</p>
                    </div>
                    <p id="no-animal-text" class="text-sm text-slate-500 italic">Khu vực xung quanh hiện tại yên tĩnh.</p>
                </section>
            </main>
        </div>
    </div>

    <script>
        // Hàm cập nhật Dashboard
        function updateDashboard() {
            fetch('api-thung-rac')
                .then(res => res.json())
                .then(data => {
                    // 1. Cập nhật con số và Gauge
                    const level = data.mucDoDay;
                    document.getElementById('fill-text').innerText = level + "%";
                    const offset = 364.4 - (364.4 * level / 100);
                    document.getElementById('gauge-progress').style.strokeDashoffset = offset;
                    
                    if(level >= 90) {
                        document.getElementById('fill-badge').innerText = "Thùng đã đầy - Cần thu gom!";
                        document.getElementById('fill-badge').className = "mt-4 text-xs text-red-500 bg-red-500/10 px-2 py-1 rounded";
                    } else {
                        document.getElementById('fill-badge').innerText = "Mức rác an toàn";
                        document.getElementById('fill-badge').className = "mt-4 text-xs text-primary bg-primary/10 px-2 py-1 rounded";
                    }

                    // 2. Cập nhật Nhiệt độ
                    document.getElementById('temp-val').innerText = data.nhietDo;

                    // 3. LOGIC BANNER CẢNH BÁO (Sửa lỗi theo yêu cầu)
                    const banner = document.getElementById('banner-status');
                    const bTitle = document.getElementById('banner-title');
                    const bIcon = document.getElementById('banner-icon');
                    const bIconBox = document.getElementById('banner-icon-box');

                    if (data.coChanNo) { 
                        // ƯU TIÊN 1: VẬT NÓNG (Màu cam)
                        banner.className = "bg-orange-500/10 border border-orange-500/20 rounded-xl p-6 flex items-center justify-between text-orange-500";
                        bTitle.innerText = "CẢNH BÁO VẬT NÓNG";
                        bTitle.className = "text-2xl font-bold text-orange-500";
                        bIcon.innerText = "fire";
                        bIconBox.className = "size-16 rounded-full bg-orange-500 flex items-center justify-center text-black shadow-[0_0_15px_rgba(249,115,22,0.5)]";
                    } else if (level >= 90) { 
                        // ƯU TIÊN 2: THÙNG ĐẦY (Màu đỏ)
                        banner.className = "bg-red-500/10 border border-red-500/20 rounded-xl p-6 flex items-center justify-between text-red-500";
                        bTitle.innerText = "THÙNG RÁC ĐÃ ĐẦY";
                        bTitle.className = "text-2xl font-bold text-red-500";
                        bIcon.innerText = "delete_forever";
                        bIconBox.className = "size-16 rounded-full bg-red-500 flex items-center justify-center text-black shadow-[0_0_15px_rgba(239,68,68,0.5)]";
                    } else if (data.coDongVat) { 
                        // ƯU TIÊN 3: ĐỘNG VẬT (Màu xanh dương/nhạt)
                        banner.className = "bg-sky-500/10 border border-sky-500/20 rounded-xl p-6 flex items-center justify-between text-sky-500";
                        bTitle.innerText = "PHÁT HIỆN ĐỘNG VẬT";
                        bTitle.className = "text-2xl font-bold text-sky-500";
                        bIcon.innerText = "pets";
                        bIconBox.className = "size-16 rounded-full bg-sky-500 flex items-center justify-center text-black";
                    } else {
                        // MẶC ĐỊNH: BÌNH THƯỜNG (Màu xanh lá)
                        banner.className = "bg-primary/10 border border-primary/20 rounded-xl p-6 flex items-center justify-between";
                        bTitle.innerText = "Hệ thống bình thường";
                        bTitle.className = "text-2xl font-bold text-primary";
                        bIcon.innerText = "check_circle";
                        bIconBox.className = "size-16 rounded-full bg-primary flex items-center justify-center text-background-dark";
                    }

                    // 4. Động vật section
                    if (data.coDongVat) {
                        document.getElementById('animal-alert-box').classList.remove('hidden');
                        document.getElementById('no-animal-text').classList.add('hidden');
                    } else {
                        document.getElementById('animal-alert-box').classList.add('hidden');
                        document.getElementById('no-animal-text').classList.remove('hidden');
                    }
                })
                .catch(err => {
                    console.error("Lỗi API:", err);
                    document.getElementById('connection-status').innerHTML = '<span class="size-2 rounded-full bg-red-500"></span><span class="text-sm font-medium text-red-500">Ngoại tuyến</span>';
                });
        }

        // Tự động cập nhật mỗi 3 giây
        setInterval(updateDashboard, 3000);
        updateDashboard();
    </script>
</body>
</html>