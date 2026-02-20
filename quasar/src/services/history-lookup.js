export function getLastSessionForExercise (sessions, exerciseId, excludeSessionId = null) {
  return sessions.find(
    (session) =>
      session.id !== excludeSessionId &&
      session.entries?.some((entry) => entry.exerciseId === exerciseId)
  )
}

export function getLastEntryForExercise (sessions, exerciseId, excludeSessionId = null) {
  const session = getLastSessionForExercise(sessions, exerciseId, excludeSessionId)
  if (!session) return null
  return session.entries.find((entry) => entry.exerciseId === exerciseId) || null
}

export function getLastModificationReason (sessions, exerciseId, excludeSessionId = null) {
  const entry = getLastEntryForExercise(sessions, exerciseId, excludeSessionId)
  return entry?.modificationReason || ''
}

export function getLastReflection (sessions, excludeSessionId = null) {
  const session = sessions.find((item) => item.id !== excludeSessionId && item.postWorkoutReflection)
  return session?.postWorkoutReflection || ''
}

export function getLastWorkingWeight (sessions, exerciseId, excludeSessionId = null) {
  const entry = getLastEntryForExercise(sessions, exerciseId, excludeSessionId)
  if (!entry || !entry.sets?.length) return null
  const sorted = [...entry.sets].filter((set) => set.weight != null).sort((a, b) => b.weight - a.weight)
  return sorted.length ? sorted[0].weight : null
}
