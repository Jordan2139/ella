import { LiveActivities } from 'capacitor-live-activities'

const baseLayout = {
  type: 'container',
  properties: [
    { direction: 'vertical' },
    { spacing: 8 },
    { padding: 16 },
    { backgroundColor: '#120a0c' },
    { cornerRadius: 12 }
  ],
  children: [
    {
      type: 'text',
      properties: [
        { text: '{{title}}' },
        { fontSize: 16 },
        { fontWeight: 'bold' },
        { color: '#ffd1dc' }
      ]
    },
    {
      type: 'text',
      properties: [
        { text: '{{subtitle}}' },
        { fontSize: 12 },
        { color: '#f6eef2' }
      ]
    },
    {
      type: 'text',
      properties: [
        { text: '{{remaining}}' },
        { fontSize: 22 },
        { fontWeight: 'bold' },
        { color: '#ffffff' }
      ]
    }
  ]
}

export async function startRestActivity ({ title, subtitle, remaining }) {
  if (!LiveActivities?.startActivity) return null
  try {
    const result = await LiveActivities.startActivity({
      layout: baseLayout,
      data: {
        title,
        subtitle,
        remaining
      }
    })
    return result?.activityId || null
  } catch {
    return null
  }
}

export async function updateRestActivity (activityId, remaining) {
  if (!activityId || !LiveActivities?.updateActivity) return
  try {
    await LiveActivities.updateActivity({
      activityId,
      data: { remaining }
    })
  } catch {
    // ignore
  }
}

export async function endRestActivity (activityId, remaining = 'Done') {
  if (!activityId || !LiveActivities?.endActivity) return
  try {
    await LiveActivities.endActivity({
      activityId,
      data: { remaining }
    })
  } catch {
    // ignore
  }
}
