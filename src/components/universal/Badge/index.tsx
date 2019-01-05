import * as React from 'react';
import styled  from 'styled-components';

export interface BadgeProps {
    src: string;
}

export default class Badge extends React.Component<BadgeProps, undefined> {
    
    render() {
        return (
            <span>
                <img src={`https://img.shields.io/${this.props.src}`} />
            </span>
        );
    }
}
