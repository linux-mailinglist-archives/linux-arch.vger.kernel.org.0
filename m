Return-Path: <linux-arch+bounces-15882-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8AFD3BF9D
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 07:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 625A53C1350
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 06:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C67239C62F;
	Tue, 20 Jan 2026 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XooknD8V"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D60387564;
	Tue, 20 Jan 2026 06:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891430; cv=none; b=RXVaPxqKrFa67B0z5JSXglbU0xrAP1ChzPFyowW4NilgqMTRD7+IUy7fpRdQN8Szbl6VOCLlpRQX0fK7BKsw9uEzjSFIsjPtKz8WqgaatlAb2vzRHOzxFEPUv5cDOX7LokjiSit3gATkSXzHwz+q4P/utOMcM8OMI7mDEwiWIUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891430; c=relaxed/simple;
	bh=5lHBBMfqPqoiY8Jb5i1UmMDSCU6QId/cFabKNEhXapA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9brgOlpVwpaJUVBfo7OwNJR7EzIEaFSujNcmhnFD7zv3tSmn6/gBhV1Ew1XvTHRSS4WVYLND8mY+AakwjYF/fVKNGMIsWwyGp1ugrHBpf/yyTIJ9cqGO7KJub1cBsJP2mb8ilr9XTnxv/v3MfVqxuiq933vaZsYywYdOKvQXJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XooknD8V; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id F3B4F20B7170;
	Mon, 19 Jan 2026 22:43:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F3B4F20B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768891415;
	bh=zpXyH34CFeKZeTaTWBElXlgUbMpP958BejYtbygF9WU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XooknD8V3y1L7GC5cut7FI2hLyVvn6UK2r3zNP70pOOrJOGkL2XgdHyUFQhkvqH+s
	 a2RAD3LH4gUbnfx4u/9xJnauVpk+rbZvmVon1tdkvwqWrzcIdMVTfcOr9i82ENiIG+
	 9hTmsE68dqA36HuiiMpMrCAkEEFwOF3W1KpplTro=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	joro@8bytes.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de,
	nunodasneves@linux.microsoft.com,
	mhklinux@outlook.com,
	romank@linux.microsoft.com
Subject: [PATCH v0 07/15] mshv: Add ioctl support for MSHV-VFIO bridge device
Date: Mon, 19 Jan 2026 22:42:22 -0800
Message-ID: <20260120064230.3602565-8-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mukesh Rathor <mrathor@linux.microsoft.com>

Add ioctl support for creating MSHV devices for a paritition. At
present only VFIO device types are supported, but more could be
added. At a high level, a partition ioctl to create device verifies
it is of type VFIO and does some setup for bridge code in mshv_vfio.c.
Adapted from KVM device ioctls.

Credits: Original author: Wei Liu <wei.liu@kernel.org>
NB: Slightly modified from the original version.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 126 ++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 83c7bad269a0..27313419828d 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1551,6 +1551,129 @@ mshv_partition_ioctl_initialize(struct mshv_partition *partition)
 	return ret;
 }
 
+static long mshv_device_attr_ioctl(struct mshv_device *mshv_dev, int cmd,
+				   ulong uarg)
+{
+	struct mshv_device_attr attr;
+	const struct mshv_device_ops *devops = mshv_dev->device_ops;
+
+	if (copy_from_user(&attr, (void __user *)uarg, sizeof(attr)))
+		return -EFAULT;
+
+	switch (cmd) {
+	case MSHV_SET_DEVICE_ATTR:
+		if (devops->device_set_attr)
+			return devops->device_set_attr(mshv_dev, &attr);
+		break;
+	case MSHV_HAS_DEVICE_ATTR:
+		if (devops->device_has_attr)
+			return devops->device_has_attr(mshv_dev, &attr);
+		break;
+	}
+
+	return -EPERM;
+}
+
+static long mshv_device_fop_ioctl(struct file *filp, unsigned int cmd,
+				  ulong uarg)
+{
+	struct mshv_device *mshv_dev = filp->private_data;
+
+	switch (cmd) {
+	case MSHV_SET_DEVICE_ATTR:
+	case MSHV_HAS_DEVICE_ATTR:
+		return mshv_device_attr_ioctl(mshv_dev, cmd, uarg);
+	}
+
+	return -ENOTTY;
+}
+
+static int mshv_device_fop_release(struct inode *inode, struct file *filp)
+{
+	struct mshv_device *mshv_dev = filp->private_data;
+	struct mshv_partition *partition = mshv_dev->device_pt;
+
+	if (mshv_dev->device_ops->device_release) {
+		mutex_lock(&partition->pt_mutex);
+		hlist_del(&mshv_dev->device_ptnode);
+		mshv_dev->device_ops->device_release(mshv_dev);
+		mutex_unlock(&partition->pt_mutex);
+	}
+
+	mshv_partition_put(partition);
+	return 0;
+}
+
+static const struct file_operations mshv_device_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = mshv_device_fop_ioctl,
+	.release = mshv_device_fop_release,
+};
+
+long mshv_partition_ioctl_create_device(struct mshv_partition *partition,
+					void __user *uarg)
+{
+	long rc;
+	struct mshv_create_device devargk;
+	struct mshv_device *mshv_dev;
+	const struct mshv_device_ops *vfio_ops;
+	int type;
+
+	if (copy_from_user(&devargk, uarg, sizeof(devargk))) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	/* At present, only VFIO is supported */
+	if (devargk.type != MSHV_DEV_TYPE_VFIO) {
+		rc = -ENODEV;
+		goto out;
+	}
+
+	if (devargk.flags & MSHV_CREATE_DEVICE_TEST) {
+		rc = 0;
+		goto out;
+	}
+
+	mshv_dev = kzalloc(sizeof(*mshv_dev), GFP_KERNEL_ACCOUNT);
+	if (mshv_dev == NULL) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	vfio_ops = &mshv_vfio_device_ops;
+	mshv_dev->device_ops = vfio_ops;
+	mshv_dev->device_pt = partition;
+
+	rc = vfio_ops->device_create(mshv_dev, type);
+	if (rc < 0) {
+		kfree(mshv_dev);
+		goto out;
+	}
+
+	hlist_add_head(&mshv_dev->device_ptnode, &partition->pt_devices);
+
+	mshv_partition_get(partition);
+	rc = anon_inode_getfd(vfio_ops->device_name, &mshv_device_fops,
+			      mshv_dev, O_RDWR | O_CLOEXEC);
+	if (rc < 0) {
+		mshv_partition_put(partition);
+		hlist_del(&mshv_dev->device_ptnode);
+		vfio_ops->device_release(mshv_dev);
+		goto out;
+	}
+
+	devargk.fd = rc;
+	rc = 0;
+
+	if (copy_to_user(uarg, &devargk, sizeof(devargk))) {
+		rc = -EFAULT;
+		goto out;
+	}
+out:
+	return rc;
+}
+
 static long
 mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
@@ -1587,6 +1710,9 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	case MSHV_ROOT_HVCALL:
 		ret = mshv_ioctl_passthru_hvcall(partition, true, uarg);
 		break;
+	case MSHV_CREATE_DEVICE:
+		ret = mshv_partition_ioctl_create_device(partition, uarg);
+		break;
 	default:
 		ret = -ENOTTY;
 	}
-- 
2.51.2.vfs.0.1


