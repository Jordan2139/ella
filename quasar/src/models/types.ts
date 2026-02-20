export type ID = string

export interface Exercise {
  id: ID
  name: string
  muscleGroup?: string | null
  createdAt: string
}

export interface TemplateSet {
  id: ID
  reps: number
  weight?: number
  isWarmup?: boolean
}

export interface TemplateExercise {
  id: ID
  exerciseId: ID
  sets: TemplateSet[]
}

export interface WorkoutTemplate {
  id: ID
  name: string
  createdAt: string
  exercises: TemplateExercise[]
}

export interface LiftSet {
  id: ID
  weight: number
  reps: number
  isWarmup: boolean
  isCompleted: boolean
  note?: string
  createdAt: string
}

export interface WorkoutEntry {
  id: ID
  exerciseId: ID
  sets: LiftSet[]
  wasModified: boolean
  modificationReason?: string
}

export interface WorkoutSession {
  id: ID
  startedAt: string
  endedAt?: string | null
  postWorkoutReflection?: string
  entries: WorkoutEntry[]
}
