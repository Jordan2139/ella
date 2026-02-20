<template>
  <q-page class="stitch-page">
    <div class="stitch-theme-body-insights-revamped dark bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">
<!-- Header -->
<header class="flex items-center justify-between p-4 bg-background-light dark:bg-background-dark/50 backdrop-blur-md sticky top-0 z-10">
<button class="p-2 hover:bg-primary/10 rounded-full transition-colors">
<span class="material-symbols-outlined text-slate-900 dark:text-slate-100">arrow_back</span>
</button>
<h1 class="text-lg font-bold tracking-tight">Body Insights</h1>
<button class="p-2 hover:bg-primary/10 rounded-full transition-colors">
<span class="material-symbols-outlined text-slate-900 dark:text-slate-100">info</span>
</button>
</header>
<!-- Main Content -->
<main class="flex-1 overflow-y-auto pb-24">
<!-- Mode Toggle -->
<div class="px-4 py-4">
<div class="flex p-1 bg-primary/10 dark:bg-slate-800/50 rounded-xl">
<button class="flex-1 flex items-center justify-center py-2 px-4 rounded-lg bg-primary text-background-dark font-semibold shadow-sm transition-all">
                    Progress
                </button>
<button class="flex-1 flex items-center justify-center py-2 px-4 rounded-lg text-slate-600 dark:text-slate-400 font-medium hover:text-primary transition-all">
                    Fatigue
                </button>
