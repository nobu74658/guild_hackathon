from PIL import Image
import numpy as np


class ConvertPhotoToPixelArt:
    def __init__(
        self,
        image: Image,
        output_width: int,
        output_height: int,
        available_colors: list = None,
    ):
        self.image = image
        self.output_width = output_width
        self.output_height = output_height
        # self.available_colors = available_colors
        self.available_colors = available_colors or [
            (0, 0, 0),  # 黒(#000000)
            (255, 255, 255), # 白(#ffffff)
            (65, 105, 225), # 青(#4169e1)
            (225, 225, 0)  # 黄色(#ffff00)
        ]
    
    def closest_color(self, pixel):
        """ 指定された色リストの中で、最も近い色を見つける """
        pixel = np.array(pixel)
        avalilable_colors = np.array(self.available_colors)
        distances = np.sqrt(np.sum((avalilable_colors - pixel) ** 2, axis=1))
        return tuple(avalilable_colors[np.argmin(distances)])


    def convert(self):
        image = self.image.resize(
            (self.output_width, self.output_height), resample=Image.NEAREST
        )

        # グレースケール化
        # image = image.convert("L")

        # 画像をRGBモードに変換
        image = image.convert("RGB")
        pixels = np.array(image)

        height, width, _ = pixels.shape
        for y in range(height):
            for x in range(width):
                pixels[y, x] = self.closest_color(pixels[y, x])
        
        # 変換後の画像を作成
        new_image = Image.fromarray(pixels)
        return new_image
    
