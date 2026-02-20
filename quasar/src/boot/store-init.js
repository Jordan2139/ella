import { boot } from 'quasar/wrappers'
import { useWorkoutStore } from 'src/stores/workout-store'

export default boot(async () => {
  const store = useWorkoutStore()
  await store.init()
})
