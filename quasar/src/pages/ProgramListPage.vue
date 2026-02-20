<template>
  <q-page class="stitch-page">
    <div class="stitch-theme-edit-workouts dark bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">
      <header class="sticky top-0 z-10 bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-md px-4 py-4 border-b border-primary/10">
        <div class="flex items-center justify-between max-w-2xl mx-auto w-full">
          <h1 class="text-xl font-bold tracking-tight">Programs</h1>
          <button class="text-primary font-semibold hover:opacity-80 transition-opacity" @click="showNewProgram = true">
            New
          </button>
        </div>
      </header>

      <main class="flex-1 max-w-2xl mx-auto w-full p-4 space-y-6 pb-24">
        <div class="flex items-center justify-between">
          <h2 class="text-lg font-bold">Your Programs</h2>
          <span class="text-xs font-medium text-slate-500 uppercase tracking-wider">Drag to reorder</span>
        </div>

        <Draggable v-model="store.programs" item-key="id" handle=".drag-handle" class="space-y-4" @end="reorderPrograms">
          <template #item="{ element: program }">
            <div class="bg-surface-dark rounded-xl border border-primary/5 overflow-hidden">
              <div class="p-4 flex items-center gap-4">
                <div class="cursor-grab active:cursor-grabbing text-primary/40 drag-handle">
                  <span class="material-symbols-outlined">drag_indicator</span>
                </div>
                <div class="flex-1">
                  <div class="flex items-center justify-between">
                    <h3 class="font-bold text-base">{{ program.name }}</h3>
                    <button class="text-slate-400 hover:text-primary transition-colors" @click="editProgram(program.id)">
                      <span class="material-symbols-outlined text-xl">edit</span>
                    </button>
                  </div>
                  <p class="text-sm text-slate-400">
                    {{ program.exercises.length }} exercises
                  </p>
                </div>
              </div>

              <div class="bg-black/20 px-4 py-2 space-y-1">
                <div
                  v-for="exerciseEntry in program.exercises"
                  :key="exerciseEntry.id"
                  class="flex items-center justify-between py-2 border-b border-white/5 last:border-0"
                >
                  <span class="text-sm">{{ exerciseName(exerciseEntry.exerciseId) }}</span>
                  <button class="text-slate-500 hover:text-red-400 transition-colors" @click="removeExercise(program.id, exerciseEntry.id)">
                    <span class="material-symbols-outlined text-lg">close</span>
                  </button>
                </div>
                <button
                  class="w-full flex items-center justify-center gap-2 py-3 text-primary text-sm font-medium hover:bg-primary/5 rounded-lg mt-2 transition-all"
                  @click="openPicker(program.id)"
                >
                  <span class="material-symbols-outlined text-sm">add_circle</span>
                  Add Exercise
                </button>
              </div>

              <div class="px-4 pb-4 flex items-center justify-between">
                <button class="text-primary text-sm font-semibold" @click="startProgram(program.id)">Start</button>
                <button class="text-red-400 text-sm font-semibold" @click="confirmDelete(program)">Delete</button>
              </div>
            </div>
          </template>
        </Draggable>

        <div v-if="!store.programs.length" class="text-sm text-slate-500">
          No programs yet. Create one to get started.
        </div>

        <button
          class="w-full py-4 border-2 border-dashed border-primary/20 rounded-xl flex items-center justify-center gap-2 text-primary/80 font-bold hover:bg-primary/5 hover:border-primary/40 transition-all"
          @click="showNewProgram = true"
        >
          <span class="material-symbols-outlined">add_box</span>
          Create New Program
        </button>
      </main>

      <ExercisePickerDialog v-model="showPicker" @select="addExercise" />
      <ConfirmDialog
        v-model="showDeleteConfirm"
        title="Delete program?"
        message="This will remove the program template."
        confirm-label="Delete"
        @confirm="deleteProgram"
      />

      <q-dialog v-model="showNewProgram">
        <q-card class="ella-card" style="min-width: 320px;">
          <q-card-section class="text-h6">New Program</q-card-section>
          <q-card-section>
            <q-input v-model="newProgramName" label="Program name" dense class="ella-input" />
          </q-card-section>
          <q-card-actions align="right">
            <q-btn flat label="Cancel" @click="showNewProgram = false" />
            <q-btn class="ella-btn-primary" label="Create" :disable="!newProgramName.trim()" @click="createProgram" />
          </q-card-actions>
        </q-card>
      </q-dialog>
    </div>
  </q-page>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { VueDraggableNext as Draggable } from 'vue-draggable-next'
import { useWorkoutStore } from 'src/stores/workout-store'
import ExercisePickerDialog from 'src/components/ExercisePickerDialog.vue'
import ConfirmDialog from 'src/components/ConfirmDialog.vue'

const router = useRouter()
const store = useWorkoutStore()

const showNewProgram = ref(false)
const newProgramName = ref('')
const showPicker = ref(false)
const activeProgramId = ref(null)
const showDeleteConfirm = ref(false)
const programPendingDelete = ref(null)

function createProgram () {
  const name = newProgramName.value.trim()
  if (!name) return
  const program = store.createProgram(name)
  newProgramName.value = ''
  showNewProgram.value = false
  router.push(`/programs/${program.id}`)
}

function editProgram (programId) {
  router.push(`/programs/${programId}`)
}

function startProgram (programId) {
  const session = store.startSessionFromProgram(programId)
  if (session) {
    router.push(`/workout/${session.id}`)
  }
}

function openPicker (programId) {
  activeProgramId.value = programId
  showPicker.value = true
}

function addExercise (exercise) {
  if (!activeProgramId.value) return
  store.addExerciseToProgram(activeProgramId.value, exercise.id)
}

function removeExercise (programId, exerciseEntryId) {
  store.removeExerciseFromProgram(programId, exerciseEntryId)
}

function confirmDelete (program) {
  programPendingDelete.value = program
  showDeleteConfirm.value = true
}

function deleteProgram () {
  if (programPendingDelete.value) {
    store.deleteProgram(programPendingDelete.value.id)
  }
  programPendingDelete.value = null
}

function reorderPrograms () {
  store.reorderPrograms(store.programs)
}

function exerciseName (exerciseId) {
  return store.exerciseById(exerciseId)?.name || 'Unknown Exercise'
}
</script>
