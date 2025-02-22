from typing import Union
from io import BytesIO
from PIL import Image

from fastapi import FastAPI, UploadFile, File, Response

from lib.convert_photo_to_pixel_art import ConvertPhotoToPixelArt


app = FastAPI()


@app.get("/api/")
def read_root():
    return {"Hello": "World"}


@app.post("/api/convert")
async def convert_image(
    image_file: UploadFile = File(...),
    output_width: int = 100,
    output_height: int = 100,
    available_colors: list = [],
):
    input_image_bytes = BytesIO(await image_file.read())
    image = Image.open(input_image_bytes)
    convert_photo_to_pixel_art = ConvertPhotoToPixelArt(
        image=image,
        output_width=output_width,
        output_height=output_height,
        available_colors=available_colors,
    )
    image = convert_photo_to_pixel_art.convert()
    output_image_bytes = BytesIO()
    image.save(output_image_bytes, format="PNG")
    return Response(content=output_image_bytes.getvalue(), media_type="image/png")


@app.get("/api/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}
