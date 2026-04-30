.PHONY: deploy-all destroy

deploy-all:
	cd terraform && terraform init && terraform apply -auto-approve
	@echo "Waiting 30s for instance to boot..."
	@sleep 30
	@cd terraform && terraform output -raw instance_public_ip > /tmp/instance_ip.txt
	@echo "[all]" > ansible/inventory.ini
	@cat /tmp/instance_ip.txt >> ansible/inventory.ini
	cd ansible && ansible-playbook -i inventory.ini playbook.yml
	@echo "Deployment complete! Public IP: $$(cat /tmp/instance_ip.txt)"

destroy:
	cd terraform && terraform destroy -auto-approve
