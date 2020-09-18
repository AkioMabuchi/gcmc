import React from "react"

class GitHubCallback extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    document.getElementById('react-github-callback-button').click();
  }

  render () {
    return(
        <div>
          <form action={"/auth/github/callback/done"} method={'POST'} className={'auth-form'}>
            <input type={'text'} name={'provider'} value={this.props.provider}/>
            <input type={'text'} name={'github_uid'} value={this.props.github_uid}/>
            <input type={'text'} name={'name'} value={this.props.name}/>
            <input type={'text'} name={'image'} value={this.props.image}/>
            <input type={'text'} name={'description'} value={this.props.description}/>
            <input type={'text'} name={'url'} value={this.props.url}/>
            <input type={'text'} name={'github_url'} value={this.props.github_url}/>
            <input type={'text'} name={'location'} value={this.props.location}/>
            <input type={'submit'} id={'react-github-callback-button'}/>
          </form>
        </div>
    )
  }
}

export default GitHubCallback
