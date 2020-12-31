import React from "react"

class UserSearchForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return (
            <div>
                <form action={"/users"} method={"GET"} className={"search-form"}>
                    <input type={"text"} name={"q"} placeholder={"検索ワードを入力"} defaultValue={this.props.info.q}/>
                    <div className={"roles"}>
                        <h3>役割検索</h3>
                        <ul className={"roles"}>
                            {
                                this.props.info.roles.map((role) => {
                                    return (
                                        <li>
                                            <input type={"checkbox"} name={"roles[]"} value={role.id} defaultChecked={this.props.info.selectedRoles.includes(role.id.toString())}/>
                                            {role.name}
                                        </li>
                                    );
                                })
                            }
                        </ul>
                        <ul className={"mode"}>
                            <li>
                                <input type={"radio"} name={"mode"} value={"and"}
                                       defaultChecked={this.props.info.mode === "and"}/>
                                AND検索
                            </li>
                            <li>
                                <input type={"radio"} name={"mode"} value={"or"}
                                       defaultChecked={this.props.info.mode === "or"}/>
                                OR検索
                            </li>
                        </ul>
                    </div>
                    <button type={"submit"}>検索</button>
                </form>
            </div>
        );
    }
}

export default UserSearchForm
