export const formatDateID = (date: string | Date | null) => {
  if (!date) return "-";

  const d = new Date(date);

  const dd = String(d.getDate()).padStart(2, "0");

  const monthNames = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember",
  ];

  const monthName = monthNames[d.getMonth()];
  const yyyy = d.getFullYear();

  return `${dd} ${monthName} ${yyyy}`;
};
