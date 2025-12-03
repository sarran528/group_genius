const API_ROOT = (
  import.meta?.env?.VITE_API_BASE_URL ?? 'http://localhost:8080'
).replace(/\/$/, '');

export const API_BASE_URL = `${API_ROOT}/api`;
export { API_ROOT };
