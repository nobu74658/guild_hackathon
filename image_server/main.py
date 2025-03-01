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
    output_width: int = 100,
    output_height: int = 100,
    avalilable_colors_hex: List[str] = [],
    pallete_id: int = 1
):
    # if pallete_id == 1:
    #     avalilable_colors_hex = [
    #         '#4caf50', '#ff9800', '#e91e63', '#795548', '#000000', '#009688'
    #     ]
    # else:
    avalilable_colors_hex = [
        # '#ffeb3b', '#f44336', '#2196f3', '#9c27b0', '#9e9e9e', '#ffffff'
        "#2d56e1", "#9ca7ae", "#000000", "#ffffff"
    ]
    available_colors_rgb = [hex_to_rgb(color) for color in avalilable_colors_hex]

    input_image_bytes = BytesIO(await image_file.read())
    image = Image.open(input_image_bytes)
    # open image in gui
    image.show()
    convert_photo_to_pixel_art = ConvertPhotoToPixelArt(
        image=image,
        output_width=output_width,
        output_height=output_height,
        available_colors=available_colors_rgb,
    )
    image = convert_photo_to_pixel_art.convert()
    image.show()
    output_image_bytes = BytesIO()
    image.save(output_image_bytes, format="PNG")
    return Response(content=output_image_bytes.getvalue(), media_type="image/png")


@app.get("/api/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}
