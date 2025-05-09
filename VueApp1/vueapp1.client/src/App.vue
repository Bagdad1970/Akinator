<script setup>
  import { ref } from 'vue';

  const currentQuestion = ref("НАЖМИТЕ 'НАЧАТЬ ИГРУ'");
  const gameStarted = ref(false);
  const loading = ref(false);
  const result = ref(null);
  const showResultButtons = ref(false);
  const showRestartButton = ref(false);

  const startGame = async () => {
    loading.value = true;
    result.value = null;
    showResultButtons.value = false;
    showRestartButton.value = false;
    try {
      const res = await fetch('https://localhost:7138/start', {
        method: 'POST'
      });
      const data = await res.json();
      currentQuestion.value = data.question.toUpperCase();
      gameStarted.value = true;
    } catch (err) {
      currentQuestion.value = `ОШИБКА: ${err.message.toUpperCase()}`;
    } finally {
      loading.value = false;
    }
  };

  const sendAnswer = async (answer) => {
    loading.value = true;
    try {
      const res = await fetch('https://localhost:7138/answer', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ Answer: answer })
      });
      const data = await res.json();

      if (data.response.includes("Я думаю, вы загадали:")) {
        result.value = data.response.toUpperCase();
        gameStarted.value = false;
        showResultButtons.value = true;
      }
      else if (data.response.includes("Ни одно животное") ||
        data.response.includes("Возможные варианты:")) {
        result.value = data.response.toUpperCase();
        gameStarted.value = false;
        showRestartButton.value = true;
      }
      else {
        currentQuestion.value = data.response.toUpperCase();
      }
    } catch (err) {
      currentQuestion.value = `ОШИБКА: ${err.message.toUpperCase()}`;
    } finally {
      loading.value = false;
    }
  };

  const reloadPage = () => {
    window.location.reload();
  };
</script>

<template>
  <div class="app">
    <h1>УГАДАЮ ЖИВОТНОЕ</h1>

    <div v-if="!gameStarted && !result && !showRestartButton" class="center-content">
      <button @click="startGame" :disabled="loading">
        {{ loading ? 'ЗАГРУЗКА...' : 'НАЧАТЬ ИГРУ' }}
      </button>
    </div>

    <div v-if="gameStarted" class="center-content">
      <p class="large-text">{{ currentQuestion }}</p>
      <div class="buttons">
        <button @click="sendAnswer('1')" :disabled="loading">ДА</button>
        <button @click="sendAnswer('0')" :disabled="loading">НЕТ</button>
      </div>
    </div>

    <div v-if="result" class="center-content result">
      <p class="large-text">{{ result }}</p>

      <div v-if="showResultButtons" class="buttons">
        <button @click="reloadPage" class="correct">ВЕРНО</button>
        <button @click="reloadPage" class="incorrect">НЕВЕРНО</button>
      </div>

      <div v-if="showRestartButton" class="buttons">
        <button @click="reloadPage" class="restart">ПЕРЕЗАГРУЗИТЬ</button>
      </div>
    </div>
  </div>
</template>

<style>
  .app {
    text-align: center;
    font-family: Arial, sans-serif;
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
  }

  h1 {
    font-size: 2.5rem;
    margin-bottom: 2rem;
    text-transform: uppercase;
  }

  .center-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 300px;
  }

  .large-text {
    font-size: 1.8rem;
    margin: 2rem 0;
    font-weight: bold;
    text-transform: uppercase;
  }

  .buttons {
    display: flex;
    gap: 20px;
    margin-top: 1rem;
    justify-content: center;
  }

  button {
    padding: 12px 24px;
    font-size: 1.2rem;
    cursor: pointer;
    text-transform: uppercase;
    font-weight: bold;
    border: none;
    border-radius: 5px;
    transition: background-color 0.3s;
  }

    button:disabled {
      background-color: #cccccc;
      cursor: not-allowed;
    }

  .result {
    background-color: #f8f8f8;
    padding: 2rem;
    border-radius: 10px;
    margin-top: 2rem;
  }

  /* Стили для кнопок ДА/НЕТ */
  button:not(.correct):not(.incorrect):not(.restart) {
    background-color: #4CAF50;
    color: white;
  }

    button:not(.correct):not(.incorrect):not(.restart):hover {
      background-color: #45a049;
    }

  /* Стили для кнопки ВЕРНО */
  .correct {
    background-color: #2196F3;
    color: white;
  }

    .correct:hover {
      background-color: #0b7dda;
    }

  /* Стили для кнопки НЕВЕРНО */
  .incorrect {
    background-color: #f44336;
    color: white;
  }

    .incorrect:hover {
      background-color: #da190b;
    }

  /* Стили для кнопки ПЕРЕЗАГРУЗИТЬ */
  .restart {
    background-color: #ff9800;
    color: white;
  }

    .restart:hover {
      background-color: #e68a00;
    }
</style>
