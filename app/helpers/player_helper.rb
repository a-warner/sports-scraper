module PlayerHelper
  def link_to_player(player)
    return unless player
    player_status = player.status_ok? ? '' : content_tag(:span, player.short_status, class: 'not-ok')

    (link_to(player.name, player) + " #{player_status} ".html_safe + '(' + link_to('ESPN', player.url, target: '_blank') + ')').html_safe
  end
end
