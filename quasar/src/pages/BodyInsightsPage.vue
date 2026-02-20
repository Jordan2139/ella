<template>
  <q-page class="stitch-page">
    <div class="stitch-theme-body-insights-revamped dark bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">
      <header class="flex items-center justify-between p-4 bg-background-light dark:bg-background-dark/50 backdrop-blur-md sticky top-0 z-10">
        <button class="p-2 hover:bg-primary/10 rounded-full transition-colors" @click="goBack">
          <span class="material-symbols-outlined text-slate-900 dark:text-slate-100">arrow_back</span>
        </button>
        <h1 class="text-lg font-bold tracking-tight">Body Insights</h1>
        <button class="p-2 hover:bg-primary/10 rounded-full transition-colors">
          <span class="material-symbols-outlined text-slate-900 dark:text-slate-100">info</span>
        </button>
      </header>

      <main class="flex-1 overflow-y-auto pb-24">
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

        <div class="relative flex flex-col items-center justify-center py-8">
          <div class="w-64 h-96 relative muscle-silhouette">
            <svg class="w-full h-full" viewBox="0 0 200 400" xmlns="http://www.w3.org/2000/svg">
              <circle class="text-slate-300 dark:text-slate-700" cx="100" cy="30" fill="currentColor" r="20"></circle>
              <path d="M60,60 L140,60 L150,85 L50,85 Z" fill="#ffd1dc"></path>
              <path d="M65,90 L135,90 L130,135 L70,135 Z" fill="#ffd1dc"></path>
              <path d="M45,85 L55,85 L40,180 L25,175 Z" fill="#fb7185"></path>
              <path d="M145,85 L155,85 L175,175 L160,180 Z" fill="#fb7185"></path>
              <path d="M72,140 L128,140 L125,190 L75,190 Z" fill="#ef4444"></path>
              <path d="M75,195 L98,195 L95,380 L65,370 Z" fill="#ef4444"></path>
              <path d="M102,195 L125,195 L135,370 L105,380 Z" fill="#ef4444"></path>
            </svg>
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

          <div class="mt-8 px-8 w-full max-w-sm">
            <div class="flex justify-between text-[10px] uppercase font-bold text-slate-500 mb-2">
              <span>Public Average</span>
              <span>Elite Strength</span>
            </div>
            <div class="h-2 w-full rounded-full bg-gradient-to-r from-red-500 via-rose-400 to-primary"></div>
          </div>
        </div>

        <div class="px-4 mt-6 grid grid-cols-2 gap-4">
          <div class="p-4 rounded-xl bg-white dark:bg-slate-800/40 border border-slate-200 dark:border-slate-700/50">
            <div class="flex items-center gap-2 mb-2">
              <span class="material-symbols-outlined text-primary text-sm">fitness_center</span>
              <span class="text-xs font-medium text-slate-500">Total Volume</span>
            </div>
            <div class="flex items-baseline gap-1">
              <span class="text-xl font-bold">{{ totalVolume }}</span>
              <span class="text-[10px] text-emerald-500">kg</span>
            </div>
          </div>
          <div class="p-4 rounded-xl bg-white dark:bg-slate-800/40 border border-slate-200 dark:border-slate-700/50">
            <div class="flex items-center gap-2 mb-2">
              <span class="material-symbols-outlined text-primary text-sm">schedule</span>
              <span class="text-xs font-medium text-slate-500">Completed Sets</span>
            </div>
            <div class="flex items-baseline gap-1">
              <span class="text-xl font-bold">{{ completedSets }}</span>
              <span class="text-[10px] text-emerald-500">sets</span>
            </div>
          </div>
          <div class="col-span-2 p-4 rounded-xl bg-primary/5 border border-primary/20 flex items-center justify-between">
            <div>
              <h4 class="text-sm font-bold">Strongest Lift</h4>
              <p class="text-xs text-slate-500">{{ strongestLiftLabel }}</p>
            </div>
            <div class="h-12 w-12 rounded-full bg-primary/20 flex items-center justify-center">
              <span class="material-symbols-outlined text-primary">emoji_events</span>
            </div>
          </div>
        </div>

        <div class="mt-8 px-4">
          <h3 class="text-sm font-bold uppercase tracking-wider text-slate-500 mb-4">Detailed Metrics</h3>
          <div class="space-y-3">
            <div
              v-for="metric in topExercises"
              :key="metric.exerciseId"
              class="flex items-center justify-between p-3 rounded-lg bg-white dark:bg-slate-800/20"
            >
              <div class="flex items-center gap-3">
                <div class="w-2 h-2 rounded-full bg-primary"></div>
                <span class="text-sm font-medium">{{ metric.name }}</span>
              </div>
              <span class="text-sm font-bold">{{ metric.maxWeight }} kg</span>
            </div>
            <div v-if="!topExercises.length" class="text-sm text-slate-500">
              Complete a workout to see metrics.
            </div>
          </div>
        </div>
      </main>
    </div>
  </q-page>
</template>

<script setup>
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { useWorkoutStore } from 'src/stores/workout-store'

const router = useRouter()
const store = useWorkoutStore()

const completedSets = computed(() =>
  store.sessions.reduce((count, session) => {
    const sets = session.entries?.flatMap((entry) => entry.sets || []) || []
    return count + sets.filter((set) => set.isCompleted).length
  }, 0)
)

const totalVolume = computed(() =>
  store.sessions.reduce((sum, session) => {
    const sets = session.entries?.flatMap((entry) => entry.sets || []) || []
    return sum + sets.reduce((inner, set) => inner + (set.weight || 0) * (set.reps || 0), 0)
  }, 0)
)

const topExercises = computed(() => {
  const byExercise = new Map()
  store.sessions.forEach((session) => {
    session.entries?.forEach((entry) => {
      const maxWeight = Math.max(...entry.sets.map((set) => set.weight || 0), 0)
      if (!byExercise.has(entry.exerciseId) || byExercise.get(entry.exerciseId) < maxWeight) {
        byExercise.set(entry.exerciseId, maxWeight)
      }
    })
  })
  return [...byExercise.entries()]
    .map(([exerciseId, maxWeight]) => ({
      exerciseId,
      maxWeight,
      name: store.exerciseById(exerciseId)?.name || 'Unknown Exercise'
    }))
    .sort((a, b) => b.maxWeight - a.maxWeight)
    .slice(0, 4)
})

const strongestLiftLabel = computed(() => {
  if (!topExercises.value.length) return 'No data yet'
  const top = topExercises.value[0]
  return `${top.name} • ${top.maxWeight} kg`
})

function goBack () {
  router.back()
}
</script>
