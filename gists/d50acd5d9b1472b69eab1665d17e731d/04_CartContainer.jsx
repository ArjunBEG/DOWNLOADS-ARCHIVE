import { createSelector } from 'reselect'

const cartItemsSelector = createSelector(
  state => state.cart.items.ids,
  state => state.cart.items.byId,
  state => state.items.byId, // this is another map of item entries by ID
  (cartItemIds, cartItemsById, itemsById) => cartItemIds.map(id => ({
    ...cartItemsById[id],
    ...itemsById[id]
  }))
)


function mapStateToProps(state) {
  return {
    items: cartItemsSelector(state)
  }
}

// in render(), this.props.items is an array of items merged with the cart entry properties (currently only 'quantity')
