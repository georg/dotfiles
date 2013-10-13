require '/Applications/Zephyros.app/Contents/Resources/libs/zephyros.rb'

def move_window(win)
  frame = win.screen.frame_without_dock_or_menu
  yield frame if block_given?
  win.frame = frame
end

def move_focused_window_on(key, modifiers, &block)
  API.bind key, modifiers do
    move_window(API.focused_window, &block)
  end
end

def move_to_screen(win, screen)
  return if screen.nil?

  frame = win.frame
  old_screen_rect = win.screen.frame_without_dock_or_menu
  new_screen_rect = screen.frame_without_dock_or_menu

  x_ratio = new_screen_rect.w / old_screen_rect.w
  y_ratio = new_screen_rect.h / old_screen_rect.h

  win.frame = {
    x: ((frame.x - old_screen_rect.x) * x_ratio).round + new_screen_rect.x,
    y: ((frame.y - old_screen_rect.y) * y_ratio).round + new_screen_rect.y,
    w: (frame.w * x_ratio).round,
    h: (frame.h * y_ratio).round
  }
end

# Split Screen Actions
move_focused_window_on "up", %w[cmd alt ctrl] do |frame|
  frame.h /= 2
end
move_focused_window_on "down", %w[cmd alt ctrl] do |frame|
  frame.y += frame.h / 2
  frame.h /= 2
end
move_focused_window_on "left", %w[cmd alt ctrl] do |frame|
  frame.w /= 2
end
move_focused_window_on "right", %w[cmd alt ctrl] do |frame|
  frame.x += frame.w / 2
  frame.w /= 2
end

# Quarter Screen (Quadrant) Actions
move_focused_window_on "up", %w[shift alt ctrl] do |frame|
  frame.x += frame.w / 2
  frame.w /= 2
  frame.h /= 2
end
move_focused_window_on "down", %w[shift alt ctrl] do |frame|
  frame.y += frame.h / 2
  frame.w /= 2
  frame.h /= 2
end
move_focused_window_on "left", %w[shift alt ctrl] do |frame|
  frame.w /= 2
  frame.h /= 2
end
move_focused_window_on "right", %w[shift alt ctrl] do |frame|
  frame.x += frame.w / 2
  frame.y += frame.h / 2
  frame.w /= 2
  frame.h /= 2
end

# Other Actions
move_focused_window_on "m", %w[cmd alt ctrl]
move_focused_window_on "c", %w[cmd alt ctrl] do |frame|
  frame.x = frame.w * 0.125
  frame.y = frame.h * 0.125
  frame.w *= 0.75
  frame.h *= 0.75
end

API.bind "right", %w[ctrl alt] do |frame|
  win = API.focused_window
  move_to_screen win, win.screen.next_screen
end
API.bind "left", %w[ctrl alt] do |frame|
  win = API.focused_window
  move_to_screen win, win.screen.previous_screen
end

wait_on_callbacks
