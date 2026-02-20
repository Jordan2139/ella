const routes = [
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      { path: '', redirect: '/start' },
      { path: 'programs', component: () => import('pages/ProgramListPage.vue') },
      { path: 'programs/:id', component: () => import('pages/ProgramEditorPage.vue') },
      { path: 'start', component: () => import('pages/StartWorkoutPage.vue') },
      { path: 'workout/:id?', component: () => import('pages/WorkoutPlayerPage.vue') },
      { path: 'workout-summary/:id', component: () => import('pages/WorkoutSummaryPage.vue') },
      { path: 'workout-history', component: () => import('pages/WorkoutHistoryPage.vue') },
      { path: 'exercises', component: () => import('pages/ExercisesPage.vue') },
      { path: 'body-insights', component: () => import('pages/BodyInsightsPage.vue') },
      { path: 'profile', component: () => import('pages/ProfilePage.vue') }
    ]
  },

  // Always leave this as last one,
  // but you can also remove it
  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/ErrorNotFound.vue')
  }
]

export default routes
