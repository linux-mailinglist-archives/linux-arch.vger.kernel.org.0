Return-Path: <linux-arch+bounces-15888-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D691D3BFB8
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 07:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2066E4F8161
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 06:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EB736D4E3;
	Tue, 20 Jan 2026 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UNMpFJkA"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B42D374185;
	Tue, 20 Jan 2026 06:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891440; cv=none; b=gGPDfukSk3qoWGYoV8hlSXt2ZuTo0BXn6vnCw0FpyDAqkSuRxYK/tw2oIbI3/5ZHZSFfVzg7JkrO3vMf3vncv4+lY57HLN9aTDmZ11ImwSIJHHXp4sOS1RlBbr9Iv1orNEPs5km1Hy03vzXlScBUO20/CSlE//k7q7ArtM89gjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891440; c=relaxed/simple;
	bh=FiWfyrWbpLORzTtg0lzCDru3O9TKF1o+yJ40EJBTcnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqWS87UOq9eA59zW1H/OCKddtcpd3UiGrYGapfzmp6J5IEXAQTp0Q8FC2bb65HNFrMIL1EXMs7A3SbOD7fPsbYjDi4L0GEo3MhEXa4xKS+LiMmBxMEF5bTiuTxg5Sxlfwf/49u0hDKj87SZGbU60iU4+LxXI0q/5Dv4+u/TB9Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UNMpFJkA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id E60DA20B7175;
	Mon, 19 Jan 2026 22:43:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E60DA20B7175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768891420;
	bh=e5zTidzD1l2EkEPlrmawzN2dIfFYQQCNH1hdqUaixrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNMpFJkAxc0ipZ/uc95ODahk07NK6NWJyqWcGkaZVKyIZt1UDQiiBulzjGwCk91VX
	 jt0oLrxXe6iYTsRwRbf+EqSpgCO1gfUoGkAjX1AJ38Zyc7EB7vv0f3UcxIZZ6sNoFr
	 vdmcs3Bq/RId5HwNs85PYXjzf1VCUY/upizMZ+/c=
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
Subject: [PATCH v0 11/15] x86/hyperv: Build logical device ids for PCI passthru hcalls
Date: Mon, 19 Jan 2026 22:42:26 -0800
Message-ID: <20260120064230.3602565-12-mrathor@linux.microsoft.com>
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
interrupts, etc need a device id as a parameter. A device id refers
to a specific device. A device id is of two types:
   o Logical: used for direct attach (see below) hypercalls. A logical
              device id is a unique 62bit value that is created and
              sent during the initial device attach. Then all further
              communications (for interrupt remaps etc) must use this
              logical id.
   o PCI: used for device domain hypercalls such as map, unmap, etc.
          This is built using actual device BDF info.

   PS: Since an L1VH only supports direct attaches, a logical device id
       on an L1VH VM is always a VMBus device id. For non-L1VH cases,
       we just use PCI BDF info, altho not strictly needed, to build the
       logical device id.

At a high level, Hyper-V supports two ways to do PCI passthru:
  1. Device Domain: root must create a device domain in the hypervisor,
     and do map/unmap hypercalls for mapping and unmapping guest RAM.
     All hypervisor communications use device id of type PCI for
     identifying and referencing the device.

  2. Direct Attach: the hypervisor will simply use the guest's HW
     page table for mappings, thus the host need not do map/unmap
     hypercalls. A direct attached device must be referenced
     via logical device id and never via the PCI device id. For an
     L1VH root/parent, Hyper-V only supports direct attaches.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 arch/x86/hyperv/irqdomain.c     | 60 ++++++++++++++++++++++++++++++---
 arch/x86/include/asm/mshyperv.h | 14 ++++++++
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index ccbe5848a28f..33017aa0caa4 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -137,7 +137,7 @@ static int get_rid_cb(struct pci_dev *pdev, u16 alias, void *data)
 	return 0;
 }
 
-static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
+static u64 hv_build_devid_type_pci(struct pci_dev *pdev)
 {
 	int pos;
 	union hv_device_id hv_devid;
@@ -197,7 +197,58 @@ static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
 	}
 
 out:
