@extends('admin.layouts')

@section('content')
<div class="container-fluid p-0">
    <div class="d-flex align-items-center justify-content-between mb-3">
        <div>
            <h1 class="h3 mb-1">Histórico do importador de notícias</h1>
            <p class="text-muted mb-0">Execuções automáticas e notícias adicionadas ao banco.</p>
        </div>
        <a href="{{ url('/api/v1/cronjob') }}" target="_blank" rel="noopener" class="btn btn-success">
            <i class="fas fa-play"></i> Executar agora
        </a>
    </div>

    @forelse($runsByDate as $date => $dayRuns)
        <div class="mb-4">
            <h2 class="h5 border-bottom pb-2 mb-3">
                <i class="far fa-calendar-alt"></i>
                {{ \Carbon\Carbon::parse($date)->format('d/m/Y') }}
            </h2>

            @foreach($dayRuns as $run)
                @php
                    $statusClass = [
                        'completed' => 'success',
                        'running' => 'warning',
                        'failed' => 'danger',
                        'interrupted' => 'danger',
                    ][$run->status] ?? 'secondary';
                    $statusLabel = [
                        'completed' => 'Concluído',
                        'running' => 'Em execução',
                        'failed' => 'Falhou',
                        'interrupted' => 'Interrompido',
                    ][$run->status] ?? $run->status;
                @endphp
                <div class="card mb-3">
                    <div class="card-header d-flex flex-wrap align-items-center justify-content-between">
                        <div>
                            <strong>Execução #{{ $run->id }}</strong>
                            <span class="ml-2">{{ $run->started_at->format('H:i:s') }}</span>
                            @if($run->finished_at)
                                <span class="text-muted">até {{ $run->finished_at->format('H:i:s') }}</span>
                            @endif
                        </div>
                        <div>
                            <span class="badge badge-{{ $statusClass }}">{{ $statusLabel }}</span>
                            <span class="badge badge-info ml-1">{{ $run->imported_count }} notícia(s)</span>
                        </div>
                    </div>
                    <div class="card-body py-2">
                        @if($run->error_message)
                            <div class="alert alert-danger py-2 mb-2">{{ $run->error_message }}</div>
                        @endif

                        @if($run->items->isEmpty())
                            <p class="text-muted mb-0 pl-3">Nenhuma notícia nova foi importada nesta execução.</p>
                        @else
                            <div class="table-responsive pl-3">
                                <table class="table table-sm table-striped mb-0">
                                    <thead>
                                        <tr>
                                            <th>Horário</th>
                                            <th>Canal</th>
                                            <th>Notícia importada</th>
                                            <th>Data da notícia</th>
                                            <th>Link</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach($run->items as $item)
                                            <tr>
                                                <td>{{ $item->imported_at->format('H:i:s') }}</td>
                                                <td>{{ $item->channel_name ?: '-' }}</td>
                                                <td>
                                                    @if($item->news_id)
                                                        <a href="{{ url('admin/news/'.$item->news_id) }}">{{ $item->news_title }}</a>
                                                    @else
                                                        {{ $item->news_title }}
                                                    @endif
                                                </td>
                                                <td>{{ $item->news_date ? $item->news_date->format('d/m/Y') : '-' }}</td>
                                                <td>
                                                    @if($item->news_link)
                                                        <a href="{{ $item->news_link }}" target="_blank" rel="noopener" class="btn btn-outline-primary btn-sm" title="Abrir notícia">
                                                            <i class="fas fa-external-link-alt"></i>
                                                        </a>
                                                    @else
                                                        -
                                                    @endif
                                                </td>
                                            </tr>
                                        @endforeach
                                    </tbody>
                                </table>
                            </div>
                        @endif
                    </div>
                </div>
            @endforeach
        </div>
    @empty
        <div class="alert alert-info">Ainda não há execuções registradas. O histórico começará após a próxima execução do cronjob.</div>
    @endforelse

    <div class="d-flex justify-content-center">
        {{ $runs->links() }}
    </div>
</div>
@endsection
