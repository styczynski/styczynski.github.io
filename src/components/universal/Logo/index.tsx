import * as React from 'react';
import styled from 'styled-components';

const planet1 = require('img/space_planet1.svg');
const planet2 = require('img/space_planet2.svg');
const planet3 = require('img/space_planet3.svg');
const planet4 = require('img/space_planet4.svg');
const planet5 = require('img/space_planet5.svg');
const planet6 = require('img/space_planet6.svg');
const rocket = require('img/rocket.svg');

const ImgHolder = styled.img`
  width: 100%;
  position: relative;
  z-index: 9999999;
`;

export enum LogoType {
    Planet1 = 'Planet1',
    Planet2 = 'Planet2',
    Planet3 = 'Planet3',
    Planet4 = 'Planet4',
    Planet5 = 'Planet5',
    Planet6 = 'Planet6',
    Rocket = 'Rocket'
};

export interface LogoProps {
    type?: LogoType | string;
}

export default class Logo extends React.Component<LogoProps, undefined> {
    render() {
        
        let src = null;
        switch(this.props.type) {
            case LogoType.Planet1:
                src = planet1;
                break;
            case LogoType.Planet2:
                src = planet2;
                break;
            case LogoType.Planet3:
                src = planet3;
                break;
            case LogoType.Planet4:
                src = planet4;
                break;
            case LogoType.Planet5:
                src = planet5;
                break;
            case LogoType.Planet6:
                src = planet6;
                break;
            case LogoType.Rocket:
                src = rocket;
                break;
            default:
                src = this.props.type;
        }
        
        return (
            <ImgHolder src={src} />
        );
    }
}
