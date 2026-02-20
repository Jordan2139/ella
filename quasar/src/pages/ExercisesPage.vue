<template>
  <q-page class="stitch-page">
    <div class="stitch-theme-user-profile dark bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">
      <div class="flex items-center bg-background-light dark:bg-background-dark p-4 sticky top-0 z-10 border-b border-primary/10">
        <div class="flex size-10 shrink-0 items-center justify-center rounded-full hover:bg-primary/10 cursor-pointer" @click="goBack">
          <span class="material-symbols-outlined text-slate-900 dark:text-slate-100">arrow_back</span>
        </div>
        <h2 class="text-lg font-bold leading-tight flex-1 text-center pr-10">Exercises</h2>
      </div>

      <div class="flex-1 overflow-y-auto pb-24">
        <div class="px-4 py-6">
          <div class="flex items-center justify-between pb-4">
            <h3 class="text-lg font-bold">Exercise Library</h3>
            <button class="text-primary text-sm font-medium" @click="openAddDialog">Add</button>
          </div>
          <div class="bg-primary/5 rounded-xl border border-primary/10 overflow-hidden">
            <div
              v-for="exercise in store.exercises"
              :key="exercise.id"
              class="flex items-center justify-between p-4 hover:bg-primary/10 cursor-pointer transition-colors group"
            >
              <div class="flex items-center gap-3">
                <span class="material-symbols-outlined text-primary">fitness_center</span>
                <div>
                  <div class="font-medium">{{ exercise.name }}</div>
                  <div class="text-xs text-slate-500">{{ exercise.muscleGroup || 'No muscle group' }}</div>
                </div>
              </div>
              <div class="flex items-center gap-2">
                <button class="text-slate-500 hover:text-primary transition-colors" @click="openEditDialog(exercise)">
                  <span class="material-symbols-outlined">edit</span>
                </button>
                <button class="text-slate-500 hover:text-red-400 transition-colors" @click="confirmDelete(exercise)">
                  <span class="material-symbols-outlined">delete</span>
                </button>
              </div>
            </div>

            <div v-if="!store.exercises.length" class="p-4 text-sm text-slate-500">
              No exercises yet.
            </div>
          </div>
        </div>
      </div>

      <q-dialog v-model="showExerciseDialog">
        <q-card class="ella-card" style="min-width: 320px;">
          <q-card-section class="text-h6">{{ dialogTitle }}</q-card-section>
          <q-card-section class="q-gutter-sm">
            <q-input v-model="exerciseName" label="Exercise name" dense class="ella-input" />
            <q-input v-model="exerciseMuscleGroup" label="Muscle group (optional)" dense class="ella-input" />
          </q-card-section>
          <q-card-actions align="right">
            <q-btn flat label="Cancel" @click="showExerciseDialog = false" />
            <q-btn class="ella-btn-primary" label="Save" :disable="!exerciseName.trim()" @click="saveExercise" />
          </q-card-actions>
        </q-card>
      </q-dialog>

      <ConfirmDialog
        v-model="showDeleteConfirm"
        title="Delete exercise?"
        message="This removes it from programs and sessions."
        confirm-label="Delete"
        @confirm="deleteExercise"
      />
    </div>
  </q-page>
</template>

<script setup>
import { computed, ref } from 'vue'
import { useRouter } from 'vue-router'
import { useWorkoutStore } from 'src/stores/workout-store'
import ConfirmDialog from 'src/components/ConfirmDialog.vue'

const router = useRouter()
const store = useWorkoutStore()

const showExerciseDialog = ref(false)
const editingExerciseId = ref(null)
const exerciseName = ref('')
const exerciseMuscleGroup = ref('')
const showDeleteConfirm = ref(false)
const exercisePendingDelete = ref(null)

const dialogTitle = computed(() => (editingExerciseId.value ? 'Edit Exercise' : 'Add Exercise'))

function goBack () {
  router.back()
}

function openAddDialog () {
  editingExerciseId.value = null
  exerciseName.value = ''
  exerciseMuscleGroup.value = ''
  showExerciseDialog.value = true
}

function openEditDialog (exercise) {
  editingExerciseId.value = exercise.id
  exerciseName.value = exercise.name
  exerciseMuscleGroup.value = exercise.muscleGroup || ''
  showExerciseDialog.value = true
}

function saveExercise () {
  if (!exerciseName.value.trim()) return
  if (editingExerciseId.value) {
    store.updateExercise(editingExerciseId.value, {
      name: exerciseName.value,
      muscleGroup: exerciseMuscleGroup.value
    })
  } else {
    store.createExercise(exerciseName.value, exerciseMuscleGroup.value)
  }
  showExerciseDialog.value = false
}

function confirmDelete (exercise) {
  exercisePendingDelete.value = exercise
  showDeleteConfirm.value = true
}

function deleteExercise () {
  if (exercisePendingDelete.value) {
    store.deleteExercise(exercisePendingDelete.value.id)
  }
  exercisePendingDelete.value = null
}
</script>
