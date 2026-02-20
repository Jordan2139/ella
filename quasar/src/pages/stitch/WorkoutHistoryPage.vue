<template>
  <q-page class="stitch-page">
    <div class="stitch-theme-workout_history dark bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 font-display">
<div class="relative flex h-screen w-full max-w-md mx-auto flex-col bg-background-light dark:bg-background-dark overflow-hidden border-x border-primary/10">
<!-- Header -->
<header class="flex items-center justify-between p-4 pt-6">
<div class="flex flex-col">
<h1 class="text-2xl font-bold tracking-tight">Workout History</h1>
<p class="text-slate-500 dark:text-slate-400 text-sm">October 2023</p>
</div>
<button class="flex size-10 items-center justify-center rounded-full bg-primary/10 text-primary">
<span class="material-symbols-outlined">filter_list</span>
</button>
</header>
<!-- Monthly Summary -->
<div class="px-4 pb-6">
<div class="grid grid-cols-2 gap-3">
<div class="flex flex-col gap-1 rounded-xl bg-primary/10 p-4 border border-primary/20">
<span class="text-xs font-medium uppercase tracking-wider text-primary/80">Total Workouts</span>
<div class="flex items-baseline gap-1">
<span class="text-3xl font-bold text-primary">18</span>
<span class="text-xs text-slate-400">sessions</span>
</div>
</div>
<div class="flex flex-col gap-1 rounded-xl bg-primary/10 p-4 border border-primary/20">
<span class="text-xs font-medium uppercase tracking-wider text-primary/80">Active Time</span>
<div class="flex items-baseline gap-1">
<span class="text-3xl font-bold text-primary">22h</span>
<span class="text-sm font-semibold text-primary">45m</span>
</div>
</div>
</div>
</div>
<!-- Scrollable Content -->
<main class="flex-1 overflow-y-auto px-4 pb-24 hide-scrollbar">
<!-- This Week Section -->
<section class="mb-6">
<h3 class="mb-3 text-sm font-semibold uppercase tracking-widest text-slate-500">This Week</h3>
<div class="flex flex-col gap-3">
<!-- Workout Card 1 -->
<div class="group flex flex-col gap-3 rounded-xl bg-slate-100/50 dark:bg-slate-800/40 p-4 border border-slate-200 dark:border-slate-700/50 transition-colors active:bg-slate-200 dark:active:bg-slate-800">
<div class="flex items-center justify-between">
<div class="flex items-center gap-3">
<div class="flex size-10 items-center justify-center rounded-lg bg-primary text-background-dark">
<span class="material-symbols-outlined text-[20px]">fitness_center</span>
</div>
<div>
<h4 class="font-bold">Leg Day</h4>
<p class="text-xs text-slate-500">Thursday, Oct 12 • 07:30 AM</p>
</div>
</div>
<span class="material-symbols-outlined text-slate-400">chevron_right</span>
</div>
<div class="grid grid-cols-3 gap-2 border-t border-slate-200 dark:border-slate-700/50 pt-3">
<div class="flex flex-col">
<span class="text-[10px] uppercase text-slate-500">Duration</span>
<span class="text-sm font-semibold">65m</span>
</div>
<div class="flex flex-col">
<span class="text-[10px] uppercase text-slate-500">Volume</span>
<span class="text-sm font-semibold text-primary">12,400 kg</span>
</div>
<div class="flex flex-col">
<span class="text-[10px] uppercase text-slate-500">Intensity</span>
<span class="text-sm font-semibold">High</span>
</div>
</div>
</div>
<!-- Workout Card 2 -->
<div class="group flex flex-col gap-3 rounded-xl bg-slate-100/50 dark:bg-slate-800/40 p-4 border border-slate-200 dark:border-slate-700/50 transition-colors active:bg-slate-200 dark:active:bg-slate-800">
<div class="flex items-center justify-between">
<div class="flex items-center gap-3">
<div class="flex size-10 items-center justify-center rounded-lg bg-primary/20 text-primary">
<span class="material-symbols-outlined text-[20px]">directions_run</span>
</div>
<div>
<h4 class="font-bold">Morning Run</h4>
<p class="text-xs text-slate-500">Tuesday, Oct 10 • 06:15 AM</p>
</div>
</div>
<span class="material-symbols-outlined text-slate-400">chevron_right</span>
</div>
<div class="grid grid-cols-3 gap-2 border-t border-slate-200 dark:border-slate-700/50 pt-3">
<div class="flex flex-col">
<span class="text-[10px] uppercase text-slate-500">Duration</span>
<span class="text-sm font-semibold">30m</span>
</div>
<div class="flex flex-col">
<span class="text-[10px] uppercase text-slate-500">Calories</span>
<span class="text-sm font-semibold text-primary">450 kcal</span>
</div>
<div class="flex flex-col">
<span class="text-[10px] uppercase text-slate-500">Distance</span>
<span class="text-sm font-semibold">5.2 km</span>
</div>
</div>
</div>
</div>
</section>
<!-- Last Week Section -->
<section class="mb-6">
<h3 class="mb-3 text-sm font-semibold uppercase tracking-widest text-slate-500">Last Week</h3>
<div class="flex flex-col gap-3">
<!-- Workout Card 3 -->
<div class="group flex flex-col gap-3 rounded-xl bg-slate-100/50 dark:bg-slate-800/40 p-4 border border-slate-200 dark:border-slate-700/50 transition-colors active:bg-slate-200 dark:active:bg-slate-800">
<div class="flex items-center justify-between">
<div class="flex items-center gap-3">
<div class="flex size-10 items-center justify-center rounded-lg bg-primary/20 text-primary">
<span class="material-symbols-outlined text-[20px]">fitness_center</span>
</div>
<div>
<h4 class="font-bold">Upper Body Focus</h4>
<p class="text-xs text-slate-500">Friday, Oct 6 • 05:45 PM</p>
</div>
</div>
<span class="material-symbols-outlined text-slate-400">chevron_right</span>
</div>
<div class="grid grid-cols-3 gap-2 border-t border-slate-200 dark:border-slate-700/50 pt-3">
<div class="flex flex-col">
<span class="text-[10px] uppercase text-slate-500">Duration</span>
<span class="text-sm font-semibold">52m</span>
</div>
<div class="flex flex-col">
<span class="text-[10px] uppercase text-slate-500">Volume</span>
<span class="text-sm font-semibold text-primary">8,200 kg</span>
</div>
<div class="flex flex-col">
<span class="text-[10px] uppercase text-slate-500">Sets</span>
<span class="text-sm font-semibold">24</span>
</div>
</div>
</div>
<!-- Workout Card 4 -->
<div class="group flex flex-col gap-3 rounded-xl bg-slate-100/50 dark:bg-slate-800/40 p-4 border border-slate-200 dark:border-slate-700/50 transition-colors active:bg-slate-200 dark:active:bg-slate-800">
<div class="flex items-center justify-between">
<div class="flex items-center gap-3">
<div class="flex size-10 items-center justify-center rounded-lg bg-primary/20 text-primary">
<span class="material-symbols-outlined text-[20px]">bolt</span>
</div>
<div>
<h4 class="font-bold">HIIT Circuit</h4>
<p class="text-xs text-slate-500">Wednesday, Oct 4 • 08:00 AM</p>
</div>
</div>
<span class="material-symbols-outlined text-slate-400">chevron_right</span>
</div>
<div class="grid grid-cols-3 gap-2 border-t border-slate-200 dark:border-slate-700/50 pt-3">
<div class="flex flex-col">
<span class="text-[10px] uppercase text-slate-500">Duration</span>
<span class="text-sm font-semibold">25m</span>
</div>
<div class="flex flex-col">
<span class="text-[10px] uppercase text-slate-500">Calories</span>
<span class="text-sm font-semibold text-primary">380 kcal</span>
</div>
<div class="flex flex-col">
<span class="text-[10px] uppercase text-slate-500">Avg HR</span>
<span class="text-sm font-semibold">164 bpm</span>
</div>
</div>
</div>
</div>
</section>
</main>
<!-- Bottom Navigation Bar -->
<nav class="absolute bottom-0 left-0 right-0 border-t border-slate-200 dark:border-slate-800 bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-lg px-4 pb-6 pt-2">
<div class="flex justify-between items-center">
<a class="flex flex-col items-center gap-1 text-slate-400" href="#">
<span class="material-symbols-outlined">home</span>
<span class="text-[10px] font-medium uppercase tracking-tighter">Home</span>
</a>
<a class="flex flex-col items-center gap-1 text-slate-400" href="#">
<span class="material-symbols-outlined">fitness_center</span>
<span class="text-[10px] font-medium uppercase tracking-tighter">Workouts</span>
</a>
<a class="flex flex-col items-center gap-1 text-primary" href="#">
<div class="relative">
<span class="material-symbols-outlined fill-[1]">history</span>
<div class="absolute -top-1 -right-1 size-1.5 rounded-full bg-primary"></div>
</div>
<span class="text-[10px] font-bold uppercase tracking-tighter">History</span>
</a>
<a class="flex flex-col items-center gap-1 text-slate-400" href="#">
<span class="material-symbols-outlined">person</span>
<span class="text-[10px] font-medium uppercase tracking-tighter">Profile</span>
</a>
</div>
</nav>
</div>
    </div>
  </q-page>
</template>

<script setup>
// Static Stitch layout
</script>

<style scoped>
.stitch-theme-workout_history {
  --ella-primary: #ffd1dc;
  --ella-bg-light: #f8f5f6;
  --ella-bg-dark: #230f14;
  --ella-surface-dark: #1e1e1e;
  --ella-neutral-dark: #2a2a2a;
}
</style>
