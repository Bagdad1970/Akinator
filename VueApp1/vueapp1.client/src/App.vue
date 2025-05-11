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

  const showStartScreen = computed(() => gameState.value === GAME_STATES.START);
  const showGameScreen = computed(() => gameState.value === GAME_STATES.PLAYING);
  const showGuessScreen = computed(() => gameState.value === GAME_STATES.GUESS);
  const showLearnAnimalScreen = computed(() => gameState.value === GAME_STATES.LEARN_ANIMAL);
  const showLearnQuestionScreen = computed(() => gameState.value === GAME_STATES.LEARN_QUESTION);
  const showLearnAnswerScreen = computed(() => gameState.value === GAME_STATES.LEARN_ANSWER);
  const showResultScreen = computed(() => gameState.value === GAME_STATES.RESULT);
  const showErrorScreen = computed(() => gameState.value === GAME_STATES.ERROR);

  const API_URL = 'https://localhost:7138';

  async function makeRequest(endpoint, body = null) {
    try {
      loading.value = true;
      const options = {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
      };

      if (body) options.body = JSON.stringify(body);

      const response = await fetch(`${API_URL}/${endpoint}`, options);

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.detail || `HTTP error! Status: ${response.status}`);
      }

      return await response.json();
    } catch (error) {
      console.error('API Error:', error);
      gameState.value = GAME_STATES.ERROR;
      errorMessage.value = error.message.includes('Failed to fetch')
        ? 'ОШИБКА: СЕРВЕР НЕ ОТВЕЧАЕТ. ПРОВЕРЬТЕ БЭКЕНД'
        : `ОШИБКА: ${error.message.toUpperCase()}`;
      return null;
    } finally {
      loading.value = false;
    }
  }

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
    }
    else if (response.includes('ВВЕДИТЕ НОВОЕ ЖИВОТНОЕ') || data.awaitingAnimalName) {
      gameState.value = GAME_STATES.LEARN_ANIMAL;
    }
    else if (response.includes('ВВЕДИТЕ ВОПРОС') || data.awaitingQuestionText) {
      gameState.value = GAME_STATES.LEARN_QUESTION;
    }
    else if (response.includes('ВВЕДИТЕ ОТВЕТ') || data.awaitingQuestionAnswer) {
      gameState.value = GAME_STATES.LEARN_ANSWER;
    }
    else if (response.includes('УРА Я УГАДАЛ') || response.includes('ИГРА ЗАВЕРШЕНА') || response.includes('СПАСИБО')) {
      resultMessage.value = response;
      gameState.value = GAME_STATES.RESULT;
    }
    else {
      currentQuestion.value = response;
      gameState.value = GAME_STATES.PLAYING;
    }
  }

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

  function submitNewAnimal() {
    if (!newAnimal.value.trim()) {
      errorMessage.value = 'Введите название животного!';
      return;
    }
    errorMessage.value = '';
    sendAnswer(newAnimal.value.trim());
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
</script>

<template>
  <div class="game-container">
    <h1>УГАДАЙ ЖИВОТНОЕ</h1>

    <!-- Начальный экран -->
    <div v-if="showStartScreen" class="screen">
      <button @click="startGame" :disabled="loading">
        {{ loading ? 'ЗАГРУЗКА...' : 'НАЧАТЬ ИГРУ' }}
      </button>
    </div>

    <!-- Основной игровой экран (только кнопки Да/Нет) -->
    <div v-if="showGameScreen" class="screen">
      <p class="question">{{ currentQuestion }}</p>
      <div class="buttons">
        <button @click="sendAnswer('yes')" :disabled="loading">ДА</button>
        <button @click="sendAnswer('no')" :disabled="loading">НЕТ</button>
      </div>
    </div>

    <!-- Экран угадывания (кнопки Верно/Неверно) -->
    <div v-if="showGuessScreen" class="screen">
      <p class="question">{{ currentQuestion }}</p>
      <div class="buttons">
        <button class="correct" @click="handleCorrectGuess" :disabled="loading">ВЕРНО</button>
        <button class="incorrect" @click="handleIncorrectGuess" :disabled="loading">НЕВЕРНО</button>
      </div>
    </div>

    <!-- Ввод нового животного -->
    <div v-if="showLearnAnimalScreen" class="screen">
      <p class="question">Какое животное вы загадали?</p>
      <div class="input-group">
        <input v-model="newAnimal"
               placeholder="Например: Кенгуру"
               @keyup.enter="submitNewAnimal"
               autofocus />
        <button @click="submitNewAnimal" :disabled="loading || !newAnimal.trim()">ДАЛЕЕ</button>
      </div>
      <p v-if="errorMessage" class="error-message">{{ errorMessage }}</p>
    </div>

    <!-- Ввод нового вопроса -->
    <div v-if="showLearnQuestionScreen" class="screen">
      <p class="question">Вопрос, который отличает ваше животное:</p>
      <p class="hint">(Например: "Оно прыгает?" или "У него есть сумка?")</p>
      <div class="input-group">
        <input v-model="newQuestion"
               placeholder="Введите вопрос"
               @keyup.enter="submitNewQuestion"
               autofocus />
        <button @click="submitNewQuestion" :disabled="loading || !newQuestion.trim()">ДАЛЕЕ</button>
      </div>
      <p v-if="errorMessage" class="error-message">{{ errorMessage }}</p>
    </div>

    <!-- Ввод ответа на вопрос -->
    <div v-if="showLearnAnswerScreen" class="screen">
      <p class="question">Какой ответ на вопрос для вашего животного?</p>
      <p class="hint">"{{ newQuestion }}"</p>
      <div class="input-group">
        <input v-model="newAnswer"
               placeholder="yes или no"
               @keyup.enter="submitNewAnswer"
               autofocus />
        <button @click="submitNewAnswer" :disabled="loading || !newAnswer.trim()">ЗАВЕРШИТЬ ОБУЧЕНИЕ</button>
      </div>
      <p v-if="errorMessage" class="error-message">{{ errorMessage }}</p>
    </div>

    <!-- Экран результата (только кнопка перезагрузки) -->
    <div v-if="showResultScreen" class="screen">
      <p class="question">Ура! Я угадал!</p>
      <p class="hint">{{ resultMessage }}</p>
      <button class="restart" @click="restartGame">ИГРАТЬ СНОВА</button>
    </div>

    <!-- Экран ошибки -->
    <div v-if="showErrorScreen" class="screen error">
      <p class="question">{{ errorMessage }}</p>
      <button class="restart" @click="restartGame">ПОПРОБОВАТЬ СНОВА</button>
    </div>
  </div>
</template>

<style>
  .game-container {
    max-width: 600px;
    margin: 0 auto;
    padding: 20px;
    font-family: 'Arial', sans-serif;
  }

  h1 {
    font-size: 2.2rem;
    color: #2c3e50;
    text-align: center;
    margin-bottom: 30px;
    text-transform: uppercase;
  }

  .screen {
    background: #f8f9fa;
    border-radius: 10px;
    padding: 30px;
    margin-bottom: 20px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  }

  .question {
    font-size: 1.4rem;
    font-weight: bold;
    margin-bottom: 20px;
    color: #34495e;
    line-height: 1.4;
  }

  .hint {
    font-size: 0.9rem;
    color: #7f8c8d;
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
    border: 2px solid #ddd;
    border-radius: 6px;
    width: 100%;
    box-sizing: border-box;
    transition: border 0.2s;
  }

    input:focus {
      border-color: #3498db;
      outline: none;
    }

  button {
    padding: 12px 25px;
    font-size: 1rem;
    font-weight: bold;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.2s;
    text-transform: uppercase;
  }

    button:disabled {
      opacity: 0.7;
      cursor: not-allowed;
    }

    button:not(.correct):not(.incorrect):not(.restart) {
      background: #3498db;
      color: white;
    }

      button:not(.correct):not(.incorrect):not(.restart):hover {
        background: #2980b9;
      }

  .correct {
    background: #2ecc71;
    color: white;
  }

    .correct:hover {
      background: #27ae60;
    }

  .incorrect {
    background: #e74c3c;
    color: white;
  }

    .incorrect:hover {
      background: #c0392b;
    }

  .restart {
    background: #f39c12;
    color: white;
    width: 100%;
  }

    .restart:hover {
      background: #d35400;
    }

  .error-message {
    color: #e74c3c;
    margin-top: 10px;
    font-weight: bold;
  }

  .error {
    background: #ffebee;
    border: 2px solid #ef9a9a;
  }
</style>
