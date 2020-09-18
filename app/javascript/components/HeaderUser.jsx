import React from "react"

class HeaderUser extends React.Component {
    constructor(props) {
        super(props);
        this.state={
            isPullDownMenuOpen: false,
            isPopupMenuOpen: false,
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

    onClickUserButton(){
        this.setState({isPopupMenuOpen: !this.state.isPopupMenuOpen});
    }

    render() {
        let popupMenu;

        if(this.state.isPopupMenuOpen){
            popupMenu = (
                <div className={'popup-menu'}>
                    <div className={'popup-menu-name'}>
                        {this.props.name}
                    </div>
                    <ul>
                        <li>
                            <a href={"/"}>招待一覧（0件）</a>
                        </li>
                        <li>
                            <a href={"/"}>参加中のプロジェクト</a>
                        </li>
                        <li>
                            <a href={"/"}>プロジェクト設定</a>
                        </li>
                        <li>
                            <a href={"/"}>プロフィール</a>
                        </li>
                        <li>
                            <a href={"/"}>アカウント設定</a>
                        </li>
                        <li>
                            <form action={'/logout'} method={'POST'}>
                                <button type={'submit'}>
                                    ログアウト
                                </button>
                            </form>
                        </li>
                    </ul>
                </div>
            );
        }
        return(
            <div>
                <button className={'hamburgerButton'} onClick={()=>{this.onClickHamburgerButton()}}>
                    <div className={`hamburgerIcon ${this.state.hamburgerImage}`}></div>
                </button>
                <div className={`pull-down-menu ${this.state.pullDownMenu}`}>

                </div>
                <button className={'user-button'} onClick={()=>{this.onClickUserButton()}}>
                    <img src={this.props.image} alt={''} />
                </button>
                {popupMenu}
            </div>
        )
    }
}

export default HeaderUser
