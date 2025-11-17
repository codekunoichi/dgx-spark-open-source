# Running Large Language Models Locally on a DGX

DGX machines provide multiple high‑end GPUs, making them ideal for running large language models (LLMs) such as GPT‑style transformers. This guide outlines general steps to run LLM inference locally using the Hugging Face Transformers library. Always ensure you have the rights to use and distribute the model you intend to run.

## 1. Set up your environment

1. **Create and activate a virtual environment** (see `python-environment/create_venv.md` for details):

   ```bash
   python3 -m venv ~/llm-venv
   source ~/llm-venv/bin/activate
   pip install --upgrade pip
   ```

2. **Install PyTorch with CUDA support**. Choose the wheel matching your CUDA version. For example, for CUDA 11.8:

   ```bash
   pip install torch torchvision --index-url https://download.pytorch.org/whl/cu118
   ```

3. **Install Transformers and related libraries**:

   ```bash
   pip install transformers accelerate sentencepiece
   ```

The `accelerate` library helps with multi‑GPU and device placement.

## 2. Download a model

Visit the [Hugging Face model hub](https://huggingface.co/models) and select a model that fits your GPU memory. For example, to load `meta-llama/Llama-2-7b-hf` (make sure you have access rights and accept the license):

```python
from transformers import AutoModelForCausalLM, AutoTokenizer

model_name = "meta-llama/Llama-2-7b-hf"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(model_name, device_map="auto")

prompt = "Once upon a time"
inputs = tokenizer(prompt, return_tensors="pt").to(model.device)
with torch.no_grad():
    outputs = model.generate(**inputs, max_new_tokens=50)

print(tokenizer.decode(outputs[0], skip_special_tokens=True))
```

The `device_map="auto"` argument tells Transformers to automatically spread the model across available GPUs if necessary. For models larger than one GPU’s memory, you can use offloading via `accelerate`.

## 3. Using multiple GPUs with `accelerate`

For larger models, the `accelerate` library can partition and offload weights. After installing `accelerate`, run the configuration wizard:

```bash
accelerate config
```

Answer the prompts to select multi‑GPU inference. Then wrap your script in `accelerate launch`:

```bash
accelerate launch run_llm.py
```

Where `run_llm.py` contains your inference code. See the [Accelerate documentation](https://huggingface.co/docs/accelerate/index) for detailed examples.

## 4. Optimising memory usage

LLMs consume significant GPU memory. Consider the following tips:

* Choose a model size appropriate for your GPUs (e.g. 7B or 13B for a single GPU; 30B+ for multiple GPUs).
* Use 16‑bit floating point precision (`torch_dtype=torch.float16`) when loading the model:

  ```python
  model = AutoModelForCausalLM.from_pretrained(model_name, torch_dtype=torch.float16, device_map="auto")
  ```

* Enable model weight offloading to CPU or disk if your GPUs cannot hold all parameters. The `accelerate` library handles this.

* For inference, disable gradient computation (`torch.no_grad()` as shown above).

## 5. Alternative frameworks

If you only need to run inference and not training, you can explore lightweight backends such as:

* **llama.cpp** — C++ implementation of LLaMA models using CPU and optional GPU acceleration.
* **vLLM** — an open‑source library for fast LLM inference with batching and streaming support.
* **text‑generation‑inference** — a production‑ready server for transformer inference from Hugging Face.

These may offer better throughput or lower memory usage depending on your use case.

## Conclusion

Running LLMs locally gives you full control over your data and performance. Use appropriate model sizes, monitor GPU memory with `nvidia‑smi`, and leverage multi‑GPU tools like `accelerate` to harness the full power of your DGX. Always respect model licenses and terms of use.