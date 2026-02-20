<template>
  <q-page class="stitch-page">
    <div class="stitch-theme-ella_dashboard_with_logo dark bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen font-display">
<div class="relative mx-auto max-w-md bg-background-light dark:bg-background-dark min-h-screen flex flex-col pb-24">
<!-- Header Section -->
<header class="p-6 flex items-center justify-between">
<div class="flex items-center gap-4">
<div class="size-14 rounded-xl border-2 border-primary/20 p-1 flex items-center justify-center bg-surface-dark overflow-hidden">
<img alt="Ella Logo" class="size-full object-contain" src="{{DATA:IMAGE:IMAGE_14}}"/>
</div>
<div>
<div class="flex items-baseline gap-1">
<span class="text-2xl font-black tracking-tighter text-primary">ELLA</span>
<span class="text-xs font-bold text-slate-500">| FITNESS</span>
</div>
<h1 class="text-sm font-semibold text-slate-400">Morning, Alex</h1>
</div>
</div>
<button class="size-10 flex items-center justify-center rounded-full bg-slate-200 dark:bg-surface-dark text-slate-600 dark:text-slate-300">
<span class="material-symbols-outlined">notifications</span>
</button>
</header>
<!-- Main Content -->
<main class="flex-1 px-6 space-y-6">
<!-- Daily Summary Progress -->
<section class="bg-slate-200 dark:bg-surface-dark rounded-xl p-5 flex items-center justify-between shadow-xl shadow-black/10">
<div class="space-y-1">
<h3 class="text-sm font-semibold text-slate-500 dark:text-slate-400">Daily Goal</h3>
<div class="flex items-baseline gap-1">
<span class="text-3xl font-extrabold text-primary">80%</span>
<span class="text-sm text-slate-400">completed</span>
</div>
<div class="w-32 h-1.5 bg-slate-300 dark:bg-neutral-dark rounded-full mt-2 overflow-hidden">
<div class="h-full bg-primary" style="width: 80%"></div>
</div>
</div>
<div class="flex flex-col items-end gap-1">
<div class="flex items-center gap-2 text-xs font-bold text-slate-500">
<span class="material-symbols-outlined text-primary text-sm">local_fire_department</span>
                        800 / 1000 kcal
                    </div>
<div class="flex items-center gap-2 text-xs font-bold text-slate-500">
<span class="material-symbols-outlined text-primary text-sm">schedule</span>
                        45 / 60 min
                    </div>
