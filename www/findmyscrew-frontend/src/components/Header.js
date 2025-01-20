import styled from 'styled-components';

const HeaderContainer = styled.header`
  background-color: #333;
  color: white;
  padding: 10px;
  display: flex;
  justify-content: space-between;
  align-items: center;
`;

function Header() {
  return (
    <HeaderContainer>
      <h1>FindMyScrewGPT</h1>
      <nav>
        <a href="/">Home</a>
        <a href="/items">Items</a>
        <a href="/about">About</a>
      </nav>
    </HeaderContainer>
  );
}

export default Header;
