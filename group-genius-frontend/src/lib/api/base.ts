const apiBaseUrl = import.meta?.env?.VITE_API_BASE_URL;

if (!apiBaseUrl) {
  throw new Error('VITE_API_BASE_URL is not configured');
}

const API_ROOT = apiBaseUrl.replace(/\/$/, '');

export const API_BASE_URL = `${API_ROOT}/api`;
export { API_ROOT };
