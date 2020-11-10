import React from "react"

class ProjectSearchForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render(){
        return(
            <div>
                <form action={"/projects"} method={"GET"} className={"project-search-form"}>
                    <input type={"text"} name={"q"} placeholder={"検索ワードを入力"}/>
                    <div className={"tags"}>
                        <h4>タグ検索</h4>
                        <div className={"checkboxes"}>
                            <p>
                                <input type={"checkbox"} name={"tag_search"}/>すべて
                            </p>
                            {
                                this.props.tags.map((tag) => {
                                    return (
                                        <p>
                                            <input type={"checkbox"} name={`tags[]`} value={tag.id}
                                                   defaultChecked={this.props.selectedTags.includes(Number(tag.id))}/>
                                            {tag.name}
                                        </p>
                                    );
                                })
                            }
                        </div>
                        <div className={"radiobutton"}>
                            <p>
                                <input type={"radio"} name={"tag_mode"} value={"or"}/>部分一致
                            </p>
                            <p>
                                <input type={"radio"} name={"tag_mode"} value={"and"}/>全一致
                            </p>

                        </div>
                    </div>
                    <button type={'submit'}>検索</button>
                </form>
            </div>
        )
    }
}

export default ProjectSearchForm
