Return-Path: <linux-arch+bounces-13305-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE2CB3908C
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 03:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1041632D1
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 01:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A9B1DED49;
	Thu, 28 Aug 2025 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SUGJnMem"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A39153BE8;
	Thu, 28 Aug 2025 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343163; cv=none; b=E51ttRR60pgHzjbBQLkIUeqGbbsNKuwcP3Gble+5VA3pOr2zQ1i0nnDrExE+EzuTeqVgd2yEmgCS7ZpKGWvk2wlV6+BPeRQeIl8gxX/PHelmJ3nMndISWcQriODMgg4w9SE4Yc1sCQffchBOTpJyg/XeT18KxoHpzfnw9KXIUWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343163; c=relaxed/simple;
	bh=gX0ryYRPHtElZ1hllAXKlj3yrn+fIX8UyZqIcK3jzeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hntkgVrKVnmt1G1H4ksR8IfLPKfaoE2TuEP2wF5fk3rFJA3n6JmAS69oYYQb6KTbagtfJqmsR5MtqQ4BmrZPdJ/OqgYgJz79tIGONC+NmxxfZOEGxtPPof0H04FBHeJKEsxGlxLMBO0wbvuVarfY6FzjUHoi9UAgglFPfckgEkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SUGJnMem; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.174.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6F6462110803;
	Wed, 27 Aug 2025 18:06:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F6462110803
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756343160;
	bh=L6UzI1NEI3CsxJslYWLm1pMyIYiQMLPOOt/vIq7wad0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUGJnMemMWGrvS6SeVWMwRZBJ8UcOKuABgfC+JR373F8jwMF5B91/tLb8COJKMH2C
	 7e3ie/n5XEEDAX6rWgZIuut0EenBfJxpfNZpjiTU5oHNbVU/yaykgyNDQn8JvymVR+
	 80EMcsCoEbZy5Bp3d1jDmPOii3fw4c6ajWRHNyqI=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mikelley@microsoft.com,
	mingo@redhat.com,
	tglx@linutronix.de,
	Tianyu.Lan@microsoft.com,
	wei.liu@kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com,
	romank@linux.microsoft.com
Subject: [PATCH hyperv-next v5 02/16] drivers: hv: VMBus protocol version 6.0
Date: Wed, 27 Aug 2025 18:05:43 -0700
Message-ID: <20250828010557.123869-3-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828010557.123869-1-romank@linux.microsoft.com>
References: <20250828010557.123869-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The confidential VMBus is supported starting from the protocol
version 6.0 onwards.

Update the relevant definitions, provide the x86-specific way to
detect availability of the Confidential VMBus and provide a
function that returns whether VMBus is confidential or not.
No functional changes.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 19 ++++++++++
 drivers/hv/hv_common.c         |  6 +++
 drivers/hv/hyperv_vmbus.h      |  2 +
 drivers/hv/vmbus_drv.c         | 12 ++++++
 include/asm-generic/mshyperv.h |  1 +
 include/hyperv/hvgdk_mini.h    |  1 +
 include/linux/hyperv.h         | 69 ++++++++++++++++++++++++----------
 7 files changed, 91 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 25773af116bc..95cd78004b11 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -90,6 +90,25 @@ void hv_set_non_nested_msr(unsigned int reg, u64 value)
 }
 EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
 
+/*
+ * Detect if the confidential VMBus is available.
+ */
+bool hv_confidential_vmbus_available(void)
+{
+	u32 eax;
+
+	eax = cpuid_eax(HYPERV_CPUID_VIRT_STACK_INTERFACE);
+	if (eax != HYPERV_VS_INTERFACE_EAX_SIGNATURE)
+		return false;
+
+	eax = cpuid_eax(HYPERV_CPUID_VIRT_STACK_PROPERTIES);
+
+	/*
+	 * The paravisor may set the bit in the hardware confidential VMs.
+	 */
+	return eax & HYPERV_VS_PROPERTIES_EAX_CONFIDENTIAL_VMBUS_AVAILABLE;
+}
+
 u64 hv_get_msr(unsigned int reg)
 {
 	if (hv_nested)
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 8836cf9fad40..fae63c54e531 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -716,6 +716,12 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
 }
 EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
 
