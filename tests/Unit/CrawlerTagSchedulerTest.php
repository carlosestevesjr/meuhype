<?php

namespace Tests\Unit;

use App\Services\CrawlerTagScheduler;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\TestCase;
use ReflectionMethod;

class CrawlerTagSchedulerTest extends TestCase
{
    #[DataProvider('scheduleProvider')]
    public function test_it_chooses_the_least_used_half_hour_slot(array $times, string $expected): void
    {
        $method = new ReflectionMethod(CrawlerTagScheduler::class, 'leastUsedTime');
        $result = $method->invoke(new CrawlerTagScheduler(), $times);

        $this->assertSame($expected, $result);
    }

    public static function scheduleProvider(): array
    {
        $fullDay = [];
        for ($minutes = 0; $minutes < 24 * 60; $minutes += 30) {
            $fullDay[] = sprintf('%02d:%02d:00', intdiv($minutes, 60), $minutes % 60);
        }

        return [
            'empty schedule starts at midnight' => [[], '00:00:00'],
            'next free slot is selected' => [['00:00:00'], '00:30:00'],
            'non-aligned legacy times count in their half-hour slot' => [['00:18:00'], '00:30:00'],
            'full day uses the least loaded slot' => [[...$fullDay, '00:00:00'], '00:30:00'],
        ];
    }
}
