Return-Path: <linux-arch+bounces-15881-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC33D3BFA2
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 07:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC2793C1451
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 06:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F5637F0E8;
	Tue, 20 Jan 2026 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DcfTkOJm"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967AF38E106;
	Tue, 20 Jan 2026 06:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891429; cv=none; b=tSKY3dywheF2saq4diFQyQ+Hp/QfcQepRdSjPwcdi2uLfk6XzZg7pOVORrusg3PYprgOLK2WzfkbNuGittJidIxyamPS1x+wVmjH3/fUQ8LGijYBr4K1+dLKw39UYdk+E/UHEdMZmKUodjO0WGenyJC92KWVPEa6q+hhfVjUoXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891429; c=relaxed/simple;
	bh=knI+V1SdVCmbYJssyVxji1WC3LUici+xNGhkcA/Jztk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ss4zzfe7N6ehCGSVAYoqIabMbrCfZ7Sa5wJGeT9HuBjyNXSz38Tjag0wD9atlHXuamjr7IG5HOyhI/1S9DDhwsXdQYE1kUcFbHjqLQC/qiFPBEPMGHz717dwEpNNu1JW2q6r4CZU8QAv3rQMAkj8lft08JwqRMUgqlp1Jwj7fhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DcfTkOJm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 30F3B20B7171;
	Mon, 19 Jan 2026 22:43:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 30F3B20B7171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768891416;
	bh=6AAp/ykXusoNZA7ncLQ0JBdGDrm8nyxPjzKKo/+ZvTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DcfTkOJm/guybBs88Dp9gw9NXcNzXsgtq0GsljuOOVQkF4lfCPXMBvaMaPidC8my4
	 vMf5jkI5R+a9XO5H2lX/akgtSVOeWt/LXHvpu0DzQ8ZZxivzKQTJnVNBZ6PO57GXoD
	 WPLau1cY0IauA77XhHi9bXHMaY7BdpIvknVlOvfo=
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
Subject: [PATCH v0 08/15] PCI: hv: rename hv_compose_msi_msg to hv_vmbus_compose_msi_msg
Date: Mon, 19 Jan 2026 22:42:23 -0800
Message-ID: <20260120064230.3602565-9-mrathor@linux.microsoft.com>
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

Main change here is to rename hv_compose_msi_msg to
hv_vmbus_compose_msi_msg as we introduce hv_compose_msi_msg in upcoming
patches that builds MSI messages for both VMBus and non-VMBus cases. VMBus
is not used on baremetal root partition for example. While at it, replace
spaces with tabs and fix some formatting involving excessive line wraps.

There is no functional change.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 95 +++++++++++++++--------------
 1 file changed, 48 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 1e237d3538f9..8bc6a38c9b5a 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -30,7 +30,7 @@
  * function's configuration space is zero.
  *
  * The rest of this driver mostly maps PCI concepts onto underlying Hyper-V
- * facilities.  For instance, the configuration space of a function exposed
+ * facilities.	For instance, the configuration space of a function exposed
  * by Hyper-V is mapped into a single page of memory space, and the
  * read and write handlers for config space must be aware of this mechanism.
  * Similarly, device setup and teardown involves messages sent to and from
