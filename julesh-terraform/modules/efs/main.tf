data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config = {
    bucket     = "terrafrom-test-to-delete-bucket"
    key        = "backend/vpc"
    region     = "ap-south-1"
  }
}

resource "aws_security_group" "efs_mount_target_sg" {
  name_prefix = var.efs-security-group
  vpc_id      = data.terraform_remote_state.vpc_state.outputs.vpc_id

  // Define ingress and egress rules as needed
  ingress {
    description = "Allow NFS traffic from EFS mount targets"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic from anywhere (adjust as needed)
  }

  // Add more ingress or egress rules as needed
}

resource "aws_efs_file_system" "my_efs" {
  creation_token   = "${var.cluster-name}-efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted = true
  tags = {
    Name = "${var.cluster-name}-efs"
  }
}


resource "aws_efs_mount_target" "my_mount_target" {
  count           = length(data.terraform_remote_state.vpc_state.outputs.private_subnet_ids)
  file_system_id  = aws_efs_file_system.my_efs.id
  subnet_id       = data.terraform_remote_state.vpc_state.outputs.private_subnet_ids[count.index]
  security_groups = [aws_security_group.efs_mount_target_sg.id]
}


#data "aws_eks_cluster" "cluster" {
#  name = var.cluster-name
#}

#resource "kubectl_manifest" "efs_csi_driver" {
#  yaml_body = <<EOF
#apiVersion: apps/v1
#kind: DaemonSet
#metadata:
#  name: efs-csi-node
#  namespace: kube-system
#spec:
#  selector:
#    matchLabels:
#      app: efs-csi-node
#  template:
#    metadata:
#      labels:
#        app: efs-csi-node
#    spec:
#      serviceAccountName: efs-csi-controller-sa
#      containers:
#        - name: efs-plugin
#          image: amazon/aws-efs-csi-driver:v1.3.2
#          volumeMounts:
#            - name: efs-csi-plugins
#              mountPath: /csi
#            - name: drivers
#              mountPath: /var/lib/kubelet/plugins
#              readOnly: true
#        - name: efs-provisioner
#          image: amazon/aws-efs-csi-driver:v1.3.2
#          args: ["--v=2"]
#          volumeMounts:
#            - name: efs-csi-plugins
#              mountPath: /csi
#            - name: drivers
#              mountPath: /var/lib/kubelet/plugins
#              readOnly: true
#      volumes:
#        - name: efs-csi-plugins
#          hostPath:
#            path: /var/lib/kubelet/plugins
#        - name: drivers
#          hostPath:
#            path: /usr/libexec/kubernetes/kubelet-plugins
#EOF
#  depends_on = [data.aws_eks_cluster.cluster]
#}
#
