import React from "react"

class ProjectSearchForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render(){
        return(
            <div>
                <form action={"/projects"} method={"GET"} className={"project-search-form"}>
                    <input type={"text"} name={"query"} placeholder={"検索ワードを入力"}/>
                    <h4>ゲームエンジン</h4>
                    <div className={"checkboxes"}>
                    </div>
                    <button type={'submit'}>検索</button>
                </form>
            </div>
        )
    }
}

export default ProjectSearchForm
