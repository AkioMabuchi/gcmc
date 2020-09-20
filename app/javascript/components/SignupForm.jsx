import React from "react"

class SignupForm extends React.Component {
  constructor(props) {
    super(props);
    this.state={
      styleOfPermalink: "normal",
      noticeOfPermalink: "",
      styleOfName: "normal",
      noticeOfName: "",
      styleOfEmail: "normal",
      noticeOfEmail: "",
      styleOfPassword: "normal",
      noticeOfPassword: "",
      password: "",
      styleOfPasswordConfirmation: "normal",
      noticeOfPasswordConfirmation: "",
      isPermalinkDone: false,
      isNameDone: false,
      isEmailDone: false,
      isPasswordDone: false,
      isPasswordConfirmationDone: false,
      isAgreementDone: false,
      buttonDisabled: true
    }
  }

  onChangeInputPermalink(e){
    let permalinkRegExp = /^[0-9a-zA-Z\\-]*$/;
    let permalink = e.target.value;
    if(permalink.length === 0){
      this.setState({styleOfPermalink: "error"});
      this.setState({noticeOfPermalink: "入力してください"});
      this.setState({isPermalinkDone: false},()=>{this.confirmComplete()});
    }else if(permalink.length > 24){
      this.setState({styleOfPermalink: "error"});
      this.setState({noticeOfPermalink: "24字以内で入力してください"});
      this.setState({isPermalinkDone: false},()=>{this.confirmComplete()});
    }else if(!permalink.match(permalinkRegExp)){
      this.setState({styleOfPermalink: "error"});
      this.setState({noticeOfPermalink: "英数字およびハイフンのみ利用可能です"});
      this.setState({isPermalinkDone: false},()=>{this.confirmComplete()});
    }else {
      fetch('/signup/confirm/permalink',{
        method: 'POST',
        body: JSON.stringify({
          permalink: permalink
        }),
        headers:{
          'Content-Type': 'application/json'
        }
      }).then((response)=>{
        return response.text()
      }).then((result)=>{
        if(result === "vacant"){
          this.setState({styleOfPermalink: "done"});
          this.setState({noticeOfPermalink: ""});
          this.setState({isPermalinkDone: true},()=>{this.confirmComplete()});
        }else{
          this.setState({styleOfPermalink: "error"});
          this.setState({noticeOfPermalink: "そのユーザーIDは既に使用されています"});
          this.setState({isPermalinkDone: false},()=>{this.confirmComplete()});
        }
      });
    }
  }

  onChangeInputName(e){
    let name = e.target.value;
    if(name.length === 0) {
      this.setState({styleOfName: "error"});
      this.setState({noticeOfName: "入力してください"});
      this.setState({isNameDone: false},()=>{this.confirmComplete()});
    }else if(name.length > 24){
      this.setState({styleOfName: "error"});
      this.setState({noticeOfName: "24字以内で入力してください"});
      this.setState({isNameDone: false},()=>{this.confirmComplete()});
    }else{
      this.setState({styleOfName: "done"});
      this.setState({noticeOfName: ""});
      this.setState({isNameDone: true},()=>{this.confirmComplete()});
    }
  }

  onChangeInputEmail(e){
    let emailRegExp = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
    let email = e.target.value;
    if(email.length === 0){
      this.setState({styleOfEmail: "error"});
      this.setState({noticeOfEmail: "入力してください"});
      this.setState({isEmailDone: false},()=>{this.confirmComplete()});
    }else if(!email.match(emailRegExp)){
      this.setState({styleOfEmail: "error"});
      this.setState({noticeOfEmail: "メールアドレスを入力してください"});
      this.setState({isEmailDone: false},()=>{this.confirmComplete()});
    }else{
      fetch('/signup/confirm/email',{
        method: 'POST',
        body: JSON.stringify({
          email: email
        }),
        headers:{
          'Content-Type': 'application/json'
        }
      }).then((response)=>{
        return response.text()
      }).then((result)=>{
        if(result === "vacant"){
          this.setState({styleOfEmail: "done"});
          this.setState({noticeOfEmail: ""});
          this.setState({isEmailDone: true},()=>{this.confirmComplete()});
        }else{
          this.setState({styleOfEmail: "error"});
          this.setState({noticeOfEmail: "そのメールアドレスは既に使用されています"});
          this.setState({isEmailDone: false},()=>{this.confirmComplete()});
        }
      });
    }

  }

