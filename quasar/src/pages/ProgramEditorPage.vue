<template>
  <q-page class="stitch-page">
    <div class="stitch-theme-edit-workouts dark bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">
      <header class="sticky top-0 z-10 bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-md px-4 py-4 border-b border-primary/10">
        <div class="flex items-center justify-between max-w-2xl mx-auto w-full">
          <h1 class="text-xl font-bold tracking-tight">{{ program?.name || 'Program' }}</h1>
          <button class="text-primary font-semibold hover:opacity-80 transition-opacity" @click="openRenameDialog">
            Rename
          </button>
        </div>
      </header>

      <main class="flex-1 max-w-2xl mx-auto w-full p-4 space-y-6 pb-24">
        <div class="flex items-center justify-between">
          <h2 class="text-lg font-bold">Exercises</h2>
          <span class="text-xs font-medium text-slate-500 uppercase tracking-wider">Drag to reorder</span>
        </div>

        <div v-if="!program" class="text-sm text-slate-500">Loading program...</div>

        <div v-else>
          <Draggable
            v-model="program.exercises"
            item-key="id"
            handle=".drag-handle"
            class="space-y-4"
            @end="reorderExercises"
          >
            <template #item="{ element: exerciseEntry }">
              <div class="bg-surface-dark rounded-xl border border-primary/5 overflow-hidden">
            <div class="p-4 flex items-center gap-4">
              <div class="cursor-grab active:cursor-grabbing text-primary/40 drag-handle">
                <span class="material-symbols-outlined">drag_indicator</span>
              </div>
              <div class="flex-1">
                <div class="flex items-center justify-between">
                  <h3 class="font-bold text-base">{{ exerciseName(exerciseEntry.exerciseId) }}</h3>
                  <button class="text-slate-400 hover:text-primary transition-colors" @click="openEditExercise(exerciseEntry.exerciseId)">
                    <span class="material-symbols-outlined text-xl">edit</span>
                  </button>
                </div>
                <p class="text-sm text-slate-400">{{ exerciseMuscleGroup(exerciseEntry.exerciseId) || 'No muscle group' }}</p>
              </div>
            </div>

            <div class="bg-black/20 px-4 py-2 space-y-2">
              <Draggable
                v-model="exerciseEntry.sets"
                item-key="id"
                handle=".drag-handle"
                @end="reorderSets(exerciseEntry)"
              >
                <template #item="{ element: set }">
                  <div class="flex items-center justify-between py-2 border-b border-white/5 last:border-0">
                <div class="grid grid-cols-2 gap-3 flex-1 pr-4">
                  <div class="space-y-1">
                    <label class="text-[10px] uppercase font-bold text-primary/60 ml-1">Reps</label>
                    <input
                      class="w-full bg-background-dark/30 border border-primary/10 rounded-lg px-3 py-2 text-sm text-slate-200 focus:outline-none focus:border-primary/40"
                      type="number"
                      v-model.number="set.reps"
                      @input="updateSet(exerciseEntry.id, set)"
                    />
                  </div>
                  <div class="space-y-1">
                    <label class="text-[10px] uppercase font-bold text-primary/60 ml-1">Weight</label>
                    <input
                      class="w-full bg-background-dark/30 border border-primary/10 rounded-lg px-3 py-2 text-sm text-slate-200 focus:outline-none focus:border-primary/40"
                      type="number"
                      v-model.number="set.weight"
                      @input="updateSet(exerciseEntry.id, set)"
                    />
                  </div>
                </div>
                <div class="flex items-center gap-2">
                  <span class="material-symbols-outlined text-slate-500 drag-handle">drag_indicator</span>
                  <label class="text-xs text-slate-400">Warmup</label>
                  <input type="checkbox" v-model="set.isWarmup" @change="updateSet(exerciseEntry.id, set)" />
                  <button class="text-slate-500 hover:text-red-400 transition-colors" @click="removeSet(exerciseEntry.id, set.id)">
                    <span class="material-symbols-outlined text-lg">close</span>
                  </button>
                </div>
                  </div>
                </template>
              </Draggable>
              <button
                class="w-full flex items-center justify-center gap-2 py-3 text-primary text-sm font-medium hover:bg-primary/5 rounded-lg mt-2 transition-all"
                @click="addSet(exerciseEntry.id)"
              >
                <span class="material-symbols-outlined text-sm">add_circle</span>
                Add Set
              </button>
            </div>
              </div>
            </template>
          </Draggable>

          <button
            class="w-full py-4 border-2 border-dashed border-primary/20 rounded-xl flex items-center justify-center gap-2 text-primary/80 font-bold hover:bg-primary/5 hover:border-primary/40 transition-all"
            @click="showPicker = true"
          >
            <span class="material-symbols-outlined">add_box</span>
            Add Exercise
          </button>
        </div>
      </main>

      <ExercisePickerDialog v-model="showPicker" @select="addExercise" />

      <q-dialog v-model="showRenameDialog">
        <q-card class="ella-card" style="min-width: 320px;">
          <q-card-section class="text-h6">Rename Program</q-card-section>
          <q-card-section>
            <q-input v-model="renameValue" label="Program name" dense class="ella-input" />
          </q-card-section>
          <q-card-actions align="right">
            <q-btn flat label="Cancel" @click="showRenameDialog = false" />
            <q-btn class="ella-btn-primary" label="Save" :disable="!renameValue.trim()" @click="renameProgram" />
          </q-card-actions>
        </q-card>
      </q-dialog>

      <q-dialog v-model="showEditExerciseDialog">
        <q-card class="ella-card" style="min-width: 320px;">
          <q-card-section class="text-h6">Edit Exercise</q-card-section>
          <q-card-section class="q-gutter-sm">
            <q-input v-model="editExerciseName" label="Exercise name" dense class="ella-input" />
            <q-input v-model="editExerciseMuscle" label="Muscle group" dense class="ella-input" />
          </q-card-section>
          <q-card-actions align="right">
            <q-btn flat label="Cancel" @click="showEditExerciseDialog = false" />
            <q-btn class="ella-btn-primary" label="Save" :disable="!editExerciseName.trim()" @click="saveExerciseEdit" />
          </q-card-actions>
        </q-card>
      </q-dialog>
    </div>
  </q-page>
