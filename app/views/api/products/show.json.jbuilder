json.product do
  json.id               @product.id
  json.title            @product.title
  json.img_url          @product.img_url
  json.price            @product.price
  json.customer_review  @product.customer_review
  json.review_count     @product.review_count
  json.asin             @product.asin
end