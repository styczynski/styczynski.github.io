import * as React from 'react';
import styled from 'styled-components';

import { withRouter } from 'react-router-dom';

import TextInput from 'components/TextInput';
import Button from 'components/Button';
import Description from 'components/Description';
import DescriptionBlock from 'components/DescriptionBlock';
import Text from 'components/Text';
import Logo from 'components/Logo';
import Card from 'components/Card';

export interface HomePanelProps {
    history: any,
    location: any,
    match: any
}

const ImageButtonWrapper = styled.a`
    display: inline-block;
    text-decoration: none;
    margin-right: 0.5vw;
    width: 5vw;
    cursor: pointer;
    border-bottom: 0.3vw solid transparent;
    padding-left: 0.2vw;
    z-index: 9999999999;
    
    &:hover {
        border-bottom: 0.3vw solid ${(props) => props.theme.colors.lightAccent};
    }
    
    @media (max-width: 500px) {
      width: 20vw;
      margin-right: 2vw;
    }
`;

const HeaderWrapper = styled.div`
    width: 100%;
    position: relative;
    top: -7vw;
    left: -4vw;
    background: ${(props) => props.theme.colors.headerGradient};
    height: 100vh;
    width: 100vw;
`;

const Photo = styled.img`
    width: 100%;
`;

const PhotoWrapper = styled.div`
    width: 20vw;
    height: 57vh;
    margin-top: 5vh;
    
    @media (max-width: 500px) {
      width: 43vw;
    }
`;

const LinksWrapper = styled.div`
    position: absolute;
    top: 80vh;
    left: 5vw;
`;

const RocketWrapper = styled.div`
    position: absolute;
    top: 30vh;
    left: 13vw;
    transform: rotateZ(45deg);
    height: 10vw;
    z-index: 99999999;
    
    @media (max-width: 768px) {
      left: 20vw;
    }
    
    @media (max-width: 500px) {
      width: 16vw;
    }
    
    @media (max-width: 500px) and (min-height: 350px) {
      width: 30vw;
      top: 55vw;
      left: 23vw;
    }
`;

const RocketTextWrapper = styled.div`
    position: absolute;
    top: 0;
    left: 42vw;
    height: 80vh;
    padding-top: 20vh;
    padding-left: 8vw;
    background: rgba(0, 0, 0, 0.48);
    width: 58vw;
    color: ${(props) => props.theme.colors.lightAccent};
    font-family: ${(props) => props.theme.primaryFont};
    
    @media (max-width: 500px) {
      width: 49vw;
    }
`;

const RocketTextTitle = styled.div`
   font-size: ${(props) => props.theme.fontSize.XXXL};
   
   @media (max-width: 500px) {
     font-size: 8vw;
   }
`;

const RocketTextSubtitle = styled.div`
   font-size: ${(props) => props.theme.fontSize.L};
   
   @media (max-width: 500px) {
     font-size: 5vw;
   }
`;

const RocketPlanetWrapper1 = styled.div`
    position: absolute;
    top: 30vh;
    left: 20vw;
    height: 10vw;
    
    @media (max-width: 500px) {
       top: 52vh;
       left: 20vw;
       width: 22vw;
    }
    
    @media (max-width: 500px) and (min-height: 350px) {
      top: 63vh;
      left: -4vw;
      width: 55vw;
    }
`;

const RocketPlanetWrapper2 = styled.div`
    position: absolute;
    top: 15vh;
    left: 5vw;
    height: 40vw;
    
    @media (max-width: 500px) {
      top: 6vh;
      left: 5vw;
      width: 27vw;
    }
    
    @media (max-width: 500px) and (min-height: 350px) {
      top: 15vh;
      left: 2vw;
      width: 49vw;
    }
`;

const RocketPlanetWrapper3 = styled.div`
    position: absolute;
    top: -18vh;
    left: 14vw;
    width: 31vw;
    
    @media (max-width: 500px) {
      top: -4vh;
      left: 0vw;
      width: 20vw;
    }
    
    @media (max-width: 500px) and (min-height: 350px) {
      top: -2vw;
      left: 0vw;
      width: 41vw;
    }
`;

const RocketPlanetWrapper4 = styled.div`
    position: absolute;
    top: 32vh;
    left: 19vw;
    width: 36vw;
    
    @media (max-width: 1024px) {
      top: 50vh;
    }
    
    @media (max-width: 768px) {
      display: none;
    }
`;

