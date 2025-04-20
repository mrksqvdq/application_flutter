"use client"

import { useEffect, useState } from "react"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { fetchProductionData } from "@/lib/data"
import ProductionChart from "@/components/production-chart"
import ProductionMetrics from "@/components/production-metrics"

export default function OperatorDashboard() {
  const [productionData, setProductionData] = useState<any>(null)
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    const loadData = async () => {
      setIsLoading(true)
      const data = await fetchProductionData()
      setProductionData(data)
      setIsLoading(false)
    }

    loadData()

    // Set up polling for real-time updates (every 30 seconds)
    const interval = setInterval(loadData, 30000)

    return () => clearInterval(interval)
  }, [])

  if (isLoading) {
    return <div className="flex items-center justify-center h-full">Loading production data...</div>
  }

  return (
    <div className="space-y-4">
      <h2 className="text-2xl font-bold">Operator Dashboard</h2>

      <ProductionMetrics data={productionData.summary} />

      <Tabs defaultValue="hourly">
        <TabsList className="grid w-full grid-cols-3">
          <TabsTrigger value="hourly">Hourly</TabsTrigger>
          <TabsTrigger value="daily">Daily</TabsTrigger>
          <TabsTrigger value="weekly">Weekly</TabsTrigger>
        </TabsList>
        <TabsContent value="hourly">
          <Card>
            <CardHeader>
              <CardTitle>Hourly Production Quality</CardTitle>
              <CardDescription>Production metrics for the last 12 hours</CardDescription>
            </CardHeader>
            <CardContent>
              <ProductionChart data={productionData.hourly} />
            </CardContent>
          </Card>
        </TabsContent>
        <TabsContent value="daily">
          <Card>
            <CardHeader>
              <CardTitle>Daily Production Quality</CardTitle>
              <CardDescription>Production metrics for the last 7 days</CardDescription>
            </CardHeader>
            <CardContent>
              <ProductionChart data={productionData.daily} />
            </CardContent>
          </Card>
        </TabsContent>
        <TabsContent value="weekly">
          <Card>
            <CardHeader>
              <CardTitle>Weekly Production Quality</CardTitle>
              <CardDescription>Production metrics for the last 4 weeks</CardDescription>
            </CardHeader>
            <CardContent>
              <ProductionChart data={productionData.weekly} />
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  )
}
