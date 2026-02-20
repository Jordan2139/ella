<template>
  <q-page class="stitch-page">
    <div class="stitch-theme-active-workout dark bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen flex flex-col font-display">
      <div v-if="!session" class="p-6 text-sm text-slate-500">No active workout.</div>

      <div v-else class="flex flex-col min-h-screen">
        <header class="sticky top-0 z-10 bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-md border-b border-primary/10 px-4 py-4 flex items-center justify-between">
          <div class="flex items-center gap-3">
            <button class="p-2 hover:bg-primary/10 rounded-full transition-colors" @click="goBack">
              <span class="material-symbols-outlined text-slate-900 dark:text-slate-100">arrow_back</span>
            </button>
            <div>
              <h1 class="text-lg font-bold leading-tight">{{ session.programName }}</h1>
              <p class="text-xs text-primary font-medium uppercase tracking-wider">Active Session</p>
            </div>
          </div>
          <button class="text-primary font-bold text-sm hover:underline" @click="finishWorkout">
            Finish Workout
          </button>
        </header>

        <main class="flex-1 overflow-y-auto px-4 py-6 space-y-8 no-scrollbar pb-32">
          <section class="bg-primary/10 border border-primary/20 rounded-xl p-4 flex items-center justify-between">
            <div>
              <h3 class="text-sm font-semibold uppercase tracking-widest text-primary/80">Rest Timer</h3>
              <div class="text-2xl font-bold">{{ formattedRest }}</div>
              <p class="text-xs text-slate-400">Auto updates Live Activity</p>
            </div>
            <div class="flex flex-col gap-2">
              <button
                class="flex items-center gap-2 px-4 py-2 rounded-full border border-primary/30 text-primary font-bold text-sm hover:bg-primary/10 transition-colors"
                @click="startRest(90)"
              >
                <span class="material-symbols-outlined text-sm">timer</span>
                Start 90s
              </button>
              <button
                class="flex items-center gap-2 px-4 py-2 rounded-full border border-primary/30 text-primary font-bold text-sm hover:bg-primary/10 transition-colors"
                @click="skipRest"
              >
                <span class="material-symbols-outlined text-sm">skip_next</span>
                Skip
              </button>
            </div>
          </section>

          <section class="flex items-center justify-between">
            <h3 class="text-sm font-semibold uppercase tracking-widest text-primary/80">Exercises</h3>
            <button class="text-primary text-sm font-semibold" @click="showPicker = true">Add Exercise</button>
          </section>

          <Draggable v-model="session.entries" item-key="id" handle=".drag-handle" class="space-y-8" @end="reorderEntries">
            <template #item="{ element: entry }">
              <section class="space-y-4">
            <div class="flex items-center justify-between">
              <div>
                <h3 class="text-base font-bold">{{ exerciseName(entry.exerciseId) }}</h3>
                <p class="text-xs text-slate-500">{{ exerciseMuscleGroup(entry.exerciseId) || 'No muscle group' }}</p>
              </div>
              <div class="flex items-center gap-2">
                <span class="material-symbols-outlined text-slate-500 drag-handle">drag_indicator</span>
                <button class="text-primary text-xs font-semibold" @click="swapExercise(entry)">
                  Swap
                </button>
                <button class="text-red-400 text-xs font-semibold" @click="removeExercise(entry.id)">
                  Remove
                </button>
              </div>
            </div>

            <div class="flex items-center gap-2 text-xs text-slate-400">
              <span v-if="lastReason(entry.exerciseId)" class="ella-chip">Last mod: {{ lastReason(entry.exerciseId) }}</span>
              <span v-if="lastReflection" class="ella-chip">Last reflection: {{ lastReflection }}</span>
            </div>

            <div class="flex items-center gap-2">
              <button class="px-3 py-1 rounded-full border border-primary/30 text-primary text-xs" @click="applyFatigue(entry.id, -2.5)">
                -2.5kg
              </button>
              <button class="px-3 py-1 rounded-full border border-primary/30 text-primary text-xs" @click="applyFatigue(entry.id, 2.5)">
                +2.5kg
              </button>
              <button class="px-3 py-1 rounded-full border border-primary/30 text-primary text-xs" @click="setReason(entry.id, 'Fatigue adjustment')">
                Fatigue Reason
              </button>
            </div>

            <div class="space-y-3">
              <Draggable v-model="entry.sets" item-key="id" handle=".drag-handle" @end="reorderSets(entry)">
                <template #item="{ element: set, index }">
                  <div class="bg-primary/10 border border-primary/20 rounded-xl p-4 flex flex-col gap-4">
                <div class="flex items-center justify-between">
                  <div class="flex items-center gap-3">
                    <span class="w-6 h-6 rounded-full bg-primary text-background-dark text-[10px] flex items-center justify-center font-bold">
                      {{ index + 1 }}
                    </span>
                    <span class="text-sm font-bold">Set</span>
                  </div>
                  <div class="flex items-center gap-2">
                    <span class="material-symbols-outlined text-slate-500 drag-handle">drag_indicator</span>
                    <label class="text-xs text-primary/60">Done</label>
                    <input type="checkbox" v-model="set.isCompleted" @change="updateSet(entry.id, set)" />
                    <button class="text-slate-500 hover:text-red-400" @click="removeSet(entry.id, set.id)">
                      <span class="material-symbols-outlined text-lg">close</span>
                    </button>
                  </div>
                </div>
                <div class="grid grid-cols-2 gap-4">
                  <div class="space-y-1">
                    <label class="text-[10px] uppercase font-bold text-primary/60 ml-1">Weight</label>
                    <input
                      class="w-full bg-background-dark/50 border border-primary/30 rounded-lg px-3 py-2 text-slate-100 focus:outline-none focus:ring-2 focus:ring-primary/50 transition-all font-bold text-lg"
                      type="number"
                      v-model.number="set.weight"
                      @input="updateSet(entry.id, set)"
                    />
                  </div>
                  <div class="space-y-1">
                    <label class="text-[10px] uppercase font-bold text-primary/60 ml-1">Reps</label>
                    <input
                      class="w-full bg-background-dark/50 border border-primary/30 rounded-lg px-3 py-2 text-slate-100 focus:outline-none focus:ring-2 focus:ring-primary/50 transition-all font-bold text-lg"
                      type="number"
                      v-model.number="set.reps"
                      @input="updateSet(entry.id, set)"
                    />
                  </div>
                </div>
                <div class="space-y-1">
                  <label class="text-[10px] uppercase font-bold text-primary/60 ml-1">Notes</label>
                  <textarea
                    class="w-full bg-background-dark/30 border border-primary/10 rounded-lg px-3 py-2 text-sm text-slate-300 focus:outline-none focus:border-primary/40 resize-none"
                    rows="1"
                    v-model="set.note"
                    @input="updateSet(entry.id, set)"
                  ></textarea>
                </div>
                <div class="flex items-center gap-2 text-xs text-slate-400">
                  <label>Warmup</label>
                  <input type="checkbox" v-model="set.isWarmup" @change="updateSet(entry.id, set)" />
                </div>
                  </div>
                </template>
              </Draggable>
            </div>

            <div class="flex items-center gap-3">
              <button
                class="flex items-center gap-2 px-4 py-2 rounded-full border border-primary/30 text-primary font-bold text-sm hover:bg-primary/10 transition-colors"
                @click="addSet(entry.id)"
              >
                <span class="material-symbols-outlined text-sm">add</span>
                Add Set
              </button>
              <button
                class="flex items-center gap-2 px-4 py-2 rounded-full border border-primary/30 text-primary font-bold text-sm hover:bg-primary/10 transition-colors"
                @click="openReasonPicker(entry)"
              >
                <span class="material-symbols-outlined text-sm">edit_note</span>
                Reason
              </button>
            </div>
              </section>
            </template>
          </Draggable>
        </main>

        <div class="fixed bottom-0 left-0 right-0 bg-background-light/90 dark:bg-background-dark/90 backdrop-blur-lg border-t border-primary/10 px-4 pt-4 pb-8 flex flex-col gap-4">
          <button
            class="w-full bg-primary hover:bg-primary/90 text-background-dark font-bold py-4 rounded-xl shadow-[0_0_20px_rgba(255,209,220,0.3)] transition-all flex items-center justify-center gap-2"
            @click="finishWorkout"
          >
            Finish Workout
            <span class="material-symbols-outlined">timer</span>
          </button>
        </div>
      </div>

      <ExercisePickerDialog v-model="showPicker" @select="addExercise" />

      <q-dialog v-model="showReasonDialog">
        <q-card class="ella-card" style="min-width: 320px;">
          <q-card-section class="text-h6">Modification Reason</q-card-section>
          <q-card-section class="q-gutter-sm">
            <q-select
              v-model="selectedReason"
              :options="reasonOptions"
              dense
              label="Quick pick"
              class="ella-input"
            />
            <q-input v-model="customReason" label="Custom reason" dense class="ella-input" />
          </q-card-section>
          <q-card-actions align="right">
            <q-btn flat label="Cancel" @click="showReasonDialog = false" />
            <q-btn class="ella-btn-primary" label="Save" @click="saveReason" />
          </q-card-actions>
        </q-card>
      </q-dialog>
    </div>
  </q-page>
