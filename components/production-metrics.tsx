"use client"

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { ArrowDown, ArrowUp, Package, CheckCircle, XCircle } from "lucide-react"

interface ProductionMetricsProps {
  data: {
    total: number
    good: number
    bad: number
    trend: number
  }
}

export default function ProductionMetrics({ data }: ProductionMetricsProps) {
  const qualityRate = data.total > 0 ? Math.round((data.good / data.total) * 100) : 0
  const defectRate = data.total > 0 ? Math.round((data.bad / data.total) * 100) : 0

  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
      <Card>
        <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
          <CardTitle className="text-sm font-medium">Total Production</CardTitle>
          <Package className="h-4 w-4 text-muted-foreground" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold">{data.total.toLocaleString()}</div>
          <div className="flex items-center text-xs text-muted-foreground mt-1">
            {data.trend > 0 ? (
              <>
                <ArrowUp className="h-3 w-3 text-green-500 mr-1" />
                <span className="text-green-500">{data.trend}% increase</span>
              </>
            ) : (
              <>
                <ArrowDown className="h-3 w-3 text-red-500 mr-1" />
                <span className="text-red-500">{Math.abs(data.trend)}% decrease</span>
              </>
            )}
            <span className="ml-1">from previous period</span>
          </div>
        </CardContent>
      </Card>

      <Card>
        <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
          <CardTitle className="text-sm font-medium">Good Quality</CardTitle>
          <CheckCircle className="h-4 w-4 text-green-500" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold">{data.good.toLocaleString()}</div>
          <div className="text-xs text-muted-foreground mt-1">{qualityRate}% of total production</div>
        </CardContent>
      </Card>

      <Card>
        <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
          <CardTitle className="text-sm font-medium">Bad Quality</CardTitle>
          <XCircle className="h-4 w-4 text-red-500" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold">{data.bad.toLocaleString()}</div>
          <div className="text-xs text-muted-foreground mt-1">{defectRate}% defect rate</div>
        </CardContent>
      </Card>
    </div>
  )
}
