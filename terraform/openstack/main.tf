resource "openstack_blockstorage_volume_v3" "volume" {
  name = "Volume-single"
  description = "First test volume"
  size        = 1
}
resource "openstack_compute_instance_v2" "instance" {
  name            = "VM-single"
  image_name      = ""
  flavor_name     = ""
  key_pair        = ""
  security_groups = ["default","all-allowed"]
  network {
    name = ""
  }
}
resource "openstack_compute_volume_attach_v2" "attachment" {
  instance_id = "${openstack_compute_instance_v2.instance.id}"
  volume_id   = "${openstack_blockstorage_volume_v3.volume.id}"
}

resource "openstack_blockstorage_volume_v3" "volumes" {
  count = 3
  name  = "Volume-${count.index}"
  size  = 1
}
resource "openstack_compute_instance_v2" "instances" {
  name            = "VM-${count.index}"
  image_name      = ""
  flavor_name     = ""
  key_pair        = ""
  security_groups = ["default","all-allowed"]
  count           = 3
  network {
    name = ""
  }
}
resource "openstack_compute_volume_attach_v2" "attachments" {
  count       = 3
  instance_id = "${openstack_compute_instance_v2.instances.*.id[count.index]}"
  volume_id   = "${openstack_blockstorage_volume_v3.volumes.*.id[count.index]}"
}