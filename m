Return-Path: <linux-arch+bounces-15883-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C88B4D3BFA4
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 07:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C38B43C1FA1
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 06:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7DE3A0E84;
	Tue, 20 Jan 2026 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IOvVNIdh"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E763803C9;
	Tue, 20 Jan 2026 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891435; cv=none; b=PrdL2Q3++1PNKnK92Vc/WDOxhiKbPj7b5HsJWK8hdkExRdxSDH11GuOzUdEKHpYGg/IhM3Fd1XljpORoGNhozr6jJvXW7RbxwdkgZmBJjiWzO0nluJ//OJ8xWb6dMyL+9ujHvybG0+nfEv0ENQ/p2VibHI4a2ZlL1seM9Hfy4uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891435; c=relaxed/simple;
	bh=bA8FXOSfgwoFcriGq3LSw/3iLnfAcmWaKC91caQlQcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=runS1K0es2BDT65W6GnChAHUpf1tG8C9p/IcHI+tCmz9aNkZPHz04Qa8x2p77OR9fRFxqf8FDLU+5nlp5br12ONLCjySaTmGFn7tf4MyhD1EGhWJ4Cj8ZtU3Mm47y6f7e9/pwEEK3JLwiZnDlrJcY79ubHPdpEZRIEPxQYm2cus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IOvVNIdh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id B615E20B716F;
	Mon, 19 Jan 2026 22:43:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B615E20B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768891414;
	bh=FwXH04ojEJxzpdDZwfeULNXdgZ4dyhCYxfw3tXdVy3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IOvVNIdhQm1FzPXkTQDr6pHRkzL3ArhoH+uoR99cwC5MHH22g9j3Kl66U8jUWNDCP
	 k5Y9DlpfYNsMYamxE6UKNWHlrDXpfhR5dsom3uwq/vPtCAsjkiqt4DXdL6AWhq3aOF
	 L6r1zY4aWR9/vJsgZZzPvwf9FsiwH55J+H45oDPk=
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
Subject: [PATCH v0 06/15] mshv: Implement mshv bridge device for VFIO
Date: Mon, 19 Jan 2026 22:42:21 -0800
Message-ID: <20260120064230.3602565-7-mrathor@linux.microsoft.com>
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

Add a new file to implement VFIO-MSHV bridge pseudo device. These
functions are called in the VFIO framework, and credits to kvm/vfio.c
as this file was adapted from it.

Original author: Wei Liu <wei.liu@kernel.org>
(Slightly modified from the original version).

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 drivers/hv/Makefile    |   3 +-
 drivers/hv/mshv_vfio.c | 210 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 212 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hv/mshv_vfio.c

diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index a49f93c2d245..eae003c4cb8f 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -14,7 +14,8 @@ hv_vmbus-y := vmbus_drv.o \
 hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
 mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
-	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o
+	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o \
+               mshv_vfio.o
 mshv_vtl-y := mshv_vtl_main.o
 
 # Code that must be built-in
