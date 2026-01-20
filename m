Return-Path: <linux-arch+bounces-15889-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 860FBD3BFBA
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 07:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 528093C3EC0
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 06:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8031437B3F3;
	Tue, 20 Jan 2026 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bWnfQDL5"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F61537F8C9;
	Tue, 20 Jan 2026 06:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891440; cv=none; b=oPBFcWcYG6EZ4RN0rHxiVWtfBD/s3qh9hlyf1KPpHnOvHILHe4bSWtBTfd39hMuZDU3AEKOCSdxM99XxX/GM45MPDv/uYMN+UobP+eN1iA3VCeOt4uX1I0xwasOvnKoPyl1B/yGCww7K4VLXQHxPa3WXXB+quqVX/v+9T6DlT+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891440; c=relaxed/simple;
	bh=BalUxhQJ1yFzwpzZ+AK8cf6+vgLeWHhnt34Pqi87B4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtzpUtwrtVXhPk+6Ep0cKlFtnbvU8JSPiDNfoN4Lf5YZc7JfGQgQBt34RZREeKPEd1pCmO+2zqJ3KDK1OQI1+O1LyBYfmUDJNqRgbZ8VISOoJiDkvPZJC9MMXx3KH/nG1WGKjc0ME6+eGqdAuKlw3tlcuvZmMFuMhvxV2e90ZwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bWnfQDL5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id C8E3D20B7167;
	Mon, 19 Jan 2026 22:43:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C8E3D20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768891419;
	bh=+gfNKWeY08Vm8PNbCFC1rEYtYrIGwfSMI5VrEew50HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bWnfQDL5EUpEsU3VzMRuWBTbnZ3bATyez623M6D62i2f141uJAJGhHGyGTh+MdAt1
	 YP6Tq7BIRfj0D3JdRcLqQw3mfIdiF6PR0FqAQxPP+4n82vypfpQBll8q63FbRw9W+p
	 wxIBkhEnSWn9JFFv8q8IWYkupEoY/QP4lQqvHtzE=
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
Subject: [PATCH v0 10/15] PCI: hv: Build device id for a VMBus device
Date: Mon, 19 Jan 2026 22:42:25 -0800
Message-ID: <20260120064230.3602565-11-mrathor@linux.microsoft.com>
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

On Hyper-V, most hypercalls related to PCI passthru to map/unmap regions,
interrupts, etc need a device id as a parameter. This device id refers
to that specific device during the lifetime of passthru.

An L1VH VM only contains VMBus based devices. A device id for a VMBus
device is slightly different in that it uses the hv_pcibus_device info
for building it to make sure it matches exactly what the hypervisor
expects. This VMBus based device id is needed when attaching devices in
an L1VH based guest VM. Before building it, a check is done to make sure
the device is a valid VMBus device.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 arch/x86/include/asm/mshyperv.h     |  2 ++
 drivers/pci/controller/pci-hyperv.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index eef4c3a5ba28..0d7fdfb25e76 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -188,6 +188,8 @@ bool hv_vcpu_is_preempted(int vcpu);
 static inline void hv_apic_init(void) {}
 #endif
 
+u64 hv_pci_vmbus_device_id(struct pci_dev *pdev);
+
 struct irq_domain *hv_create_pci_msi_domain(void);
 
 int hv_map_msi_interrupt(struct irq_data *data,
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 8bc6a38c9b5a..40f0b06bb966 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -579,6 +579,8 @@ static void hv_pci_onchannelcallback(void *context);
 #define DELIVERY_MODE		APIC_DELIVERY_MODE_FIXED
 #define HV_MSI_CHIP_FLAGS	MSI_CHIP_FLAG_SET_ACK
 
+static bool hv_vmbus_pci_device(struct pci_bus *pbus);
+
 static int hv_pci_irqchip_init(void)
 {
 	return 0;
@@ -598,6 +600,26 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
 
 #define hv_msi_prepare		pci_msi_prepare
 
+u64 hv_pci_vmbus_device_id(struct pci_dev *pdev)
+{
+	u64 u64val;
+	struct hv_pcibus_device *hbus;
+	struct pci_bus *pbus = pdev->bus;
+
+	if (!hv_vmbus_pci_device(pbus))
+		return 0;
+
+	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
+	u64val = (hbus->hdev->dev_instance.b[5] << 24) |
+		 (hbus->hdev->dev_instance.b[4] << 16) |
+		 (hbus->hdev->dev_instance.b[7] << 8) |
+		 (hbus->hdev->dev_instance.b[6] & 0xf8) |
+		 PCI_FUNC(pdev->devfn);
+
+	return u64val;
+}
+EXPORT_SYMBOL_GPL(hv_pci_vmbus_device_id);
+
 /**
  * hv_irq_retarget_interrupt() - "Unmask" the IRQ by setting its current
  * affinity.
@@ -1404,6 +1426,13 @@ static struct pci_ops hv_pcifront_ops = {
 	.write = hv_pcifront_write_config,
 };
 
+#ifdef CONFIG_X86
+static bool hv_vmbus_pci_device(struct pci_bus *pbus)
+{
+	return pbus->ops == &hv_pcifront_ops;
+}
+#endif /* CONFIG_X86 */
+
 /*
  * Paravirtual backchannel
  *
-- 
2.51.2.vfs.0.1


