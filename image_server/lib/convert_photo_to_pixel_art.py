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
        self.available_colors = available_colors or [
            (0, 0, 0),
            (255, 255, 255),
        ]
    
    
    def closest_color(self, pixel):
        pixel = np.array(pixel)
        avalilable_colors = np.array(self.available_colors)
        distances = np.sqrt(np.sum((avalilable_colors - pixel) ** 2, axis=1))
        return tuple(avalilable_colors[np.argmin(distances)])


    def convert(self):
        image = self.image.resize(
            (self.output_width, self.output_height), resample=Image.NEAREST
        )
        image = image.convert("RGB")
        pixels = np.array(image)
        pixels = np.apply_along_axis(self.closest_color, axis=2, arr=pixels)
        new_image = Image.fromarray(pixels.astype(np.uint8))
        return new_image
