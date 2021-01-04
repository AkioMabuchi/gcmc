import React from "react"
import consumer from "../channels/consumer";

class Message extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            messages: this.props.info.messages,
            messageFormWarning: ""
        };
    }

    componentDidMount() {
        consumer.subscriptions.create("MessageChannel", {
            received(data) {
                return this.updateMessage(data);
            },

            updateMessage: this.updateMessage.bind(this)
        });
    }

    updateMessage(data) {
        let plainMessage = data.message;
        if ((plainMessage.fromUserId === this.props.info.toUserId &&
            plainMessage.toUserId === this.props.info.fromUserId) ||
            (plainMessage.fromUserId === this.props.info.fromUserId &&
                plainMessage.toUserId === this.props.info.toUserId)) {
            let message = [
                {
                    image: plainMessage.image,
                    name: plainMessage.name,
                    date: plainMessage.date,
                    content: plainMessage.content
                }
            ];

            this.setState({messages: message.concat(this.state.messages)});
        }
    }

    sendMessage() {
        let content = document.getElementById("react-input-message-content").value;

        if (content.length > 200) {
            this.setState({messageFormWarning: "200字以内で入力してください"});
        } else if (content.length > 0) {
            this.setState({messageFormWarning: ""});
            document.getElementById("react-input-message-submit").click();
            document.getElementById("react-input-message-content").value = "";
        } else {
            this.setState({messageFormWarning: "入力してください"});
        }
    }

    render() {
        let messageFormWarning;

        if (this.state.messageFormWarning.length > 0) {
            messageFormWarning = (
                <div className={"warning"}>
                    {this.state.messageFormWarning}
                </div>
            );
        }

        return (
            <div className={"messages"}>
                <form action={`/messages/${this.props.info.permalink}/create`} method={"POST"}
                      className={"send-message-box"}>
                    <h4>送信先ユーザー</h4>
                    <div className={"user-image-name"}>
                        <div className={"user-image"}>
                            <a href={`/users/${this.props.info.permalink}`}>
                                <img src={this.props.info.toUserImage} alt={"/NoUserImage.png"}/>
                            </a>
                        </div>
                        <div className={"user-name"}>
                            <a href={`/users/${this.props.info.permalink}`}>
                                {this.props.info.toUserName}
                            </a>
                        </div>
                    </div>
                    <h4>メッセージ内容</h4>
                    <textarea name={"content"} id={"react-input-message-content"}/>
                    {messageFormWarning}
                    <button type={"button"} onClick={(e) => {
                        this.sendMessage()
                    }}>送信
                    </button>
                    <input type={"submit"} id={"react-input-message-submit"}/>
                </form>
                <ul className={"messages-list"}>
                    {
                        this.state.messages.map((message) => {
                            return (
                                <li>
                                    <div className={"message-header"}>
                                        <div className={"message-image"}>
                                            <img src={message.image} alt={"/NoUserImage.png"}/>
                                        </div>
                                        <div className={"message-name"}>
                                            {message.name}
                                        </div>
                                        <div className={"message-date"}>
                                            {message.date}
                                        </div>
                                    </div>
                                    <div className={"message-content"}>
                                        {message.content}
                                    </div>
                                </li>
                            )
                        })
                    }
                </ul>
            </div>
        );
    }
}

export default Message
