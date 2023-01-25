import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="drawing"
export default class extends Controller {
  static targets = ["canvas"];
  connect() {
    console.log("Hello, Stimulus!", this.element);
    this.canvas = this.canvasTarget;
    this.canvas.width = 400;
    this.canvas.height = 400;

    // get 2d context
    this.ctx = this.canvas.getContext("2d");

    // set line width
    this.ctx.lineWidth = 3;

    // set line color
    this.ctx.strokeStyle = "#aaa";

    // set background color
    this.ctx.fillStyle = "white";

    // listen for mouse events
    this.canvas.addEventListener("mousedown", this.startDrawing.bind(this));
    this.canvas.addEventListener("mouseup", this.stopDrawing.bind(this));
    this.canvas.addEventListener("mousemove", this.draw.bind(this));

    if (this.data.has("drawable")) {
      const image = new Image();
      image.src = this.data.get("drawable");
      image.onload = () => this.ctx.drawImage(image, 0, 0);
    }
  }

  startDrawing(event) {
    console.log("start drawing", event);
    this.drawing = true;
    this.draw(event);
  }

  stopDrawing() {
    this.drawing = false;
    this.ctx.beginPath();

    this.uploadToActiveStorage();
  }

  draw(event) {
    if (!this.drawing) {
      return;
    }

    this.ctx.lineTo(event.offsetX, event.offsetY);
    this.ctx.stroke();
    this.ctx.beginPath();
    this.ctx.moveTo(event.offsetX, event.offsetY);
  }

  uploadToActiveStorage() {
    const drawing_id = this.data.get("id");
    const dataURL = this.canvas.toDataURL("image/png");

    // patch 'drawable/:id', to: 'drawings#drawable', as: 'drawable'

    fetch(`/drawable/${drawing_id}`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
          .content,
      },
      body: JSON.stringify({
        drawing: {
          drawable: dataURL,
        },
      }),
    });
  }

  clear(e) {
    e.preventDefault();
    e.stopImmediatePropagation();

    this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
    this.ctx.beginPath();
    this.uploadToActiveStorage();
  }
}