interface HomePanelState {
};

class HomePanel extends React.Component<HomePanelProps, HomePanelState> {
    state: HomePanelState;
    timer: number;
    
    constructor(props) {
       super(props);

       this.state = {};
    }
    
    /*
      <ImageButtonWrapper href='http://www.goldenline.pl/piotr-styczi-styczynski/'>
         <Logo type={require('img/goldenline.png')} />
      </ImageButtonWrapper>
    */
    
    render() {
        return (
            <div>
                <HeaderWrapper>
                    <RocketWrapper>
                        <Logo type='Rocket' />
                    </RocketWrapper>
                    <RocketPlanetWrapper1>
                        <Logo type='Planet3' />
                    </RocketPlanetWrapper1>
                    <RocketPlanetWrapper2>
                        <Logo type='Planet4' />
                    </RocketPlanetWrapper2>
                    <RocketPlanetWrapper3>
                        <Logo type='Planet1' />
                    </RocketPlanetWrapper3>
                    <RocketPlanetWrapper4>
                        <Logo type='Planet6' />
                    </RocketPlanetWrapper4>
                    <RocketTextWrapper>
                        <RocketTextTitle>
                            Piotr Styczyński
                        </RocketTextTitle>
                        <RocketTextSubtitle>
                            /Frotend engineer/
                            /UX Designer/
                            /Web developer/
                        </RocketTextSubtitle>
                        <PhotoWrapper>
                            <Photo src={require('img/photo.png')} />
                        </PhotoWrapper>
                    </RocketTextWrapper>
                    <LinksWrapper>
                        <ImageButtonWrapper href='https://linkedin.com/in/piotr-styczyński-661043151/'>
                             <Logo type={require('img/linkedin.png')} />
                        </ImageButtonWrapper>
                        <ImageButtonWrapper href='https://github.com/styczynski'>
                             <Logo type={require('img/git.png')} />
                        </ImageButtonWrapper>
                        <ImageButtonWrapper href='./cv/PIOTR_STYCZYNSKI_CV.pdf'>
                             <Logo type={require('img/cv.png')} />
                        </ImageButtonWrapper>
                    </LinksWrapper>
                </HeaderWrapper>
                <DescriptionBlock
                  size='M'
                  text={<Text translate>about_me_description</Text>}
                  content={
                      <Text translate>about_me_text</Text>
                  }
                >
                    <Logo type='Planet4' />
                </DescriptionBlock>
                <DescriptionBlock
                  fullBar
                  size='L'
                  text={<Text translate>experiments_description</Text>}
                  content={
                      <div></div>
                  }
                >
                    <Logo type='Planet1' />
                </DescriptionBlock>
                <Description
                  size='L'
                  text={<Text translate>open_source_description</Text>}
                  content={
                      <div>
                          <Card
                              title='Atom Terminal Panel'
                              link='https://github.com/styczynski/atom-terminal-panel'
                              badges={[
                                'apm/v/atom-terminal-panel.svg?style=flat-square',
                                'apm/dm/atom-terminal-panel.svg?style=flat-square',
                                'apm/l/atom-terminal-panel.svg?style=flat-square'
                              ]}
                              description={<Text translate>atom_terminal_panel_description</Text>}
                          />
                          <Card
                              title='Autocomplete JS'
                              link='http://styczynski.in/autocomplete-js/'
                              badges={[
                                'badge/platform-node-green.svg?style=flat-square&logoWidth=20&logo=data%3Aimage%2Fpng%3Bbase64%2CiVBORw0KGgoAAAANSUhEUgAAAC8AAAAyCAYAAADMb4LpAAAABmJLR0QA%2FwD%2FAP%2BgvaeTAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAAB3RJTUUH4AgTDxIs6TxZnwAAATRJREFUaN7t2q0OwjAQB%2FC2FoPEgMMgMaAxPAcJCYo3ICEzvAGG8A4ERULIJAZDCDMLFkGCw3MoBITB%2BnHrFv59gO1319st6VUSkSjqUlwPDkJFQahYMyNdZz4JPO7cZW7xabPsMgjrsomva63yCEJFm9OEvGfetqZtd8EIv4iGdLhMndWuaRDaeK4OMmgdRaXUkCx47rZnsgs%2F8VmhTYJI7DbRZUm%2B4M%2BkreIRaWfeJ1pnF17weUP%2FCkKJAi%2FggQceeOCBBx544IEHHnjggQce%2BH%2FBc4xeXK1PtsSD1rycnn1LaKFPiVOdz59ve5rvmpmgu%2FWZaFf7qcpXazLCvQu635zRTMp1EJnNpFwGYdvdlK%2BXu2jLhZ6AZ3b3oNfcilq57fQnKDmurLwHwPXnlrhv42k9AGprq6tU7LX3AAAAAElFTkSuQmCC',
                                'npm/v/jquery-autocomplete-js.svg?style=flat-square',
                                'npm/l/jquery-autocomplete-js.svg?style=flat-square',
                                'npm/dm/jquery-autocomplete-js.svg?style=flat-square'
                              ]}
                              description={<Text translate>autocomplete_js_description</Text>}
                          />
                      </div>
                  }
                >
                    <Logo type='Planet6' />
                </Description>
                <DescriptionBlock
                  size='L'
                  text={<Text translate>experiments_description</Text>}
                  content={
                      <div>
                          <Card
                              title='Weatherly'
                              link='https://github.com/styczynski/weatherly'
                              badges={[
                                'github/tag/styczynski/weatherly.svg?style=flat-square'
                              ]}
                              description={<Text translate>weatherly_description</Text>}
                          />
                          <Card
                              title='utest'
                              link='https://github.com/styczynski/bash-universal-tester'
                              badges={[
                                'github/release/styczynski/bash-universal-tester.svg?style=flat-square'
                              ]}
                              description={<Text translate>utest_description</Text>}
                          />
                          <Card
                              title='ipp-poly'
                              link='https://github.com/styczynski/ipp-poly'
                              badges={[
                                'travis/styczynski/ipp-poly.svg?style=flat-square',
                                'github/tag/styczynski/ipp-poly.svg?style=flat-square'
                              ]}
                              description={<Text translate>ipp_poly_description</Text>}
                          />
                          <Card
                              title='avr-weather-esp8266'
                              link='https://github.com/styczynski/avr-weather-esp8266'
                              badges={[
                                'badge/Platform-AVR-green.svg?style=flat-square&logo=github'
                              ]}
                              description={<Text translate>avr_weather_esp8266_description</Text>}
                          />
                      </div>
                  }
                >
                    <Logo type='Planet3' />
                </DescriptionBlock>
                <Description
                  size='L'
                  text={<Text translate>space_junk_description</Text>}
                  content={
                      <div>
                          <Card
                              title='Tic Tac Console'
                              link='https://github.com/styczynski/TicTacConsole'
                              badges={[
                                'badge/platform-windows-blue.svg?style=flat-square&logoWidth=20&logo=data%3Aimage%2Fpng%3Bbase64%2CiVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABmJLR0QA%2FwD%2FAP%2BgvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAB3RJTUUH4AgSEisSipueyAAAAHBJREFUSMdjZKA2WPv%2BPzKXkSxDiuf%2FZ7AKIEopbgsW3v%2FPwCOA4AcLMqK7jhjAQo4mUgATA43BqAWjFlADiCvQ1HjsuXNJIwPD%2BgmMtLMAGyCzqBhNRaMWDAELWBiCBRmJrcDJy2hUaj1Q3wIiLQcAUjQgoD1kMJYAAAAASUVORK5CYII%3D'
                              ]}
                              description={<Text translate>tic_tac_console_description</Text>}
                          />
                          <Card
                              title='WACCGL'
                              link='https://github.com/styczynski/WACCGL'
                              badges={[
                                'badge/platform-windows-blue.svg?style=flat-square&logoWidth=20&logo=data%3Aimage%2Fpng%3Bbase64%2CiVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABmJLR0QA%2FwD%2FAP%2BgvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAB3RJTUUH4AgSEisSipueyAAAAHBJREFUSMdjZKA2WPv%2BPzKXkSxDiuf%2FZ7AKIEopbgsW3v%2FPwCOA4AcLMqK7jhjAQo4mUgATA43BqAWjFlADiCvQ1HjsuXNJIwPD%2BgmMtLMAGyCzqBhNRaMWDAELWBiCBRmJrcDJy2hUaj1Q3wIiLQcAUjQgoD1kMJYAAAAASUVORK5CYII%3D'
                              ]}
                              description={<Text translate>waccgl_description</Text>}
                          />
                      </div>
                  }
                >
                    <Logo type='Planet5' />
                </Description>
            </div>
        );
    }
};

export default withRouter(HomePanel);