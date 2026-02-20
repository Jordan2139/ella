<template>
  <q-layout view="lHh Lpr lFf" class="stitch-layout">
    <q-page-container>
      <router-view />
    </q-page-container>

    <footer class="fixed bottom-0 w-full bg-background-light dark:bg-background-dark border-t border-primary/20 px-4 pb-6 pt-2 z-20">
      <div class="flex justify-between items-center max-w-lg mx-auto">
        <a :class="navClass('/start')" href="#/start">
          <span class="material-symbols-outlined text-2xl" :style="navFill('/start')">home</span>
          <p class="text-[10px] font-bold uppercase tracking-wider">Home</p>
        </a>
        <a :class="navClass('/workout-history')" href="#/workout-history">
          <span class="material-symbols-outlined text-2xl" :style="navFill('/workout-history')">history</span>
          <p class="text-[10px] font-bold uppercase tracking-wider">History</p>
        </a>
        <a :class="navClass('/body-insights')" href="#/body-insights">
          <span class="material-symbols-outlined text-2xl" :style="navFill('/body-insights')">monitoring</span>
          <p class="text-[10px] font-bold uppercase tracking-wider">Body</p>
        </a>
        <a :class="navClass('/profile')" href="#/profile">
          <span class="material-symbols-outlined text-2xl" :style="navFill('/profile')">person</span>
          <p class="text-[10px] font-bold uppercase tracking-wider">Profile</p>
        </a>
      </div>
    </footer>
  </q-layout>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()
const activePath = computed(() => route.path)

const baseClass = 'flex flex-1 flex-col items-center justify-center gap-1 transition-colors'

function isActive (path) {
  return activePath.value === path
}

function navClass (path) {
  return `${baseClass} ${isActive(path) ? 'text-primary' : 'text-slate-500 hover:text-primary'}`
}

function navFill (path) {
  return isActive(path) ? "font-variation-settings:'FILL' 1" : ''
}
</script>