-	return hv_devid;
+	return hv_devid.as_uint64;
+}
+
+/* Build device id for direct attached devices */
+static u64 hv_build_devid_type_logical(struct pci_dev *pdev)
+{
+	hv_pci_segment segment;
+	union hv_device_id hv_devid;
+	union hv_pci_bdf bdf = {.as_uint16 = 0};
+	struct rid_data data = {
+		.bridge = NULL,
+		.rid = PCI_DEVID(pdev->bus->number, pdev->devfn)
+	};
+
+	segment = pci_domain_nr(pdev->bus);
+	bdf.bus = PCI_BUS_NUM(data.rid);
+	bdf.device = PCI_SLOT(data.rid);
+	bdf.function = PCI_FUNC(data.rid);
+
+	hv_devid.as_uint64 = 0;
+	hv_devid.device_type = HV_DEVICE_TYPE_LOGICAL;
+	hv_devid.logical.id = (u64)segment << 16 | bdf.as_uint16;
+
+	return hv_devid.as_uint64;
+}
+
+/* Build device id after the device has been attached */
+u64 hv_build_devid_oftype(struct pci_dev *pdev, enum hv_device_type type)
+{
+	if (type == HV_DEVICE_TYPE_LOGICAL) {
+		if (hv_l1vh_partition())
+			return hv_pci_vmbus_device_id(pdev);
+		else
+			return hv_build_devid_type_logical(pdev);
+	} else if (type == HV_DEVICE_TYPE_PCI)
+		return hv_build_devid_type_pci(pdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hv_build_devid_oftype);
+
+/* Build device id for the interrupt path */
+static u64 hv_build_irq_devid(struct pci_dev *pdev)
+{
+	enum hv_device_type dev_type;
+
+	if (hv_pcidev_is_attached_dev(pdev) || hv_l1vh_partition())
+		dev_type = HV_DEVICE_TYPE_LOGICAL;
+	else
+		dev_type = HV_DEVICE_TYPE_PCI;
+
+	return hv_build_devid_oftype(pdev, dev_type);
 }
 
 /*
@@ -221,7 +272,7 @@ int hv_map_msi_interrupt(struct irq_data *data,
 
 	msidesc = irq_data_get_msi_desc(data);
 	pdev = msi_desc_to_pci_dev(msidesc);
-	hv_devid = hv_build_devid_type_pci(pdev);
+	hv_devid.as_uint64 = hv_build_irq_devid(pdev);
 	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
 
 	return hv_map_interrupt(hv_current_partition_id, hv_devid, false, cpu,
@@ -296,7 +347,8 @@ static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
 {
 	union hv_device_id hv_devid;
 
-	hv_devid = hv_build_devid_type_pci(pdev);
+	hv_devid.as_uint64 = hv_build_irq_devid(pdev);
+
 	return hv_unmap_interrupt(hv_devid.as_uint64, irq_entry);
 }
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 0d7fdfb25e76..97477c5a8487 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -188,6 +188,20 @@ bool hv_vcpu_is_preempted(int vcpu);
 static inline void hv_apic_init(void) {}
 #endif
 
+#if IS_ENABLED(CONFIG_HYPERV_IOMMU)
+static inline bool hv_pcidev_is_attached_dev(struct pci_dev *pdev)
+{ return false; }       /* temporary */
+u64 hv_build_devid_oftype(struct pci_dev *pdev, enum hv_device_type type);
+#else	/* CONFIG_HYPERV_IOMMU */
+static inline bool hv_pcidev_is_attached_dev(struct pci_dev *pdev)
+{ return false; }
+
+static inline u64 hv_build_devid_oftype(struct pci_dev *pdev,
+				       enum hv_device_type type)
+{ return 0; }
+
+#endif	/* CONFIG_HYPERV_IOMMU */
+
 u64 hv_pci_vmbus_device_id(struct pci_dev *pdev);
 
 struct irq_domain *hv_create_pci_msi_domain(void);
-- 
2.51.2.vfs.0.1


