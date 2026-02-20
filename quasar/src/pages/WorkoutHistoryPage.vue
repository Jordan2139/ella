<template>
  <q-page class="stitch-page">
    <div class="stitch-theme-workout-history dark bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen font-display">
      <div class="relative mx-auto max-w-md min-h-screen flex flex-col pb-24">
        <header class="p-6 flex items-center justify-between">
          <div>
            <h1 class="text-xl font-bold tracking-tight">Workout History</h1>
            <p class="text-xs text-slate-500 dark:text-slate-400 font-medium uppercase tracking-wider">
              Past sessions
            </p>
          </div>
          <button class="size-10 flex items-center justify-center rounded-full bg-slate-200 dark:bg-surface-dark text-slate-600 dark:text-slate-300">
            <span class="material-symbols-outlined">filter_alt</span>
          </button>
        </header>

        <main class="flex-1 px-6 space-y-4">
          <div v-if="!store.sessions.length" class="text-sm text-slate-500">
            No workouts yet.
          </div>

          <div
            v-for="session in store.sessions"
            :key="session.id"
            class="group flex flex-col gap-3 rounded-xl bg-slate-100/50 dark:bg-slate-800/40 p-4 border border-slate-200 dark:border-slate-700/50 transition-colors active:bg-slate-200 dark:active:bg-slate-800"
            @click="openSummary(session.id)"
          >
            <div class="flex items-center justify-between">
              <div>
                <h3 class="font-bold text-base">{{ session.programName }}</h3>
                <p class="text-xs text-slate-500 dark:text-slate-400">
                  {{ formatDate(session.startedAt) }}
                </p>
              </div>
              <span class="material-symbols-outlined text-slate-400">chevron_right</span>
            </div>
            <div class="flex items-center gap-4 text-xs text-slate-500">
              <span>{{ session.entries.length }} exercises</span>
              <span>{{ session.completedAt ? 'Completed' : 'In Progress' }}</span>
            </div>
          </div>
        </main>
      </div>
    </div>
  </q-page>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { useWorkoutStore } from 'src/stores/workout-store'

const router = useRouter()
const store = useWorkoutStore()

function openSummary (sessionId) {
  router.push(`/workout-summary/${sessionId}`)
}

function formatDate (value) {
  return new Date(value).toLocaleString()
}
</script>
