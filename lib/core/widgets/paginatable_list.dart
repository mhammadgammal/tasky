import 'dart:developer' show log;

import 'package:flutter/material.dart';

/// A reusable, generic widget that displays a paginatable list with
/// infinite scroll and optional pull-to-refresh.
///
/// Usage:
/// PaginatableList<MyModel>(
///   itemBuilder: (ctx, item, index) => MyItemWidget(item: item),
///   pageLoader: (page, pageSize) => api.loadItems(page: page, pageSize: pageSize),
/// )
class PaginatableList<T> extends StatefulWidget {
  final Future<List<T>> Function(int page, int pageSize) pageLoader;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? separator;
  final int pageSize;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final int initialPage;
  final List<T>? initialItems;
  final bool loadOnInit;
  final Widget? loadingIndicator;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final PaginatableListController? controller;
  final double threshold;

  const PaginatableList({
    super.key,
    required this.pageLoader,
    required this.itemBuilder,
    this.separator,
    this.pageSize = 20,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.initialPage = 1,
    this.initialItems,
    this.loadOnInit = true,
    this.loadingIndicator,
    this.emptyWidget,
    this.errorWidget,
    this.controller,
    this.threshold = 200.0,
  });

  @override
  State<PaginatableList<T>> createState() => _PaginatableListState<T>();
}

class _PaginatableListState<T> extends State<PaginatableList<T>> {
  final ScrollController _scrollController = ScrollController();
  final List<T> _items = [];
  late int _page;
  bool _isLoading = false;
  bool _isRefreshing = false;
  bool _hasMore = true;
  bool _isError = false;
  ScrollPosition? _ambientScrollPosition;

  @override
  void initState() {
    super.initState();
    _page = widget.initialPage;
    log('initialState', name: 'PaginatableList');
    log('initial Items: ${widget.initialItems}', name: 'PaginatableList');
    if (widget.initialItems != null) {
      _items.addAll(widget.initialItems!);
    }
    log('Items: $_items', name: 'PaginatableList');

    widget.controller?._attach(this);

    _scrollController.addListener(_onScroll);
    if (widget.loadOnInit &&
        (widget.initialItems == null || widget.initialItems!.isEmpty)) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _loadPage(append: false),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // When shrinkWrap is used (list nested inside an ancestor scrollable,
    // e.g. NeverScrollableScrollPhysics), this list's own ScrollPosition
    // never has real scroll room: maxScrollExtent stays 0, which makes the
    // "near bottom" check in _onScroll vacuously true on every relayout and
    // triggers runaway page loads. Watch the ancestor Scrollable instead,
    // since that's the one the user actually scrolls.
    if (widget.shrinkWrap) {
      final ambient = Scrollable.maybeOf(context)?.position;
      if (!identical(ambient, _ambientScrollPosition)) {
        _ambientScrollPosition?.removeListener(_onScroll);
        _ambientScrollPosition = ambient;
        _ambientScrollPosition?.addListener(_onScroll);
      }
    }
  }

  @override
  void dispose() {
    widget.controller?._detach();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _ambientScrollPosition?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final ScrollMetrics? metrics = widget.shrinkWrap
        ? _ambientScrollPosition
        : (_scrollController.hasClients ? _scrollController.position : null);
    if (metrics == null) return;
    final threshold = widget.threshold; // distance from bottom to trigger
    if (metrics.pixels >= metrics.maxScrollExtent - threshold &&
        !_isLoading &&
        _hasMore &&
        !_isRefreshing &&
        !_isError) {
      log('paginting', name: 'PaginatableList');
      _loadPage(append: true);
    }
  }

  Future<void> _loadPage({required bool append}) async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    final int fetchPage = append ? _page + 1 : widget.initialPage;
    try {
      final List<T> fetched = await widget.pageLoader(
        fetchPage,
        widget.pageSize,
      );
      setState(() {
        if (!append) {
          _items.clear();
          _page = fetchPage;
        } else {
          _page = fetchPage;
        }
        _items.addAll(fetched);
        log('fetched length: ${fetched.length}', name: 'PaginatableList');
        log('page size: ${widget.pageSize}', name: 'PaginatableList');
        _hasMore = fetched.length >= widget.pageSize;
      });
    } catch (e) {
      setState(() {
        _isError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _refresh() async {
    if (_isRefreshing) return;
    setState(() {
      _isRefreshing = true;
      _isError = false;
      _hasMore = true;
    });
    try {
      await _loadPage(append: false);
    } finally {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isError && _items.isEmpty) {
      return widget.errorWidget ?? _buildDefaultError();
    }

    if (_items.isEmpty && _isLoading) {
      return widget.loadingIndicator ?? _buildDefaultLoading();
    }

    if (_items.isEmpty) {
      return widget.emptyWidget ?? _buildDefaultEmpty();
    }

    Widget list = ListView.separated(
      controller: _scrollController,
      padding: widget.padding,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      itemCount: _items.length + (_hasMore || _isLoading ? 1 : 0),
      separatorBuilder: (_, __) => widget.separator ?? const SizedBox.shrink(),
      itemBuilder: (ctx, index) {
        if (index < _items.length) {
          return widget.itemBuilder(ctx, _items[index], index);
        }
        // Compact trailing indicator only — widget.loadingIndicator/errorWidget
        // are full-page states (e.g. a whole skeleton list) and must not be
        // embedded as a single row inside the already-loaded list.
        if (_isError) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(child: _buildDefaultLoadMoreError()),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Center(child: _buildDefaultLoadMoreLoading()),
        );
      },
    );
    log(
      'list item count: ${_items.length + (_hasMore || _isLoading ? 1 : 0)}',
      name: 'PaginatableList',
    );
    // Always allow pull-to-refresh; controller may also call refresh programmatically
    return RefreshIndicator(onRefresh: _refresh, child: list);
  }

  Widget _buildDefaultLoading() =>
      const Center(child: CircularProgressIndicator());

  Widget _buildDefaultLoadMoreLoading() => const CircularProgressIndicator();

  Widget _buildDefaultEmpty() => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('No items found'),
        const SizedBox(height: 8),
        TextButton(onPressed: _refresh, child: const Text('Refresh')),
      ],
    ),
  );

  Widget _buildDefaultError() => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Something went wrong'),
        const SizedBox(height: 8),
        ElevatedButton(onPressed: _refresh, child: const Text('Retry')),
      ],
    ),
  );

  Widget _buildDefaultLoadMoreError() => ElevatedButton(
    onPressed: () => _loadPage(append: true),
    child: const Text('Retry'),
  );
}

/// Controller for [PaginatableList] to allow programmatic refresh/scroll.
class PaginatableListController {
  _PaginatableListState? _state;

  void _attach(_PaginatableListState state) => _state = state;

  void _detach() => _state = null;

  /// Refresh the list (pull-to-refresh behavior)
  Future<void> refresh() async => _state?._refresh();

  /// Scroll to top
  Future<void> scrollToTop({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.ease,
  }) async {
    final sc = _state?._scrollController;
    if (sc != null && sc.hasClients) {
      await sc.animateTo(0.0, duration: duration, curve: curve);
    }
  }
}
