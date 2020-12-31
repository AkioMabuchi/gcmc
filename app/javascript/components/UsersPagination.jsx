import React from "react"

class UsersPagination extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            page: this.props.info.page
        }
    }

    onClickButtonPage(page) {
        this.setState({page: page}, () => {
            document.getElementById("react-user-pagination-form").click();
        });
    }

    render() {
        let q;
        let roles;
        let mode;

        let numberButtons = [];
        let buttons;

        if (this.props.info.q !== null) {
            q = (
                <input type={"hidden"} name={"q"} value={this.props.info.q}/>
            );
        }

        if (this.props.info.roles !== null) {
            roles = (
                <div>
                    {
                        this.props.info.roles.map((role) => {
                            return (
                                <input type={"hidden"} name={"roles[]"} value={role}/>
                            );
                        })
                    }
                </div>
            );
        }

        if (this.props.info.mode !== null) {
            mode = (
                <input type={"hidden"} name={"mode"} value={this.props.info.mode}/>
            );
        }

        if (this.props.info.page <= this.props.info.maxPage) {
            let hasLeftDots = false;
            let hasRightDots = false;

            if(this.props.info.page > 1){
                numberButtons.push(
                    <li>
                        <button type={"button"} onClick={() => {
                            this.onClickButtonPage(1)
                        }}>
                            <i className={"fas fa-angle-double-left"}/>
                        </button>
                    </li>
                );
                numberButtons.push(
                    <li>
                        <button type={"button"} onClick={() => {
                            this.onClickButtonPage(this.props.info.page - 1)
                        }}>
                            <i className={"fas fa-angle-left"}/>
                        </button>
                    </li>
                );
            }
            for (let i = 1; i <= this.props.info.maxPage; i++) {
                let isDraw = true;
                if(i > 1 && i < this.props.info.maxPage){
                    if(i < this.props.info.page - 2){
                        isDraw = false;
                        if(!hasLeftDots){
                            hasLeftDots = true;
                            numberButtons.push(
                                <li>
                                    <div className={"dots"}>
                                        ...
                                    </div>
                                </li>
                            );
                        }
                    }
                    if(i > this.props.info.page + 2){
                        isDraw = false;
                        if(!hasRightDots){
                            hasRightDots = true;
                            numberButtons.push(
                                <li>
                                    <div className={"dots"}>
                                        ...
                                    </div>
                                </li>
                            );
                        }
                    }
                }
                if(isDraw) {
                    if(i === this.props.info.page){
                        numberButtons.push(
                            <li>
                                <div className={"current-page"}>
                                    {i}
                                </div>
                            </li>
                        );
                    }else{
                        numberButtons.push(
                            <li>
                                <button type={"button"} onClick={() => {
                                    this.onClickButtonPage(i)
                                }}>
                                    {i}
                                </button>
                            </li>
                        );
                    }
                }
            }
            if(this.props.info.page < this.props.info.maxPage){
                numberButtons.push(
                    <li>
                        <button type={"button"} onClick={() => {
                            this.onClickButtonPage(this.state.page + 1)
                        }}>
                            <i className={"fas fa-angle-right"}/>
                        </button>
                    </li>
                );
                numberButtons.push(
                    <li>
                        <button type={"button"} onClick={() => {
                            this.onClickButtonPage(this.props.info.maxPage)
                        }}>
                            <i className={"fas fa-angle-double-right"}/>
                        </button>
                    </li>
                );
            }

            buttons = (
                <ul className={"buttons"}>
                    {numberButtons}
                </ul>
            );
        }
        return (
            <div>
                <form action={"/users"} method={"GET"} className={"pagination-form"}>
                    <input type={"hidden"} name={"p"} value={this.state.page}/>
                    {q}
                    {roles}
                    {mode}
                    <input type={"submit"} id={"react-user-pagination-form"}/>
                    {buttons}
                </form>
            </div>
        );
    }
}

export default UsersPagination
