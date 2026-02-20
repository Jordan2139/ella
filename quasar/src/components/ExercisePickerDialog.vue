<template>
  <q-dialog v-model="open">
    <q-card class="exercise-picker ella-card">
      <q-card-section>
        <div class="text-h6">Add Exercise</div>
      </q-card-section>

      <q-card-section class="q-gutter-sm">
        <q-input v-model="filter" label="Search exercises" dense class="ella-input" />
        <q-input v-model="newName" label="New exercise name" dense class="ella-input" />
        <q-input v-model="newMuscleGroup" label="Muscle group (optional)" dense class="ella-input" />
        <q-btn
          class="ella-btn-primary"
          label="Add & Select"
          :disable="!newName.trim()"
          @click="createAndSelect"
        />
      </q-card-section>

      <q-separator />

      <q-card-section class="scroll">
        <q-list bordered separator class="ella-card-soft">
          <q-item
            v-for="exercise in filteredExercises"
            :key="exercise.id"
            clickable
            @click="selectExercise(exercise)"
          >
            <q-item-section>{{ exercise.name }}</q-item-section>
          </q-item>
        </q-list>
        <div v-if="!filteredExercises.length" class="text-caption text-grey-6 q-mt-sm">
          No matches yet.
        </div>
      </q-card-section>

      <q-card-actions align="right">
        <q-btn flat label="Close" @click="open = false" />
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { computed, ref, watch } from 'vue'
import { useWorkoutStore } from 'src/stores/workout-store'

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false
  }
})

const emit = defineEmits(['update:modelValue', 'select'])

const store = useWorkoutStore()
const open = computed({
  get: () => props.modelValue,
  set: (value) => emit('update:modelValue', value)
})

const filter = ref('')
const newName = ref('')
const newMuscleGroup = ref('')

const filteredExercises = computed(() => {
  const term = filter.value.trim().toLowerCase()
  if (!term) return store.exercises
  return store.exercises.filter((exercise) => exercise.name.toLowerCase().includes(term))
})

function selectExercise (exercise) {
  emit('select', exercise)
  open.value = false
}

function createAndSelect () {
  const exercise = store.createExercise(newName.value, newMuscleGroup.value)
  if (exercise) {
    emit('select', exercise)
    newName.value = ''
    newMuscleGroup.value = ''
    open.value = false
  }
}

watch(open, (value) => {
  if (!value) {
    filter.value = ''
    newName.value = ''
    newMuscleGroup.value = ''
  }
})
</script>

<style scoped>
.exercise-picker {
  width: min(520px, 90vw);
}
</style>
