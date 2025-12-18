.PHONY: up down transcribe

URL = http://localhost:9000/asr?task=transcribe&language=pt
INPUT_DIR =./input
OUTPUT_DIR =./output

up:
	@mkdir -p $(INPUT_DIR)
	@mkdir -p $(OUTPUT_DIR)
	docker compose up -d

down:
	docker compose down

transcribe:
	@mkdir -p $(INPUT_DIR)
	@mkdir -p $(OUTPUT_DIR)
	@for file in $(INPUT_DIR)/*; do \
		if [ -f "$$file" ]; then \
			FILENAME=$$(basename "$$file"); \
			echo "Transcrevendo: $$FILENAME..."; \
			curl -s -X POST "$(URL)" \
				-F "audio_file=@$$file" \
				-o "$(OUTPUT_DIR)/$$FILENAME.txt"; \
			echo "Salvo em: $(OUTPUT_DIR)/$$FILENAME.txt"; \
		fi \
	done

log:
	docker logs -f whisper-asr