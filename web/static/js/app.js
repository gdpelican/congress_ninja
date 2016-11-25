let Rep = {
  props: ['rep'],
  template: `
    <li>
      {{rep.name}}
    </li>
  `
}

let RepRequestForm = {
  props: ['repRequest'],
  template: `
    <form v-on:submit="submit">
      <input type="number" v-model.trim="repRequest.zip" placeholder="What's your zip code?" />
      <input type="submit" />
    </form>
  `,
  methods: {
    submit(event) {
      event.preventDefault()
      this.$http.post('/api/rep_requests', { rep_request: { zip: this.repRequest.zip } }).then((response) => {
        this.$emit('request-saved', response.body.rep_request)
      }, (error) => {
        console.log(error)
      })
    }
  }
}

window.CN = new Vue({
  el: '#app',
  data: { loaded: false, repRequest: {} },
  components: { 'rep': Rep, 'rep-request-form': RepRequestForm },
  template: `
    <section v-if="repRequest.id">
      <ul>
        <rep v-bind:rep="rep" v-for="rep in repRequest.reps"></rep>
      </ul>
      <div v-if="repRequest.reps.length == 0">No rep!</div>
      <div v-if="repRequest.reps.length > 1">Multiple reps!</div>
    </section>
    <rep-request-form v-else v-on:request-saved="saveRequest" v-bind:rep-request="repRequest"></rep-request-form>
  `,
  methods: {
    saveRequest(repRequest) {
      this.repRequest = repRequest
      console.log(repRequest.reps)
    }
  }
})
