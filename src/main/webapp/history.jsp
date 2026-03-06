<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="dark" lang="vi">
    <head>
        <meta charset="utf-8"/>
        <title>Lịch sử hoạt động</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap" rel="stylesheet"/>
        <script>
            tailwind.config = {darkMode: "class", theme: {extend: {colors: {"primary": "#2bee6c", "background-dark": "#102216"}}}}
        </script>
    </head>
    <body class="bg-background-dark text-slate-100 font-sans">
        <div class="flex h-screen">
            <aside class="w-64 border-r border-primary/10 p-6 space-y-8">
                <div class="flex items-center gap-3">
                    <span class="material-symbols-outlined text-primary text-3xl">delete_sweep</span>
                    <span class="text-xl font-bold">Smart Bin</span>
                </div>
                <nav class="space-y-4">
                    <a href="index.jsp" class="flex items-center gap-3 text-slate-400 hover:text-primary"><span class="material-symbols-outlined">dashboard</span> Dashboard</a>
                    <a href="lich-su-hoat-dong" class="flex items-center gap-3 text-primary font-bold"><span class="material-symbols-outlined">history</span> Lịch sử</a>
                </nav>
            </aside>

            <main class="flex-1 p-8 overflow-y-auto">
                <header class="mb-8 flex justify-between items-center">
                    <h2 class="text-2xl font-bold italic">Lịch sử hoạt động</h2>
                    <div class="bg-slate-800 p-1 rounded-lg flex gap-2">
                        <a href="lich-su-hoat-dong?type=ALL" class="px-4 py-1 rounded ${currentFilter == 'ALL' ? 'bg-primary text-black' : ''}">Tất cả</a>
                        <a href="lich-su-hoat-dong?type=động vật" class="px-4 py-1 rounded ${currentFilter == 'động vật' ? 'bg-primary text-black' : ''}">Động vật</a>
                    </div>
                </header>

                <div class="grid grid-cols-4 gap-6 mb-8">
                    <div class="bg-slate-900/40 p-4 rounded-xl border border-primary/10">
                        <p class="text-slate-500 text-sm">Phát hiện động vật</p>
                        <p class="text-3xl font-bold">${animalToday} <span class="text-sm font-normal text-primary">Lần</span></p>
                    </div>
                </div>

                <div class="bg-slate-900/40 rounded-xl border border-primary/5 overflow-hidden">
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr class="border-b border-primary/10 text-slate-500 text-sm">
                                <th class="p-4">THỜI GIAN</th>
                                <th class="p-4">SỰ KIỆN</th>
                                <th class="p-4">CẢM BIẾN</th>
                                <th class="p-4">HÀNH ĐỘNG</th>
                                <th class="p-4">TRẠNG THÁI</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-primary/5">
                            <c:forEach items="${historyList}" var="item">
                                <tr class="hover:bg-primary/5 border-b border-primary/5">
                                    <td class="p-4 text-sm">${item.thoiGian}</td>
                                    <td class="p-4 font-bold text-primary">${item.suKien}</td>
                                    <td class="p-4 text-xs text-slate-400">${item.maSensor}</td>
                                    <td class="p-4 text-sm">${item.hanhDong}</td>
                                    <td class="p-4">
                                        <span class="px-2 py-1 rounded text-xs font-bold 
                                              ${item.trangThai eq 'Thành công' ? 'bg-primary/10 text-primary' : 'bg-orange-500/10 text-orange-500'}">
                                            ${item.trangThai}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </body>
</html>