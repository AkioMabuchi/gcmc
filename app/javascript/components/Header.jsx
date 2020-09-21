import React from "react"

class Header extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            isPullDownMenuOpen: false,
            hamburgerImage: "close",
            pullDownMenu: "close",
            isPopupMenuOpen: false
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
            if(this.props.mode === "guest"){
                this.setState({pullDownMenu: "open-guest"});
            }
            if(this.props.mode === "user"){
                this.setState({pullDownMenu: "open-user"});
            }
        }
    }

    onClickUserButton(){
        this.setState({isPopupMenuOpen: !this.state.isPopupMenuOpen});
    }

    render(){
        let headerRightSide;
        let pullDownMenuBottom;
        let popupMenu;
        if(this.props.mode === "guest"){
            headerRightSide = (
                <div>
                    <a href={"/login"} className={"guest-button"}>ログイン</a>
                    <a href={"/signup"} className={"guest-button"}>新規登録</a>
                </div>
            );
            pullDownMenuBottom = (
                <div className={'bottom-menu'}>
                    <ul>
                        <li>
                            <a href={'/login'}>ログイン</a>
                        </li>
                        <li>
                            <a href={'/signup'}>新規登録</a>
                        </li>
                    </ul>
                </div>
            );
        }
        if(this.props.mode === "user"){
            headerRightSide = (
                <div>
                    <a href={"/projects/create"} className={'new-project-button'}>新規プロジェクト</a>
                    <button className={'user-button'} onClick={()=>{this.onClickUserButton()}}>
                        <img src={this.props.image} alt={''} />
                    </button>
                </div>
            );
            pullDownMenuBottom = (
                <div className={'bottom-menu'}>
                    <ul>
                        <li>
                            <div className={'user-info'}>
                                <img src={this.props.image} alt={''}/>
                                <div className={'user-name'}>{this.props.name}</div>
                            </div>
                        </li>
                        <li>
                            <a href={'/users/invitations'}>招待一覧（{this.props.invitations}件）</a>
                        </li>
                        <li>
                            <a href={'/projects/create'}>新規プロジェクト</a>
                        </li>
                        <li>
                            <a href={'/projects/attends'}>参加中のプロジェクト</a>
                        </li>
                        <li>
                            <a href={'/projects/settings'}>プロジェクト設定</a>
                        </li>
                        <li>
                            <a href={`/users/user/${this.props.permalink}`}>プロフィール</a>
                        </li>
                        <li>
                            <a href={'/users/settings/profile'}>アカウント設定</a>
                        </li>
                        <li>
                            <form action={'/logout'} method={'POST'}>
                                <button type={'submit'}>ログアウト</button>
                            </form>
                        </li>
                    </ul>
                </div>
            );
        }


        if(this.state.isPopupMenuOpen){
            popupMenu = (
                <div className={'popup-menu'}>
                    <div className={'popup-menu-name'}>
                        {this.props.name}
                    </div>
                    <ul>
                        <li>
                            <a href={"/users/invitations"}>招待一覧（{this.props.invitations}件）</a>
                        </li>
                        <li>
                            <a href={"/projects/attends"}>参加中のプロジェクト</a>
                        </li>
                        <li>
                            <a href={"/projects/settings"}>プロジェクト設定</a>
                        </li>
                        <li>
                            <a href={`/users/user/${this.props.permalink}`}>プロフィール</a>
                        </li>
                        <li>
                            <a href={"/users/settings/profile"}>アカウント設定</a>
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
                <a href={'/'} className={'header-logo'}/>
                <ul className={'header-menu'}>
                    <li>
                        <a href={'/projects'}>プロジェクト</a>
                    </li>
                    <li>
                        <a href={"/users"}>ユーザー</a>
                    </li>
                    <li>
                        <a href={"/board"}>ボード</a>
                    </li>
                    <li>
                        <a href={"/events"}>イベント</a>
                    </li>
                    <li>
                        <a href={"/articles"}>記事一覧</a>
                    </li>
                </ul>
                <form action={'/search'} method={'GET'} className={'header-search-form'}>
                    <input type={'text'} name={'content'} placeholder={'検索'}/>
                    <button type={'submit'}><i className={'fas fa-search'}/></button>
                </form>
                {headerRightSide}
                <button className={'hamburgerButton'} onClick={() => {this.onClickHamburgerButton()}}>
                    <div className={`hamburgerIcon ${this.state.hamburgerImage}`}/>
                </button>
                <div className={`pull-down-menu ${this.state.pullDownMenu}`}>
                    <ul className={'pull-down-menu'}>
                        <li>
                            <a href={'/projects'}>プロジェクト</a>
                        </li>
                        <li>
                            <a href={'/users'}>ユーザー</a>
                        </li>
                        <li>
                            <a href={'/board'}>ボード</a>
                        </li>
                        <li>
                            <a href={'/events'}>イベント</a>
                        </li>
                        <li>
                            <a href={'/articles'}>記事一覧</a>
                        </li>
                    </ul>
                    <form action={"/search"} method={'GET'} className={'menu-search-form'}>
                        <input type={'text'} name={'content'} placeholder={'検索'}/>
                        <button type={'submit'}><i className={'fas fa-search'}/></button>
                    </form>
                    {pullDownMenuBottom}
                </div>
                {popupMenu}
            </div>
        )
    }
}

export default Header
