"use client"

import type React from "react"

import { useEffect, useState } from "react"
import { useRouter } from "next/navigation"
import { Button } from "@/components/ui/button"
import { Home, BarChart, Settings, LogOut } from "lucide-react"

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode
}) {
  const [user, setUser] = useState<{ username: string; role: string; isAuthenticated: boolean } | null>(null)
  const router = useRouter()

  useEffect(() => {
    // Check if user is authenticated
    const storedUser = localStorage.getItem("user")
    if (storedUser) {
      const parsedUser = JSON.parse(storedUser)
      if (parsedUser.isAuthenticated) {
        setUser(parsedUser)
        return
      }
    }

    // Redirect to login if not authenticated
    router.push("/")
  }, [router])

  const handleLogout = () => {
    localStorage.removeItem("user")
    router.push("/")
  }

  if (!user) {
    return <div className="flex items-center justify-center min-h-screen">Loading...</div>
  }

  return (
    <div className="flex flex-col min-h-screen bg-gray-50">
      <header className="bg-white border-b border-gray-200 py-4 px-4 flex items-center justify-between">
        <div className="flex items-center">
          <h1 className="text-xl font-bold text-gray-900">Production Monitor</h1>
          <span className="ml-2 text-sm text-gray-500">({user.role})</span>
        </div>
        <div className="flex items-center">
          <span className="mr-4 text-sm text-gray-600">Hello, {user.username}</span>
          <Button variant="outline" size="sm" onClick={handleLogout}>
            <LogOut className="h-4 w-4 mr-2" />
            Logout
          </Button>
        </div>
      </header>

      <div className="flex flex-1">
        <nav className="w-16 bg-white border-r border-gray-200 flex flex-col items-center py-4">
          <Button variant="ghost" size="icon" className="mb-4" onClick={() => router.push(`/dashboard/${user.role}`)}>
            <Home className="h-5 w-5" />
          </Button>
          <Button
            variant="ghost"
            size="icon"
            className="mb-4"
            onClick={() => router.push(`/dashboard/${user.role}/charts`)}
          >
            <BarChart className="h-5 w-5" />
          </Button>
          <Button
            variant="ghost"
            size="icon"
            className="mb-4"
            onClick={() => router.push(`/dashboard/${user.role}/settings`)}
          >
            <Settings className="h-5 w-5" />
          </Button>
        </nav>

        <main className="flex-1 p-4">{children}</main>
      </div>
    </div>
  )
}
