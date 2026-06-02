# Habitura MVP Implementation Plan

## Screen Inventory
- Home: greeting/date header, notification/streak pills, progress and level cards, today's habit cards, quote card, main tab bar.
- Calendar: monthly grid, completion quality indicators, date selection, selected day summary, completed and missed habit history.
- Add Habit: create/edit form, category/frequency/difficulty selectors, reminders, color and icon picker, suggestion chips.
- Progress: top statistics, completion chart, habit performance rows, insight card.
- Profile: profile header, level/streak, XP card, statistics, badges, settings rows, local premium-style CTA card.
- Local settings detail screens for tappable profile rows and home edit flow.

## Navigation Flow
- A GoRouter ShellRoute hosts Home, Calendar, Add Habit, Progress, and Profile.
- The central bottom action always opens Add Habit.
- Habit edit opens `/add?habitId=<id>` with existing values.
- Profile rows route to local detail screens.

## Folder Structure
- `lib/core`: app constants, Hive bootstrap, router, theme, shared widgets.
- `lib/features/habits`: Hive models, repository, Riverpod providers, Home/Calendar/Add screens and widgets.
- `lib/features/progress`: progress screen and derived chart/stat widgets.
- `lib/features/profile`: preferences model/repository/providers plus Profile/settings screens.

## Component Inventory
- App shell, soft cards, stat chips, metric cards, progress bars, bottom nav, habit cards, selectors, calendar cells, badge cards, settings rows, chart cards.

## State Management Plan
- Hive persists habits, completion history, and preferences.
- Riverpod Notifier controllers expose mutation methods and derived progress data.
- Local providers manage selected calendar date/month and add form state.