</div>
</section>
<!-- Weekly Progress Calendar -->
<section class="space-y-3">
<div class="flex items-center justify-between">
<h2 class="font-bold text-lg">Weekly Progress</h2>
<span class="text-primary text-xs font-bold uppercase">October 2023</span>
</div>
<div class="flex justify-between gap-2 overflow-x-auto hide-scrollbar pb-1">
<div class="flex flex-col items-center gap-2 min-w-[44px]">
<span class="text-[10px] font-bold text-slate-500">MON</span>
<div class="size-10 rounded-full flex items-center justify-center bg-slate-200 dark:bg-surface-dark border border-slate-300 dark:border-neutral-dark">
<span class="text-sm font-bold">14</span>
</div>
</div>
<div class="flex flex-col items-center gap-2 min-w-[44px]">
<span class="text-[10px] font-bold text-slate-500">TUE</span>
<div class="size-10 rounded-full flex items-center justify-center bg-primary text-black font-bold border border-primary">
<span class="material-symbols-outlined text-lg">check</span>
</div>
</div>
<div class="flex flex-col items-center gap-2 min-w-[44px]">
<span class="text-[10px] font-bold text-slate-500">WED</span>
<div class="size-10 rounded-full flex items-center justify-center bg-primary text-black font-bold border border-primary">
<span class="material-symbols-outlined text-lg">check</span>
</div>
</div>
<div class="flex flex-col items-center gap-2 min-w-[44px]">
<span class="text-[10px] font-bold text-primary">THU</span>
<div class="size-10 rounded-full flex items-center justify-center bg-primary/20 border-2 border-primary text-primary font-bold">
<span class="text-sm font-bold">17</span>
</div>
</div>
<div class="flex flex-col items-center gap-2 min-w-[44px]">
<span class="text-[10px] font-bold text-slate-500">FRI</span>
<div class="size-10 rounded-full flex items-center justify-center bg-slate-200 dark:bg-surface-dark border border-slate-300 dark:border-neutral-dark">
<span class="text-sm font-bold">18</span>
</div>
</div>
<div class="flex flex-col items-center gap-2 min-w-[44px]">
<span class="text-[10px] font-bold text-slate-500">SAT</span>
<div class="size-10 rounded-full flex items-center justify-center bg-slate-200 dark:bg-surface-dark border border-slate-300 dark:border-neutral-dark">
<span class="text-sm font-bold">19</span>
</div>
</div>
<div class="flex flex-col items-center gap-2 min-w-[44px]">
<span class="text-[10px] font-bold text-slate-500">SUN</span>
<div class="size-10 rounded-full flex items-center justify-center bg-slate-200 dark:bg-surface-dark border border-slate-300 dark:border-neutral-dark">
<span class="text-sm font-bold">20</span>
</div>
</div>
</div>
</section>
<!-- Quick Action Button -->
<section>
<button class="w-full bg-primary hover:bg-opacity-90 py-5 rounded-xl flex items-center justify-center gap-3 group transition-all transform active:scale-[0.98]">
<div class="size-10 bg-black rounded-full flex items-center justify-center text-primary group-hover:scale-110 transition-transform">
<span class="material-symbols-outlined fill-1">play_arrow</span>
</div>
<span class="text-black font-extrabold text-xl uppercase tracking-tight">Start Workout</span>
</button>
</section>
<!-- Recent Activities -->
<section class="space-y-4">
<div class="flex items-center justify-between">
<h2 class="font-bold text-lg">Recent Activities</h2>
<button class="text-primary text-sm font-semibold">View All</button>
</div>
<!-- Activity Card 1 -->
<div class="bg-slate-200 dark:bg-surface-dark rounded-xl p-4 border border-slate-300 dark:border-neutral-dark">
<div class="flex items-center justify-between mb-4">
<div class="flex items-center gap-3">
<div class="size-10 rounded-lg bg-primary/10 flex items-center justify-center text-primary">
<span class="material-symbols-outlined">fitness_center</span>
</div>
<div>
<h4 class="font-bold text-sm">Leg Day - Hypertrophy</h4>
<p class="text-xs text-slate-500 dark:text-slate-400">Yesterday • 18:30</p>
</div>
</div>
<span class="material-symbols-outlined text-slate-500">more_horiz</span>
</div>
<div class="grid grid-cols-3 gap-2">
<div class="bg-white/5 dark:bg-black/20 rounded-lg p-2 text-center">
<p class="text-[10px] text-slate-500 font-bold uppercase">Duration</p>
<p class="text-sm font-bold">64 min</p>
</div>
<div class="bg-white/5 dark:bg-black/20 rounded-lg p-2 text-center">
<p class="text-[10px] text-slate-500 font-bold uppercase">Volume</p>
<p class="text-sm font-bold">12,450 kg</p>
</div>
<div class="bg-white/5 dark:bg-black/20 rounded-lg p-2 text-center">
<p class="text-[10px] text-slate-500 font-bold uppercase">Burned</p>
<p class="text-sm font-bold text-primary">542 kcal</p>
</div>
</div>
</div>
<!-- Activity Card 2 -->
<div class="bg-slate-200 dark:bg-surface-dark rounded-xl p-4 border border-slate-300 dark:border-neutral-dark">
<div class="flex items-center justify-between mb-4">
<div class="flex items-center gap-3">
<div class="size-10 rounded-lg bg-primary/10 flex items-center justify-center text-primary">
<span class="material-symbols-outlined">directions_run</span>
</div>
<div>
<h4 class="font-bold text-sm">Morning HIIT Blast</h4>
<p class="text-xs text-slate-500 dark:text-slate-400">Oct 15 • 07:15</p>
</div>
</div>
<span class="material-symbols-outlined text-slate-500">more_horiz</span>
</div>
<div class="grid grid-cols-3 gap-2">
<div class="bg-white/5 dark:bg-black/20 rounded-lg p-2 text-center">
<p class="text-[10px] text-slate-500 font-bold uppercase">Duration</p>
<p class="text-sm font-bold">32 min</p>
</div>
<div class="bg-white/5 dark:bg-black/20 rounded-lg p-2 text-center">
<p class="text-[10px] text-slate-500 font-bold uppercase">Intensity</p>
<p class="text-sm font-bold">High</p>
</div>
<div class="bg-white/5 dark:bg-black/20 rounded-lg p-2 text-center">
<p class="text-[10px] text-slate-500 font-bold uppercase">Burned</p>
<p class="text-sm font-bold text-primary">410 kcal</p>
</div>
</div>
</div>
</section>
</main>
<!-- Bottom Navigation Bar -->
<nav class="fixed bottom-0 left-0 right-0 mx-auto max-w-md bg-white/80 dark:bg-surface-dark/80 backdrop-blur-xl border-t border-slate-200 dark:border-neutral-dark px-4 py-3 flex justify-around items-center z-50">
<a class="flex flex-col items-center gap-1 text-primary" href="#">
<span class="material-symbols-outlined fill-1">home</span>
<span class="text-[10px] font-bold uppercase">Home</span>
</a>
<a class="flex flex-col items-center gap-1 text-slate-400" href="#">
<span class="material-symbols-outlined">fitness_center</span>
<span class="text-[10px] font-bold uppercase">Training</span>
</a>
<a class="flex flex-col items-center gap-1 text-slate-400" href="#">
<span class="material-symbols-outlined">analytics</span>
<span class="text-[10px] font-bold uppercase">Body</span>
</a>
<a class="flex flex-col items-center gap-1 text-slate-400" href="#">
<span class="material-symbols-outlined">person</span>
<span class="text-[10px] font-bold uppercase">Profile</span>
</a>
</nav>
</div>
    </div>
  </q-page>
</template>

<script setup>
// Static Stitch layout
</script>

<style scoped>
.stitch-theme-ella_dashboard_with_logo {
  --ella-primary: #ffd1dc;
  --ella-bg-light: #f8f8f5;
  --ella-bg-dark: #121212;
  --ella-surface-dark: #1e1e1e;
  --ella-neutral-dark: #2a2a2a;
}
</style>
