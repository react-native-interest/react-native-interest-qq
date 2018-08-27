/**
 * Created by iwangx on 2018/8/27.
 */

import React, {PureComponent} from "react"

import PropTypes from "prop-types"

import {
    View,
    TouchableWithoutFeedback,
    StyleSheet,
    Text
} from "react-native"

class HomeRow extends PureComponent {

    constructor(props) {
        super(props);
    }

    static propTypes = {
        onPress:PropTypes.func,
        text:PropTypes.string
    };

    static defaultProps = {};

    componentDidMount() {

    }

    onPress=()=>{
        let {
            onPress
        } = this.props;
        onPress && onPress();
    };

    render() {
        const {
            props,
            state
        } = this;

        let {
            text
        } = props;

        return (
            <TouchableWithoutFeedback
                onPress={this.onPress}
            >
                <View style={homeRowStyle.row}>
                    <Text>{text}</Text>
                </View>
            </TouchableWithoutFeedback>
        )
    }
}

const homeRowStyle = StyleSheet.create({
    row:{
        height:50,
        flexDirection:"row",
        alignItems:"center",
        backgroundColor:"#fff",
        borderBottomColor:"#ccc",
        borderBottomWidth:1,
        paddingLeft:10
    }
});

export default HomeRow