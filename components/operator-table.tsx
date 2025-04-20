"use client"

import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table"
import { Badge } from "@/components/ui/badge"

interface OperatorTableProps {
  data: {
    id: string
    name: string
    shift: string
    machine: string
    totalProduction: number
    qualityRate: number
    status: "active" | "inactive" | "break"
  }[]
}

export default function OperatorTable({ data }: OperatorTableProps) {
  return (
    <div className="rounded-md border">
      <Table>
        <TableHeader>
          <TableRow>
            <TableHead>Operator</TableHead>
            <TableHead>Shift</TableHead>
            <TableHead>Machine</TableHead>
            <TableHead className="text-right">Production</TableHead>
            <TableHead className="text-right">Quality</TableHead>
            <TableHead>Status</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {data.map((operator) => (
            <TableRow key={operator.id}>
              <TableCell className="font-medium">{operator.name}</TableCell>
              <TableCell>{operator.shift}</TableCell>
              <TableCell>{operator.machine}</TableCell>
              <TableCell className="text-right">{operator.totalProduction}</TableCell>
              <TableCell className="text-right">{operator.qualityRate}%</TableCell>
              <TableCell>
                <Badge
                  variant={
                    operator.status === "active" ? "default" : operator.status === "break" ? "outline" : "secondary"
                  }
                >
                  {operator.status}
                </Badge>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  )
}
