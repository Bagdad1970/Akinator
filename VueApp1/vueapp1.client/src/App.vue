<script setup>
import { ref, computed } from 'vue';

const GAME_STATES = {
  START: 'start',
  PLAYING: 'playing',
  GUESS: 'guess',
  LEARN_ANIMAL: 'learn_animal',
  LEARN_QUESTION: 'learn_question',
  LEARN_ANSWER: 'learn_answer',
  RESULT: 'result',
  ERROR: 'error'
};

const gameState = ref(GAME_STATES.START);
const currentQuestion = ref("НАЖМИТЕ 'НАЧАТЬ ИГРУ'");
const loading = ref(false);
const resultMessage = ref('');
const errorMessage = ref('');

// Данные для обучения
const newAnimal = ref('');
const newQuestion = ref('');
const newAnswer = ref('');

// Состояния для авторизации
const showLoginModal = ref(false);
const showRegisterModal = ref(false);
const loginData = ref({ email: '', password: '' });
const registerData = ref({ username: '', email: '', password: '' });
const isAuthenticated = ref(false);
const authError = ref('');

const API_URL = 'https://localhost:7138';

// Вычисляемые свойства для состояний игры
const showStartScreen = computed(() => gameState.value === GAME_STATES.START);
const showGameScreen = computed(() => gameState.value === GAME_STATES.PLAYING);
const showGuessScreen = computed(() => gameState.value === GAME_STATES.GUESS);
const showLearnAnimalScreen = computed(() => gameState.value === GAME_STATES.LEARN_ANIMAL);
const showLearnQuestionScreen = computed(() => gameState.value === GAME_STATES.LEARN_QUESTION);
const showLearnAnswerScreen = computed(() => gameState.value === GAME_STATES.LEARN_ANSWER);
const showResultScreen = computed(() => gameState.value === GAME_STATES.RESULT);
const showErrorScreen = computed(() => gameState.value === GAME_STATES.ERROR);

// Универсальный метод для API запросов
async function makeRequest(endpoint, body = null, method = 'POST') {
  try {
    loading.value = true;
    const options = {
      method,
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': isAuthenticated.value ? `Bearer ${localStorage.getItem('token')}` : ''
      },
    };

    if (body) options.body = JSON.stringify(body);

    const response = await fetch(`${API_URL}/${endpoint}`, options);
    const data = await response.json();

    if (!response.ok) {
      throw new Error(data.message || data.detail || `HTTP error! Status: ${response.status}`);
    }

    return data;
  } catch (error) {
    console.error('API Error:', error);
    errorMessage.value = error.message.includes('Failed to fetch')
      ? 'ОШИБКА: СЕРВЕР НЕ ОТВЕЧАЕТ. ПРОВЕРЬТЕ БЭКЕНД'
      : `ОШИБКА: ${error.message.toUpperCase()}`;
    gameState.value = GAME_STATES.ERROR;
    return null;
  } finally {
    loading.value = false;
  }
}

// Игровые методы
async function startGame() {
  const data = await makeRequest('start');
  if (!data) return;

  currentQuestion.value = data.question.toUpperCase();
  gameState.value = GAME_STATES.PLAYING;
}

async function sendAnswer(answer) {
  const data = await makeRequest('answer', { Answer: answer });
  if (!data) return;

  const response = data.response.toUpperCase();

  if (response.includes('ПРЕДПОЛОЖЕНИЕ:')) {
    currentQuestion.value = response;
    gameState.value = GAME_STATES.GUESS;
  } else if (response.includes('НАЗЫВАЕТСЯ ВАШЕ ЖИВОТНОЕ') || data.awaitingAnimalName) {
    gameState.value = GAME_STATES.LEARN_ANIMAL;
  } else if (response.includes('ВВЕДИТЕ ВОПРОС') || data.awaitingQuestionText) {
    gameState.value = GAME_STATES.LEARN_QUESTION;
  } else if (response.includes('ВВЕДИТЕ ОТВЕТ') || data.awaitingQuestionAnswer) {
    gameState.value = GAME_STATES.LEARN_ANSWER;
  } else if (response.includes('УРА Я УГАДАЛ') || response.includes('ИГРА ЗАВЕРШЕНА') || response.includes('СПАСИБО! Я запомнил животное')) {
    resultMessage.value = response;
    gameState.value = GAME_STATES.RESULT;
  } else {
    currentQuestion.value = response;
    gameState.value = GAME_STATES.PLAYING;
  }
}

// Методы для обработки ответов
function handleCorrectGuess() {
  resultMessage.value = currentQuestion.value;
  gameState.value = GAME_STATES.RESULT;
}