+bool __weak hv_confidential_vmbus_available(void)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_confidential_vmbus_available);
+
 void hv_identify_partition_type(void)
 {
 	/* Assume guest role */
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index b61f01fc1960..6e4c3acc1169 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -334,6 +334,8 @@ extern const struct vmbus_channel_message_table_entry
 
 /* General vmbus interface */
 
+bool vmbus_is_confidential(void);
+
 struct hv_device *vmbus_device_create(const guid_t *type,
 				      const guid_t *instance,
 				      struct vmbus_channel *channel);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index a366365f2c49..8d9488c3174d 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -57,6 +57,18 @@ static long __percpu *vmbus_evt;
 int vmbus_irq;
 int vmbus_interrupt;
 
+/*
+ * If the Confidential VMBus is used, the data on the "wire" is not
+ * visible to either the host or the hypervisor.
+ */
+static bool is_confidential;
+
+bool vmbus_is_confidential(void)
+{
+	return is_confidential;
+}
+EXPORT_SYMBOL_GPL(vmbus_is_confidential);
+
 /*
  * The panic notifier below is responsible solely for unloading the
  * vmbus connection, which is necessary in a panic event.
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index dbd4c2f3aee3..acb017f6c423 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -332,6 +332,7 @@ bool hv_is_hibernation_supported(void);
 enum hv_isolation_type hv_get_isolation_type(void);
 bool hv_is_isolation_supported(void);
 bool hv_isolation_type_snp(void);
+bool hv_confidential_vmbus_available(void);
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
 void hyperv_cleanup(void);
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 79b7324e4ef5..4b189f9d39cb 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -260,6 +260,7 @@ union hv_hypervisor_version_info {
 #define HYPERV_CPUID_VIRT_STACK_PROPERTIES	 0x40000082
 /* Support for the extended IOAPIC RTE format */
 #define HYPERV_VS_PROPERTIES_EAX_EXTENDED_IOAPIC_RTE	 BIT(2)
+#define HYPERV_VS_PROPERTIES_EAX_CONFIDENTIAL_VMBUS_AVAILABLE	 BIT(3)
 
 #define HYPERV_HYPERVISOR_PRESENT_BIT		 0x80000000
 #define HYPERV_CPUID_MIN			 0x40000005
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index a59c5c3e95fb..a1820fabbfc0 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -265,16 +265,18 @@ static inline u32 hv_get_avail_to_write_percent(
  * Linux kernel.
  */
 
-#define VERSION_WS2008  ((0 << 16) | (13))
-#define VERSION_WIN7    ((1 << 16) | (1))
-#define VERSION_WIN8    ((2 << 16) | (4))
-#define VERSION_WIN8_1    ((3 << 16) | (0))
-#define VERSION_WIN10 ((4 << 16) | (0))
-#define VERSION_WIN10_V4_1 ((4 << 16) | (1))
-#define VERSION_WIN10_V5 ((5 << 16) | (0))
-#define VERSION_WIN10_V5_1 ((5 << 16) | (1))
-#define VERSION_WIN10_V5_2 ((5 << 16) | (2))
-#define VERSION_WIN10_V5_3 ((5 << 16) | (3))
+#define VMBUS_MAKE_VERSION(MAJ, MIN)	((((u32)MAJ) << 16) | (MIN))
+#define VERSION_WS2008					VMBUS_MAKE_VERSION(0, 13)
+#define VERSION_WIN7					VMBUS_MAKE_VERSION(1, 1)
+#define VERSION_WIN8					VMBUS_MAKE_VERSION(2, 4)
+#define VERSION_WIN8_1					VMBUS_MAKE_VERSION(3, 0)
+#define VERSION_WIN10					VMBUS_MAKE_VERSION(4, 0)
+#define VERSION_WIN10_V4_1				VMBUS_MAKE_VERSION(4, 1)
+#define VERSION_WIN10_V5				VMBUS_MAKE_VERSION(5, 0)
+#define VERSION_WIN10_V5_1				VMBUS_MAKE_VERSION(5, 1)
+#define VERSION_WIN10_V5_2				VMBUS_MAKE_VERSION(5, 2)
+#define VERSION_WIN10_V5_3				VMBUS_MAKE_VERSION(5, 3)
+#define VERSION_WIN10_V6_0				VMBUS_MAKE_VERSION(6, 0)
 
 /* Make maximum size of pipe payload of 16K */
 #define MAX_PIPE_DATA_PAYLOAD		(sizeof(u8) * 16384)
@@ -335,14 +337,22 @@ struct vmbus_channel_offer {
 } __packed;
 
 /* Server Flags */
-#define VMBUS_CHANNEL_ENUMERATE_DEVICE_INTERFACE	1
-#define VMBUS_CHANNEL_SERVER_SUPPORTS_TRANSFER_PAGES	2
-#define VMBUS_CHANNEL_SERVER_SUPPORTS_GPADLS		4
-#define VMBUS_CHANNEL_NAMED_PIPE_MODE			0x10
-#define VMBUS_CHANNEL_LOOPBACK_OFFER			0x100
-#define VMBUS_CHANNEL_PARENT_OFFER			0x200
-#define VMBUS_CHANNEL_REQUEST_MONITORED_NOTIFICATION	0x400
-#define VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER		0x2000
+#define VMBUS_CHANNEL_ENUMERATE_DEVICE_INTERFACE		0x0001
+/*
+ * This flag indicates that the channel is offered by the paravisor, and must
+ * use encrypted memory for the channel ring buffer.
+ */
+#define VMBUS_CHANNEL_CONFIDENTIAL_RING_BUFFER			0x0002
+/*
+ * This flag indicates that the channel is offered by the paravisor, and must
+ * use encrypted memory for GPA direct packets and additional GPADLs.
+ */
+#define VMBUS_CHANNEL_CONFIDENTIAL_EXTERNAL_MEMORY		0x0004
+#define VMBUS_CHANNEL_NAMED_PIPE_MODE					0x0010
+#define VMBUS_CHANNEL_LOOPBACK_OFFER					0x0100
+#define VMBUS_CHANNEL_PARENT_OFFER						0x0200
+#define VMBUS_CHANNEL_REQUEST_MONITORED_NOTIFICATION	0x0400
+#define VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER				0x2000
 
 struct vmpacket_descriptor {
 	u16 type;
@@ -621,6 +631,12 @@ struct vmbus_channel_relid_released {
 	u32 child_relid;
 } __packed;
 
+/*
+ * Used by the paravisor only, means that the encrypted ring buffers and
+ * the encrypted external memory are supported
+ */
+#define VMBUS_FEATURE_FLAG_CONFIDENTIAL_CHANNELS	0x10
+
 struct vmbus_channel_initiate_contact {
 	struct vmbus_channel_message_header header;
 	u32 vmbus_version_requested;
@@ -630,7 +646,8 @@ struct vmbus_channel_initiate_contact {
 		struct {
 			u8	msg_sint;
 			u8	msg_vtl;
-			u8	reserved[6];
+			u8	reserved[2];
+			u32 feature_flags; /* VMBus version 6.0 */
 		};
 	};
 	u64 monitor_page1;
@@ -1008,6 +1025,10 @@ struct vmbus_channel {
 
 	/* boolean to control visibility of sysfs for ring buffer */
 	bool ring_sysfs_visible;
+	/* The ring buffer is encrypted */
+	bool co_ring_buffer;
+	/* The external memory is encrypted */
+	bool co_external_memory;
 };
 
 #define lock_requestor(channel, flags)					\
@@ -1032,6 +1053,16 @@ u64 vmbus_request_addr_match(struct vmbus_channel *channel, u64 trans_id,
 			     u64 rqst_addr);
 u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id);
 
+static inline bool is_co_ring_buffer(const struct vmbus_channel_offer_channel *o)
+{
+	return !!(o->offer.chn_flags & VMBUS_CHANNEL_CONFIDENTIAL_RING_BUFFER);
+}
+
+static inline bool is_co_external_memory(const struct vmbus_channel_offer_channel *o)
+{
+	return !!(o->offer.chn_flags & VMBUS_CHANNEL_CONFIDENTIAL_EXTERNAL_MEMORY);
+}
+
 static inline bool is_hvsock_offer(const struct vmbus_channel_offer_channel *o)
 {
 	return !!(o->offer.chn_flags & VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER);
-- 
2.43.0


