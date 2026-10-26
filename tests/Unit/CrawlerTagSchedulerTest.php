<?php

namespace Tests\Unit;

use App\Services\CrawlerTagScheduler;
use PHPUnit\Framework\TestCase;
use ReflectionMethod;

class CrawlerTagSchedulerTest extends TestCase
{
    public function test_it_accepts_only_titles_that_are_valid_times(): void
    {
        $method = new ReflectionMethod(CrawlerTagScheduler::class, 'isTimeTitle');
        $scheduler = new CrawlerTagScheduler();

        $this->assertTrue($method->invoke($scheduler, '00:00:00'));
        $this->assertTrue($method->invoke($scheduler, '23:30:00'));
        $this->assertFalse($method->invoke($scheduler, '24:00:00'));
        $this->assertFalse($method->invoke($scheduler, 'Crawler IMDb'));
        $this->assertFalse($method->invoke($scheduler, null));
    }
}
