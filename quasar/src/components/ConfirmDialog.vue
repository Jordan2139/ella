<template>
  <q-dialog v-model="open">
    <q-card class="ella-card">
      <q-card-section class="text-h6">{{ title }}</q-card-section>
      <q-card-section class="text-body2 text-grey-7">{{ message }}</q-card-section>
      <q-card-actions align="right">
        <q-btn flat :label="cancelLabel" @click="open = false" />
        <q-btn :color="confirmColor" :label="confirmLabel" @click="confirm" />
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false
  },
  title: {
    type: String,
    default: 'Confirm'
  },
  message: {
    type: String,
    default: 'Are you sure?'
  },
  confirmLabel: {
    type: String,
    default: 'Confirm'
  },
  cancelLabel: {
    type: String,
    default: 'Cancel'
  },
  confirmColor: {
    type: String,
    default: 'negative'
  }
})

const emit = defineEmits(['update:modelValue', 'confirm'])

const open = computed({
  get: () => props.modelValue,
  set: (value) => emit('update:modelValue', value)
})

function confirm () {
  emit('confirm')
  open.value = false
}
</script>
