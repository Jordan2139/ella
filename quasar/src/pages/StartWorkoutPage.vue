<template>
  <q-page class="stitch-page">
    <div class="stitch-theme-workout-dashboard-pink dark bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen font-display">
      <div class="relative mx-auto max-w-md bg-background-light dark:bg-background-dark min-h-screen flex flex-col pb-24">
        <header class="p-6 flex items-center justify-between">
          <div class="flex items-center gap-3">
            <div class="size-12 rounded-full border-2 border-primary p-0.5">
              <div class="size-full rounded-full bg-primary/10"></div>
            </div>
            <div>
              <h1 class="text-xl font-bold tracking-tight">Start Workout</h1>
              <p class="text-xs text-slate-500 dark:text-slate-400 font-medium uppercase tracking-wider">
                Choose a program or go empty
              </p>
            </div>
          </div>
          <button class="size-10 flex items-center justify-center rounded-full bg-slate-200 dark:bg-surface-dark text-slate-600 dark:text-slate-300">
            <span class="material-symbols-outlined">notifications</span>
          </button>
        </header>

        <main class="flex-1 px-6 space-y-6">
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

          <section>
            <button
              class="w-full bg-primary hover:bg-opacity-90 py-5 rounded-xl flex items-center justify-center gap-3 group transition-all transform active:scale-[0.98]"
              @click="startEmpty"
            >
              <div class="size-10 bg-black rounded-full flex items-center justify-center text-primary group-hover:scale-110 transition-transform">
                <span class="material-symbols-outlined fill-1">play_arrow</span>
              </div>
              <span class="text-black font-extrabold text-xl uppercase tracking-tight">Empty Workout</span>
            </button>
          </section>

          <section class="space-y-4">
            <div class="flex items-center justify-between">
              <h2 class="font-bold text-lg">Programs</h2>
              <button class="text-primary text-sm font-semibold" @click="goPrograms">View All</button>
            </div>

            <div
              v-for="program in store.programs"
              :key="program.id"
              class="bg-slate-200 dark:bg-surface-dark rounded-xl p-4 border border-slate-300 dark:border-neutral-dark"
            >
              <div class="flex items-center justify-between mb-4">
                <div class="flex items-center gap-3">
                  <div class="size-10 rounded-lg bg-primary/10 flex items-center justify-center text-primary">
                    <span class="material-symbols-outlined">fitness_center</span>
                  </div>
                  <div>
                    <h4 class="font-bold text-sm">{{ program.name }}</h4>
                    <p class="text-xs text-slate-500 dark:text-slate-400">
                      {{ program.exercises.length }} exercises
                    </p>
                  </div>
                </div>
                <button class="text-primary text-sm font-semibold" @click="startProgram(program.id)">Start</button>
              </div>
            </div>

            <div v-if="!store.programs.length" class="text-sm text-slate-500 dark:text-slate-400">
              No programs yet. Create one in Programs.
            </div>
          </section>
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

function startProgram (programId) {
  const session = store.startSessionFromProgram(programId)
  if (session) {
    router.push(`/workout/${session.id}`)
  }
}

function startEmpty () {
  const session = store.startEmptySession()
  router.push(`/workout/${session.id}`)
}

function goPrograms () {
  router.push('/programs')
}
</script>