</template>

<script setup>
import { computed, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { computed, onBeforeUnmount, ref } from 'vue'
import { VueDraggableNext as Draggable } from 'vue-draggable-next'
import { useWorkoutStore } from 'src/stores/workout-store'
import ExercisePickerDialog from 'src/components/ExercisePickerDialog.vue'
import { getLastModificationReason, getLastReflection } from 'src/services/history-lookup'
import { startRestActivity, updateRestActivity, endRestActivity } from 'src/services/live-activities'

const route = useRoute()
const router = useRouter()
const store = useWorkoutStore()
const showPicker = ref(false)
const showReasonDialog = ref(false)
const reasonEntryId = ref(null)
const selectedReason = ref('')
const customReason = ref('')
const reasonOptions = ['Felt heavy', 'Too easy', 'Fatigue adjustment', 'Form tweak', 'Tempo change']
const restRemaining = ref(0)
const restActivityId = ref(null)
let restInterval = null
let lastActivityTick = 0

const sessionId = computed(() => route.params.id || store.activeSessionId)
const session = computed(() => (sessionId.value ? store.sessionById(sessionId.value) : null))
const lastReflection = computed(() => getLastReflection(store.sessions, sessionId.value))
const formattedRest = computed(() => {
  const total = restRemaining.value
  const mins = Math.floor(total / 60).toString().padStart(2, '0')
  const secs = Math.floor(total % 60).toString().padStart(2, '0')
  return `${mins}:${secs}`
})

function addExercise (exercise) {
  if (!session.value) return
  store.addExerciseToSession(session.value.id, exercise.id)
}

function removeExercise (exerciseEntryId) {
  if (!session.value) return
  store.removeExerciseFromSession(session.value.id, exerciseEntryId)
}

function addSet (exerciseEntryId) {
  if (!session.value) return
  store.addSetToSessionExercise(session.value.id, exerciseEntryId)
}

function removeSet (exerciseEntryId, setId) {
  if (!session.value) return
  store.removeSetFromSessionExercise(session.value.id, exerciseEntryId, setId)
}

function updateSet (exerciseEntryId, set) {
  if (!session.value) return
  store.updateSessionSet(session.value.id, exerciseEntryId, set.id, {
    reps: set.reps,
    weight: set.weight,
    isWarmup: set.isWarmup,
    isCompleted: set.isCompleted,
    note: set.note
  })
}

function swapExercise (entry) {
  if (!store.exercises.length || !session.value) return
  const currentIndex = store.exercises.findIndex((exercise) => exercise.id === entry.exerciseId)
  const next = store.exercises[(currentIndex + 1) % store.exercises.length]
  store.updateSessionEntry(session.value.id, entry.id, {
    exerciseId: next.id,
    modificationReason: 'Swapped exercise'
  })
}

function setReason (entryId, reason) {
  if (!session.value) return
  store.updateSessionEntry(session.value.id, entryId, {
    modificationReason: reason
  })
}

function applyFatigue (entryId, delta) {
  if (!session.value) return
  store.applyFatigueAdjustment(session.value.id, entryId, delta)
}

function openReasonPicker (entry) {
  reasonEntryId.value = entry.id
  selectedReason.value = entry.modificationReason || ''
  customReason.value = ''
  showReasonDialog.value = true
}

function saveReason () {
  if (!session.value || !reasonEntryId.value) return
  const reason = customReason.value.trim() || selectedReason.value
  store.updateSessionEntry(session.value.id, reasonEntryId.value, {
    modificationReason: reason
  })
  showReasonDialog.value = false
}

function finishWorkout () {
  if (!session.value) return
  stopRest()
  store.endSession(session.value.id)
  router.replace(`/workout-summary/${session.value.id}`)
}

function reorderEntries () {
  if (!session.value) return
  store.reorderSessionEntries(session.value.id, session.value.entries)
}

function reorderSets (entry) {
  if (!session.value) return
  store.reorderSessionSets(session.value.id, entry.id, entry.sets)
}

function goBack () {
  router.back()
}

function tickRest () {
  if (restRemaining.value <= 0) {
    stopRest()
    return
  }
  restRemaining.value -= 1
  const now = Date.now()
  if (restActivityId.value && now - lastActivityTick > 10000) {
    lastActivityTick = now
    updateRestActivity(restActivityId.value, formattedRest.value)
  }
}

async function startRest (durationSeconds) {
  restRemaining.value = durationSeconds
  if (restInterval) {
    clearInterval(restInterval)
  }
  restInterval = setInterval(tickRest, 1000)
  lastActivityTick = Date.now()
  restActivityId.value = await startRestActivity({
    title: 'Rest Timer',
    subtitle: session.value?.programName || 'Workout',
    remaining: formattedRest.value
  })
}

function stopRest () {
  if (restInterval) {
    clearInterval(restInterval)
    restInterval = null
  }
  if (restActivityId.value) {
    endRestActivity(restActivityId.value, 'Done')
    restActivityId.value = null
  }
  restRemaining.value = 0
}

function skipRest () {
  stopRest()
}

onBeforeUnmount(() => {
  stopRest()
})

function exerciseName (exerciseId) {
  return store.exerciseById(exerciseId)?.name || 'Unknown Exercise'
}

function exerciseMuscleGroup (exerciseId) {
  return store.exerciseById(exerciseId)?.muscleGroup || ''
}

function lastReason (exerciseId) {
  return getLastModificationReason(store.sessions, exerciseId, sessionId.value)
}
</script>
