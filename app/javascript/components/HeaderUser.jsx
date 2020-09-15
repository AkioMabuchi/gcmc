import React from "react"

class HeaderUser extends React.Component {
    constructor(props) {
        super(props);
        this.state={
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
        return(
            <div>
                <button className={'hamburgerButton'} onClick={()=>{this.onClickHamburgerButton()}}>
                    <div className={`hamburgerIcon ${this.state.hamburgerImage}`}></div>
                </button>
                <div className={`pull-down-menu ${this.state.pullDownMenu}`}>

                </div>
            </div>
        )
    }
}

export default HeaderUser
