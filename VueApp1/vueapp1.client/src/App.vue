<template>
  <div class="game-container">
    <div class="account-status">
      Аккаунт: {{ accountStatus }}
    </div>

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
      <button class="restart" @click="restartGame">В МЕНЮ</button>
    </div>

    <div v-if="showErrorScreen" class="screen error">
      <p class="question">{{ errorMessage }}</p>
      <button class="restart" @click="restartGame">В МЕНЮ</button>
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

<script>
  export default {
    data() {
      return {
        GAME_STATES: {
          START: 'start',
          PLAYING: 'playing',
          GUESS: 'guess',
          LEARN_ANIMAL: 'learn_animal',
          LEARN_QUESTION: 'learn_question',
          LEARN_ANSWER: 'learn_answer',
          RESULT: 'result',
          ERROR: 'error'
        },
        gameState: 'start',
        currentQuestion: "НАЖМИТЕ 'НАЧАТЬ ИГРУ'",
        loading: false,
        resultMessage: '',
        errorMessage: '',
        newAnimal: '',
        newQuestion: '',
        newAnswer: '',
        showLoginModal: false,
        showRegisterModal: false,
        loginData: { email: '', password: '' },
        registerData: { username: '', email: '', password: '' },
        isAuthenticated: false,
        username: '',
        userId: null,
        authError: '',
        API_URL: 'https://localhost:7138',
        statistics: {
          userId: null,
          sessionStart: null,
          sessionEnd: null,
          totalQuestionsAsked: 0,
          answers: [],
          guessedAnimal: null,
          addedAnimal: null,
          wasCorrectGuess: null
        }
      }
    },
    computed: {
      showStartScreen() {
        return this.gameState === this.GAME_STATES.START
      },
      showGameScreen() {
        return this.gameState === this.GAME_STATES.PLAYING
      },
      showGuessScreen() {
        return this.gameState === this.GAME_STATES.GUESS
      },
      showLearnAnimalScreen() {
        return this.gameState === this.GAME_STATES.LEARN_ANIMAL
      },
      showLearnQuestionScreen() {
        return this.gameState === this.GAME_STATES.LEARN_QUESTION
      },
      showLearnAnswerScreen() {
        return this.gameState === this.GAME_STATES.LEARN_ANSWER
      },
      showResultScreen() {
        return this.gameState === this.GAME_STATES.RESULT
      },
      showErrorScreen() {
        return this.gameState === this.GAME_STATES.ERROR
      },
      accountStatus() {
        return this.isAuthenticated ? this.username : 'Гость'
      }
    },
    created() {
      const token = localStorage.getItem('token')
      if (token) {
        this.isAuthenticated = true
        const savedUsername = localStorage.getItem('username')
        const savedUserId = localStorage.getItem('userId')
        console.log(savedUserId)
        if (savedUsername && savedUserId) {
          this.username = savedUsername
          const parsedUserId = parseInt(savedUserId, 10)
          this.userId = isNaN(parsedUserId) ? null : parsedUserId
          this.statistics.userId = this.userId
          console.log('Initial statistics on created:', this.statistics)
        }
      }
    },
    methods: {
      async makeRequest(endpoint, body = null, method = 'POST') {
        try {
          this.loading = true
          const options = {
            method,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': this.isAuthenticated ? `Bearer ${localStorage.getItem('token')}` : ''
            },
          }

          if (body) options.body = JSON.stringify(body)

          const response = await fetch(`${this.API_URL}/${endpoint}`, options)
          const responseText = await response.text()
          let data = null

          try {
            data = JSON.parse(responseText)
          } catch (jsonError) {
            console.error('JSON parse error:', jsonError, 'Response:', responseText)
            throw new Error('Invalid JSON response from server')
          }

          if (!response.ok) {
            throw new Error(data.message || data.detail || `HTTP error! Status: ${response.status}`)
          }

          return { data, status: response.status }
        } catch (error) {
          console.error('API Error:', error)
          this.errorMessage = error.message.includes('Failed to fetch')
            ? 'ОШИБКА: СЕРВЕР НЕ ОТВЕЧАЕТ. ПРОВЕРЬТЕ БЭКЕНД'
            : `ОШИБКА: ${error.message.toUpperCase()}`
          this.gameState = this.GAME_STATES.ERROR
          return null
        } finally {
          this.loading = false
        }
      },

      async saveStatistics() {
        if (!this.isAuthenticated) {
          console.warn('Skipping statistics save: User not authenticated')
          return
        }
        const statsToSend = {
          userId: this.statistics.userId,
          sessionStart: this.statistics.sessionStart,
          sessionEnd: new Date().toISOString(),
          totalQuestionsAsked: this.statistics.answers.length,
          answers: JSON.stringify(this.statistics.answers),
          guessedAnimal: this.statistics.guessedAnimal,
          addedAnimal: this.statistics.addedAnimal,
          wasCorrectGuess: this.statistics.wasCorrectGuess
        }
        console.log('Saving statistics to api/game/end:', JSON.stringify(statsToSend, null, 2))
        const result = await this.makeRequest('end', statsToSend)
        console.log('Server response:', result)
      },

      async startGame() {
        this.statistics = {
          userId: this.isAuthenticated && this.userId ? this.userId : 1,
          sessionStart: new Date().toISOString(),
          sessionEnd: null,
          totalQuestionsAsked: 0,
          answers: [],
          guessedAnimal: null,
          addedAnimal: null,
          wasCorrectGuess: null
        }
        console.log('Statistics on game start:', this.statistics)
        const result = await this.makeRequest('start')
        if (!result) return

        this.currentQuestion = result.data.question.toUpperCase()
        this.gameState = this.GAME_STATES.PLAYING
      },

      async sendAnswer(answer) {
        this.statistics.answers.push(answer)
        this.statistics.totalQuestionsAsked = this.statistics.answers.length
        console.log('Statistics after answer:', this.statistics)
        const result = await this.makeRequest('answer', { Answer: answer })
        if (!result) return

        const response = result.data.response.toUpperCase()

        if (response.includes('ПРЕДПОЛОЖЕНИЕ:')) {
          this.currentQuestion = response
          this.statistics.guessedAnimal = response.replace('ПРЕДПОЛОЖЕНИЕ: ', '').trim()
          console.log('Statistics after guess:', this.statistics)
          this.gameState = this.GAME_STATES.GUESS
        } else if (response.includes('НАЗЫВАЕТСЯ ВАШЕ ЖИВОТНОЕ') || result.data.awaitingAnimalName) {
          this.gameState = this.GAME_STATES.LEARN_ANIMAL
        } else if (response.includes('ВВЕДИТЕ ВОПРОС') || result.data.awaitingQuestionText) {
          this.gameState = this.GAME_STATES.LEARN_QUESTION
        } else if (response.includes('ВВЕДИТЕ ОТВЕТ') || result.data.awaitingQuestionAnswer) {
          this.gameState = this.GAME_STATES.LEARN_ANSWER
        } else if (response.includes('УРА Я УГАДАЛ') || response.includes('ИГРА ЗАВЕРШЕНА') || response.includes('СПАСИБО! Я запомнил животное')) {
          this.resultMessage = response
          this.gameState = this.GAME_STATES.RESULT
          await this.saveStatistics()
        } else {
          this.currentQuestion = response
          console.log('Statistics after next question:', this.statistics)
          this.gameState = this.GAME_STATES.PLAYING
        }
      },

      async handleCorrectGuess() {
        this.statistics.wasCorrectGuess = true
        this.statistics.totalQuestionsAsked = this.statistics.answers.length
        console.log('Statistics after correct guess:', this.statistics)
        this.resultMessage = this.currentQuestion
        this.gameState = this.GAME_STATES.RESULT
        await this.saveStatistics()
      },

      async handleIncorrectGuess() {
        this.statistics.wasCorrectGuess = false
        console.log('Statistics after incorrect guess:', this.statistics)
        this.sendAnswer('no')
        this.newAnimal = ''
        this.newQuestion = ''
        this.newAnswer = ''
      },

      async submitNewAnimal() {
        if (!this.newAnimal.trim()) {
          this.errorMessage = 'Введите название животного!'
          return
        }
        this.errorMessage = ''
        this.statistics.addedAnimal = this.newAnimal.trim()
        console.log('Statistics after new animal:', this.statistics)
        this.sendAnswer(this.newAnimal.trim())
        this.resultMessage = `СПАСИБО! Я запомнил животное: ${"'" + this.newAnimal.trim().toUpperCase() + "'"}`
        this.gameState = this.GAME_STATES.RESULT
        this.newAnimal = ''
        await this.saveStatistics()
      },

      async submitNewQuestion() {
        if (!this.newQuestion.trim()) {
          this.errorMessage = 'Введите текст вопроса!'
          return
        }
        this.errorMessage = ''
        console.log('Statistics before new question:', this.statistics)
        this.sendAnswer(this.newQuestion.trim())
      },

      async submitNewAnswer() {
        const answer = this.newAnswer.trim().toLowerCase()
        if (answer !== 'yes' && answer !== 'no') {
          this.errorMessage = 'Введите "yes" или "no"!'
          return
        }
        this.errorMessage = ''
        console.log('Statistics before new answer:', this.statistics)
        this.sendAnswer(answer)
        await this.saveStatistics()
      },

      async restartGame() {
        this.gameState = this.GAME_STATES.START
        this.currentQuestion = "НАЖМИТЕ 'НАЧАТЬ ИГРУ'"
        this.resultMessage = ''
        this.errorMessage = ''
        this.newAnimal = ''
        this.newQuestion = ''
        this.newAnswer = ''
        this.statistics = {
          userId: this.isAuthenticated ? this.userId : null,
          sessionStart: null,
          sessionEnd: null,
          totalQuestionsAsked: 0,
          answers: [],
          guessedAnimal: null,
          addedAnimal: null,
          wasCorrectGuess: null
        }
      },

      openLoginModal() {
        this.showLoginModal = true
        this.showRegisterModal = false
        this.authError = ''
      },

      openRegisterModal() {
        this.showRegisterModal = true
        this.showLoginModal = false
        this.authError = ''
      },

      closeModals() {
        this.showLoginModal = false
        this.showRegisterModal = false
      },

      async handleLogin() {
        if (!this.loginData.email.trim() || !this.loginData.password.trim()) {
          this.authError = 'Заполните все поля!'
          return
        }

        const result = await this.makeRequest('api/auth/login', {
          email: this.loginData.email.trim(),
          password: this.loginData.password.trim()
        })

        if (result?.data.message === "Logged in successfully") {
          localStorage.setItem('token', result.data.token)
          localStorage.setItem('username', result.data.username)
          localStorage.setItem('email', result.data.email)
          localStorage.setItem('userId', result.data.userId)
          this.isAuthenticated = true
          this.username = result.data.username
          this.userId =  result.data.userId
          this.statistics.userId = result.data.userId
          console.log('Statistics after login:', this.statistics)
          this.closeModals()
          this.loginData = { email: '', password: '' }
        } else {
          this.authError = result?.data.message || 'Ошибка входа'
        }
      },

      async handleRegister() {
        if (!this.registerData.username.trim() ||
          !this.registerData.email.trim() ||
          !this.registerData.password.trim()) {
          this.authError = 'Заполните все поля!'
          return
        }

        const result = await this.makeRequest('api/auth/register', {
          username: this.registerData.username.trim(),
          email: this.registerData.email.trim(),
          password: this.registerData.password.trim()
        })

        if (result?.data.message === "User created successfully") {
          localStorage.setItem('token', result.data.token)
          localStorage.setItem('username', result.data.username)
          localStorage.setItem('email', result.data.email)
          localStorage.setItem('userId', result.data.userId )
          this.isAuthenticated = true
          this.username = result.data.username
          this.userId = result.data.userId
          this.statistics.userId = result.data.userId
          console.log('Statistics after register:', this.statistics)
          this.closeModals()
          this.registerData = { username: '', email: '', password: '' }
        } else {
          this.authError = result?.data.message || 'Ошибка регистрации'
        }
      },

      async handleLogout() {
        const username = localStorage.getItem('username') || '';
        const email = localStorage.getItem('email') || '';
        console.log(email)
        await this.makeRequest('api/auth/logout', {
          username: username,
          email: email
        })
        localStorage.removeItem('token')
        localStorage.removeItem('username')
        localStorage.removeItem('email')
        localStorage.removeItem('userId')
        this.isAuthenticated = false
        this.username = ''
        this.userId = null
        this.statistics.userId = null
        console.log('Statistics after logout:', this.statistics)
      }
    }
  }
</script>

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

.account-status {
  position: absolute;
  top: 20px;
  left: 20px;
  font-weight: 600;
  color: #2d3436;
  background: #f5f7fa;
  padding: 8px 15px;
  border-radius: 8px;
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.auth-buttons {
  position: absolute;
  top: 20px;
  right: 20px;
  display: flex;
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
    min-width: auto;
    margin-left: auto;
  }

  .account-status {
    top: 10px;
    left: 10px;
    font-size: 0.8rem;
    padding: 5px 10px;
  }

  .auth-buttons {
    top: 10px;
    right: 10px;
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
}
</style>