@@ -109,33 +109,33 @@ enum pci_message_type {
 	/*
 	 * Version 1.1
 	 */
-	PCI_MESSAGE_BASE                = 0x42490000,
-	PCI_BUS_RELATIONS               = PCI_MESSAGE_BASE + 0,
-	PCI_QUERY_BUS_RELATIONS         = PCI_MESSAGE_BASE + 1,
-	PCI_POWER_STATE_CHANGE          = PCI_MESSAGE_BASE + 4,
+	PCI_MESSAGE_BASE		= 0x42490000,
+	PCI_BUS_RELATIONS		= PCI_MESSAGE_BASE + 0,
+	PCI_QUERY_BUS_RELATIONS		= PCI_MESSAGE_BASE + 1,
+	PCI_POWER_STATE_CHANGE		= PCI_MESSAGE_BASE + 4,
 	PCI_QUERY_RESOURCE_REQUIREMENTS = PCI_MESSAGE_BASE + 5,
-	PCI_QUERY_RESOURCE_RESOURCES    = PCI_MESSAGE_BASE + 6,
-	PCI_BUS_D0ENTRY                 = PCI_MESSAGE_BASE + 7,
-	PCI_BUS_D0EXIT                  = PCI_MESSAGE_BASE + 8,
-	PCI_READ_BLOCK                  = PCI_MESSAGE_BASE + 9,
-	PCI_WRITE_BLOCK                 = PCI_MESSAGE_BASE + 0xA,
-	PCI_EJECT                       = PCI_MESSAGE_BASE + 0xB,
-	PCI_QUERY_STOP                  = PCI_MESSAGE_BASE + 0xC,
-	PCI_REENABLE                    = PCI_MESSAGE_BASE + 0xD,
-	PCI_QUERY_STOP_FAILED           = PCI_MESSAGE_BASE + 0xE,
-	PCI_EJECTION_COMPLETE           = PCI_MESSAGE_BASE + 0xF,
-	PCI_RESOURCES_ASSIGNED          = PCI_MESSAGE_BASE + 0x10,
-	PCI_RESOURCES_RELEASED          = PCI_MESSAGE_BASE + 0x11,
-	PCI_INVALIDATE_BLOCK            = PCI_MESSAGE_BASE + 0x12,
-	PCI_QUERY_PROTOCOL_VERSION      = PCI_MESSAGE_BASE + 0x13,
-	PCI_CREATE_INTERRUPT_MESSAGE    = PCI_MESSAGE_BASE + 0x14,
-	PCI_DELETE_INTERRUPT_MESSAGE    = PCI_MESSAGE_BASE + 0x15,
+	PCI_QUERY_RESOURCE_RESOURCES	= PCI_MESSAGE_BASE + 6,
+	PCI_BUS_D0ENTRY			= PCI_MESSAGE_BASE + 7,
+	PCI_BUS_D0EXIT			= PCI_MESSAGE_BASE + 8,
+	PCI_READ_BLOCK			= PCI_MESSAGE_BASE + 9,
+	PCI_WRITE_BLOCK			= PCI_MESSAGE_BASE + 0xA,
+	PCI_EJECT			= PCI_MESSAGE_BASE + 0xB,
+	PCI_QUERY_STOP			= PCI_MESSAGE_BASE + 0xC,
+	PCI_REENABLE			= PCI_MESSAGE_BASE + 0xD,
+	PCI_QUERY_STOP_FAILED		= PCI_MESSAGE_BASE + 0xE,
+	PCI_EJECTION_COMPLETE		= PCI_MESSAGE_BASE + 0xF,
+	PCI_RESOURCES_ASSIGNED		= PCI_MESSAGE_BASE + 0x10,
+	PCI_RESOURCES_RELEASED		= PCI_MESSAGE_BASE + 0x11,
+	PCI_INVALIDATE_BLOCK		= PCI_MESSAGE_BASE + 0x12,
+	PCI_QUERY_PROTOCOL_VERSION	= PCI_MESSAGE_BASE + 0x13,
+	PCI_CREATE_INTERRUPT_MESSAGE	= PCI_MESSAGE_BASE + 0x14,
+	PCI_DELETE_INTERRUPT_MESSAGE	= PCI_MESSAGE_BASE + 0x15,
 	PCI_RESOURCES_ASSIGNED2		= PCI_MESSAGE_BASE + 0x16,
 	PCI_CREATE_INTERRUPT_MESSAGE2	= PCI_MESSAGE_BASE + 0x17,
 	PCI_DELETE_INTERRUPT_MESSAGE2	= PCI_MESSAGE_BASE + 0x18, /* unused */
 	PCI_BUS_RELATIONS2		= PCI_MESSAGE_BASE + 0x19,
-	PCI_RESOURCES_ASSIGNED3         = PCI_MESSAGE_BASE + 0x1A,
-	PCI_CREATE_INTERRUPT_MESSAGE3   = PCI_MESSAGE_BASE + 0x1B,
+	PCI_RESOURCES_ASSIGNED3		= PCI_MESSAGE_BASE + 0x1A,
+	PCI_CREATE_INTERRUPT_MESSAGE3	= PCI_MESSAGE_BASE + 0x1B,
 	PCI_MESSAGE_MAXIMUM
 };
 
