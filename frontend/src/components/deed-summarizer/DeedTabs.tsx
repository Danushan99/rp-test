import type { ReactNode } from "react";

export type DeedTabKey = "summaries" | "timeline" | "analytics" | "infographic";

export default function DeedTabs({
  tab,
  setTab,
  children,
}: {
  tab: DeedTabKey;
  setTab: (t: DeedTabKey) => void;
  children: ReactNode;
}) {
  const items: Array<{ key: DeedTabKey; label: string }> = [
    { key: "summaries", label: "Summaries" },
    { key: "timeline", label: "Timeline" },
    { key: "analytics", label: "Analytics" },
    { key: "infographic", label: "Infographic" },
  ];

  return (
    <div className="rounded-2xl bg-white shadow-soft">
      <div className="flex flex-wrap gap-2 border-b p-3">
        {items.map((it) => (
          <button
            key={it.key}
            onClick={() => setTab(it.key)}
            className={[
              "rounded-xl px-3 py-2 text-sm transition",
              tab === it.key
                ? "bg-neutral-900 text-white"
                : "bg-neutral-100 text-neutral-700 hover:bg-neutral-200",
            ].join(" ")}
          >
            {it.label}
          </button>
        ))}
      </div>
      <div className="p-5">{children}</div>
    </div>
  );
}
