<template>
  <q-page class="stitch-page">
    <div class="stitch-theme-user-profile dark bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">
      <div class="flex items-center bg-background-light dark:bg-background-dark p-4 sticky top-0 z-10 border-b border-primary/10">
        <div class="flex size-10 shrink-0 items-center justify-center rounded-full hover:bg-primary/10 cursor-pointer" @click="goBack">
          <span class="material-symbols-outlined text-slate-900 dark:text-slate-100">arrow_back</span>
        </div>
        <h2 class="text-lg font-bold leading-tight flex-1 text-center pr-10">Profile</h2>
      </div>

      <div class="flex-1 overflow-y-auto pb-24">
        <div class="flex p-6 flex-col items-center gap-4">
          <div class="relative" @click="openEditProfile">
            <div class="bg-center bg-no-repeat aspect-square bg-cover rounded-full h-32 w-32 ring-4 ring-primary/20 ring-offset-4 ring-offset-background-dark bg-slate-700"></div>
            <div class="absolute bottom-0 right-0 bg-primary p-1.5 rounded-full border-4 border-background-dark">
              <span class="material-symbols-outlined text-background-dark text-sm block">edit</span>
            </div>
          </div>
          <div class="flex flex-col items-center text-center">
            <p class="text-2xl font-bold tracking-tight">{{ profileName }}</p>
            <p class="text-primary/80 text-sm font-medium">{{ profileTagline }}</p>
          </div>
        </div>

        <div class="px-4 py-2">
          <h3 class="text-lg font-bold px-2 pb-4">My Stats</h3>
          <div class="grid grid-cols-3 gap-3">
            <div class="flex flex-col items-center justify-center gap-1 rounded-xl p-4 bg-primary/5 border border-primary/10">
              <p class="text-xs font-medium text-slate-500 dark:text-slate-400 uppercase tracking-wider text-center">Workouts</p>
              <p class="text-primary text-2xl font-bold leading-tight">{{ totalWorkouts }}</p>
            </div>
            <div class="flex flex-col items-center justify-center gap-1 rounded-xl p-4 bg-primary/5 border border-primary/10">
              <p class="text-xs font-medium text-slate-500 dark:text-slate-400 uppercase tracking-wider text-center">Completed Sets</p>
              <p class="text-primary text-2xl font-bold leading-tight">{{ completedSets }}</p>
            </div>
            <div class="flex flex-col items-center justify-center gap-1 rounded-xl p-4 bg-primary/5 border border-primary/10">
              <p class="text-xs font-medium text-slate-500 dark:text-slate-400 uppercase tracking-wider text-center">Streak</p>
              <p class="text-primary text-2xl font-bold leading-tight">{{ streakDays }}d</p>
            </div>
          </div>
        </div>

        <div class="py-6">
          <div class="flex items-center justify-between px-6 pb-4">
            <h3 class="text-lg font-bold">Achievements</h3>
            <a class="text-primary text-sm font-medium" href="#">View All</a>
          </div>
          <div class="flex overflow-x-auto gap-4 px-6 no-scrollbar">
            <div class="flex flex-col items-center gap-2 min-w-[80px]">
              <div class="size-16 rounded-full bg-primary/20 flex items-center justify-center border-2 border-primary">
                <span class="material-symbols-outlined text-primary text-3xl fill">wb_sunny</span>
              </div>
              <p class="text-[10px] font-semibold text-center uppercase">Early Bird</p>
            </div>
            <div class="flex flex-col items-center gap-2 min-w-[80px]">
              <div class="size-16 rounded-full bg-primary/20 flex items-center justify-center border-2 border-primary">
                <span class="material-symbols-outlined text-primary text-3xl fill">directions_run</span>
              </div>
              <p class="text-[10px] font-semibold text-center uppercase">5K Runner</p>
            </div>
            <div class="flex flex-col items-center gap-2 min-w-[80px]">
              <div class="size-16 rounded-full bg-primary/20 flex items-center justify-center border-2 border-primary">
                <span class="material-symbols-outlined text-primary text-3xl fill">calendar_month</span>
              </div>
              <p class="text-[10px] font-semibold text-center uppercase">Consistent</p>
            </div>
          </div>
        </div>

        <div class="px-4 py-2">
          <h3 class="text-lg font-bold px-2 pb-2">Account Settings</h3>
          <div class="bg-primary/5 rounded-xl border border-primary/10 overflow-hidden">
            <div class="flex items-center justify-between p-4 hover:bg-primary/10 cursor-pointer transition-colors group" @click="openEditProfile">
              <div class="flex items-center gap-3">
                <span class="material-symbols-outlined text-primary">person</span>
                <span class="font-medium">Edit Profile</span>
              </div>
              <span class="material-symbols-outlined text-slate-500 group-hover:translate-x-1 transition-transform">chevron_right</span>
            </div>
            <div class="h-px bg-primary/10 mx-4"></div>
            <div class="flex items-center justify-between p-4 hover:bg-primary/10 cursor-pointer transition-colors group" @click="openNotifications">
              <div class="flex items-center gap-3">
                <span class="material-symbols-outlined text-primary">notifications</span>
                <span class="font-medium">Notifications</span>
              </div>
              <span class="material-symbols-outlined text-slate-500 group-hover:translate-x-1 transition-transform">chevron_right</span>
            </div>
          </div>
          <button class="w-full mt-6 py-4 text-rose-400 font-semibold flex items-center justify-center gap-2 rounded-xl hover:bg-rose-400/10 transition-colors">
            <span class="material-symbols-outlined">logout</span>
            Logout
          </button>
        </div>
      </div>
    </div>

    <q-dialog v-model="showEditProfile">
      <q-card class="ella-card" style="min-width: 320px;">
        <q-card-section class="text-h6">Edit Profile</q-card-section>
        <q-card-section class="q-gutter-sm">
          <q-input v-model="editName" label="Name" dense class="ella-input" />
          <q-input v-model="editTagline" label="Tagline" dense class="ella-input" />
        </q-card-section>
        <q-card-actions align="right">
          <q-btn flat label="Cancel" @click="showEditProfile = false" />
          <q-btn class="ella-btn-primary" label="Save" @click="saveProfile" />
        </q-card-actions>
      </q-card>
    </q-dialog>

    <q-dialog v-model="showNotifications">
      <q-card class="ella-card" style="min-width: 320px;">
        <q-card-section class="text-h6">Notifications</q-card-section>
        <q-card-section>
          <q-toggle v-model="notificationsEnabled" label="Workout reminders" />
        </q-card-section>
        <q-card-actions align="right">
          <q-btn flat label="Close" @click="showNotifications = false" />
          <q-btn class="ella-btn-primary" label="Save" @click="saveNotifications" />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </q-page>
