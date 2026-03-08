import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import { AuthProvider } from "@/contexts/AuthContext";

// Pages
import Index from "@/pages/Index";
import Login from "@/pages/Login";
import DashboardLayout from "@/components/layout/DashboardLayout";
import DashboardHome from "@/pages/dashboard/DashboardHome";
import LegalReasoning from "@/pages/dashboard/LegalReasoning";
import KnowledgeGraph from "@/pages/dashboard/KnowledgeGraph";
import RiskDetection from "@/pages/dashboard/RiskDetection";
import Documents from "@/pages/dashboard/Documents";
import History from "@/pages/dashboard/History";
import Settings from "@/pages/dashboard/Settings";
import Help from "@/pages/dashboard/Help";
import LegalReference from "@/pages/dashboard/LegalReference";
import DeedSummarizer from "@/pages/dashboard/DeedSummarizer";
import NotFound from "@/pages/NotFound";

const queryClient = new QueryClient();

const App = () => (
  <QueryClientProvider client={queryClient}>
    <AuthProvider>
      <TooltipProvider>
        <Toaster />
        <Sonner />
        <BrowserRouter>
          <Routes>
            {/* Auth Routes */}
            <Route path="/login" element={<Login />} />
            
            {/* Dashboard Routes */}
            <Route path="/dashboard" element={<DashboardLayout />}>
              <Route index element={<DashboardHome />} />
              <Route path="reasoning" element={<LegalReasoning />} />
              <Route path="knowledge-graph" element={<KnowledgeGraph />} />
              <Route path="risk-detection" element={<RiskDetection />} />
              <Route path="documents" element={<Documents />} />
              <Route path="legal-reference" element={<LegalReference />} />
              <Route path="deed-summarizer" element={<DeedSummarizer />} />
              <Route path="history" element={<History />} />
              <Route path="settings" element={<Settings />} />
              <Route path="help" element={<Help />} />
            </Route>
            
            {/* Home/Landing Route */}
            <Route path="/" element={<Index />} />
            
            {/* 404 */}
            <Route path="*" element={<NotFound />} />
          </Routes>
        </BrowserRouter>
      </TooltipProvider>
    </AuthProvider>
  </QueryClientProvider>
);

export default App;