@@ -1775,20 +1775,21 @@ static u32 hv_compose_msi_req_v1(
  * via the HVCALL_RETARGET_INTERRUPT hypercall. But the choice of dummy vCPU is
  * not irrelevant because Hyper-V chooses the physical CPU to handle the
  * interrupts based on the vCPU specified in message sent to the vPCI VSP in
- * hv_compose_msi_msg(). Hyper-V's choice of pCPU is not visible to the guest,
- * but assigning too many vPCI device interrupts to the same pCPU can cause a
- * performance bottleneck. So we spread out the dummy vCPUs to influence Hyper-V
- * to spread out the pCPUs that it selects.
+ * hv_vmbus_compose_msi_msg(). Hyper-V's choice of pCPU is not visible to the
+ * guest, but assigning too many vPCI device interrupts to the same pCPU can
+ * cause a performance bottleneck. So we spread out the dummy vCPUs to influence
+ * Hyper-V to spread out the pCPUs that it selects.
  *
  * For the single-MSI and MSI-X cases, it's OK for hv_compose_msi_req_get_cpu()
  * to always return the same dummy vCPU, because a second call to
- * hv_compose_msi_msg() contains the "real" vCPU, causing Hyper-V to choose a
- * new pCPU for the interrupt. But for the multi-MSI case, the second call to
- * hv_compose_msi_msg() exits without sending a message to the vPCI VSP, so the
- * original dummy vCPU is used. This dummy vCPU must be round-robin'ed so that
- * the pCPUs are spread out. All interrupts for a multi-MSI device end up using
- * the same pCPU, even though the vCPUs will be spread out by later calls
- * to hv_irq_unmask(), but that is the best we can do now.
+ * hv_vmbus_compose_msi_msg() contains the "real" vCPU, causing Hyper-V to
+ * choose a new pCPU for the interrupt. But for the multi-MSI case, the second
+ * call to hv_vmbus_compose_msi_msg() exits without sending a message to the
+ * vPCI VSP, so the original dummy vCPU is used. This dummy vCPU must be
+ * round-robin'ed so that the pCPUs are spread out. All interrupts for a
+ * multi-MSI device end up using the same pCPU, even though the vCPUs will be
+ * spread out by later calls to hv_irq_unmask(), but that is the best we can do
+ * now.
  *
  * With Hyper-V in Nov 2022, the HVCALL_RETARGET_INTERRUPT hypercall does *not*
  * cause Hyper-V to reselect the pCPU based on the specified vCPU. Such an
@@ -1863,7 +1864,7 @@ static u32 hv_compose_msi_req_v3(
 }
 
 /**
- * hv_compose_msi_msg() - Supplies a valid MSI address/data
+ * hv_vmbus_compose_msi_msg() - Supplies a valid MSI address/data
  * @data:	Everything about this MSI
  * @msg:	Buffer that is filled in by this function
  *
@@ -1873,7 +1874,7 @@ static u32 hv_compose_msi_req_v3(
  * response supplies a data value and address to which that data
  * should be written to trigger that interrupt.
  */
-static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+static void hv_vmbus_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct hv_pcibus_device *hbus;
 	struct vmbus_channel *channel;
@@ -1955,7 +1956,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 			return;
 		}
 		/*
-		 * The vector we select here is a dummy value.  The correct
+		 * The vector we select here is a dummy value.	The correct
 		 * value gets sent to the hypervisor in unmask().  This needs
 		 * to be aligned with the count, and also not zero.  Multi-msi
 		 * is powers of 2 up to 32, so 32 will always work here.
@@ -2047,7 +2048,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 
 		/*
 		 * Make sure that the ring buffer data structure doesn't get
-		 * freed while we dereference the ring buffer pointer.  Test
+		 * freed while we dereference the ring buffer pointer.	Test
 		 * for the channel's onchannel_callback being NULL within a
 		 * sched_lock critical section.  See also the inline comments
 		 * in vmbus_reset_channel_cb().
@@ -2147,7 +2148,7 @@ static const struct msi_parent_ops hv_pcie_msi_parent_ops = {
 /* HW Interrupt Chip Descriptor */
 static struct irq_chip hv_msi_irq_chip = {
 	.name			= "Hyper-V PCIe MSI",
-	.irq_compose_msi_msg	= hv_compose_msi_msg,
+	.irq_compose_msi_msg	= hv_vmbus_compose_msi_msg,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_eoi		= irq_chip_eoi_parent,
@@ -2159,8 +2160,8 @@ static int hv_pcie_domain_alloc(struct irq_domain *d, unsigned int virq, unsigne
 			       void *arg)
 {
 	/*
-	 * TODO: Allocating and populating struct tran_int_desc in hv_compose_msi_msg()
-	 * should be moved here.
+	 * TODO: Allocating and populating struct tran_int_desc in
+	 *	 hv_vmbus_compose_msi_msg() should be moved here.
 	 */
 	int ret;
 
@@ -2227,7 +2228,7 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
 /**
  * get_bar_size() - Get the address space consumed by a BAR
  * @bar_val:	Value that a BAR returned after -1 was written
- *              to it.
+ *		to it.
  *
  * This function returns the size of the BAR, rounded up to 1
  * page.  It has to be rounded up because the hypervisor's page
@@ -2573,7 +2574,7 @@ static void q_resource_requirements(void *context, struct pci_response *resp,
  * new_pcichild_device() - Create a new child device
  * @hbus:	The internal struct tracking this root PCI bus.
  * @desc:	The information supplied so far from the host
- *              about the device.
+ *		about the device.
  *
  * This function creates the tracking structure for a new child
  * device and kicks off the process of figuring out what it is.
@@ -3100,7 +3101,7 @@ static void hv_pci_onchannelcallback(void *context)
 			 * sure that the packet pointer is still valid during the call:
 			 * here 'valid' means that there's a task still waiting for the
 			 * completion, and that the packet data is still on the waiting
-			 * task's stack.  Cf. hv_compose_msi_msg().
+			 * task's stack.  Cf. hv_vmbus_compose_msi_msg().
 			 */
 			comp_packet->completion_func(comp_packet->compl_ctxt,
 						     response,
@@ -3417,7 +3418,7 @@ static int hv_allocate_config_window(struct hv_pcibus_device *hbus)
 	 * vmbus_allocate_mmio() gets used for allocating both device endpoint
 	 * resource claims (those which cannot be overlapped) and the ranges
 	 * which are valid for the children of this bus, which are intended
-	 * to be overlapped by those children.  Set the flag on this claim
+	 * to be overlapped by those children.	Set the flag on this claim
 	 * meaning that this region can't be overlapped.
 	 */
 
@@ -4066,7 +4067,7 @@ static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
 		irq_data = irq_get_irq_data(entry->irq);
 		if (WARN_ON_ONCE(!irq_data))
 			return -EINVAL;
-		hv_compose_msi_msg(irq_data, &entry->msg);
+		hv_vmbus_compose_msi_msg(irq_data, &entry->msg);
 	}
 	return 0;
 }
@@ -4074,7 +4075,7 @@ static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
 /*
  * Upon resume, pci_restore_msi_state() -> ... ->  __pci_write_msi_msg()
  * directly writes the MSI/MSI-X registers via MMIO, but since Hyper-V
- * doesn't trap and emulate the MMIO accesses, here hv_compose_msi_msg()
+ * doesn't trap and emulate the MMIO accesses, here hv_vmbus_compose_msi_msg()
  * must be used to ask Hyper-V to re-create the IOMMU Interrupt Remapping
  * Table entries.
  */
-- 
2.51.2.vfs.0.1


