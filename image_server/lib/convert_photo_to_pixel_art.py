from PIL import Image


class ConvertPhotoToPixelArt:
    def __init__(
        self,
        image: Image,
        output_width: int,
        output_height: int,
        available_colors: list,
    ):
        self.image = image
        self.output_width = output_width
        self.output_height = output_height
        self.available_colors = available_colors

    def convert(self):
        image = self.image.resize(
            (self.output_width, self.output_height), resample=Image.NEAREST
        )
        return image
