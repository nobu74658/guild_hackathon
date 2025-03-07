from PIL import Image
import numpy as np
from collections import deque


class ConvertPhotoToPixelArt:
    def __init__(
        self,
        image: Image,
        input_width: int,
        input_height: int,
        output_column: int,
        output_row: int,
        width_ratio: float = 1.0,
        height_ratio: float = 1.0,
        shear: float = 0.0,
        # output_width: int,
        # output_height: int,
        available_colors: list = None,
        # auto_contrast: bool = True,
        # manual_color_mapping: dict = None,
    ):
        self.image = image
        self.input_width = input_width
        self.input_height = input_height
        self.output_column = output_column
        self.output_row = output_row
        self.width_ratio = width_ratio
        self.height_ratio = height_ratio
        self.shear = max(-1, min(1, shear))  # 制限 -1 ~ 1
        # self.output_width = output_width
        # self.output_height = output_height
        self.available_colors = available_colors or [
            (0, 0, 0),
            (255, 255, 255),
        ]
        # self.auto_contrast = auto_contrast
        # self.manual_color_mapping = manual_color_mapping or {}
    

    def apply_affine_transform(self, image):
        """ widthRatio, heightRatio, shear を考慮し、アフィン変換を適用する """
        new_width = int(self.output_column * self.width_ratio)
        new_height = int(self.output_row * self.height_ratio)
        image = image.resize((new_width, new_height), resample=Image.NEAREST)
        
        shear_angle = self.shear * 45
        shear_factor = np.tan(np.radians(shear_angle))
        shear_padding = int(abs(shear_factor) * new_height)

        expanded_width = new_width + shear_padding
        expanded_image = Image.new("RGB", (expanded_width, new_height), (255, 255, 255))
        
        if self.shear > 0:
            expanded_image.paste(image, (shear_padding, 0))
        else:
            expanded_image.paste(image, (0, 0))

        affine_matrix = (1, shear_factor, 0, 0, 1, 0)
        transformed_image = expanded_image.transform(
            (expanded_width, new_height),
            Image.AFFINE,
            affine_matrix,
            resample=Image.NEAREST,
            fillcolor=(255, 255, 255),
        )
        return transformed_image
    
    
    def closest_color(self, pixel):
        pixel = np.array(pixel)
        avalilable_colors = np.array(self.available_colors)
        distances = np.sqrt(np.sum((avalilable_colors - pixel) ** 2, axis=1))
        return tuple(avalilable_colors[np.argmin(distances)])
    

    # def flood_fill(self, pixels, x, y, new_color):
    #     height, width = pixels.shape[:2]
    #     target_color = tuple(pixels[y, x])
    #     if target_color == new_color:
    #         return

    #     queue = deque([(x, y)])
    #     while queue:
    #         cx, cy = queue.popleft()
    #         if pixels[cy, cx].tolist() == list(target_color):
    #             pixels[cy, cx] = new_color
    #             for nx, ny in [(cx + 1, cy), (cx - 1, cy), (cx, cy + 1), (cx, cy - 1)]:
    #                 if 0 <= nx < width and 0 <= ny < height:
    #                     queue.append((nx, ny))


    # def get_transformed_coordinates(self, x, y):
    #     new_width = int(self.output_column * self.widthRatio)
    #     new_height = int(self.output_row * self.heightRatio)
    #     scale_x = new_width / self.input_width
    #     scale_y = new_height / self.input_height
    #     x = int(x * scale_x)
    #     y = int(y * scale_y)

    #     shear_angle = self.shear * 45
    #     shear_factor = np.tan(np.radians(shear_angle))
    #     shear_padding = int(new_height * abs(shear_factor))
        
    #     if self.shear > 0:
    #         x_new = x + y * shear_factor + shear_padding
    #     else:
    #         x_new = x + y * shear_factor
        
    #     y_new = y
    #     return int(x_new), int(y_new)


    def convert(self):
        transformed_image = self.apply_affine_transform(self.image)
        transformed_image = transformed_image.convert("RGB")
        pixels = np.array(transformed_image)

        # 現在は自動変換のみ
        pixels = np.apply_along_axis(self.closest_color, axis=2, arr=pixels)

        # 自動と手動の切り替え
        # if self.auto_convert:
        #     pixels = np.apply_along_axis(self.closest_color, axis=2, arr=pixels)
        # else:
        #     for (x, y), new_color in self.manual_color_mapping.items():
        #         x_trans, y_trans = self.get_transformed_coordinates(x, y)
        #         if 0 <= x_trans < pixels.shape[1] and 0 <= y_trans < pixels.shape[0]:
        #             self.flood_fill(pixels, x_trans, y_trans, new_color)

        new_image = Image.fromarray(pixels.astype(np.uint8))
        return new_image
