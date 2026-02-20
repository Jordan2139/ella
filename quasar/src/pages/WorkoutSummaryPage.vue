<template>
  <q-page class="stitch-page">
    <div class="stitch-theme-workout-details dark bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">
      <header class="sticky top-0 z-10 flex items-center justify-between bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-md px-4 py-4 border-b border-primary/10">
        <div class="flex items-center gap-3">
          <button class="flex items-center justify-center size-10 rounded-full hover:bg-primary/10 transition-colors" @click="goBack">
            <span class="material-symbols-outlined text-slate-900 dark:text-slate-100">arrow_back</span>
          </button>
          <h1 class="text-lg font-bold">Workout Summary</h1>
        </div>
      </header>

      <main class="flex-1 overflow-y-auto pb-24">
        <div v-if="!session" class="p-4 text-sm text-slate-500">No session found.</div>

        <template v-else>
          <div class="p-4 flex flex-col gap-2">
            <div class="flex items-start justify-between">
              <div>
                <h2 class="text-2xl font-bold tracking-tight">{{ session.programName }}</h2>
                <div class="flex items-center gap-2 mt-1 text-slate-500 dark:text-slate-400 text-sm">
                  <span class="material-symbols-outlined text-sm">calendar_today</span>
                  <span>{{ formatDate(session.startedAt) }}</span>
                </div>
              </div>
              <div class="bg-primary/20 text-primary px-3 py-1 rounded-full text-xs font-bold uppercase tracking-wider">
                Completed
              </div>
            </div>
          </div>

          <div class="px-4 py-4">
            <div class="bg-white dark:bg-primary/5 border border-primary/10 rounded-xl p-4">
              <div class="flex items-center justify-between mb-4">
                <h3 class="font-bold text-sm uppercase tracking-wide flex items-center gap-2">
                  <span class="material-symbols-outlined text-primary text-lg">monitoring</span>
                  Reflection
                </h3>
              </div>
              <textarea
                class="w-full bg-background-dark/30 border border-primary/10 rounded-lg px-3 py-2 text-sm text-slate-300 focus:outline-none focus:border-primary/40 resize-none"
                rows="2"
                v-model="reflection"
                placeholder="Add a post-workout reflection"
              ></textarea>
              <button
                class="mt-3 px-4 py-2 rounded-full border border-primary/30 text-primary text-xs"
                @click="saveReflection"
              >
                Save Reflection
              </button>
            </div>
          </div>

          <div class="px-4 py-2 flex flex-col gap-4">
            <h3 class="font-bold text-sm uppercase tracking-wide px-1">Exercises Breakdown</h3>
            <div
              v-for="entry in session.entries"
              :key="entry.id"
              class="bg-white dark:bg-primary/5 border border-primary/10 rounded-xl p-4"
            >
              <div class="flex justify-between items-start mb-4">
                <div class="flex items-center gap-3">
                  <div class="size-10 bg-primary/20 rounded-lg flex items-center justify-center text-primary">
                    <span class="material-symbols-outlined">fitness_center</span>
                  </div>
                  <div>
                    <h4 class="font-bold text-base">{{ exerciseName(entry.exerciseId) }}</h4>
                    <p class="text-xs text-slate-500 dark:text-slate-400">{{ entry.sets.length }} Sets</p>
                  </div>
                </div>
              </div>
              <div class="space-y-2">
                <div
                  v-for="(set, index) in entry.sets"
                  :key="set.id"
                  class="flex items-center justify-between py-2 border-b border-primary/5 text-sm last:border-0"
                >
                  <span class="text-slate-500 dark:text-slate-400 font-medium">Set {{ index + 1 }}</span>
                  <div class="flex gap-4">
                    <span class="font-bold">{{ set.weight }} kg</span>
                    <span class="text-primary font-bold">{{ set.reps }} Reps</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </template>
      </main>
    </div>
  </q-page>
</template>

<script setup>
import { computed, ref, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useWorkoutStore } from 'src/stores/workout-store'

const route = useRoute()
const router = useRouter()
const store = useWorkoutStore()

const sessionId = computed(() => route.params.id)
const session = computed(() => store.sessionById(sessionId.value))
const reflection = ref('')

watch(session, (value) => {
  reflection.value = value?.postWorkoutReflection || ''
}, { immediate: true })

function saveReflection () {
  if (!session.value) return
  store.setSessionReflection(session.value.id, reflection.value)
}

function exerciseName (exerciseId) {
  return store.exerciseById(exerciseId)?.name || 'Unknown Exercise'
}

function formatDate (value) {
  return new Date(value).toLocaleString()
}

function goBack () {
  router.push('/start')
}
</script>
