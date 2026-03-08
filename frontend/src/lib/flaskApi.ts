import axios from "axios";

export const FLASK_API_BASE_URL =
  import.meta.env.VITE_FLASK_API_BASE_URL || "http://127.0.0.1:5000";

export const flaskApi = axios.create({
  baseURL: FLASK_API_BASE_URL,
  timeout: 120000,
});
