const rawApiBaseUrl = import.meta.env.VITE_API_BASE_URL?.trim();

console.log('Vite env:', import.meta.env);
console.log('VITE_API_BASE_URL:', import.meta.env.VITE_API_BASE_URL);

if (!rawApiBaseUrl) {
  throw new Error('VITE_API_BASE_URL is not configured');
}

const API_ROOT = rawApiBaseUrl.replace(/\/$/, '');

export const API_BASE_URL = `${API_ROOT}/api`;
export { API_ROOT };
