<template>
  <q-page class="stitch-page">
    <div class="stitch-theme-body_insights dark bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">
<!-- Header -->
<header class="flex items-center justify-between px-6 py-4 border-b border-slate-200 dark:border-slate-800 bg-white/5 backdrop-blur-md sticky top-0 z-50">
<button class="flex items-center justify-center p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-white/10 transition-colors">
<span class="material-symbols-outlined">arrow_back</span>
</button>
<div class="text-center">
<h1 class="text-lg font-bold tracking-tight uppercase">Body Insights</h1>
<p class="text-[10px] text-slate-500 dark:text-slate-400 font-medium tracking-widest uppercase">Last synced: 2m ago</p>
</div>
<button class="flex items-center justify-center p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-white/10 transition-colors text-primary">
<span class="material-symbols-outlined">history</span>
</button>
</header>
<!-- Main Content Area -->
<main class="flex-1 relative flex flex-col overflow-hidden">
<!-- Top Controls: Gender Toggle -->
<div class="px-6 py-4 flex justify-center">
<div class="flex h-11 w-full max-w-xs items-center justify-center rounded-xl bg-slate-200 dark:bg-slate-900/50 p-1 border border-slate-300 dark:border-slate-800">
<label class="flex cursor-pointer h-full grow items-center justify-center overflow-hidden rounded-lg px-2 has-[:checked]:bg-white dark:has-[:checked]:bg-primary has-[:checked]:text-slate-900 text-slate-500 dark:text-slate-400 text-sm font-semibold transition-all">
<span class="truncate">Male</span>
<input checked="" class="hidden" name="gender" type="radio" value="Male"/>
</label>
<label class="flex cursor-pointer h-full grow items-center justify-center overflow-hidden rounded-lg px-2 has-[:checked]:bg-white dark:has-[:checked]:bg-primary has-[:checked]:text-slate-900 text-slate-500 dark:text-slate-400 text-sm font-semibold transition-all">
<span class="truncate">Female</span>
<input class="hidden" name="gender" type="radio" value="Female"/>
</label>
</div>
</div>
<!-- 3D Visualization Area -->
<div class="flex-1 relative flex items-center justify-center overflow-hidden min-h-[400px]">
<!-- Background Mesh Glow -->
<div class="absolute inset-0 bg-gradient-to-b from-transparent via-primary/5 to-transparent pointer-events-none"></div>
<!-- Central Figure Mockup (Using an SVG representation of an anatomical model) -->
<div class="relative z-10 w-full max-w-md aspect-[3/4] flex items-center justify-center">
<img alt="Anatomical figure with highlighted muscle groups" class="h-full object-contain opacity-90 muscle-glow" data-alt="3D anatomical figure with bright green and amber muscles" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCUoYE-2S28e0UUeXq3Myq3MVD-oEIrP4tjUUXU7aMsbd4M3q4VvlAiiAODWASHwtHdykfIKj0cqSAtZe0JMKtYZ8AjGdizyE2lj44hINokfbAZUG-tDXt4BTNeSRKjvhbZ_MVQpRJii3S5RrDq36OnnIDtKLXqacoZS2JDZzJnHrbGkNQQjQFk8Pvz7A408VPmuH177tXIeeuaHhKHahNUIspafAJrP30CkNiceZvmAJ8FbVhJS0whG6XolzRBV19Jz9GsV079n0o"/>
<!-- Floating Lift Cards -->
<!-- Chest -->
<div class="absolute top-[25%] left-[10%] bg-slate-900/80 backdrop-blur-md border border-slate-700 p-2 rounded-lg shadow-2xl flex items-center gap-3 scale-90 md:scale-100">
<div class="w-8 h-8 rounded bg-primary/20 flex items-center justify-center">
<span class="material-symbols-outlined text-primary text-sm">fitness_center</span>
</div>
<div>
<p class="text-[9px] uppercase font-bold text-slate-400 leading-none mb-1">Chest</p>
<p class="text-xs font-bold whitespace-nowrap"><span class="gold-text">225lb</span> Bench Press</p>
</div>
<div class="text-[#FFD700] flex items-center">
<span class="material-symbols-outlined text-sm">stars</span>
</div>
</div>
<!-- Back/Shoulders -->
<div class="absolute top-[15%] right-[5%] bg-slate-900/80 backdrop-blur-md border border-slate-700 p-2 rounded-lg shadow-2xl flex items-center gap-3 scale-90 md:scale-100">
<div>
<p class="text-[9px] uppercase font-bold text-slate-400 leading-none mb-1">Back</p>
<p class="text-xs font-bold whitespace-nowrap">405lb Deadlift</p>
</div>
<div class="w-8 h-8 rounded bg-slate-800 flex items-center justify-center">
<span class="material-symbols-outlined text-slate-300 text-sm">straighten</span>
</div>
</div>
<!-- Legs -->
<div class="absolute bottom-[20%] right-[10%] bg-slate-900/80 backdrop-blur-md border border-slate-700 p-2 rounded-lg shadow-2xl flex items-center gap-3 scale-90 md:scale-100">
<div class="w-8 h-8 rounded bg-primary/20 flex items-center justify-center">
<span class="material-symbols-outlined text-primary text-sm">reorder</span>
</div>
<div>
<p class="text-[9px] uppercase font-bold text-slate-400 leading-none mb-1">Legs</p>
<p class="text-xs font-bold whitespace-nowrap">315lb Squat</p>
</div>
</div>
</div>
<!-- Recovery Legend (Overlaying on Figure Area) -->
<div class="absolute bottom-4 left-6 right-6">
<div class="bg-slate-900/60 backdrop-blur-lg border border-slate-800 rounded-xl p-3 flex items-center justify-around shadow-lg">
<div class="flex items-center gap-2">
<div class="w-3 h-3 rounded-full bg-primary shadow-[0_0_8px_rgba(196,242,13,0.6)]"></div>
<span class="text-[10px] font-bold uppercase text-slate-300">Ready</span>
</div>
<div class="flex items-center gap-2">
<div class="w-3 h-3 rounded-full bg-amber-500 shadow-[0_0_8px_rgba(245,158,11,0.6)]"></div>
<span class="text-[10px] font-bold uppercase text-slate-300">Recovering</span>
</div>
<div class="flex items-center gap-2">
<div class="w-3 h-3 rounded-full bg-red-600 shadow-[0_0_8px_rgba(220,38,38,0.6)]"></div>
<span class="text-[10px] font-bold uppercase text-slate-300">Fatigued</span>
</div>
</div>
</div>
</div>
<!-- Details & CTA -->
<div class="px-6 pb-24 pt-4 space-y-4">
<div class="flex items-center justify-between mb-2">
<h3 class="text-sm font-bold uppercase tracking-wider text-slate-400">Strength Records</h3>
<span class="text-[10px] text-primary font-bold">VIEW ALL</span>
</div>
<!-- Horizontal scroll for more lifts -->
<div class="flex gap-4 overflow-x-auto pb-4 custom-scrollbar">
<div class="min-w-[140px] bg-slate-900/40 border border-slate-800 p-3 rounded-xl">
<p class="text-[10px] text-slate-500 font-bold uppercase">Shoulders</p>
<p class="text-lg font-bold">155 <span class="text-xs text-slate-400">lb</span></p>
<p class="text-[10px] text-slate-400 truncate">Overhead Press</p>
</div>
<div class="min-w-[140px] bg-slate-900/40 border border-slate-800 p-3 rounded-xl">
<p class="text-[10px] text-slate-500 font-bold uppercase">Arms</p>
<p class="text-lg font-bold">95 <span class="text-xs text-slate-400">lb</span></p>
<p class="text-[10px] text-slate-400 truncate">Barbell Curls</p>
</div>
<div class="min-w-[140px] bg-slate-900/40 border border-slate-800 p-3 rounded-xl border-primary/30 ring-1 ring-primary/20">
<p class="text-[10px] text-primary font-bold uppercase">Core</p>
<p class="text-lg font-bold">5:00 <span class="text-xs text-slate-400">min</span></p>
<p class="text-[10px] text-slate-400 truncate">Plank Hold</p>
</div>
</div>
<button class="w-full bg-primary py-4 rounded-xl text-slate-900 font-bold flex items-center justify-center gap-2 hover:opacity-90 transition-opacity">
<span>View Recovery Timeline</span>
<span class="material-symbols-outlined text-lg">trending_up</span>
</button>
</div>
</main>
<!-- Bottom Navigation Bar -->
<nav class="fixed bottom-0 left-0 right-0 bg-slate-950 border-t border-slate-800 px-4 pb-6 pt-3 z-50">
<div class="flex items-center justify-around max-w-md mx-auto">
<a class="flex flex-col items-center gap-1 text-slate-500" href="#">
<span class="material-symbols-outlined">fitness_center</span>
<span class="text-[10px] font-medium uppercase">Workouts</span>
</a>
<a class="flex flex-col items-center gap-1 text-primary" href="#">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1">monitoring</span>
<span class="text-[10px] font-medium uppercase">Insights</span>
</a>
<div class="relative -top-6">
<button class="w-14 h-14 bg-primary rounded-full shadow-[0_0_20px_rgba(196,242,13,0.4)] flex items-center justify-center text-slate-950 border-4 border-slate-950">
<span class="material-symbols-outlined font-bold text-3xl">add</span>
</button>
</div>
<a class="flex flex-col items-center gap-1 text-slate-500" href="#">
<span class="material-symbols-outlined">restaurant</span>
<span class="text-[10px] font-medium uppercase">Diet</span>
</a>
<a class="flex flex-col items-center gap-1 text-slate-500" href="#">
<span class="material-symbols-outlined">person</span>
<span class="text-[10px] font-medium uppercase">Profile</span>
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
.stitch-theme-body_insights {
  --ella-primary: #c4f20d;
  --ella-bg-light: #f8f8f5;
  --ella-bg-dark: #1e2210;
  --ella-surface-dark: #1e1e1e;
  --ella-neutral-dark: #2a2a2a;
}
</style>
