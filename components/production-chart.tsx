"use client"

import { Bar, BarChart, CartesianGrid, Legend, XAxis, YAxis } from "recharts"
import { ChartContainer, ChartTooltip, ChartTooltipContent } from "@/components/ui/chart"

interface ProductionChartProps {
  data: any[]
}

export default function ProductionChart({ data }: ProductionChartProps) {
  return (
    <ChartContainer
      config={{
        total: {
          label: "Total Production",
          color: "hsl(var(--chart-1))",
        },
        good: {
          label: "Good Quality",
          color: "hsl(var(--chart-2))",
        },
        bad: {
          label: "Bad Quality",
          color: "hsl(var(--chart-3))",
        },
      }}
      className="h-[300px]"
    >
      <BarChart
        accessibilityLayer
        data={data}
        margin={{
          top: 20,
          right: 20,
          left: 20,
          bottom: 20,
        }}
      >
        <CartesianGrid vertical={false} strokeDasharray="3 3" />
        <XAxis dataKey="time" tickLine={false} axisLine={false} tickMargin={10} />
        <YAxis tickLine={false} axisLine={false} tickMargin={10} />
        <ChartTooltip content={<ChartTooltipContent indicator="dashed" />} />
        <Bar dataKey="total" fill="var(--color-total)" radius={4} />
        <Bar dataKey="good" fill="var(--color-good)" radius={4} />
        <Bar dataKey="bad" fill="var(--color-bad)" radius={4} />
        <Legend />
      </BarChart>
    </ChartContainer>
  )
}
