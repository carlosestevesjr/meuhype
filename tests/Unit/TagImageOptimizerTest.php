<?php

namespace Tests\Unit;

use App\Services\TagImageOptimizer;
use PHPUnit\Framework\TestCase;

class TagImageOptimizerTest extends TestCase
{
    private array $files = [];

    protected function tearDown(): void
    {
        foreach ($this->files as $file) {
            if (is_file($file)) {
                unlink($file);
            }
        }
    }

    public function test_it_keeps_an_acceptable_image_without_upscaling(): void
    {
        $path = $this->createImage(320, 480, 'small.png');
        $result = (new TagImageOptimizer())->optimize($path);

        $this->assertFalse($result['changed']);
        $this->assertSame(320, $result['width']);
        $this->assertSame(480, $result['height']);
        $this->assertSame($path, $result['path']);
    }

    public function test_it_resizes_a_large_image_without_cropping_and_uses_the_best_available_format(): void
    {
        $path = $this->createImage(1200, 1800, 'large.png');
        $result = (new TagImageOptimizer())->optimize($path);
        $this->files[] = $result['path'];

        $this->assertTrue($result['changed']);
        $this->assertSame(720, $result['width']);
        $this->assertSame(1080, $result['height']);
        $expectedExtension = function_exists('imagewebp') ? 'webp' : 'jpg';
        $this->assertSame($expectedExtension, pathinfo($result['path'], PATHINFO_EXTENSION));
        $this->assertFileDoesNotExist($path);
        $this->assertLessThanOrEqual(TagImageOptimizer::TARGET_BYTES, $result['after_bytes']);
    }

    public function test_it_can_force_jpeg_for_legacy_news_paths(): void
    {
        $path = $this->createImage(320, 480, 'news.jpg');
        $result = (new TagImageOptimizer())->optimize($path, 'jpg');
        $this->files[] = $result['path'];

        $this->assertTrue($result['changed']);
        $this->assertSame($path, $result['path']);
        $this->assertSame('image/jpeg', mime_content_type($result['path']));
    }

    private function createImage(int $width, int $height, string $filename): string
    {
        $path = sys_get_temp_dir() . '/' . uniqid('meuhype-', true) . '-' . $filename;
        $image = imagecreatetruecolor($width, $height);
        $background = imagecolorallocate($image, 46, 91, 120);
        imagefill($image, 0, 0, $background);
        imagepng($image, $path, 6);
        imagedestroy($image);
        $this->files[] = $path;

        return $path;
    }
}
