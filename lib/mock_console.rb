require 'human_player'

class MockConsole

	attr_accessor :array_gets, :string_puts

	def initialize
		@array_gets
		@string_puts = String.new
	end

	def print(string)
		@string_puts << string
	end

	def puts(string)
		@string_puts << string
    @string_puts << "\n"
	end

	def putc(string)
		@string_puts << string
	end

	def gets
    value = @array_gets.shift.to_s
    @string_puts << value
    @string_puts << "\n"
    return value.to_i
	end
end
