import { defineStore } from 'pinia'
import localforage from 'localforage'

const STORAGE_KEY = 'ella-workout-data'

localforage.config({
  name: 'ella',
  storeName: 'workout_data'
})

const createId = () => `${Date.now().toString(36)}-${Math.random().toString(36).slice(2, 10)}`

const createTemplateSet = (overrides = {}) => ({
  id: createId(),
  reps: 8,
  weight: 0,
  isWarmup: false,
  ...overrides
})

const createLiftSet = (overrides = {}) => ({
  id: createId(),
  reps: 5,
  weight: 0,
  isWarmup: false,
  isCompleted: false,
  note: '',
  createdAt: new Date().toISOString(),
  ...overrides
})

const cloneTemplateSetsToLiftSets = (sets = []) =>
  sets.map((set) =>
    createLiftSet({
      reps: set.reps ?? 0,
      weight: set.weight ?? 0,
      isWarmup: Boolean(set.isWarmup)
    })
  )

const emptyState = () => ({
  loaded: false,
  exercises: [],
  programs: [],
  sessions: [],
  activeSessionId: null,
  profile: {
    name: 'Alex',
    tagline: 'Ready for Greatness?',
    notificationsEnabled: true
  }
})

export const useWorkoutStore = defineStore('workout', {
  state: emptyState,
  getters: {
    programById: (state) => (id) => state.programs.find((program) => program.id === id),
    sessionById: (state) => (id) => state.sessions.find((session) => session.id === id),
    exerciseById: (state) => (id) => state.exercises.find((exercise) => exercise.id === id),
    activeSession: (state) => state.sessions.find((session) => session.id === state.activeSessionId) || null
  },
  actions: {
    async init () {
      if (this.loaded) return
      await this.load()
      this.$subscribe(() => {
        void this.persist()
      }, { detached: true })
    },
    async load () {
      if (this.loaded) return
      const saved = await localforage.getItem(STORAGE_KEY)
      if (saved) {
        this.exercises = saved.exercises || []
        this.programs = saved.programs || []
        this.sessions = saved.sessions || []
        this.activeSessionId = saved.activeSessionId || null
        this.profile = saved.profile || this.profile
        this.migrateLegacyData()
      }
      this.loaded = true
    },
    migrateLegacyData () {
      this.exercises = this.exercises.map((exercise) => ({
        id: exercise.id || createId(),
        name: exercise.name || 'Untitled Exercise',
        muscleGroup: exercise.muscleGroup || null,
        createdAt: exercise.createdAt || new Date().toISOString()
      }))

      this.programs = this.programs.map((program) => ({
        id: program.id || createId(),
        name: program.name || 'Untitled Program',
        createdAt: program.createdAt || new Date().toISOString(),
        exercises: (program.exercises || []).map((entry) => ({
          id: entry.id || createId(),
          exerciseId: entry.exerciseId || entry.exercise?.id || createId(),
          sets: (entry.sets || []).map((set) => ({
            id: set.id || createId(),
            reps: set.reps ?? 0,
            weight: set.weight ?? 0,
            isWarmup: Boolean(set.isWarmup)
          }))
        }))
      }))

      this.sessions = this.sessions.map((session) => ({
        id: session.id || createId(),
        programId: session.programId || null,
        programName: session.programName || 'Workout',
        startedAt: session.startedAt || new Date().toISOString(),
        completedAt: session.completedAt || session.endedAt || null,
        postWorkoutReflection: session.postWorkoutReflection || '',
        entries: (session.entries || session.exercises || []).map((entry) => ({
          id: entry.id || createId(),
          exerciseId: entry.exerciseId || entry.exercise?.id || createId(),
          wasModified: Boolean(entry.wasModified),
          modificationReason: entry.modificationReason || '',
          fatigueAdjustment: entry.fatigueAdjustment ?? 0,
          sets: (entry.sets || []).map((set) => ({
            id: set.id || createId(),
            reps: set.reps ?? 0,
            weight: set.weight ?? 0,
            isWarmup: Boolean(set.isWarmup),
            isCompleted: Boolean(set.isCompleted),
            note: set.note || '',
            createdAt: set.createdAt || new Date().toISOString()
          }))
        }))
      }))
    },
    async persist () {
      const snapshot = {
        exercises: this.exercises,
        programs: this.programs,
        sessions: this.sessions,
        activeSessionId: this.activeSessionId,
        profile: this.profile
      }
      await localforage.setItem(STORAGE_KEY, snapshot)
    },
    updateProfile (updates) {
      this.profile = {
        ...this.profile,
        ...updates
      }
    },
    createExercise (name, muscleGroup = '') {
      const trimmed = name.trim()
      if (!trimmed) return null
      const existing = this.exercises.find((exercise) => exercise.name.toLowerCase() === trimmed.toLowerCase())
      if (existing) return existing
      const exercise = {
        id: createId(),
        name: trimmed,
        muscleGroup: muscleGroup.trim() || null,
        createdAt: new Date().toISOString()
      }
      this.exercises.push(exercise)
      return exercise
    },
    updateExercise (exerciseId, updates) {
      const exercise = this.exerciseById(exerciseId)
      if (!exercise) return
      exercise.name = (updates.name ?? exercise.name).trim()
      exercise.muscleGroup = updates.muscleGroup?.trim() || null
    },
    deleteExercise (exerciseId) {
      this.exercises = this.exercises.filter((exercise) => exercise.id !== exerciseId)
      this.programs.forEach((program) => {
        program.exercises = program.exercises.filter((entry) => entry.exerciseId !== exerciseId)
      })
      this.sessions.forEach((session) => {
        session.entries = session.entries.filter((entry) => entry.exerciseId !== exerciseId)
      })
    },
    createProgram (name = 'New Program') {
      const program = {
        id: createId(),
        name,
        createdAt: new Date().toISOString(),
        exercises: []
      }
      this.programs.push(program)
      return program
    },
    deleteProgram (programId) {
      this.programs = this.programs.filter((program) => program.id !== programId)
    },
    reorderPrograms (newPrograms) {
      this.programs = [...newPrograms]
    },
    renameProgram (programId, name) {
      const program = this.programById(programId)
      if (program) {
        program.name = name
      }
    },
    addExerciseToProgram (programId, exerciseId) {
      const program = this.programById(programId)
      if (!program) return
      const exercise = this.exerciseById(exerciseId)
      if (!exercise) return
      program.exercises.push({
        id: createId(),
        exerciseId: exercise.id,
        sets: [createTemplateSet(), createTemplateSet(), createTemplateSet()]
      })
    },
    reorderProgramExercises (programId, newArray) {
      const program = this.programById(programId)
      if (!program) return
      program.exercises = [...newArray]
    },
    removeExerciseFromProgram (programId, exerciseEntryId) {
      const program = this.programById(programId)
      if (!program) return
      program.exercises = program.exercises.filter((entry) => entry.id !== exerciseEntryId)
    },
    addSetToProgramExercise (programId, exerciseEntryId) {
      const program = this.programById(programId)
      if (!program) return
      const entry = program.exercises.find((item) => item.id === exerciseEntryId)
      if (!entry) return
      entry.sets.push(createTemplateSet())
    },
    updateProgramSet (programId, exerciseEntryId, setId, updates) {
      const program = this.programById(programId)
      if (!program) return
      const entry = program.exercises.find((item) => item.id === exerciseEntryId)
      if (!entry) return
      const set = entry.sets.find((item) => item.id === setId)
      if (!set) return
      set.reps = updates.reps ?? set.reps
      set.weight = updates.weight ?? set.weight
      set.isWarmup = updates.isWarmup ?? set.isWarmup
    },
    removeSetFromProgramExercise (programId, exerciseEntryId, setId) {
      const program = this.programById(programId)
      if (!program) return
      const entry = program.exercises.find((item) => item.id === exerciseEntryId)
      if (!entry) return
      entry.sets = entry.sets.filter((set) => set.id !== setId)
    },
    reorderProgramSets (programId, exerciseEntryId, newSets) {
      const program = this.programById(programId)
      if (!program) return
      const entry = program.exercises.find((item) => item.id === exerciseEntryId)
      if (!entry) return
      entry.sets = [...newSets]
    },
    startSessionFromProgram (programId) {
      const program = this.programById(programId)
      if (!program) return null
      const session = {
        id: createId(),
        programId: program.id,
        programName: program.name,
        startedAt: new Date().toISOString(),
        completedAt: null,
        postWorkoutReflection: '',
        entries: program.exercises.map((exercise) => ({
          id: createId(),
          exerciseId: exercise.exerciseId,
          wasModified: false,
          modificationReason: '',
          fatigueAdjustment: 0,
          sets: cloneTemplateSetsToLiftSets(exercise.sets)
        }))
      }
      this.sessions.unshift(session)
      this.activeSessionId = session.id
      return session
    },
    startEmptySession (name = 'Empty Workout') {
      const session = {
        id: createId(),
        programId: null,
        programName: name,
        startedAt: new Date().toISOString(),
        completedAt: null,
        postWorkoutReflection: '',
        entries: []
      }
      this.sessions.unshift(session)
      this.activeSessionId = session.id
      return session
    },
    endSession (sessionId) {
      const session = this.sessionById(sessionId)
      if (!session) return
      session.completedAt = new Date().toISOString()
      if (this.activeSessionId === sessionId) {
        this.activeSessionId = null
      }
    },
    setSessionReflection (sessionId, reflection) {
      const session = this.sessionById(sessionId)
      if (!session) return
      session.postWorkoutReflection = reflection
    },
    addExerciseToSession (sessionId, exercise) {
      const session = this.sessionById(sessionId)
      if (!session) return
      const resolved = typeof exercise === 'string' ? this.exerciseById(exercise) : exercise
      if (!resolved) return
      session.entries.push({
        id: createId(),
        exerciseId: resolved.id,
        wasModified: true,
        modificationReason: 'Added during session',
        fatigueAdjustment: 0,
        sets: [createLiftSet()]
      })
    },
    removeExerciseFromSession (sessionId, exerciseEntryId) {
      const session = this.sessionById(sessionId)
      if (!session) return
      session.entries = session.entries.filter((entry) => entry.id !== exerciseEntryId)
    },
    addSetToSessionExercise (sessionId, exerciseEntryId) {
      const session = this.sessionById(sessionId)
      if (!session) return
      const entry = session.entries.find((item) => item.id === exerciseEntryId)
      if (!entry) return
      entry.sets.push(createLiftSet())
    },
    updateSessionEntry (sessionId, exerciseEntryId, updates) {
      const session = this.sessionById(sessionId)
      if (!session) return
      const entry = session.entries.find((item) => item.id === exerciseEntryId)
      if (!entry) return
      if (updates.exerciseId) {
        entry.exerciseId = updates.exerciseId
        entry.wasModified = true
      }
      if (updates.modificationReason !== undefined) {
        entry.modificationReason = updates.modificationReason
        entry.wasModified = true
      }
      if (typeof updates.fatigueAdjustment === 'number') {
        entry.fatigueAdjustment = updates.fatigueAdjustment
      }
    },
    applyFatigueAdjustment (sessionId, exerciseEntryId, deltaWeight = 0) {
      const session = this.sessionById(sessionId)
      if (!session) return
      const entry = session.entries.find((item) => item.id === exerciseEntryId)
      if (!entry) return
      entry.fatigueAdjustment += deltaWeight
      entry.sets.forEach((set) => {
        set.weight = Math.max(0, (set.weight ?? 0) + deltaWeight)
      })
      entry.wasModified = true
      if (!entry.modificationReason) {
        entry.modificationReason = 'Fatigue adjustment'
      }
    },
    updateSessionSet (sessionId, exerciseEntryId, setId, updates) {
      const session = this.sessionById(sessionId)
      if (!session) return
      const entry = session.entries.find((item) => item.id === exerciseEntryId)
      if (!entry) return
      const set = entry.sets.find((item) => item.id === setId)
      if (!set) return
      set.reps = updates.reps ?? set.reps
      set.weight = updates.weight ?? set.weight
      set.isWarmup = updates.isWarmup ?? set.isWarmup
      if (typeof updates.isCompleted === 'boolean') {
        set.isCompleted = updates.isCompleted
      }
      if (updates.note !== undefined) {
        set.note = updates.note
      }
    },
    removeSetFromSessionExercise (sessionId, exerciseEntryId, setId) {
      const session = this.sessionById(sessionId)
      if (!session) return
      const entry = session.entries.find((item) => item.id === exerciseEntryId)
      if (!entry) return
      entry.sets = entry.sets.filter((set) => set.id !== setId)
    },
    reorderSessionEntries (sessionId, newEntries) {
      const session = this.sessionById(sessionId)
      if (!session) return
      session.entries = [...newEntries]
    },
    reorderSessionSets (sessionId, exerciseEntryId, newSets) {
      const session = this.sessionById(sessionId)
      if (!session) return
      const entry = session.entries.find((item) => item.id === exerciseEntryId)
      if (!entry) return
      entry.sets = [...newSets]
    }
  }
})