function handleIncorrectGuess() {
  sendAnswer('no');
  newAnimal.value = '';
  newQuestion.value = '';
  newAnswer.value = '';
}

// Методы для обучения игры
function submitNewAnimal() {
  if (!newAnimal.value.trim()) {
    errorMessage.value = 'Введите название животного!';
    return;
  }
  errorMessage.value = '';
  sendAnswer(newAnimal.value.trim());
  resultMessage.value = `СПАСИБО! Я запомнил животное: ${"'" + newAnimal.value.trim().toUpperCase() + "'"}`;
  gameState.value = GAME_STATES.RESULT;
  newAnimal.value = '';
}

function submitNewQuestion() {
  if (!newQuestion.value.trim()) {
    errorMessage.value = 'Введите текст вопроса!';
    return;
  }
  errorMessage.value = '';
  sendAnswer(newQuestion.value.trim());
}

function submitNewAnswer() {
  const answer = newAnswer.value.trim().toLowerCase();
  if (answer !== 'yes' && answer !== 'no') {
    errorMessage.value = 'Введите "yes" или "no"!';
    return;
  }
  errorMessage.value = '';
  sendAnswer(answer);
}

// Методы для управления игрой
async function restartGame() {
  gameState.value = GAME_STATES.START;
  currentQuestion.value = "НАЖМИТЕ 'НАЧАТЬ ИГРУ'";
  resultMessage.value = '';
  errorMessage.value = '';
  newAnimal.value = '';
  newQuestion.value = '';
  newAnswer.value = '';
  await startGame();
}

// Методы для авторизации
function openLoginModal() {
  showLoginModal.value = true;
  showRegisterModal.value = false;
  authError.value = '';
}

function openRegisterModal() {
  showRegisterModal.value = true;
  showLoginModal.value = false;
  authError.value = '';
}

function closeModals() {
  showLoginModal.value = false;
  showRegisterModal.value = false;
}

async function handleLogin() {
  if (!loginData.value.email.trim() || !loginData.value.password.trim()) {
    authError.value = 'Заполните все поля!';
    return;
  }

  const data = await makeRequest('api/auth/login', {
    email: loginData.value.email.trim(),
    password: loginData.value.password.trim()
  });

  if (data?.success) {
    localStorage.setItem('token', data.token);
    isAuthenticated.value = true;
    closeModals();
    loginData.value = { email: '', password: '' };
    resultMessage.value = 'ВХОД УСПЕШЕН!';
    gameState.value = GAME_STATES.RESULT;
  } else {
    authError.value = data?.message || 'Ошибка входа';
  }
}

async function handleRegister() {
  if (!registerData.value.username.trim() || 
      !registerData.value.email.trim() || 
      !registerData.value.password.trim()) {
    authError.value = 'Заполните все поля!';
    return;
  }

  const data = await makeRequest('api/auth/register', {
    username: registerData.value.username.trim(),
    email: registerData.value.email.trim(),
    password: registerData.value.password.trim()
  });

  if (data?.success) {
    localStorage.setItem('token', data.token);
    isAuthenticated.value = true;
    closeModals();
    registerData.value = { username: '', email: '', password: '' };
    resultMessage.value = 'РЕГИСТРАЦИЯ УСПЕШНА!';
    gameState.value = GAME_STATES.RESULT;
  } else {
    authError.value = data?.message || 'Ошибка регистрации';
  }
}

async function handleLogout() {
  const data = await makeRequest('api/auth/logout');
  if (data?.success) {
    localStorage.removeItem('token');
    isAuthenticated.value = false;
    resultMessage.value = 'ВЫХОД УСПЕШЕН!';
    gameState.value = GAME_STATES.RESULT;
  }
}

// Проверяем токен при загрузке
const token = localStorage.getItem('token');
if (token) {
  isAuthenticated.value = true;
}
</script>

