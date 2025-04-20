import LoginForm from "@/components/login-form"

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-4 bg-gray-50">
      <div className="w-full max-w-md">
        <div className="text-center mb-8">
          <h1 className="text-2xl font-bold text-gray-900">Production Monitor</h1>
          <p className="text-gray-600 mt-2">Track and analyze production quality</p>
        </div>
        <LoginForm />
      </div>
    </main>
  )
}