diff --git a/drivers/hv/mshv_vfio.c b/drivers/hv/mshv_vfio.c
new file mode 100644
index 000000000000..6ea4d99a3bd2
--- /dev/null
+++ b/drivers/hv/mshv_vfio.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VFIO-MSHV bridge pseudo device
+ *
+ * Heavily inspired by the VFIO-KVM bridge pseudo device.
+ */
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/vfio.h>
+
+#include "mshv.h"
+#include "mshv_root.h"
+
+struct mshv_vfio_file {
+	struct list_head node;
+	struct file *file;	/* list of struct mshv_vfio_file */
+};
+
+struct mshv_vfio {
+	struct list_head file_list;
+	struct mutex lock;
+};
+
+static bool mshv_vfio_file_is_valid(struct file *file)
+{
+	bool (*fn)(struct file *file);
+	bool ret;
+
+	fn = symbol_get(vfio_file_is_valid);
+	if (!fn)
+		return false;
+
+	ret = fn(file);
+
+	symbol_put(vfio_file_is_valid);
+
+	return ret;
+}
+
+static long mshv_vfio_file_add(struct mshv_device *mshvdev, unsigned int fd)
+{
+	struct mshv_vfio *mshv_vfio = mshvdev->device_private;
+	struct mshv_vfio_file *mvf;
+	struct file *filp;
+	long ret = 0;
+
+	filp = fget(fd);
+	if (!filp)
+		return -EBADF;
+
+	/* Ensure the FD is a vfio FD. */
+	if (!mshv_vfio_file_is_valid(filp)) {
+		ret = -EINVAL;
+		goto out_fput;
+	}
+
+	mutex_lock(&mshv_vfio->lock);
+
+	list_for_each_entry(mvf, &mshv_vfio->file_list, node) {
+		if (mvf->file == filp) {
+			ret = -EEXIST;
+			goto out_unlock;
+		}
+	}
+
+	mvf = kzalloc(sizeof(*mvf), GFP_KERNEL_ACCOUNT);
+	if (!mvf) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	mvf->file = get_file(filp);
+	list_add_tail(&mvf->node, &mshv_vfio->file_list);
+
+out_unlock:
+	mutex_unlock(&mshv_vfio->lock);
+out_fput:
+	fput(filp);
+	return ret;
+}
+
+static long mshv_vfio_file_del(struct mshv_device *mshvdev, unsigned int fd)
+{
+	struct mshv_vfio *mshv_vfio = mshvdev->device_private;
+	struct mshv_vfio_file *mvf;
+	long ret;
+
+	CLASS(fd, f)(fd);
+
+	if (fd_empty(f))
+		return -EBADF;
+
+	ret = -ENOENT;
+	mutex_lock(&mshv_vfio->lock);
+
+	list_for_each_entry(mvf, &mshv_vfio->file_list, node) {
+		if (mvf->file != fd_file(f))
+			continue;
+
+		list_del(&mvf->node);
+		fput(mvf->file);
+		kfree(mvf);
+		ret = 0;
+		break;
+	}
+
+	mutex_unlock(&mshv_vfio->lock);
+	return ret;
+}
+
+static long mshv_vfio_set_file(struct mshv_device *mshvdev, long attr,
+			      void __user *arg)
+{
+	int32_t __user *argp = arg;
+	int32_t fd;
+
+	switch (attr) {
+	case MSHV_DEV_VFIO_FILE_ADD:
+		if (get_user(fd, argp))
+			return -EFAULT;
+		return mshv_vfio_file_add(mshvdev, fd);
+
+	case MSHV_DEV_VFIO_FILE_DEL:
+		if (get_user(fd, argp))
+			return -EFAULT;
+		return mshv_vfio_file_del(mshvdev, fd);
+	}
+
+	return -ENXIO;
+}
+
+static long mshv_vfio_set_attr(struct mshv_device *mshvdev,
+			      struct mshv_device_attr *attr)
+{
+	switch (attr->group) {
+	case MSHV_DEV_VFIO_FILE:
+		return mshv_vfio_set_file(mshvdev, attr->attr,
+					  u64_to_user_ptr(attr->addr));
+	}
+
+	return -ENXIO;
+}
+
+static long mshv_vfio_has_attr(struct mshv_device *mshvdev,
+			      struct mshv_device_attr *attr)
+{
+	switch (attr->group) {
+	case MSHV_DEV_VFIO_FILE:
+		switch (attr->attr) {
+		case MSHV_DEV_VFIO_FILE_ADD:
+		case MSHV_DEV_VFIO_FILE_DEL:
+			return 0;
+		}
+
+		break;
+	}
+
+	return -ENXIO;
+}
+
+static long mshv_vfio_create_device(struct mshv_device *mshvdev, u32 type)
+{
+	struct mshv_device *tmp;
+	struct mshv_vfio *mshv_vfio;
+
+	/* Only one VFIO "device" per VM */
+	hlist_for_each_entry(tmp, &mshvdev->device_pt->pt_devices,
+			     device_ptnode)
+		if (tmp->device_ops == &mshv_vfio_device_ops)
+			return -EBUSY;
+
+	mshv_vfio = kzalloc(sizeof(*mshv_vfio), GFP_KERNEL_ACCOUNT);
+	if (mshv_vfio == NULL)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&mshv_vfio->file_list);
+	mutex_init(&mshv_vfio->lock);
+
+	mshvdev->device_private = mshv_vfio;
+
+	return 0;
+}
+
+/* This is called from mshv_device_fop_release() */
+static void mshv_vfio_release_device(struct mshv_device *mshvdev)
+{
+	struct mshv_vfio *mv = mshvdev->device_private;
+	struct mshv_vfio_file *mvf, *tmp;
+
+	list_for_each_entry_safe(mvf, tmp, &mv->file_list, node) {
+		fput(mvf->file);
+		list_del(&mvf->node);
+		kfree(mvf);
+	}
+
+	kfree(mv);
+	kfree(mshvdev);
+}
+
+struct mshv_device_ops mshv_vfio_device_ops = {
+	.device_name = "mshv-vfio",
+	.device_create = mshv_vfio_create_device,
+	.device_release = mshv_vfio_release_device,
+	.device_set_attr = mshv_vfio_set_attr,
+	.device_has_attr = mshv_vfio_has_attr,
+};
-- 
2.51.2.vfs.0.1


