# MI-RUB Homework repository

## Requirements

   * ruby 2.0 or higer

     ruby -v
     
   * `rspec` gem

     gem install rspec

   * `rubocop` gem

    gem install rubocop
 
## Workflow

   1. fetch new work from upstream repository

   2. create a new branch, reflecting number of the homework, e.g.: 01

   3. create an implementation

   4. run all tests from the `spec` directory

    rspec spec

   5. or specify just individual tests to be executed, e.g.:

    rspec spec/iterator_spec.rb

   6. assess quality of all your code

    rubocop *.rb

   7. commit and push to the task-dedicated branch

   8. create a Merge Request from the task-dedicated branch to master

   9. wait for assessment, in case of unclosed request with comments, fix them and return to step 3

