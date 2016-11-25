window.CN = new Vue({
  el: '#app',
  data: { loaded: false, repRequest: {} },
  methods: {
    submit(event) {
      console.log('submitted')
      event.preventDefault()
      this.$http.post('/api/rep_requests', { rep_request: this.repRequest }).then((response) => {
        console.log(response)
      }, (error) => {
        console.log(error)
      })
    }
  }
})