</template>

<script setup>
import { computed, ref, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { VueDraggableNext as Draggable } from 'vue-draggable-next'
import { useWorkoutStore } from 'src/stores/workout-store'
import ExercisePickerDialog from 'src/components/ExercisePickerDialog.vue'

const route = useRoute()
const router = useRouter()
const store = useWorkoutStore()
const showPicker = ref(false)
const showRenameDialog = ref(false)
const renameValue = ref('')
const showEditExerciseDialog = ref(false)
const editExerciseId = ref(null)
const editExerciseName = ref('')
const editExerciseMuscle = ref('')

const programId = computed(() => route.params.id)
const program = computed(() => store.programById(programId.value))

watch([programId, () => store.loaded], () => {
  if (!store.loaded) return
  if (programId.value === 'new') {
    const created = store.createProgram('New Program')
    router.replace(`/programs/${created.id}`)
    return
  }
  if (!program.value) {
    router.replace('/programs')
  }
}, { immediate: true })

function addExercise (exercise) {
  if (!program.value) return
  store.addExerciseToProgram(program.value.id, exercise.id)
}

function addSet (exerciseEntryId) {
  if (!program.value) return
  store.addSetToProgramExercise(program.value.id, exerciseEntryId)
}

function removeSet (exerciseEntryId, setId) {
  if (!program.value) return
  store.removeSetFromProgramExercise(program.value.id, exerciseEntryId, setId)
}

function updateSet (exerciseEntryId, set) {
  if (!program.value) return
  store.updateProgramSet(program.value.id, exerciseEntryId, set.id, {
    reps: set.reps,
    weight: set.weight,
    isWarmup: set.isWarmup
  })
}

function reorderExercises () {
  if (!program.value) return
  store.reorderProgramExercises(program.value.id, program.value.exercises)
}

function reorderSets (exerciseEntry) {
  if (!program.value) return
  store.reorderProgramSets(program.value.id, exerciseEntry.id, exerciseEntry.sets)
}

function openRenameDialog () {
  if (!program.value) return
  renameValue.value = program.value.name
  showRenameDialog.value = true
}

function renameProgram () {
  if (!program.value) return
  store.renameProgram(program.value.id, renameValue.value.trim())
  showRenameDialog.value = false
}

function openEditExercise (exerciseId) {
  const exercise = store.exerciseById(exerciseId)
  if (!exercise) return
  editExerciseId.value = exerciseId
  editExerciseName.value = exercise.name
  editExerciseMuscle.value = exercise.muscleGroup || ''
  showEditExerciseDialog.value = true
}

function saveExerciseEdit () {
  if (!editExerciseId.value) return
  store.updateExercise(editExerciseId.value, {
    name: editExerciseName.value,
    muscleGroup: editExerciseMuscle.value
  })
  showEditExerciseDialog.value = false
}

function exerciseName (exerciseId) {
  return store.exerciseById(exerciseId)?.name || 'Unknown Exercise'
}

function exerciseMuscleGroup (exerciseId) {
  return store.exerciseById(exerciseId)?.muscleGroup || ''
}
</script>
