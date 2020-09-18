import React from "react"

class HeaderGuest extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isPullDownMenuOpen: false,
      hamburgerImage: "close",
      pullDownMenu: "close"
    };
  }

  onClickHamburgerButton(){
    if(this.state.isPullDownMenuOpen){
      this.setState({isPullDownMenuOpen: false});
      this.setState({hamburgerImage: "close"});
      this.setState({pullDownMenu: "close"});
    }else{
      this.setState({isPullDownMenuOpen: true});
      this.setState({hamburgerImage: "open"});
      this.setState({pullDownMenu: "open-user"});
    }
  }

  render() {
    return (
        <div>
          <a href={"/login"} className={"login-button"} style={{"right":"130px"}}>ログイン</a>
          <a href={"/signup"} className={"login-button"} style={{"right":"10px"}}>新規登録</a>
          <button className={'hamburgerButton'} onClick={() => {this.onClickHamburgerButton()}}>
            <div className={`hamburgerIcon ${this.state.hamburgerImage}`}></div>
          </button>
          <div className={`pull-down-menu ${this.state.pullDownMenu}`}>

          </div>
        </div>
    )
  }
}

export default HeaderGuest