  onChangeInputPassword(e){
    let password = e.target.value;
    this.setState({password: password});
    if(password.length < 8 || password.length > 32){
      this.setState({styleOfPassword: "error"});
      this.setState({noticeOfPassword: "8字以上、32字以下のパスワードを入力してください"});
      this.setState({isPasswordDone: false},()=>{this.confirmComplete()});
    }else{
      this.setState({styleOfPassword: "done"});
      this.setState({noticeOfPassword: ""});
      this.setState({isPasswordDone: true},()=>{this.confirmComplete()});
    }
  }

  onChangeInputPasswordConfirmation(e){
    let passwordConfirmation = e.target.value;
    if(this.state.password === passwordConfirmation){
      this.setState({styleOfPasswordConfirmation: "done"});
      this.setState({noticeOfPasswordConfirmation: ""});
      this.setState({isPasswordConfirmationDone: true},()=>{this.confirmComplete()});
    }else{
      this.setState({styleOfPasswordConfirmation: "error"});
      this.setState({noticeOfPasswordConfirmation: "もう一度入力してください"});
      this.setState({isPasswordConfirmationDone: false},()=>{this.confirmComplete()});
    }
  }

  onChangeInputAgreement(e){
    if(e.target.checked){
      this.setState({isAgreementDone: true},()=>{this.confirmComplete()});
    }else{
      this.setState({isAgreementDone: false}, ()=>{this.confirmComplete()});
    }
  }

  confirmComplete(){
    if(this.state.isPermalinkDone && this.state.isNameDone && this.state.isEmailDone && this.state.isPasswordDone && this.state.isPasswordConfirmationDone && this.state.isAgreementDone){
      this.setState({buttonDisabled: false});
    }else{
      this.setState({buttonDisabled: true});
    }
  }

  render(){
    return(
        <div>
          <form action={'/signup'} method={'POST'} className={'signup-form'}>
            <h4>ユーザーID<small>（必須、24字以内の英数字およびハイフンのみ）</small></h4>
            <input type={'text'} name={'permalink'} className={this.state.styleOfPermalink} onChange={(e)=>{this.onChangeInputPermalink(e)}}/>
            <p className={this.state.styleOfPermalink}>{this.state.noticeOfPermalink}</p>
            <h4>ユーザー名<small>（必須、24字以内）</small></h4>
            <input type={'text'} name={'name'} className={this.state.styleOfName} onChange={(e)=>{this.onChangeInputName(e)}}/>
            <p className={this.state.styleOfName}>{this.state.noticeOfName}</p>
            <h4>メールアドレス<small>（必須）</small></h4>
            <input type={'email'} name={'email'} className={this.state.styleOfEmail} onChange={(e)=>{this.onChangeInputEmail(e)}}/>
            <p className={this.state.styleOfEmail}>{this.state.noticeOfEmail}</p>
            <h4>パスワード<small>（8字以上、32字以内）</small></h4>
            <input type={'password'} name={'password'} className={this.state.styleOfPassword} onChange={(e)=>{this.onChangeInputPassword(e)}}/>
            <p className={this.state.styleOfPassword}>{this.state.noticeOfPassword}</p>
            <h4>パスワード<small>（確認用）</small></h4>
            <input type={'password'} name={'password_confirmation'} className={this.state.styleOfPasswordConfirmation} onChange={(e)=>{this.onChangeInputPasswordConfirmation(e)}}/>
            <p className={this.state.styleOfPasswordConfirmation}>{this.state.noticeOfPasswordConfirmation}</p>
            <div className={'agreement'}>
              <input type={'checkbox'} name={'agreement'} onChange={(e)=>{this.onChangeInputAgreement(e)}}/>
              利用規約に同意します
            </div>
            <button type={'submit'} disabled={this.state.buttonDisabled}>新規登録</button>
          </form>
        </div>
    )
  }
}

export default SignupForm
