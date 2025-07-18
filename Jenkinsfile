pipeline {
    agent any
    environment {
        EC2_USER = "ubuntu"
        EC2_IP = "13.203.66.164"
        AWS_KEY = "new-flask-key"  // make sure this matches your Jenkins SSH credential ID
    }
    stages {
        stage('Terraform Apply') {
            steps {
                sh 'cd terraform && terraform init && terraform apply -auto-approve'
            }
        }
        stage('Deploy to EC2') {
            steps {
                sshagent(["$AWS_KEY"]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no $EC2_USER@$EC2_IP << 'EOF'
                    sudo apt update
                    sudo apt install -y python3-pip docker.io
                    pip3 install flask prometheus_client
                    nohup python3 flask_app.py > flask.log 2>&1 &
                    sudo systemctl start docker
                    docker run -d -p 9090:9090 --name prometheus -v ~/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
                    docker run -d -p 3000:3000 --name grafana grafana/grafana
                    EOF
                    """
                }
            }
        }
    }
}