</template>

<script setup>
import { computed, ref } from 'vue'
import { useRouter } from 'vue-router'
import { useWorkoutStore } from 'src/stores/workout-store'

const router = useRouter()
const store = useWorkoutStore()

const totalWorkouts = computed(() => store.sessions.length)
const completedSets = computed(() =>
  store.sessions.reduce((count, session) => {
    const sets = session.entries?.flatMap((entry) => entry.sets || []) || []
    return count + sets.filter((set) => set.isCompleted).length
  }, 0)
)
const streakDays = computed(() => Math.min(12, store.sessions.length))

const profileName = computed(() => store.profile.name)
const profileTagline = computed(() => store.profile.tagline)

const showEditProfile = ref(false)
const showNotifications = ref(false)
const editName = ref(profileName.value)
const editTagline = ref(profileTagline.value)
const notificationsEnabled = ref(store.profile.notificationsEnabled)

function goBack () {
  router.back()
}

function openNotifications () {
  notificationsEnabled.value = store.profile.notificationsEnabled
  showNotifications.value = true
}

function openEditProfile () {
  editName.value = store.profile.name
  editTagline.value = store.profile.tagline
  showEditProfile.value = true
}

function saveProfile () {
  store.updateProfile({
    name: editName.value.trim() || store.profile.name,
    tagline: editTagline.value.trim() || store.profile.tagline
  })
  showEditProfile.value = false
}

function saveNotifications () {
  store.updateProfile({
    notificationsEnabled: notificationsEnabled.value
  })
  showNotifications.value = false
}
</script>
