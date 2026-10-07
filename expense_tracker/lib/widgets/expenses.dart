import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  final void Function() onToggleTheme;
  final bool isDarkMode;

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  Category? _selectedFilter;
  final double _monthlyBudget = 5000.00;

  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Dev Course',
      amount: 599.00,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Coffee and Pastries',
      amount: 245.50,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Cinema Tickets',
      amount: 380.00,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Monthly Electric Bill',
      amount: 2850.00,
      date: DateTime.now(),
      category: Category.bills,
    ),
  ];

  List<Expense> get _filteredExpenses {
    if (_selectedFilter == null) {
      return _registeredExpenses;
    }
    return _registeredExpenses
        .where((expense) => expense.category == _selectedFilter)
        .toList();
  }

  double get _totalFilteredAmount {
    double total = 0;
    for (final item in _filteredExpenses) {
      total += item.amount;
    }
    return total;
  }

  double get _totalAllExpenses {
    double total = 0;
    for (final item in _registeredExpenses) {
      total += item.amount;
    }
    return total;
  }

  double get _budgetRatio {
    if (_monthlyBudget <= 0) return 0.0;
    return _totalAllExpenses / _monthlyBudget;
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final ratio = _budgetRatio;
    final progressValue = ratio > 1.0 ? 1.0 : ratio;
    final percentage = (ratio / 0.01).toStringAsFixed(1);

    Color budgetBarColor = colorScheme.primary;
    String alertMessage = 'Budget on track';
    IconData alertIcon = Icons.check_circle_outline_rounded;
    Color alertColor = Colors.teal;

    if (ratio >= 1.0) {
      budgetBarColor = colorScheme.error;
      alertMessage = 'Budget Exceeded!';
      alertIcon = Icons.error_outline_rounded;
      alertColor = colorScheme.error;
    } else if (ratio >= 0.8) {
      budgetBarColor = Colors.orangeAccent;
      alertMessage = 'Warning: Over 80 percent used';
      alertIcon = Icons.warning_amber_rounded;
      alertColor = Colors.orange;
    }

    Widget mainContent = const Center(
      child: Text('No expenses found. Tap + to add one!'),
    );

    if (_filteredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _filteredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Charven's Expense Tracker"),
        actions: [
          IconButton(
            onPressed: widget.onToggleTheme,
            icon: Icon(
              widget.isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ),
            tooltip: 'Toggle Theme',
          ),
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add_circle_outline_rounded),
            tooltip: 'Add Expense',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Monthly Budget',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Row(
                      children: [
                        Icon(alertIcon, size: 16, color: alertColor),
                        const SizedBox(width: 4),
                        Text(
                          alertMessage,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: alertColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progressValue,
                    minHeight: 10,
                    backgroundColor: colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(budgetBarColor),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₱${_totalAllExpenses.toStringAsFixed(2)} of ₱${_monthlyBudget.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '$percentage%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: budgetBarColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedFilter == null
                      ? 'Filtered Spending'
                      : '${_selectedFilter!.name.toUpperCase()} Spending',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                Text(
                  '₱${_totalFilteredAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
          Chart(expenses: _registeredExpenses),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: const Text('All'),
                    selected: _selectedFilter == null,
                    onSelected: (_) {
                      setState(() {
                        _selectedFilter = null;
                      });
                    },
                  ),
                ),
                ...Category.values.map(
                  (category) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      avatar: Icon(categoryIcons[category], size: 16),
                      label: Text(category.name.toUpperCase()),
                      selected: _selectedFilter == category,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilter = selected ? category : null;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddExpenseOverlay,
        icon: const Icon(Icons.add),
        label: const Text('New Expense'),
      ),
    );
  }
}