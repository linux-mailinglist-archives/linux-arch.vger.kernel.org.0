Return-Path: <linux-arch+bounces-13301-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33648B39059
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 03:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15AD46327C
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 01:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AC11E98EF;
	Thu, 28 Aug 2025 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KJB8jR3B"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE701DE3A4;
	Thu, 28 Aug 2025 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756342824; cv=none; b=kmpW+LJ/joa4Oswdjfx4Rgn4dg6nWQJ5Qrs2HpiYbRiibVxP3LwejpK2AktwQA5WEA+/U+YSDVp2IrJkXvoDKisQHMBQmFM7q/WPRmtoI/itZtya8Eo/uhpQIzABvty//KtfVTUV0ldp27y3E0fpf2F4nNdrvMkNaLcO5cBbDBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756342824; c=relaxed/simple;
	bh=cXjwyYCcuwed9HT3WHEVmquePrgM5qIWCdFLZfHpEqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uXr25+jcmyRgvH2ArgnEztuZq5NrV3MlEh+7o2nZu5tttRWvqTxUtygHSRV70u5D3gPESD3B+PwDivzKjfwRGm4FzNJOaQDSIE0NZS8Rhm1wLlFiRCRlQkq05KUIN2Kq58+8FEVFC5VY0e9YR8tWpGgDDkuJ8pvmOhudm72XTnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KJB8jR3B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9E52C211082E;
	Wed, 27 Aug 2025 18:00:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E52C211082E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756342816;
	bh=/CwiEWHR++EoFKg4PyyXshEcybacnRMuJn3wXJvfRYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KJB8jR3BJiRzL3+PyozeUQRm+IAkR0v1AuodIpi5jdYa0RVAuNab9zVJHuOBXRYtV
	 BQdDsV9MtnY+Y/XTDtQ7GjT+lS3F9JASRmuz8fpASQ/47D14gA+VjIgRWbYnL0MxXF
	 MU81cEpE/2JGGEszl8P8CEcRFk/nIFqz3Wq8BNRI=
From: Mukesh Rathor <mrathor@linux.microsoft.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-arch@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jikos@kernel.org,
	bentiss@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	dmitry.torokhov@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bhelgaas@google.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	gregkh@linuxfoundation.org,
	deller@gmx.de,
	arnd@arndb.de,
	sgarzare@redhat.com,
	horms@kernel.org
Subject: [PATCH V0 1/2] hyper-v: Add CONFIG_HYPERV_VMBUS option
Date: Wed, 27 Aug 2025 17:59:51 -0700
Message-Id: <20250828005952.884343-2-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20250828005952.884343-1-mrathor@linux.microsoft.com>
References: <20250828005952.884343-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Somehow vmbus driver is hinged on CONFIG_HYPERV. It appears this is initial
code that did not get addressed when the scope of CONFIG_HYPERV went beyond
vmbus. This commit creates a fine grained HYPERV_VMBUS option and updates
drivers that depend on VMBUS.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 drivers/gpu/drm/Kconfig        |  2 +-
 drivers/hid/Kconfig            |  2 +-
 drivers/hv/Kconfig             | 12 +++++++++---
 drivers/hv/Makefile            |  2 +-
 drivers/input/serio/Kconfig    |  4 ++--
 drivers/net/hyperv/Kconfig     |  2 +-
 drivers/pci/Kconfig            |  2 +-
 drivers/scsi/Kconfig           |  2 +-
 drivers/uio/Kconfig            |  2 +-
 drivers/video/fbdev/Kconfig    |  2 +-
 include/asm-generic/mshyperv.h |  8 +++++---
 net/vmw_vsock/Kconfig          |  2 +-
 12 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index f7ea8e895c0c..58f34da061c6 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -398,7 +398,7 @@ source "drivers/gpu/drm/imagination/Kconfig"
 
 config DRM_HYPERV
 	tristate "DRM Support for Hyper-V synthetic video device"
-	depends on DRM && PCI && HYPERV
+	depends on DRM && PCI && HYPERV_VMBUS
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
 	select DRM_GEM_SHMEM_HELPER
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index a57901203aeb..fe3dc8c0db99 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1162,7 +1162,7 @@ config GREENASIA_FF
 
 config HID_HYPERV_MOUSE
 	tristate "Microsoft Hyper-V mouse driver"
-	depends on HYPERV
+	depends on HYPERV_VMBUS
 	help
 	Select this option to enable the Hyper-V mouse driver.
 
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 2e8df09db599..08c4ed005137 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -44,18 +44,24 @@ config HYPERV_TIMER
 
 config HYPERV_UTILS
 	tristate "Microsoft Hyper-V Utilities driver"
-	depends on HYPERV && CONNECTOR && NLS
+	depends on HYPERV_VMBUS && CONNECTOR && NLS
 	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	  Select this option to enable the Hyper-V Utilities.
 
 config HYPERV_BALLOON
 	tristate "Microsoft Hyper-V Balloon driver"
-	depends on HYPERV
+	depends on HYPERV_VMBUS
 	select PAGE_REPORTING
 	help
 	  Select this option to enable Hyper-V Balloon driver.
 
+config HYPERV_VMBUS
+	tristate "Microsoft Hyper-V Vmbus driver"
+	depends on HYPERV
+	help
+	  Select this option to enable Hyper-V Vmbus driver.
+
 config MSHV_ROOT
 	tristate "Microsoft Hyper-V root partition support"
 	depends on HYPERV && (X86_64 || ARM64)
