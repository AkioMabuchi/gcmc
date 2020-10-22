import React from "react"

class CreateProjectForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render(){
        return(
            <div>
                <form action={"/new"} method={"POST"} className={"new-project-form"}>
                    <h4>プロジェクトID<small>必須</small></h4>
                    <h5>リンク名に使われます</h5>
                    <input type={"text"} name={"permalink"}/>
                    <button type={"submit"}>作成</button>
                </form>
            </div>
        )
    }
}

export default CreateProjectForm
