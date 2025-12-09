Return-Path: <linux-arch+bounces-15310-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E45C3CAEE9B
	for <lists+linux-arch@lfdr.de>; Tue, 09 Dec 2025 06:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 335B23003862
	for <lists+linux-arch@lfdr.de>; Tue,  9 Dec 2025 05:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CE827F75F;
	Tue,  9 Dec 2025 05:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i3ChbI+4"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E4F2264BA;
	Tue,  9 Dec 2025 05:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765257102; cv=none; b=AAQLes4IF1MUxFFod8ZgX1kXTD7A26jYytkqCjQTx1P+b49HtG5wOmRU63Jqsdk+xG6CDr2qjYdzY3s+izAtS42Uq/+YCuSKrxnSPnHrE1GjqTjtDcRHyX54rzAkHatABMrhmKOMJ59DWn9yP0ayUCiG+vsTKr4EoJJYNzZfP+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765257102; c=relaxed/simple;
	bh=+3p143fMjSAppT2Qj7LdMPmEhdytqzIMC8YXkd/Gslo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fmbdaq/SAFGaP9xWafdJ4U5TN1yrFsPcEAOMJbG34GLVtsnGjqPnlafJ+sez+ZNo7AVnGk2vi5EXEHjXcJTK39wtUzqQxqjWCBq6Se1eISzMVO3vq9eZPKgklKLM36EgkYPYlL4rTBv+zHaQeFh7vDQP/juD1FRu8NjU2iU80y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i3ChbI+4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.232.230])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3B0AB201568D;
	Mon,  8 Dec 2025 21:11:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B0AB201568D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765257100;
	bh=UvO9DsqrHAa+vgyuca9m8lV/Z4f5gmA9KXFanQPw9dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3ChbI+4CtB4IYKTOGVQl/4hLhMCQy38sL9A+5KxkZ2VFTF+5GHh63mnUNj1LN66t
	 /FqojnkhWLVQdb8KEqD62aUYJ+RgL8TpytZo2DGDUDa5evOPiJwPaT4SeRsvEL/ojB
	 mMZSpfoz8yYQO768MaHBYSTPQdonf0LzUxL1n824=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	easwar.hariharan@linux.microsoft.com,
	jacob.pan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	mhklinux@outlook.com,
	peterz@infradead.org,
	linux-arch@vger.kernel.org
Subject: [RFC v1 1/5] PCI: hv: Create and export hv_build_logical_dev_id()
Date: Tue,  9 Dec 2025 13:11:24 +0800
Message-ID: <20251209051128.76913-2-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

Hyper-V uses a logical device ID to identify a PCI endpoint device for
child partitions. This ID will also be required for future hypercalls
used by the Hyper-V IOMMU driver.

Refactor the logic for building this logical device ID into a standalone
helper function and export the interface for wider use.

Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 28 ++++++++++++++++++++--------
 include/asm-generic/mshyperv.h      |  2 ++
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 146b43981b27..4b82e06b5d93 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -598,15 +598,31 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
 
 #define hv_msi_prepare		pci_msi_prepare
 
+/**
+ * Build a "Device Logical ID" out of this PCI bus's instance GUID and the
+ * function number of the device.
+ */
+u64 hv_build_logical_dev_id(struct pci_dev *pdev)
+{
+	struct pci_bus *pbus = pdev->bus;
+	struct hv_pcibus_device *hbus = container_of(pbus->sysdata,
+						struct hv_pcibus_device, sysdata);
+
+	return (u64)((hbus->hdev->dev_instance.b[5] << 24) |
+		     (hbus->hdev->dev_instance.b[4] << 16) |
+		     (hbus->hdev->dev_instance.b[7] << 8)  |
+		     (hbus->hdev->dev_instance.b[6] & 0xf8) |
+		     PCI_FUNC(pdev->devfn));
+}
+EXPORT_SYMBOL_GPL(hv_build_logical_dev_id);
+
 /**
  * hv_irq_retarget_interrupt() - "Unmask" the IRQ by setting its current
  * affinity.
  * @data:	Describes the IRQ
  *
  * Build new a destination for the MSI and make a hypercall to
- * update the Interrupt Redirection Table. "Device Logical ID"
- * is built out of this PCI bus's instance GUID and the function
- * number of the device.
+ * update the Interrupt Redirection Table.
  */
 static void hv_irq_retarget_interrupt(struct irq_data *data)
 {
@@ -642,11 +658,7 @@ static void hv_irq_retarget_interrupt(struct irq_data *data)
 	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
 	params->int_entry.msi_entry.address.as_uint32 = int_desc->address & 0xffffffff;
 	params->int_entry.msi_entry.data.as_uint32 = int_desc->data;
-	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
-			   (hbus->hdev->dev_instance.b[4] << 16) |
-			   (hbus->hdev->dev_instance.b[7] << 8) |
-			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
-			   PCI_FUNC(pdev->devfn);
+	params->device_id = hv_build_logical_dev_id(pdev);
 	params->int_target.vector = hv_msi_get_int_vector(data);
 
 	if (hbus->protocol_version >= PCI_PROTOCOL_VERSION_1_2) {
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 64ba6bc807d9..1a205ed69435 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -71,6 +71,8 @@ extern enum hv_partition_type hv_curr_partition_type;
 extern void * __percpu *hyperv_pcpu_input_arg;
 extern void * __percpu *hyperv_pcpu_output_arg;
 
+extern u64 hv_build_logical_dev_id(struct pci_dev *pdev);
+
 u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
-- 
2.49.0