@@ -75,7 +81,7 @@ config MSHV_ROOT
 
 config MSHV_VTL
 	tristate "Microsoft Hyper-V VTL driver"
-	depends on X86_64 && HYPERV_VTL_MODE
+	depends on X86_64 && HYPERV_VTL_MODE && HYPERV_VMBUS
 	# Mapping VTL0 memory to a userspace process in VTL2 is supported in OpenHCL.
 	# VTL2 for OpenHCL makes use of Huge Pages to improve performance on VMs,
 	# specially with large memory requirements.
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index c53a0df746b7..050517756a82 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
+obj-$(CONFIG_HYPERV_VMBUS)	+= hv_vmbus.o
 obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
 obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
 obj-$(CONFIG_MSHV_ROOT)		+= mshv_root.o
diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index 17edc1597446..c7ef347a4dff 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -276,8 +276,8 @@ config SERIO_OLPC_APSP
 
 config HYPERV_KEYBOARD
 	tristate "Microsoft Synthetic Keyboard driver"
-	depends on HYPERV
-	default HYPERV
+	depends on HYPERV_VMBUS
+	default HYPERV_VMBUS
 	help
 	  Select this option to enable the Hyper-V Keyboard driver.
 
diff --git a/drivers/net/hyperv/Kconfig b/drivers/net/hyperv/Kconfig
index c8cbd85adcf9..982964c1a9fb 100644
--- a/drivers/net/hyperv/Kconfig
+++ b/drivers/net/hyperv/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config HYPERV_NET
 	tristate "Microsoft Hyper-V virtual network driver"
-	depends on HYPERV
+	depends on HYPERV_VMBUS
 	select UCS2_STRING
 	select NLS
 	help
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9a249c65aedc..7065a8e5f9b1 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -221,7 +221,7 @@ config PCI_LABEL
 
 config PCI_HYPERV
 	tristate "Hyper-V PCI Frontend"
-	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && SYSFS
+	depends on ((X86 && X86_64) || ARM64) && HYPERV_VMBUS && PCI_MSI && SYSFS
 	select PCI_HYPERV_INTERFACE
 	select IRQ_MSI_LIB
 	help
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 5522310bab8d..19d0884479a2 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -589,7 +589,7 @@ config XEN_SCSI_FRONTEND
 
 config HYPERV_STORAGE
 	tristate "Microsoft Hyper-V virtual storage driver"
-	depends on SCSI && HYPERV
+	depends on SCSI && HYPERV_VMBUS
 	depends on m || SCSI_FC_ATTRS != m
 	default HYPERV
 	help
diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index b060dcd7c635..6f86a61231e6 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -140,7 +140,7 @@ config UIO_MF624
 
 config UIO_HV_GENERIC
 	tristate "Generic driver for Hyper-V VMBus"
-	depends on HYPERV
+	depends on HYPERV_VMBUS
 	help
 	  Generic driver that you can bind, dynamically, to any
 	  Hyper-V VMBus device. It is useful to provide direct access
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index c21484d15f0c..72c63eaeb983 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1774,7 +1774,7 @@ config FB_BROADSHEET
 
 config FB_HYPERV
 	tristate "Microsoft Hyper-V Synthetic Video support"
-	depends on FB && HYPERV
+	depends on FB && HYPERV_VMBUS
 	select DMA_CMA if HAVE_DMA_CONTIGUOUS && CMA
 	select FB_IOMEM_HELPERS_DEFERRED
 	help
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 1d2ad1304ad4..66c58c91b530 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -165,6 +165,7 @@ static inline u64 hv_generate_guest_id(u64 kernel_version)
 
 void __init hv_mark_resources(void);
 
+#if IS_ENABLED(CONFIG_HYPERV_VMBUS)
 /* Free the message slot and signal end-of-message if required */
 static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 {
@@ -200,6 +201,10 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 	}
 }
 
+extern int vmbus_interrupt;
+extern int vmbus_irq;
+#endif /* CONFIG_HYPERV_VMBUS */
+
 int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
 
 void hv_setup_vmbus_handler(void (*handler)(void));
@@ -213,9 +218,6 @@ void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
 void hv_remove_crash_handler(void);
 void hv_setup_mshv_handler(void (*handler)(void));
 
-extern int vmbus_interrupt;
-extern int vmbus_irq;
-
 #if IS_ENABLED(CONFIG_HYPERV)
 /*
  * Hypervisor's notion of virtual processor ID is different from
diff --git a/net/vmw_vsock/Kconfig b/net/vmw_vsock/Kconfig
index 56356d2980c8..8e803c4828c4 100644
--- a/net/vmw_vsock/Kconfig
+++ b/net/vmw_vsock/Kconfig
@@ -72,7 +72,7 @@ config VIRTIO_VSOCKETS_COMMON
 
 config HYPERV_VSOCKETS
 	tristate "Hyper-V transport for Virtual Sockets"
-	depends on VSOCKETS && HYPERV
+	depends on VSOCKETS && HYPERV_VMBUS
 	help
 	  This module implements a Hyper-V transport for Virtual Sockets.
 
-- 
2.36.1.vfs.0.0


