require "administrate/base_dashboard"

class HighlightDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    book: Field::BelongsTo,
    id: Field::Number,
    content: Field::Text,
    location: Field::Number,
    annotation_id: Field::String,
    note: Field::Text,
    note_id: Field::String,
    fetched_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :book,
    :id,
    :content,
    :location,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :book,
    :content,
    :location,
    :annotation_id,
    :note,
    :note_id,
    :fetched_at,
  ]

  # Overwrite this method to customize how highlights are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(highlight)
  #   "Highlight ##{highlight.id}"
  # end
end
