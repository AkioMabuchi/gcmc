import React from "react"


class ProjectSearchForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return (
            <div>
                <form action={"/projects"} method={"GET"} className={"project-search-form"}>
                    <input type={"text"} name={"q"} placeholder={"検索ワードを入力"}/>
                    <div className={"tags"}>
                        <h4>タグ検索</h4>
                        <ul>
                            {
                                this.props.info.tags.map((tag) => {
                                    return (
                                        <li>
                                            <input type={"checkbox"} name={"tags[]"}/>
                                            {tag.name}
                                        </li>
                                    );
                                })
                            }
                        </ul>
                    </div>
                    <button type={'submit'}>検索</button>
                </form>
            </div>
        )
    }
}

export default ProjectSearchForm
