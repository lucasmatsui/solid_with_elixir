defmodule User do
  alias __MODULE__, as: User
  defstruct [:id, :validated]

  @type t :: %User{
    id: String.t(),
    validated: boolean()
  }

  def new(validated) do
    %User{
      id: "6efdb246-8e01-485f-b814-3ab3fad87c3e",
      validated: validated
    }
  end
end

defmodule IdentityChecker do
  @callback valid?(User.t()) :: {atom(), boolean()}
end

defmodule Unico do
  @behaviour IdentityChecker

  def valid?(%User{} = user) when user.validated == true, do: {:unico, true}
  def valid?(_user), do: {:unico, false}
end

defmodule Brscan do
  @behaviour IdentityChecker

  def valid?(%User{} = user) when user.validated == true, do: {:brscan, true}
  def valid?(_user), do: {:brscan, false}
end

defmodule Client do
  def execute(%User{} = user, validator) do
    validator.valid?(user)
  end
end

User.new(true)
|> Client.execute(Brscan)
|> IO.inspect()
