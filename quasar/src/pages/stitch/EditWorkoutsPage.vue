<template>
  <q-page class="stitch-page">
    <div class="stitch-theme-edit_workouts dark bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">
<!-- Top Header -->
<header class="sticky top-0 z-10 bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-md px-4 py-4 border-b border-primary/10">
<div class="flex items-center justify-between max-w-2xl mx-auto w-full">
<h1 class="text-xl font-bold tracking-tight">Edit Workouts</h1>
<button class="text-primary font-semibold hover:opacity-80 transition-opacity">Done</button>
</div>
</header>
<!-- Tabs -->
<nav class="flex border-b border-primary/10 max-w-2xl mx-auto w-full px-4">
<button class="flex-1 py-4 text-sm font-bold active-tab">Scheduled</button>
<button class="flex-1 py-4 text-sm font-bold text-slate-500 dark:text-slate-400">Templates</button>
</nav>
<main class="flex-1 max-w-2xl mx-auto w-full p-4 space-y-6 pb-24">
<!-- Section Header -->
<div class="flex items-center justify-between">
<h2 class="text-lg font-bold">Weekly Routine</h2>
<span class="text-xs font-medium text-slate-500 uppercase tracking-wider">Drag to reorder</span>
</div>
<!-- Workout List -->
<div class="space-y-4">
<!-- Workout Card 1 -->
<div class="bg-surface-dark rounded-xl border border-primary/5 overflow-hidden">
<div class="p-4 flex items-center gap-4">
<div class="cursor-grab active:cursor-grabbing text-primary/40">
<span class="material-symbols-outlined">drag_indicator</span>
</div>
<div class="flex-1">
<div class="flex items-center justify-between">
<h3 class="font-bold text-base">Leg Day</h3>
<button class="text-slate-400 hover:text-primary transition-colors">
<span class="material-symbols-outlined text-xl">more_vert</span>
</button>
</div>
<p class="text-sm text-slate-400">Squats, Lunges + 3 more</p>
</div>
</div>
<!-- Exercise Nested List -->
<div class="bg-black/20 px-4 py-2 space-y-1">
<div class="flex items-center justify-between py-2 border-b border-white/5 last:border-0">
<span class="text-sm">Back Squats</span>
<button class="text-slate-500 hover:text-red-400 transition-colors">
<span class="material-symbols-outlined text-lg">close</span>
</button>
</div>
<div class="flex items-center justify-between py-2 border-b border-white/5 last:border-0">
<span class="text-sm">Walking Lunges</span>
<button class="text-slate-500 hover:text-red-400 transition-colors">
<span class="material-symbols-outlined text-lg">close</span>
</button>
</div>
<button class="w-full flex items-center justify-center gap-2 py-3 text-primary text-sm font-medium hover:bg-primary/5 rounded-lg mt-2 transition-all">
<span class="material-symbols-outlined text-sm">add_circle</span>
                        Add Exercise
                    </button>
</div>
</div>
<!-- Workout Card 2 -->
<div class="bg-surface-dark rounded-xl border border-primary/5 overflow-hidden">
<div class="p-4 flex items-center gap-4">
<div class="cursor-grab active:cursor-grabbing text-primary/40">
<span class="material-symbols-outlined">drag_indicator</span>
</div>
<div class="flex-1">
<div class="flex items-center justify-between">
<h3 class="font-bold text-base">Upper Body Focus</h3>
<button class="text-slate-400 hover:text-primary transition-colors">
<span class="material-symbols-outlined text-xl">more_vert</span>
</button>
</div>
<p class="text-sm text-slate-400">Bench Press, Rows + 4 more</p>
</div>
</div>
<div class="bg-black/20 px-4 py-2">
<button class="w-full flex items-center justify-center gap-2 py-3 text-primary text-sm font-medium hover:bg-primary/5 rounded-lg transition-all">
<span class="material-symbols-outlined text-sm">add_circle</span>
                        Add Exercise
                    </button>
</div>
</div>
<!-- Workout Card 3 -->
<div class="bg-surface-dark rounded-xl border border-primary/5 overflow-hidden opacity-75">
<div class="p-4 flex items-center gap-4">
<div class="cursor-grab active:cursor-grabbing text-primary/40">
<span class="material-symbols-outlined">drag_indicator</span>
</div>
<div class="flex-1">
<div class="flex items-center justify-between">
<h3 class="font-bold text-base">Cardio Blast</h3>
<button class="text-slate-400 hover:text-primary transition-colors">
<span class="material-symbols-outlined text-xl">more_vert</span>
</button>
</div>
<p class="text-sm text-slate-400">HIIT Sprints, Jump Rope</p>
</div>
</div>
<div class="bg-black/20 px-4 py-2">
<button class="w-full flex items-center justify-center gap-2 py-3 text-primary text-sm font-medium hover:bg-primary/5 rounded-lg transition-all">
<span class="material-symbols-outlined text-sm">add_circle</span>
                        Add Exercise
                    </button>
</div>
</div>
</div>
<!-- Add New Workout Button -->
<button class="w-full py-4 border-2 border-dashed border-primary/20 rounded-xl flex items-center justify-center gap-2 text-primary/80 font-bold hover:bg-primary/5 hover:border-primary/40 transition-all">
<span class="material-symbols-outlined">add_box</span>
            Create New Routine
        </button>
</main>
<!-- Floating Action Button -->
<button class="fixed bottom-24 right-6 w-14 h-14 bg-primary text-background-dark rounded-full shadow-lg shadow-primary/20 flex items-center justify-center hover:scale-105 active:scale-95 transition-transform z-20">
<span class="material-symbols-outlined font-bold">add</span>
</button>
<!-- Bottom Navigation Bar -->
<footer class="fixed bottom-0 left-0 right-0 bg-surface-dark border-t border-primary/10 px-4 pb-6 pt-2 z-30">
<div class="max-w-2xl mx-auto flex items-center justify-around">
<a class="flex flex-col items-center gap-1 text-slate-500" href="#">
<span class="material-symbols-outlined">dashboard</span>
<span class="text-[10px] font-medium uppercase tracking-tighter">Home</span>
</a>
<a class="flex flex-col items-center gap-1 text-primary" href="#">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1">fitness_center</span>
<span class="text-[10px] font-medium uppercase tracking-tighter">Workouts</span>
</a>
<a class="flex flex-col items-center gap-1 text-slate-500" href="#">
<span class="material-symbols-outlined">monitoring</span>
<span class="text-[10px] font-medium uppercase tracking-tighter">Progress</span>
</a>
<a class="flex flex-col items-center gap-1 text-slate-500" href="#">
<span class="material-symbols-outlined">settings</span>
<span class="text-[10px] font-medium uppercase tracking-tighter">Settings</span>
</a>
</div>
</footer>
    </div>
  </q-page>
</template>

<script setup>
// Static Stitch layout
</script>

<style scoped>
.stitch-theme-edit_workouts {
  --ella-primary: #ffd1dc;
  --ella-bg-light: #f8f5f6;
  --ella-bg-dark: #121212;
  --ella-surface-dark: #1e1e1e;
  --ella-neutral-dark: #2a2a2a;
}
</style>
