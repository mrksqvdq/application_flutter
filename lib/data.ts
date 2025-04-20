// Mock data functions for the production monitoring app
// In a real application, these would fetch data from an API

export async function fetchProductionData() {
  // Simulate API call delay
  await new Promise((resolve) => setTimeout(resolve, 500))

  // Generate mock data
  return {
    summary: {
      total: 1250,
      good: 1175,
      bad: 75,
      trend: 5.2,
    },
    hourly: [
      { time: "08:00", total: 120, good: 112, bad: 8 },
      { time: "09:00", total: 135, good: 128, bad: 7 },
      { time: "10:00", total: 142, good: 135, bad: 7 },
      { time: "11:00", total: 125, good: 118, bad: 7 },
      { time: "12:00", total: 110, good: 102, bad: 8 },
      { time: "13:00", total: 128, good: 120, bad: 8 },
      { time: "14:00", total: 145, good: 138, bad: 7 },
      { time: "15:00", total: 130, good: 122, bad: 8 },
      { time: "16:00", total: 115, good: 110, bad: 5 },
      { time: "17:00", total: 100, good: 95, bad: 5 },
    ],
    daily: [
      { time: "Mon", total: 950, good: 902, bad: 48 },
      { time: "Tue", total: 1050, good: 997, bad: 53 },
      { time: "Wed", total: 1100, good: 1045, bad: 55 },
      { time: "Thu", total: 1000, good: 950, bad: 50 },
      { time: "Fri", total: 1200, good: 1140, bad: 60 },
      { time: "Sat", total: 800, good: 760, bad: 40 },
      { time: "Sun", total: 500, good: 475, bad: 25 },
    ],
    weekly: [
      { time: "Week 1", total: 6500, good: 6175, bad: 325 },
      { time: "Week 2", total: 7000, good: 6650, bad: 350 },
      { time: "Week 3", total: 6800, good: 6460, bad: 340 },
      { time: "Week 4", total: 7200, good: 6840, bad: 360 },
    ],
  }
}

export async function fetchOperatorData() {
  // Simulate API call delay
  await new Promise((resolve) => setTimeout(resolve, 500))

  // Generate mock data
  return [
    {
      id: "op1",
      name: "John Smith",
      shift: "Morning",
      machine: "Machine A",
      totalProduction: 450,
      qualityRate: 96,
      status: "active",
    },
    {
      id: "op2",
      name: "Sarah Johnson",
      shift: "Morning",
      machine: "Machine B",
      totalProduction: 425,
      qualityRate: 94,
      status: "break",
    },
    {
      id: "op3",
      name: "Michael Brown",
      shift: "Afternoon",
      machine: "Machine A",
      totalProduction: 375,
      qualityRate: 92,
      status: "active",
    },
    {
      id: "op4",
      name: "Emily Davis",
      shift: "Afternoon",
      machine: "Machine B",
      totalProduction: 0,
      qualityRate: 0,
      status: "inactive",
    },
  ]
}