<template>
  <div class="game-container">
    <div class="auth-buttons" v-if="!isAuthenticated">
      <button @click="openLoginModal" class="auth-btn login-btn">Вход</button>
      <button @click="openRegisterModal" class="auth-btn register-btn">Регистрация</button>
    </div>

    <div class="auth-buttons" v-if="isAuthenticated">
      <button @click="handleLogout" class="auth-btn logout-btn">Выход</button>
    </div>

    <h1>УГАДАЙ ЖИВОТНОЕ</h1>

    <div v-if="showStartScreen" class="screen">
      <button @click="startGame" :disabled="loading">
        {{ loading ? 'ЗАГРУЗКА...' : 'НАЧАТЬ ИГРУ' }}
      </button>
    </div>

    <div v-if="showGameScreen" class="screen">
      <p class="question">{{ currentQuestion }}</p>
      <div class="buttons">
        <button @click="sendAnswer('yes')" :disabled="loading">ДА</button>
        <button @click="sendAnswer('no')" :disabled="loading">НЕТ</button>
      </div>
    </div>

    <div v-if="showGuessScreen" class="screen">
      <p class="question">{{ currentQuestion }}</p>
      <div class="buttons">
        <button class="correct" @click="handleCorrectGuess" :disabled="loading">ВЕРНО</button>
        <button class="incorrect" @click="handleIncorrectGuess" :disabled="loading">НЕВЕРНО</button>
      </div>
    </div>

    <div v-if="showLearnAnimalScreen" class="screen">
      <p class="question">Какое животное вы загадали?</p>
      <div class="input-group">
        <input v-model="newAnimal"
               placeholder="Например: Кенгуру"
               @keyup.enter="submitNewAnimal"
               autofocus />
        <button @click="submitNewAnimal" :disabled="loading">ДАЛЕЕ</button>
      </div>
      <p v-if="errorMessage" class="error-message">{{ errorMessage }}</p>
    </div>

    <div v-if="showLearnQuestionScreen" class="screen">
      <p class="question">Введите вопрос, который отличает ваше животное:</p>
      <div class="input-group">
        <input v-model="newQuestion"
               placeholder="Например: Оно прыгает?"
               @keyup.enter="submitNewQuestion"
               autofocus />
        <button @click="submitNewQuestion" :disabled="loading">ДАЛЕЕ</button>
      </div>
      <p v-if="errorMessage" class="error-message">{{ errorMessage }}</p>
    </div>

    <div v-if="showLearnAnswerScreen" class="screen">
      <p class="question">Какой правильный ответ на этот вопрос для вашего животного?</p>
      <div class="input-group">
        <input v-model="newAnswer"
               placeholder="Введите 'yes' или 'no'"
               @keyup.enter="submitNewAnswer"
               autofocus />
        <button @click="submitNewAnswer" :disabled="loading">ЗАВЕРШИТЬ</button>
      </div>
      <p v-if="errorMessage" class="error-message">{{ errorMessage }}</p>
    </div>

    <div v-if="showResultScreen" class="screen">
      <p class="question">Результат:</p>
      <p class="hint">{{ resultMessage }}</p>
      <button class="restart" @click="restartGame">ИГРАТЬ СНОВА</button>
    </div>

    <div v-if="showErrorScreen" class="screen error">
      <p class="question">{{ errorMessage }}</p>
      <button class="restart" @click="restartGame">ПОПРОБОВАТЬ СНОВА</button>
    </div>

    <div v-if="showLoginModal" class="modal-overlay" @click.self="closeModals">
      <div class="modal">
        <h2>Вход</h2>
        <div class="modal-content">
          <div class="input-group">
            <label>Email:</label>
            <input v-model="loginData.email" type="email" placeholder="Введите email" />
          </div>
          <div class="input-group">
            <label>Пароль:</label>
            <input v-model="loginData.password" type="password" placeholder="Введите пароль" />
          </div>
          <p v-if="authError" class="error-message">{{ authError }}</p>
          <button @click="handleLogin" class="modal-btn">Войти</button>
          <button @click="closeModals" class="modal-btn cancel-btn">Отмена</button>
        </div>
      </div>
    </div>

    <div v-if="showRegisterModal" class="modal-overlay" @click.self="closeModals">
      <div class="modal">
        <h2>Регистрация</h2>
        <div class="modal-content">
          <div class="input-group">
            <label>Логин:</label>
            <input v-model="registerData.username" placeholder="Введите логин" />
          </div>
          <div class="input-group">
            <label>Email:</label>
            <input v-model="registerData.email" type="email" placeholder="Введите email" />
          </div>
          <div class="input-group">
            <label>Пароль:</label>
            <input v-model="registerData.password" type="password" placeholder="Введите пароль" />
          </div>
          <p v-if="authError" class="error-message">{{ authError }}</p>
          <button @click="handleRegister" class="modal-btn">Зарегистрироваться</button>
          <button @click="closeModals" class="modal-btn cancel-btn">Отмена</button>
        </div>
      </div>
    </div>
  </div>
