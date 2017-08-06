/**
 * Given a camelCase string, count the count of the words
 *
 * Example
 *
 *     "showCamelCase" => 3
 *     "show" => 1
 */
function countWords(input) {
  return input.split(/[A-Z]/).length
}
