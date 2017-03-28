# Naive Bayes classifier
Method Naive Bayes classifier

Read about it in https://en.wikipedia.org/wiki/Naive_Bayes_classifier


## Use

### Training
```ruby
bc = BayesCassified.new
bc.traine({
    "class1" => [
      [feature1, feature2, feature3, ..., featureN],
      [feature1, feature2, feature3, ..., featureN]
    ],

    "class2" => [
      [feature1, feature2, feature3, ..., featureN],
      [feature1, feature2, feature3, ..., featureN]
    ],
  })
```

### Classify
```ruby
bc.classify([feature1, feature2, feature3, ..., featureN])
```

## Test

### run.rb
```ruby
ruby run.rb
```