</template>
<style>
.game-container {
  min-width: 800px;
  min-height: 450px;
  margin: 50px auto;
  padding: 25px;
  margin-left: 200px;
  font-family: 'Poppins', sans-serif;
  background: linear-gradient(135deg, #f5f7fa, #e4e9f7);
  border-radius: 20px;
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
  position: relative;
}

.auth-buttons {
  position: absolute;
  top: 20px;
  right: 20px;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.auth-btn {
  padding: 10px 18px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-size: 0.9rem;
  font-weight: 600;
  transition: transform 0.2s, background-color 0.3s;
}

.auth-btn:hover {
  transform: translateY(-2px);
}

.login-btn {
  background-color: #dfe6e9;
  color: #2d3436;
}

.login-btn:hover {
  background-color: #b2bec3;
}

.register-btn {
  background-color: #6c5ce7;
  color: white;
}

.register-btn:hover {
  background-color: #5a4db8;
}

.logout-btn {
  background-color: #e17055;
  color: white;
}

.logout-btn:hover {
  background-color: #d35400;
}

h1 {
  font-size: 2.2rem;
  color: #2d3436;
  text-align: center;
  margin-bottom: 30px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 1px;
}

.screen {
  background: #ffffff;
  border-radius: 15px;
  padding: 30px;
  margin-bottom: 50px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
  transition: transform 0.3s ease;
}

.screen:hover {
  transform: translateY(-5px);
}

.question {
  font-size: 1.4rem;
  font-weight: 600;
  margin-bottom: 20px;
  color: #2d3436;
  line-height: 1.5;
}

.hint {
  font-size: 0.9rem;
  color: #636e72;
  margin-bottom: 20px;
  font-style: italic;
}

.buttons {
  display: flex;
  gap: 15px;
  justify-content: center;
  margin-top: 20px;
}

.input-group {
  display: flex;
  flex-direction: column;
  gap: 15px;
  width: 100%;
}

input {
  padding: 12px 15px;
  font-size: 1rem;
  border: 2px solid #dfe6e9;
  border-radius: 8px;
  width: 100%;
  box-sizing: border-box;
  transition: border-color 0.3s, box-shadow 0.3s;
}

input:focus {
  border-color: #6c5ce7;
  box-shadow: 0 0 8px rgba(108, 92, 231, 0.3);
  outline: none;
}

button {
  padding: 12px 25px;
  font-size: 1rem;
  font-weight: 600;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.3s, transform 0.2s;
  text-transform: uppercase;
}

button:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

button:not(.correct):not(.incorrect):not(.restart):not(.auth-btn):not(.modal-btn) {
  background: #6c5ce7;
  color: white;
}

button:not(.correct):not(.incorrect):not(.restart):not(.auth-btn):not(.modal-btn):hover {
  background: #5a4db8;
  transform: translateY(-2px);
}

.correct {
  background: #00b894;
  color: white;
}

.correct:hover {
  background: #009e7a;
  transform: translateY(-2px);
}

.incorrect {
  background: #e17055;
  color: white;
}

.incorrect:hover {
  background: #d35400;
  transform: translateY(-2px);
}

.restart {
  background: #f1c40f;
  color: #2d3436;
  width: 100%;
}

.restart:hover {
  background: #d4ac0d;
  transform: translateY(-2px);
}

.error-message {
  color: #e17055;
  margin-top: 10px;
  font-size: 0.9rem;
  font-weight: 600;
}

.error {
  background: #fff5f5;
  border: 2px solid #fab1a0;
}

/* Modal Styles */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.6);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
  animation: fadeIn 0.3s ease;
}

.modal {
  background: #ffffff;
  border-radius: 15px;
  padding: 30px;
  width: 100%;
  max-width: 450px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
  transform: scale(0.9);
  animation: scaleUp 0.3s ease forwards;
}

.modal h2 {
  margin-top: 0;
  color: #2d3436;
  text-align: center;
  font-weight: 700;
}

.modal-content {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.modal-btn {
  padding: 12px;
  border: none;
  border-radius: 8px;
  font-size: 0.95rem;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.3s, transform 0.2s;
}

.modal-btn:not(.cancel-btn) {
  background-color: #6c5ce7;
  color: white;
}

.modal-btn:not(.cancel-btn):hover {
  background-color: #5a4db8;
  transform: translateY(-2px);
}

.cancel-btn {
  background-color: #dfe6e9;
  color: #2d3436;
}

.cancel-btn:hover {
  background-color: #b2bec3;
  transform: translateY(-2px);
}

label {
  font-weight: 600;
  margin-bottom: 5px;
  color: #2d3436;
  font-size: 0.9rem;
}

/* Animations */
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

@keyframes scaleUp {
  from { transform: scale(0.9); opacity: 0.7; }
  to { transform: scale(1); opacity: 1; }
}

/* Responsive Design */
@media (max-width: 600px) {
  .game-container {
    margin: 10px;
    padding: 15px;
  }

  h1 {
    font-size: 1.8rem;
  }

  .screen {
    padding: 20px;
  }

  button, input {
    font-size: 0.9rem;
    padding: 10px;
  }

  .auth-buttons {
    top: 10px;
    right: 10px;
  }
}
</style>