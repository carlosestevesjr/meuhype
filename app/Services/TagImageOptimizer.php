<?php

namespace App\Services;

use RuntimeException;

class TagImageOptimizer
{
    public const MAX_WIDTH = 1000;

    public const MAX_HEIGHT = 1500;

    public const TARGET_BYTES = 409600;

    /**
     * Otimiza uma imagem para exibicao web, sem cortar ou ampliar.
     */
    public function optimize(string $path): array
    {
        if (!is_file($path) || !is_readable($path)) {
            throw new RuntimeException('Arquivo de imagem nao encontrado ou sem permissao de leitura.');
        }

        $beforeBytes = (int) filesize($path);
        $dimensions = @getimagesize($path);

        if (!$dimensions || empty($dimensions[0]) || empty($dimensions[1])) {
            throw new RuntimeException('Nao foi possivel identificar as dimensoes da imagem.');
        }

        [$width, $height] = $dimensions;
        if ($width <= self::MAX_WIDTH && $height <= self::MAX_HEIGHT && $beforeBytes <= self::TARGET_BYTES) {
            return $this->result($path, $width, $height, $beforeBytes, $beforeBytes, false);
        }

        $contents = file_get_contents($path);
        $source = $contents === false ? false : @imagecreatefromstring($contents);
        if (!$source) {
            throw new RuntimeException('O formato da imagem nao pode ser processado pelo servidor.');
        }

        [$targetWidth, $targetHeight] = $this->fitDimensions($width, $height);
        $extension = function_exists('imagewebp') ? 'webp' : 'jpg';
        $temporaryPath = dirname($path) . '/.' . pathinfo($path, PATHINFO_FILENAME) . '-' . uniqid('', true) . '.' . $extension;

        try {
            $quality = 82;
            $this->writeImage($source, $temporaryPath, $targetWidth, $targetHeight, $quality, $extension);

            while ($this->fileSize($temporaryPath) > self::TARGET_BYTES && $quality > 66) {
                $quality -= 4;
                $this->writeImage($source, $temporaryPath, $targetWidth, $targetHeight, $quality, $extension);
            }

            // Cartazes muito detalhados podem continuar pesados mesmo apos reduzir a qualidade.
            for ($attempt = 0; $this->fileSize($temporaryPath) > self::TARGET_BYTES && $attempt < 3; $attempt++) {
                $targetWidth = max(1, (int) floor($targetWidth * 0.85));
                $targetHeight = max(1, (int) floor($targetHeight * 0.85));
                $this->writeImage($source, $temporaryPath, $targetWidth, $targetHeight, $quality, $extension);
            }

            $finalPath = dirname($path) . '/' . pathinfo($path, PATHINFO_FILENAME) . '.' . $extension;
            if (!rename($temporaryPath, $finalPath)) {
                throw new RuntimeException('Nao foi possivel finalizar a imagem otimizada.');
            }

            if ($finalPath !== $path && is_file($path)) {
                @unlink($path);
            }

            clearstatcache(true, $finalPath);

            return $this->result(
                $finalPath,
                $targetWidth,
                $targetHeight,
                $beforeBytes,
                $this->fileSize($finalPath),
                true
            );
        } finally {
            imagedestroy($source);
            if (is_file($temporaryPath)) {
                @unlink($temporaryPath);
            }
        }
    }

    private function fitDimensions(int $width, int $height): array
    {
        $scale = min(self::MAX_WIDTH / $width, self::MAX_HEIGHT / $height, 1);

        return [
            max(1, (int) round($width * $scale)),
            max(1, (int) round($height * $scale)),
        ];
    }

    private function writeImage(
        $source,
        string $path,
        int $width,
        int $height,
        int $quality,
        string $extension
    ): void
    {
        $canvas = imagecreatetruecolor($width, $height);
        if ($extension === 'webp') {
            imagealphablending($canvas, false);
            imagesavealpha($canvas, true);
            $background = imagecolorallocatealpha($canvas, 0, 0, 0, 127);
        } else {
            $background = imagecolorallocate($canvas, 255, 255, 255);
        }
        imagefilledrectangle($canvas, 0, 0, $width, $height, $background);

        imagecopyresampled(
            $canvas,
            $source,
            0,
            0,
            0,
            0,
            $width,
            $height,
            imagesx($source),
            imagesy($source)
        );

        $saved = $extension === 'webp'
            ? imagewebp($canvas, $path, $quality)
            : imagejpeg($canvas, $path, $quality);
        imagedestroy($canvas);

        if (!$saved) {
            throw new RuntimeException('Nao foi possivel gravar a imagem otimizada.');
        }
    }

    private function fileSize(string $path): int
    {
        clearstatcache(true, $path);

        return (int) filesize($path);
    }

    private function result(
        string $path,
        int $width,
        int $height,
        int $beforeBytes,
        int $afterBytes,
        bool $changed
    ): array {
        return [
            'path' => $path,
            'width' => $width,
            'height' => $height,
            'before_bytes' => $beforeBytes,
            'after_bytes' => $afterBytes,
            'saved_bytes' => max(0, $beforeBytes - $afterBytes),
            'changed' => $changed,
        ];
    }
}