</div>
</div>
<!-- Silhouette Section -->
<div class="relative flex flex-col items-center justify-center py-8">
<div class="w-64 h-96 relative muscle-silhouette">
<!-- Simple Stylized Silhouette Mockup using SVG Path representations -->
<svg class="w-full h-full" viewbox="0 0 200 400" xmlns="http://www.w3.org/2000/svg">
<!-- Head -->
<circle class="text-slate-300 dark:text-slate-700" cx="100" cy="30" fill="currentColor" r="20"></circle>
<!-- Shoulders (Progress: Advanced Pink) -->
<path d="M60,60 L140,60 L150,85 L50,85 Z" fill="#ffd1dc"></path>
<!-- Chest (Progress: Advanced Pink) -->
<path d="M65,90 L135,90 L130,135 L70,135 Z" fill="#ffd1dc"></path>
<!-- Arms (Progress: Mid-Level Coral-ish Pink) -->
<path d="M45,85 L55,85 L40,180 L25,175 Z" fill="#fb7185"></path>
<path d="M145,85 L155,85 L175,175 L160,180 Z" fill="#fb7185"></path>
<!-- Torso/Abs (Progress: Beginner Red) -->
<path d="M72,140 L128,140 L125,190 L75,190 Z" fill="#ef4444"></path>
<!-- Legs (Progress: Beginner Red) -->
<path d="M75,195 L98,195 L95,380 L65,370 Z" fill="#ef4444"></path>
<path d="M102,195 L125,195 L135,370 L105,380 Z" fill="#ef4444"></path>
</svg>
<!-- Overlay Labels (Visual Polish) -->
<div class="absolute top-[15%] left-0 -translate-x-full pr-4 text-right">
<span class="text-[10px] uppercase tracking-widest text-slate-500 font-bold">Shoulders</span>
<p class="text-xs font-bold text-primary">Advanced</p>
</div>
<div class="absolute top-[40%] right-0 translate-x-full pl-4 text-left">
<span class="text-[10px] uppercase tracking-widest text-slate-500 font-bold">Arms</span>
<p class="text-xs font-bold text-rose-400">Intermediate</p>
</div>
<div class="absolute bottom-[20%] left-0 -translate-x-full pr-4 text-right">
<span class="text-[10px] uppercase tracking-widest text-slate-500 font-bold">Legs</span>
<p class="text-xs font-bold text-red-500">Beginner</p>
</div>
</div>
<!-- Legend Bar -->
<div class="mt-8 px-8 w-full max-w-sm">
<div class="flex justify-between text-[10px] uppercase font-bold text-slate-500 mb-2">
<span>Public Average</span>
<span>Elite Strength</span>
</div>
<div class="h-2 w-full rounded-full bg-gradient-to-r from-red-500 via-rose-400 to-primary"></div>
</div>
</div>
<!-- Insight Cards Grid -->
<div class="px-4 mt-6 grid grid-cols-2 gap-4">
<div class="p-4 rounded-xl bg-white dark:bg-slate-800/40 border border-slate-200 dark:border-slate-700/50">
<div class="flex items-center gap-2 mb-2">
<span class="material-symbols-outlined text-primary text-sm">fitness_center</span>
<span class="text-xs font-medium text-slate-500">Chest Press</span>
</div>
<div class="flex items-baseline gap-1">
<span class="text-xl font-bold">+18%</span>
<span class="text-[10px] text-emerald-500">▲ vs. Avg</span>
</div>
</div>
<div class="p-4 rounded-xl bg-white dark:bg-slate-800/40 border border-slate-200 dark:border-slate-700/50">
<div class="flex items-center gap-2 mb-2">
<span class="material-symbols-outlined text-primary text-sm">directions_run</span>
<span class="text-xs font-medium text-slate-500">Squat Power</span>
</div>
<div class="flex items-baseline gap-1">
<span class="text-xl font-bold">-4%</span>
<span class="text-[10px] text-red-500">▼ vs. Avg</span>
</div>
</div>
<div class="col-span-2 p-4 rounded-xl bg-primary/5 border border-primary/20 flex items-center justify-between">
<div>
<h4 class="text-sm font-bold">Strongest Region</h4>
<p class="text-xs text-slate-500">Your upper body strength is in the top 15%.</p>
</div>
<div class="h-12 w-12 rounded-full bg-primary/20 flex items-center justify-center">
<span class="material-symbols-outlined text-primary">emoji_events</span>
</div>
</div>
</div>
<!-- Muscle Detail List -->
<div class="mt-8 px-4">
<h3 class="text-sm font-bold uppercase tracking-wider text-slate-500 mb-4">Detailed Metrics</h3>
<div class="space-y-3">
<div class="flex items-center justify-between p-3 rounded-lg bg-white dark:bg-slate-800/20">
<div class="flex items-center gap-3">
<div class="w-2 h-2 rounded-full bg-primary"></div>
<span class="text-sm font-medium">Shoulder Press</span>
</div>
<span class="text-sm font-bold">145 lbs</span>
</div>
<div class="flex items-center justify-between p-3 rounded-lg bg-white dark:bg-slate-800/20">
<div class="flex items-center gap-3">
<div class="w-2 h-2 rounded-full bg-rose-400"></div>
<span class="text-sm font-medium">Bicep Curls</span>
</div>
<span class="text-sm font-bold">45 lbs</span>
</div>
<div class="flex items-center justify-between p-3 rounded-lg bg-white dark:bg-slate-800/20">
<div class="flex items-center gap-3">
<div class="w-2 h-2 rounded-full bg-red-500"></div>
<span class="text-sm font-medium">Deadlift</span>
</div>
<span class="text-sm font-bold">185 lbs</span>
</div>
</div>
</div>
</main>
<!-- Bottom Navigation Bar -->
<nav class="fixed bottom-0 left-0 right-0 bg-white/80 dark:bg-background-dark/90 backdrop-blur-lg border-t border-slate-200 dark:border-slate-800 px-4 pb-6 pt-2">
<div class="flex justify-between items-center max-w-md mx-auto">
<a class="flex flex-col items-center gap-1 p-2 text-slate-400" href="#">
<span class="material-symbols-outlined">home</span>
<span class="text-[10px] font-medium">Home</span>
</a>
<a class="flex flex-col items-center gap-1 p-2 text-primary" href="#">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1">insights</span>
<span class="text-[10px] font-medium">Insights</span>
</a>
<a class="flex flex-col items-center gap-1 p-2 text-slate-400" href="#">
<span class="material-symbols-outlined">fitness_center</span>
<span class="text-[10px] font-medium">Workout</span>
</a>
<a class="flex flex-col items-center gap-1 p-2 text-slate-400" href="#">
<span class="material-symbols-outlined">person</span>
<span class="text-[10px] font-medium">Profile</span>
</a>
</div>
</nav>
    </div>
  </q-page>
</template>

<script setup>
// Static Stitch layout
</script>

<style scoped>
.stitch-theme-body-insights-revamped {
  --ella-primary: #ffd1dc;
  --ella-bg-light: #f8f5f6;
  --ella-bg-dark: #230f14;
  --ella-surface-dark: #1e1e1e;
  --ella-neutral-dark: #2a2a2a;
}
</style>
