const ItemList = ({ items }) => (
  <ul>
    {items.map((item) => (
      <li key={item.id}>
        <div>{item.name}</div>
      </li>
    ))}
  </ul>
);