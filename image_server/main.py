from typing import Union, List
from io import BytesIO
from PIL import Image

from fastapi import FastAPI, UploadFile, File, Response, Query

from lib.convert_photo_to_pixel_art import ConvertPhotoToPixelArt


app = FastAPI()


def hex_to_rgb(hex_color: str):
    hex_color = hex_color.lstrip("#")
    return tuple(int(hex_color[i : i + 2], 16) for i in (0, 2, 4))


@app.get("/api/")
def read_root():
    return {"Hello": "World"}


@app.post("/api/convert")
async def convert_image(
    image_file: UploadFile = File(...),
    output_column: int = 100, # 列（横の編み地の数）
    output_row: int = 100,    # 行（縦の編み地の数）
    width_ratio: float = 1.0,
    height_ratio: float = 1.0,
    shear: float = 0.0,
    available_colors_hex: List[str] = Query([]),
    # auto_contrast: bool = True,
    # manual_color_mapping: dict = None,
):
    available_colors_rgb = [hex_to_rgb(color) for color in available_colors_hex]

    input_image_bytes = BytesIO(await image_file.read())
    image = Image.open(input_image_bytes)
    # open image in gui
    image.show()
    convert_photo_to_pixel_art = ConvertPhotoToPixelArt(
        image=image,
        input_width=image.width,
        input_height=image.height,
        output_column=output_column,
        output_row=output_row,
        width_ratio=width_ratio,
        height_ratio=height_ratio,
        shear=shear,
        available_colors=available_colors_rgb,
        # auto_contrast=auto_contrast,
        # manual_color_mapping=manual_color_mapping,
    )
    image = convert_photo_to_pixel_art.convert()
    image.show()
    output_image_bytes = BytesIO()
    image.save(output_image_bytes, format="PNG")
    return Response(content=output_image_bytes.getvalue(), media_type="image/png")


@app.get("/api/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}
