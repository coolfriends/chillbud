module Chillbud
  module Format
    class << self
      def blockify(s)
        <<~HEREDOC
          ```
          #{s}
          ```
        HEREDOC
      end
    end
  end
end
