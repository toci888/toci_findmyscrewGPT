import axios from 'axios';

const API = axios.create({
  baseURL: 'http://127.0.0.1:8080/api',
});

export const getItems = async () => {
  const response = await API.get('/items/');
  return response.data;
};
