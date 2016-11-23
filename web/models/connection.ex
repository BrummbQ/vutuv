defmodule Vutuv.Connection do
  use Vutuv.Web, :model

  schema "connections" do
    belongs_to :follower, Vutuv.User
    belongs_to :followee, Vutuv.User

    has_many :memberships, Vutuv.Membership, on_delete: :delete_all
    has_many :groups, through: [:memberships, :group]

    timestamps
  end

  @required_fields ~w(follower_id followee_id)a
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields++@optional_fields)
    |> validate_required(@required_fields)
    |> validate_not_following_self
    |> unique_constraint(:follower_id_followee_id, message: ("You're already following this person."))
  end

  defp validate_not_following_self(%{changes: %{followee_id: same, follower_id: same}} = changeset) do
    changeset
    |> add_error(:follower_id, "Cannot follow yourself")
  end

  defp validate_not_following_self(changeset), do: changeset


  def latest(n) do
    Ecto.Query.from(u in Vutuv.Connection, join: f in assoc(u, :followee), join: f2 in assoc(u, :follower), where: (is_nil(f.validated?) or f.validated? == true) and (is_nil(f2.validated?) or f2.validated? == true), order_by: [desc: :inserted_at], limit: ^n)
  end
end
