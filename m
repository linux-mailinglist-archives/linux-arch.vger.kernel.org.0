Return-Path: <linux-arch+bounces-11346-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 089C2A819B9
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 02:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BF43B69B5
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 00:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5101E78F47;
	Wed,  9 Apr 2025 00:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Jk0DGU+Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB37F442C;
	Wed,  9 Apr 2025 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157329; cv=none; b=ktDyG9hFEXEqYSrEYHUt7eb3uCNgBSpBAse2VTTnpN/X0CDoaiELB6pw2CA/Dpv2LEocIupZ/rfcAwE66FW8rP1gwHH7prp4XSSQ3YW6ORFp6LoiU9cwwN7SDrfXz4GOeyazLc5mck5IYExteq6eL7gj5B5hOEnA11IZebbcN88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157329; c=relaxed/simple;
	bh=xzLj8YcSBp8O2F9qRqRSdYZ6gJI2ZLBOcWWkcR5AaK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIveDhmM/pnk3h4wLo6Ovd/tIgrRQUJtMcNiXkC29tqVLIR0MAHsOmeN2p/Yv28a3PBmJEWlwUsl7+IJZqXmQSYe75QDqs/h8UxIi8HrHvIp44svUeKaW60EiE1Nhm8Vk/Xd5tqucd66hn8ABejHDss2x+0Jc5OaCrwJhhJdpBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Jk0DGU+Y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4558C2113E9B;
	Tue,  8 Apr 2025 17:08:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4558C2113E9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744157319;
	bh=SeCqEFvlsBa7m/fkvLQtZnQUkJkJQ0LNguchchgHmoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jk0DGU+Y5IpMinnAiu1PIOGDhsjn7nHVboBQWxZXVvxHanJwUV59z5ZVwJA2Qx4Uy
	 xMTK6Cco4InWUJiW79do4k5nyULtY6UMVqkFD1S47muDorHl1Q3Tt/zRhvBaXiyojb
	 HeQPDTU7l8P++Hpvs6U8ru9ToBGCepxUufiIGoP4=
From: Roman Kisel <romank@linux.microsoft.com>
To: aleksander.lobakin@intel.com,
	andriy.shevchenko@linux.intel.com,
	arnd@arndb.de,
	bp@alien8.de,
	catalin.marinas@arm.com,
	corbet@lwn.net,
	dakr@kernel.org,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	haiyangz@microsoft.com,
	hch@lst.de,
	hpa@zytor.com,
	James.Bottomley@HansenPartnership.com,
	Jonathan.Cameron@huawei.com,
	kys@microsoft.com,
	leon@kernel.org,
	lukas@wunner.de,
	luto@kernel.org,
	m.szyprowski@samsung.com,
	martin.petersen@oracle.com,
	mingo@redhat.com,
	peterz@infradead.org,
	quic_zijuhu@quicinc.com,
	robin.murphy@arm.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next 4/6] arch: x86, drivers: hyperv: Enable confidential VMBus
Date: Tue,  8 Apr 2025 17:08:33 -0700
Message-ID: <20250409000835.285105-5-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409000835.285105-1-romank@linux.microsoft.com>
References: <20250409000835.285105-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Confidential VMBus employs the paravisor SynIC pages to implement
the control plane of the protocol, and the data plane may use
encrypted pages.

Implement scanning the additional pages in the control plane,
and update the logic not to decrypt ring buffer and GPADLs (GPA
descr. lists) unconditionally.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c |  23 +-
 drivers/hv/channel.c           |  36 +--
 drivers/hv/channel_mgmt.c      |  29 +-
 drivers/hv/connection.c        |  10 +-
 drivers/hv/hv.c                | 485 ++++++++++++++++++++++++---------
 drivers/hv/hyperv_vmbus.h      |   9 +-
 drivers/hv/ring_buffer.c       |   5 +-
 drivers/hv/vmbus_drv.c         | 140 +++++-----
 8 files changed, 518 insertions(+), 219 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 4f6e3d02f730..4163bc24269e 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -28,6 +28,7 @@
 #include <asm/apic.h>
 #include <asm/timer.h>
 #include <asm/reboot.h>
+#include <asm/msr.h>
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
@@ -77,14 +78,28 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_msr);
 
 void hv_set_non_nested_msr(unsigned int reg, u64 value)
 {
+	if (reg == HV_X64_MSR_EOM && vmbus_is_confidential()) {
+		/* Reach out to the paravisor. */
+		native_wrmsrl(reg, value);
+		return;
+	}
+
 	if (hv_is_synic_msr(reg) && ms_hyperv.paravisor_present) {
+		/* The hypervisor will get the intercept. */
 		hv_ivm_msr_write(reg, value);
 
-		/* Write proxy bit via wrmsl instruction */
-		if (hv_is_sint_msr(reg))
-			wrmsrl(reg, value | 1 << 20);
+		if (hv_is_sint_msr(reg)) {
+			/*
+			 * Write proxy bit in the case of non-confidential VMBus control plane.
+			 * Using wrmsl instruction so the following goes to the paravisor.
+			 */
+			u32 proxy = 1 & !vmbus_is_confidential();
+
+			value |= (proxy << 20);
+			native_wrmsrl(reg, value);
+		}
 	} else {
-		wrmsrl(reg, value);
+		native_wrmsrl(reg, value);
 	}
 }
 EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index fb8cd8469328..ef540b72f6ea 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -443,20 +443,23 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 		return ret;
 	}
 
-	/*
-	 * Set the "decrypted" flag to true for the set_memory_decrypted()
-	 * success case. In the failure case, the encryption state of the
-	 * memory is unknown. Leave "decrypted" as true to ensure the
-	 * memory will be leaked instead of going back on the free list.
-	 */
-	gpadl->decrypted = true;
-	ret = set_memory_decrypted((unsigned long)kbuffer,
-				   PFN_UP(size));
-	if (ret) {
-		dev_warn(&channel->device_obj->device,
-			 "Failed to set host visibility for new GPADL %d.\n",
-			 ret);
-		return ret;
+	if ((!channel->confidential_external_memory && type == HV_GPADL_BUFFER) ||
+		(!channel->confidential_ring_buffer && type == HV_GPADL_RING)) {
+		/*
+		 * Set the "decrypted" flag to true for the set_memory_decrypted()
+		 * success case. In the failure case, the encryption state of the
+		 * memory is unknown. Leave "decrypted" as true to ensure the
+		 * memory will be leaked instead of going back on the free list.
+		 */
+		gpadl->decrypted = true;
+		ret = set_memory_decrypted((unsigned long)kbuffer,
+					PFN_UP(size));
+		if (ret) {
+			dev_warn(&channel->device_obj->device,
+				"Failed to set host visibility for new GPADL %d.\n",
+				ret);
+			return ret;
+		}
 	}
 
 	init_completion(&msginfo->waitevent);
@@ -676,12 +679,13 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 		goto error_clean_ring;
 
 	err = hv_ringbuffer_init(&newchannel->outbound,
-				 page, send_pages, 0);
+				 page, send_pages, 0, newchannel->confidential_ring_buffer);
 	if (err)
 		goto error_free_gpadl;
 
 	err = hv_ringbuffer_init(&newchannel->inbound, &page[send_pages],
-				 recv_pages, newchannel->max_pkt_size);
+				 recv_pages, newchannel->max_pkt_size,
+				 newchannel->confidential_ring_buffer);
 	if (err)
 		goto error_free_gpadl;
 
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 6e084c207414..39c8b80d967f 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -843,14 +843,14 @@ static void vmbus_wait_for_unload(void)
 				= per_cpu_ptr(hv_context.cpu_context, cpu);
 
 			/*
-			 * In a CoCo VM the synic_message_page is not allocated
+			 * In a CoCo VM the hv_synic_message_page is not allocated
 			 * in hv_synic_alloc(). Instead it is set/cleared in
 			 * hv_synic_enable_regs() and hv_synic_disable_regs()
 			 * such that it is set only when the CPU is online. If
 			 * not all present CPUs are online, the message page
 			 * might be NULL, so skip such CPUs.
 			 */
-			page_addr = hv_cpu->synic_message_page;
+			page_addr = hv_cpu->hv_synic_message_page;
 			if (!page_addr)
 				continue;
 
@@ -891,7 +891,7 @@ static void vmbus_wait_for_unload(void)
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
-		page_addr = hv_cpu->synic_message_page;
+		page_addr = hv_cpu->hv_synic_message_page;
 		if (!page_addr)
 			continue;
 
@@ -1021,6 +1021,7 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 	struct vmbus_channel_offer_channel *offer;
 	struct vmbus_channel *oldchannel, *newchannel;
 	size_t offer_sz;
+	bool confidential_ring_buffer, confidential_external_memory;
 
 	offer = (struct vmbus_channel_offer_channel *)hdr;
 
@@ -1033,6 +1034,18 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 		return;
 	}
 
+	confidential_ring_buffer = is_confidential_ring_buffer(offer);
+	if (confidential_ring_buffer) {
+		if (vmbus_proto_version < VERSION_WIN_COPPER || !vmbus_is_confidential())
+			return;
+	}
+
+	confidential_external_memory = is_confidential_external_memory(offer);
+	if (is_confidential_external_memory(offer)) {
+		if (vmbus_proto_version < VERSION_WIN_COPPER || !vmbus_is_confidential())
+			return;
+	}
+
 	oldchannel = find_primary_channel_by_offer(offer);
 
 	if (oldchannel != NULL) {
@@ -1069,6 +1082,14 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 
 		atomic_dec(&vmbus_connection.offer_in_progress);
 
+		if ((oldchannel->confidential_ring_buffer && !confidential_ring_buffer) ||
+				(oldchannel->confidential_external_memory &&
+				!confidential_external_memory)) {
+			pr_err_ratelimited("Offer %d changes the confidential state\n",
+				offer->child_relid);
+			return;
+		}
+
 		WARN_ON(oldchannel->offermsg.child_relid != INVALID_RELID);
 		/* Fix up the relid. */
 		oldchannel->offermsg.child_relid = offer->child_relid;
@@ -1111,6 +1132,8 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 		pr_err("Unable to allocate channel object\n");
 		return;
 	}
+	newchannel->confidential_ring_buffer = confidential_ring_buffer;
+	newchannel->confidential_external_memory = confidential_external_memory;
 
 	vmbus_setup_channel_state(newchannel, offer);
 
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 8351360bba16..268b7d58b45b 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -51,7 +51,8 @@ EXPORT_SYMBOL_GPL(vmbus_proto_version);
  * Linux guests and are not listed.
  */
 static __u32 vmbus_versions[] = {
-	VERSION_WIN10_V5_3,
+	VERSION_WIN_COPPER,
+	VERSION_WIN_IRON,
 	VERSION_WIN10_V5_2,
 	VERSION_WIN10_V5_1,
 	VERSION_WIN10_V5,
@@ -65,7 +66,7 @@ static __u32 vmbus_versions[] = {
  * Maximal VMBus protocol version guests can negotiate.  Useful to cap the
  * VMBus version for testing and debugging purpose.
  */
-static uint max_version = VERSION_WIN10_V5_3;
+static uint max_version = VERSION_WIN_COPPER;
 
 module_param(max_version, uint, S_IRUGO);
 MODULE_PARM_DESC(max_version,
@@ -105,6 +106,11 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID;
 	}
 
+	if (vmbus_is_confidential() && version >= VERSION_WIN_COPPER)
+		msg->feature_flags = VMBUS_FEATURE_FLAG_CONFIDENTIAL_CHANNELS;
+	else
+		msg->feature_flags = 0;
+
 	/*
 	 * shared_gpa_boundary is zero in non-SNP VMs, so it's safe to always
 	 * bitwise OR it
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 308c8f279df8..2f84e94635e3 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -74,7 +74,7 @@ int hv_post_message(union hv_connection_id connection_id,
 	aligned_msg->payload_size = payload_size;
 	memcpy((void *)aligned_msg->payload, payload, payload_size);
 
-	if (ms_hyperv.paravisor_present) {
+	if (ms_hyperv.paravisor_present && !vmbus_is_confidential()) {
 		if (hv_isolation_type_tdx())
 			status = hv_tdx_hypercall(HVCALL_POST_MESSAGE,
 						  virt_to_phys(aligned_msg), 0);
@@ -94,11 +94,135 @@ int hv_post_message(union hv_connection_id connection_id,
 	return hv_result(status);
 }
 
+enum hv_page_encryption_action {
+	HV_PAGE_ENC_DEAFULT,
+	HV_PAGE_ENC_ENCRYPT,
+	HV_PAGE_ENC_DECRYPT
+};
+
+static int hv_alloc_page(unsigned int cpu, void **page, enum hv_page_encryption_action enc_action,
+	const char *note)
+{
+	int ret = 0;
+
+	pr_debug("allocating %s\n", note);
+
+	/*
+	 * After the page changes its encryption status, its contents will
+	 * appear scrambled. Thus `get_zeroed_page` would zero the page out
+	 * in vain, we do that ourselves exactly one time.
+	 *
+	 * The function might be called from contexts where sleeping is very
+	 * bad (like hotplug callbacks) or not possible (interrupt handling),
+	 * Thus requesting `GFP_ATOMIC`.
+	 *
+	 * The page order is 0 as we need 1 page and log_2 (1) = 0.
+	 */
+	*page = (void *)__get_free_pages(GFP_ATOMIC, 0);
+	if (!*page)
+		return -ENOMEM;
+
+	pr_debug("allocated %s\n", note);
+
+	switch (enc_action) {
+	case HV_PAGE_ENC_ENCRYPT:
+		ret = set_memory_encrypted((unsigned long)*page, 1);
+		break;
+	case HV_PAGE_ENC_DECRYPT:
+		ret = set_memory_decrypted((unsigned long)*page, 1);
+		break;
+	case HV_PAGE_ENC_DEAFULT:
+		break;
+	default:
+		pr_warn("unknown page encryption action %d for %s\n", enc_action, note);
+		break;
+	}
+
+	if (ret)
+		goto failed;
+
+	memset(*page, 0, PAGE_SIZE);
+	return 0;
+
+failed:
+
+	pr_err("page encryption action %d failed for %s, error %d when allocating the page\n",
+		enc_action, note, ret);
+	free_page((unsigned long)*page);
+	*page = NULL;
+	return ret;
+}
+
+static int hv_free_page(void **page, enum hv_page_encryption_action enc_action,
+	const char *note)
+{
+	int ret = 0;
+
+	pr_debug("freeing %s\n", note);
+
+	if (!page)
+		return 0;
+	if (!*page)
+		return 0;
+
+	switch (enc_action) {
+	case HV_PAGE_ENC_ENCRYPT:
+		ret = set_memory_encrypted((unsigned long)*page, 1);
+		break;
+	case HV_PAGE_ENC_DECRYPT:
+		ret = set_memory_decrypted((unsigned long)*page, 1);
+		break;
+	case HV_PAGE_ENC_DEAFULT:
+		break;
+	default:
+		pr_warn("unknown page encryption action %d for %s page\n",
+			enc_action, note);
+		break;
+	}
+
+	/*
+	 * In the case of the action failure, the page is leaked.
+	 * Something is wrong, prefer to lose the page and stay afloat.
+	 */
+	if (ret) {
+		pr_err("page encryption action %d failed for %s, error %d when freeing\n",
+			enc_action, note, ret);
+	} else {
+		pr_debug("freed %s\n", note);
+		free_page((unsigned long)*page);
+	}
+
+	*page = NULL;
+
+	return ret;
+}
+
+static bool hv_should_allocate_post_msg_page(void)
+{
+	return ms_hyperv.paravisor_present && hv_isolation_type_tdx();
+}
+
+static bool hv_should_allocate_synic_pages(void)
+{
+	return !ms_hyperv.paravisor_present && !hv_root_partition();
+}
+
+static bool hv_should_allocate_pv_synic_pages(void)
+{
+	return vmbus_is_confidential();
+}
+
 int hv_synic_alloc(void)
 {
 	int cpu, ret = -ENOMEM;
 	struct hv_per_cpu_context *hv_cpu;
 
+	const bool allocate_post_msg_page = hv_should_allocate_post_msg_page();
+	const bool allocate_synic_pages = hv_should_allocate_synic_pages();
+	const bool allocate_pv_synic_pages = hv_should_allocate_pv_synic_pages();
+	const enum hv_page_encryption_action enc_action =
+		(!vmbus_is_confidential()) ? HV_PAGE_ENC_DECRYPT : HV_PAGE_ENC_DEAFULT;
+
 	/*
 	 * First, zero all per-cpu memory areas so hv_synic_free() can
 	 * detect what memory has been allocated and cleanup properly
@@ -122,74 +246,38 @@ int hv_synic_alloc(void)
 		tasklet_init(&hv_cpu->msg_dpc,
 			     vmbus_on_msg_dpc, (unsigned long)hv_cpu);
 
-		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx()) {
-			hv_cpu->post_msg_page = (void *)get_zeroed_page(GFP_ATOMIC);
-			if (!hv_cpu->post_msg_page) {
-				pr_err("Unable to allocate post msg page\n");
+		if (allocate_post_msg_page) {
+			ret = hv_alloc_page(cpu, &hv_cpu->post_msg_page,
+				enc_action, "post msg page");
+			if (ret)
 				goto err;
-			}
-
-			ret = set_memory_decrypted((unsigned long)hv_cpu->post_msg_page, 1);
-			if (ret) {
-				pr_err("Failed to decrypt post msg page: %d\n", ret);
-				/* Just leak the page, as it's unsafe to free the page. */
-				hv_cpu->post_msg_page = NULL;
-				goto err;
-			}
-
-			memset(hv_cpu->post_msg_page, 0, PAGE_SIZE);
 		}
 
 		/*
-		 * Synic message and event pages are allocated by paravisor.
-		 * Skip these pages allocation here.
+		 * If these SynIC pages are not allocated, SIEF and SIM pages
+		 * are configured using what the root partition or the paravisor
+		 * provides upon reading the SIEFP and SIMP registers.
 		 */
-		if (!ms_hyperv.paravisor_present && !hv_root_partition()) {
-			hv_cpu->synic_message_page =
-				(void *)get_zeroed_page(GFP_ATOMIC);
-			if (!hv_cpu->synic_message_page) {
-				pr_err("Unable to allocate SYNIC message page\n");
+		if (allocate_synic_pages) {
+			ret = hv_alloc_page(cpu, &hv_cpu->hv_synic_message_page,
+				enc_action, "SynIC msg page");
+			if (ret)
 				goto err;
-			}
-
-			hv_cpu->synic_event_page =
-				(void *)get_zeroed_page(GFP_ATOMIC);
-			if (!hv_cpu->synic_event_page) {
-				pr_err("Unable to allocate SYNIC event page\n");
-
-				free_page((unsigned long)hv_cpu->synic_message_page);
-				hv_cpu->synic_message_page = NULL;
+			ret = hv_alloc_page(cpu, &hv_cpu->hv_synic_event_page,
+				enc_action, "SynIC event page");
+			if (ret)
 				goto err;
-			}
 		}
 
-		if (!ms_hyperv.paravisor_present &&
-		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
-			ret = set_memory_decrypted((unsigned long)
-				hv_cpu->synic_message_page, 1);
-			if (ret) {
-				pr_err("Failed to decrypt SYNIC msg page: %d\n", ret);
-				hv_cpu->synic_message_page = NULL;
-
-				/*
-				 * Free the event page here so that hv_synic_free()
-				 * won't later try to re-encrypt it.
-				 */
-				free_page((unsigned long)hv_cpu->synic_event_page);
-				hv_cpu->synic_event_page = NULL;
+		if (allocate_pv_synic_pages) {
+			ret = hv_alloc_page(cpu, &hv_cpu->pv_synic_message_page,
+				HV_PAGE_ENC_DEAFULT, "pv SynIC msg page");
+			if (ret)
 				goto err;
-			}
-
-			ret = set_memory_decrypted((unsigned long)
-				hv_cpu->synic_event_page, 1);
-			if (ret) {
-				pr_err("Failed to decrypt SYNIC event page: %d\n", ret);
-				hv_cpu->synic_event_page = NULL;
+			ret = hv_alloc_page(cpu, &hv_cpu->pv_synic_event_page,
+				HV_PAGE_ENC_DEAFULT, "pv SynIC event page");
+			if (ret)
 				goto err;
-			}
-
-			memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
-			memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
 		}
 	}
 
@@ -205,55 +293,38 @@ int hv_synic_alloc(void)
 
 void hv_synic_free(void)
 {
-	int cpu, ret;
+	int cpu;
+
+	const bool free_post_msg_page = hv_should_allocate_post_msg_page();
+	const bool free_synic_pages = hv_should_allocate_synic_pages();
+	const bool free_pv_synic_pages = hv_should_allocate_pv_synic_pages();
 
 	for_each_present_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu =
 			per_cpu_ptr(hv_context.cpu_context, cpu);
 
-		/* It's better to leak the page if the encryption fails. */
-		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx()) {
-			if (hv_cpu->post_msg_page) {
-				ret = set_memory_encrypted((unsigned long)
-					hv_cpu->post_msg_page, 1);
-				if (ret) {
-					pr_err("Failed to encrypt post msg page: %d\n", ret);
-					hv_cpu->post_msg_page = NULL;
-				}
-			}
+		if (free_post_msg_page)
+			hv_free_page(&hv_cpu->post_msg_page,
+				HV_PAGE_ENC_ENCRYPT, "post msg page");
+		if (free_synic_pages) {
+			hv_free_page(&hv_cpu->hv_synic_event_page,
+				HV_PAGE_ENC_ENCRYPT, "SynIC event page");
+			hv_free_page(&hv_cpu->hv_synic_message_page,
+				HV_PAGE_ENC_ENCRYPT, "SynIC msg page");
 		}
-
-		if (!ms_hyperv.paravisor_present &&
-		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
-			if (hv_cpu->synic_message_page) {
-				ret = set_memory_encrypted((unsigned long)
-					hv_cpu->synic_message_page, 1);
-				if (ret) {
-					pr_err("Failed to encrypt SYNIC msg page: %d\n", ret);
-					hv_cpu->synic_message_page = NULL;
-				}
-			}
-
-			if (hv_cpu->synic_event_page) {
-				ret = set_memory_encrypted((unsigned long)
-					hv_cpu->synic_event_page, 1);
-				if (ret) {
-					pr_err("Failed to encrypt SYNIC event page: %d\n", ret);
-					hv_cpu->synic_event_page = NULL;
-				}
-			}
+		if (free_pv_synic_pages) {
+			hv_free_page(&hv_cpu->pv_synic_event_page,
+				HV_PAGE_ENC_DEAFULT, "pv SynIC event page");
+			hv_free_page(&hv_cpu->pv_synic_message_page,
+				HV_PAGE_ENC_DEAFULT, "pv SynIC msg page");
 		}
-
-		free_page((unsigned long)hv_cpu->post_msg_page);
-		free_page((unsigned long)hv_cpu->synic_event_page);
-		free_page((unsigned long)hv_cpu->synic_message_page);
 	}
 
 	kfree(hv_context.hv_numa_map);
 }
 
 /*
- * hv_synic_init - Initialize the Synthetic Interrupt Controller.
+ * hv_synic_enable_regs - Initialize the Synthetic Interrupt Controller.
  *
  * If it is already initialized by another entity (ie x2v shim), we need to
  * retrieve the initialized message and event pages.  Otherwise, we create and
@@ -266,7 +337,6 @@ void hv_synic_enable_regs(unsigned int cpu)
 	union hv_synic_simp simp;
 	union hv_synic_siefp siefp;
 	union hv_synic_sint shared_sint;
-	union hv_synic_scontrol sctrl;
 
 	/* Setup the Synic's message page */
 	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
@@ -276,18 +346,18 @@ void hv_synic_enable_regs(unsigned int cpu)
 		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
 		u64 base = (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
-		hv_cpu->synic_message_page =
-			(void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
-		if (!hv_cpu->synic_message_page)
+		hv_cpu->hv_synic_message_page
+			= (void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
+		if (!hv_cpu->hv_synic_message_page)
 			pr_err("Fail to map synic message page.\n");
 	} else {
-		simp.base_simp_gpa = virt_to_phys(hv_cpu->synic_message_page)
+		simp.base_simp_gpa = virt_to_phys(hv_cpu->hv_synic_message_page)
 			>> HV_HYP_PAGE_SHIFT;
 	}
 
 	hv_set_msr(HV_MSR_SIMP, simp.as_uint64);
 
-	/* Setup the Synic's event page */
+	/* Setup the Synic's event page with the hypervisor. */
 	siefp.as_uint64 = hv_get_msr(HV_MSR_SIEFP);
 	siefp.siefp_enabled = 1;
 
@@ -295,12 +365,12 @@ void hv_synic_enable_regs(unsigned int cpu)
 		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
 		u64 base = (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
-		hv_cpu->synic_event_page =
-			(void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
-		if (!hv_cpu->synic_event_page)
+		hv_cpu->hv_synic_event_page
+			= (void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
+		if (!hv_cpu->hv_synic_event_page)
 			pr_err("Fail to map synic event page.\n");
 	} else {
-		siefp.base_siefp_gpa = virt_to_phys(hv_cpu->synic_event_page)
+		siefp.base_siefp_gpa = virt_to_phys(hv_cpu->hv_synic_event_page)
 			>> HV_HYP_PAGE_SHIFT;
 	}
 
@@ -313,8 +383,24 @@ void hv_synic_enable_regs(unsigned int cpu)
 
 	shared_sint.vector = vmbus_interrupt;
 	shared_sint.masked = false;
-	shared_sint.auto_eoi = hv_recommend_using_aeoi();
-	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
+
+	/*
+	 * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
+	 * it doesn't provide a recommendation flag and AEOI must be disabled.
+	 */
+#ifdef HV_DEPRECATING_AEOI_RECOMMENDED
+	shared_sint.auto_eoi =
+			!(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED);
+#else
+	shared_sint.auto_eoi = 0;
+#endif
+	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT,
+				shared_sint.as_uint64);
+}
+
+static void hv_synic_enable_interrupts(void)
+{
+	union hv_synic_scontrol sctrl;
 
 	/* Enable the global synic bit */
 	sctrl.as_uint64 = hv_get_msr(HV_MSR_SCONTROL);
@@ -323,13 +409,78 @@ void hv_synic_enable_regs(unsigned int cpu)
 	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
 }
 
+/*
+ * The paravisor might not support proxying SynIC, and this
+ * function may fail.
+ */
+static int hv_pv_synic_enable_regs(unsigned int cpu)
+{
+	union hv_synic_simp simp;
+	union hv_synic_siefp siefp;
+
+	int err;
+	struct hv_per_cpu_context *hv_cpu
+		= per_cpu_ptr(hv_context.cpu_context, cpu);
+
+	/* Setup the Synic's message page with the paravisor. */
+	simp.as_uint64 = hv_pv_get_synic_register(HV_MSR_SIMP, &err);
+	if (err)
+		return err;
+	simp.simp_enabled = 1;
+	simp.base_simp_gpa = virt_to_phys(hv_cpu->pv_synic_message_page)
+			>> HV_HYP_PAGE_SHIFT;
+	err = hv_pv_set_synic_register(HV_MSR_SIMP, simp.as_uint64);
+	if (err)
+		return err;
+
+	/* Setup the Synic's event page with the paravisor. */
+	siefp.as_uint64 = hv_pv_get_synic_register(HV_MSR_SIEFP, &err);
+	if (err)
+		return err;
+	siefp.siefp_enabled = 1;
+	siefp.base_siefp_gpa = virt_to_phys(hv_cpu->pv_synic_event_page)
+			>> HV_HYP_PAGE_SHIFT;
+	return hv_pv_set_synic_register(HV_MSR_SIEFP, siefp.as_uint64);
+}
+
+static int hv_pv_synic_enable_interrupts(void)
+{
+	union hv_synic_scontrol sctrl;
+	int err;
+
+	/* Enable the global synic bit */
+	sctrl.as_uint64 = hv_pv_get_synic_register(HV_MSR_SCONTROL, &err);
+	if (err)
+		return err;
+	sctrl.enable = 1;
+
+	return hv_pv_set_synic_register(HV_MSR_SCONTROL, sctrl.as_uint64);
+}
+
 int hv_synic_init(unsigned int cpu)
 {
+	int err = 0;
+
+	/*
+	 * The paravisor may not support the confidential VMBus,
+	 * check on that first.
+	 */
+	if (vmbus_is_confidential())
+		err = hv_pv_synic_enable_regs(cpu);
+	if (err)
+		return err;
+
 	hv_synic_enable_regs(cpu);
+	if (!vmbus_is_confidential())
+		hv_synic_enable_interrupts();
+	else
+		err = hv_pv_synic_enable_interrupts();
+	if (err)
+		return err;
 
 	hv_stimer_legacy_init(cpu, VMBUS_MESSAGE_SINT);
 
-	return 0;
+	return err;
 }
 
 void hv_synic_disable_regs(unsigned int cpu)
@@ -339,7 +490,6 @@ void hv_synic_disable_regs(unsigned int cpu)
 	union hv_synic_sint shared_sint;
 	union hv_synic_simp simp;
 	union hv_synic_siefp siefp;
-	union hv_synic_scontrol sctrl;
 
 	shared_sint.as_uint64 = hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT);
 
@@ -358,8 +508,8 @@ void hv_synic_disable_regs(unsigned int cpu)
 	 */
 	simp.simp_enabled = 0;
 	if (ms_hyperv.paravisor_present || hv_root_partition()) {
-		iounmap(hv_cpu->synic_message_page);
-		hv_cpu->synic_message_page = NULL;
+		iounmap(hv_cpu->hv_synic_message_page);
+		hv_cpu->hv_synic_message_page = NULL;
 	} else {
 		simp.base_simp_gpa = 0;
 	}
@@ -370,43 +520,97 @@ void hv_synic_disable_regs(unsigned int cpu)
 	siefp.siefp_enabled = 0;
 
 	if (ms_hyperv.paravisor_present || hv_root_partition()) {
-		iounmap(hv_cpu->synic_event_page);
-		hv_cpu->synic_event_page = NULL;
+		iounmap(hv_cpu->hv_synic_event_page);
+		hv_cpu->hv_synic_event_page = NULL;
 	} else {
 		siefp.base_siefp_gpa = 0;
 	}
 
 	hv_set_msr(HV_MSR_SIEFP, siefp.as_uint64);
+}
+
+static void hv_synic_disable_interrupts(void)
+{
+	union hv_synic_scontrol sctrl;
 
 	/* Disable the global synic bit */
 	sctrl.as_uint64 = hv_get_msr(HV_MSR_SCONTROL);
 	sctrl.enable = 0;
 	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
+}
 
+static void hv_vmbus_disable_percpu_interrupts(void)
+{
 	if (vmbus_irq != -1)
 		disable_percpu_irq(vmbus_irq);
 }
 
+static void hv_pv_synic_disable_regs(unsigned int cpu)
+{
+	/*
+	 * The get/set register errors are deliberatley ignored in
+	 * the cleanup path as they are non-consequential here.
+	 */
+	int err;
+	union hv_synic_simp simp;
+	union hv_synic_siefp siefp;
+
+	struct hv_per_cpu_context *hv_cpu
+		= per_cpu_ptr(hv_context.cpu_context, cpu);
+
+	/* Disable SynIC's message page in the paravisor. */
+	simp.as_uint64 = hv_pv_get_synic_register(HV_MSR_SIMP, &err);
+	if (err)
+		return;
+	simp.simp_enabled = 0;
+
+	iounmap(hv_cpu->pv_synic_message_page);
+	hv_cpu->pv_synic_message_page = NULL;
+
+	err = hv_pv_set_synic_register(HV_MSR_SIMP, simp.as_uint64);
+	if (err)
+		return;
+
+	/* Disable SynIC's event page in the paravisor. */
+	siefp.as_uint64 = hv_pv_get_synic_register(HV_MSR_SIEFP, &err);
+	if (err)
+		return;
+	siefp.siefp_enabled = 0;
+
+	iounmap(hv_cpu->pv_synic_event_page);
+	hv_cpu->pv_synic_event_page = NULL;
+
+	hv_pv_set_synic_register(HV_MSR_SIEFP, siefp.as_uint64);
+}
+
+static void hv_pv_synic_disable_interrupts(void)
+{
+	union hv_synic_scontrol sctrl;
+	int err;
+
+	/* Disable the global synic bit */
+	sctrl.as_uint64 = hv_pv_get_synic_register(HV_MSR_SCONTROL, &err);
+	if (err)
+		return;
+	sctrl.enable = 0;
+	hv_pv_set_synic_register(HV_MSR_SCONTROL, sctrl.as_uint64);
+}
+
 #define HV_MAX_TRIES 3
-/*
- * Scan the event flags page of 'this' CPU looking for any bit that is set.  If we find one
- * bit set, then wait for a few milliseconds.  Repeat these steps for a maximum of 3 times.
- * Return 'true', if there is still any set bit after this operation; 'false', otherwise.
- *
- * If a bit is set, that means there is a pending channel interrupt.  The expectation is
- * that the normal interrupt handling mechanism will find and process the channel interrupt
- * "very soon", and in the process clear the bit.
- */
-static bool hv_synic_event_pending(void)
+
+static bool hv_synic_event_pending_for(union hv_synic_event_flags *event, int sint)
 {
-	struct hv_per_cpu_context *hv_cpu = this_cpu_ptr(hv_context.cpu_context);
-	union hv_synic_event_flags *event =
-		(union hv_synic_event_flags *)hv_cpu->synic_event_page + VMBUS_MESSAGE_SINT;
-	unsigned long *recv_int_page = event->flags; /* assumes VMBus version >= VERSION_WIN8 */
+	unsigned long *recv_int_page;
 	bool pending;
 	u32 relid;
-	int tries = 0;
+	int tries;
+
+	if (!event)
+		return false;
 
+	tries = 0;
+	event += sint;
+	recv_int_page = event->flags; /* assumes VMBus version >= VERSION_WIN8 */
 retry:
 	pending = false;
 	for_each_set_bit(relid, recv_int_page, HV_EVENT_FLAGS_COUNT) {
@@ -460,6 +664,26 @@ static int hv_pick_new_cpu(struct vmbus_channel *channel)
 /*
  * hv_synic_cleanup - Cleanup routine for hv_synic_init().
  */
+/*
+ * Scan the event flags page of 'this' CPU looking for any bit that is set.  If we find one
+ * bit set, then wait for a few milliseconds.  Repeat these steps for a maximum of 3 times.
+ * Return 'true', if there is still any set bit after this operation; 'false', otherwise.
+ *
+ * If a bit is set, that means there is a pending channel interrupt.  The expectation is
+ * that the normal interrupt handling mechanism will find and process the channel interrupt
+ * "very soon", and in the process clear the bit.
+ */
+static bool hv_synic_event_pending(void)
+{
+	struct hv_per_cpu_context *hv_cpu = this_cpu_ptr(hv_context.cpu_context);
+	union hv_synic_event_flags *hv_synic_event_page = hv_cpu->hv_synic_event_page;
+	union hv_synic_event_flags *pv_synic_event_page = hv_cpu->pv_synic_event_page;
+
+	return
+		hv_synic_event_pending_for(hv_synic_event_page, VMBUS_MESSAGE_SINT) ||
+		hv_synic_event_pending_for(pv_synic_event_page, VMBUS_MESSAGE_SINT);
+}
+
 int hv_synic_cleanup(unsigned int cpu)
 {
 	struct vmbus_channel *channel, *sc;
@@ -516,6 +740,13 @@ int hv_synic_cleanup(unsigned int cpu)
 	hv_stimer_legacy_cleanup(cpu);
 
 	hv_synic_disable_regs(cpu);
+	if (vmbus_is_confidential())
+		hv_pv_synic_disable_regs(cpu);
+	if (!vmbus_is_confidential())
+		hv_synic_disable_interrupts();
+	else
+		hv_pv_synic_disable_interrupts();
+	hv_vmbus_disable_percpu_interrupts();
 
 	return ret;
 }
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 29780f3a7478..9337e0afa3ce 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -120,8 +120,10 @@ enum {
  * Per cpu state for channel handling
  */
 struct hv_per_cpu_context {
-	void *synic_message_page;
-	void *synic_event_page;
+	void *hv_synic_message_page;
+	void *hv_synic_event_page;
+	void *pv_synic_message_page;
+	void *pv_synic_event_page;
 
 	/*
 	 * The page is only used in hv_post_message() for a TDX VM (with the
@@ -182,7 +184,8 @@ extern int hv_synic_cleanup(unsigned int cpu);
 void hv_ringbuffer_pre_init(struct vmbus_channel *channel);
 
 int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
-		       struct page *pages, u32 pagecnt, u32 max_pkt_size);
+		       struct page *pages, u32 pagecnt, u32 max_pkt_size,
+			   bool confidential);
 
 void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info);
 
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 3c9b02471760..05c2cd42fc75 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -183,7 +183,8 @@ void hv_ringbuffer_pre_init(struct vmbus_channel *channel)
 
 /* Initialize the ring buffer. */
 int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
-		       struct page *pages, u32 page_cnt, u32 max_pkt_size)
+		       struct page *pages, u32 page_cnt, u32 max_pkt_size,
+			   bool confidential)
 {
 	struct page **pages_wraparound;
 	int i;
@@ -207,7 +208,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 
 	ring_info->ring_buffer = (struct hv_ring_buffer *)
 		vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
-			pgprot_decrypted(PAGE_KERNEL));
+			confidential ? PAGE_KERNEL : pgprot_decrypted(PAGE_KERNEL));
 
 	kfree(pages_wraparound);
 	if (!ring_info->ring_buffer)
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index fa3ad6fe0bec..2557ec849fa6 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1027,12 +1027,9 @@ static void vmbus_onmessage_work(struct work_struct *work)
 	kfree(ctx);
 }
 
-void vmbus_on_msg_dpc(unsigned long data)
+static void vmbus_on_msg_dpc_for(void *message_page_addr)
 {
-	struct hv_per_cpu_context *hv_cpu = (void *)data;
-	void *page_addr = hv_cpu->synic_message_page;
-	struct hv_message msg_copy, *msg = (struct hv_message *)page_addr +
-				  VMBUS_MESSAGE_SINT;
+	struct hv_message msg_copy, *msg;
 	struct vmbus_channel_message_header *hdr;
 	enum vmbus_channel_message_type msgtype;
 	const struct vmbus_channel_message_table_entry *entry;
@@ -1040,6 +1037,10 @@ void vmbus_on_msg_dpc(unsigned long data)
 	__u8 payload_size;
 	u32 message_type;
 
+	if (!message_page_addr)
+		return;
+	msg = (struct hv_message *)message_page_addr + VMBUS_MESSAGE_SINT;
+
 	/*
 	 * 'enum vmbus_channel_message_type' is supposed to always be 'u32' as
 	 * it is being used in 'struct vmbus_channel_message_header' definition
@@ -1165,6 +1166,14 @@ void vmbus_on_msg_dpc(unsigned long data)
 	vmbus_signal_eom(msg, message_type);
 }
 
+void vmbus_on_msg_dpc(unsigned long data)
+{
+	struct hv_per_cpu_context *hv_cpu = (void *)data;
+
+	vmbus_on_msg_dpc_for(hv_cpu->hv_synic_message_page);
+	vmbus_on_msg_dpc_for(hv_cpu->pv_synic_message_page);
+}
+
 #ifdef CONFIG_PM_SLEEP
 /*
  * Fake RESCIND_CHANNEL messages to clean up hv_sock channels by force for
@@ -1203,21 +1212,19 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
 #endif /* CONFIG_PM_SLEEP */
 
 /*
- * Schedule all channels with events pending
+ * Schedule all channels with events pending.
+ * The event page can be directly checked to get the id of
+ * the channel that has the interrupt pending.
  */
-static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
+static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu, void *event_page_addr)
 {
 	unsigned long *recv_int_page;
 	u32 maxbits, relid;
+	union hv_synic_event_flags *event;
 
-	/*
-	 * The event page can be directly checked to get the id of
-	 * the channel that has the interrupt pending.
-	 */
-	void *page_addr = hv_cpu->synic_event_page;
-	union hv_synic_event_flags *event
-		= (union hv_synic_event_flags *)page_addr +
-					 VMBUS_MESSAGE_SINT;
+	if (!event_page_addr)
+		return;
+	event = (union hv_synic_event_flags *)event_page_addr + VMBUS_MESSAGE_SINT;
 
 	maxbits = HV_EVENT_FLAGS_COUNT;
 	recv_int_page = event->flags;
@@ -1288,26 +1295,35 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 	}
 }
 
-static void vmbus_isr(void)
+static void vmbus_message_sched(struct hv_per_cpu_context *hv_cpu, void *message_page_addr)
 {
-	struct hv_per_cpu_context *hv_cpu
-		= this_cpu_ptr(hv_context.cpu_context);
-	void *page_addr;
 	struct hv_message *msg;
 
-	vmbus_chan_sched(hv_cpu);
-
-	page_addr = hv_cpu->synic_message_page;
-	msg = (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
+	if (!message_page_addr)
+		return;
+	msg = (struct hv_message *)message_page_addr + VMBUS_MESSAGE_SINT;
 
 	/* Check if there are actual msgs to be processed */
 	if (msg->header.message_type != HVMSG_NONE) {
 		if (msg->header.message_type == HVMSG_TIMER_EXPIRED) {
 			hv_stimer0_isr();
 			vmbus_signal_eom(msg, HVMSG_TIMER_EXPIRED);
-		} else
+		} else {
 			tasklet_schedule(&hv_cpu->msg_dpc);
+		}
 	}
+}
+
+static void vmbus_isr(void)
+{
+	struct hv_per_cpu_context *hv_cpu
+		= this_cpu_ptr(hv_context.cpu_context);
+
+	vmbus_chan_sched(hv_cpu, hv_cpu->hv_synic_event_page);
+	vmbus_chan_sched(hv_cpu, hv_cpu->pv_synic_event_page);
+
+	vmbus_message_sched(hv_cpu, hv_cpu->hv_synic_message_page);
+	vmbus_message_sched(hv_cpu, hv_cpu->pv_synic_message_page);
 
 	add_interrupt_randomness(vmbus_interrupt);
 }
@@ -1318,11 +1334,35 @@ static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void vmbus_percpu_work(struct work_struct *work)
+static int vmbus_setup_control_plane(void)
 {
-	unsigned int cpu = smp_processor_id();
+	int ret;
+	int hyperv_cpuhp_online;
+
+	ret = hv_synic_alloc();
+	if (ret < 0)
+		goto err_alloc;
 
-	hv_synic_init(cpu);
+	/*
+	 * Initialize the per-cpu interrupt state and stimer state.
+	 * Then connect to the host.
+	 */
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
+				hv_synic_init, hv_synic_cleanup);
+	if (ret < 0)
+		goto err_alloc;
+	hyperv_cpuhp_online = ret;
+	ret = vmbus_connect();
+	if (ret)
+		goto err_connect;
+	return 0;
+
+err_connect:
+	cpuhp_remove_state(hyperv_cpuhp_online);
+	return -ENODEV;
+err_alloc:
+	hv_synic_free();
+	return -ENOMEM;
 }
 
 /*
@@ -1335,8 +1375,7 @@ static void vmbus_percpu_work(struct work_struct *work)
  */
 static int vmbus_bus_init(void)
 {
-	int ret, cpu;
-	struct work_struct __percpu *works;
+	int ret;
 
 	ret = hv_init();
 	if (ret != 0) {
@@ -1371,41 +1410,21 @@ static int vmbus_bus_init(void)
 		}
 	}
 
-	ret = hv_synic_alloc();
-	if (ret)
-		goto err_alloc;
-
-	works = alloc_percpu(struct work_struct);
-	if (!works) {
-		ret = -ENOMEM;
-		goto err_alloc;
-	}
-
 	/*
-	 * Initialize the per-cpu interrupt state and stimer state.
-	 * Then connect to the host.
+	 * Attempt to establish the confidential control plane first if this VM is
+	.* a hardware confidential VM, and the paravisor is present.
 	 */
-	cpus_read_lock();
-	for_each_online_cpu(cpu) {
-		struct work_struct *work = per_cpu_ptr(works, cpu);
+	ret = -ENODEV;
+	if (ms_hyperv.paravisor_present && (hv_isolation_type_tdx() || hv_isolation_type_snp())) {
+		is_confidential = true;
+		ret = vmbus_setup_control_plane();
+		is_confidential = ret == 0;
 
-		INIT_WORK(work, vmbus_percpu_work);
-		schedule_work_on(cpu, work);
+		pr_info("VMBus control plane is confidential: %d\n", is_confidential);
 	}
 
-	for_each_online_cpu(cpu)
-		flush_work(per_cpu_ptr(works, cpu));
-
-	/* Register the callbacks for possible CPU online/offline'ing */
-	ret = cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
-						   hv_synic_init, hv_synic_cleanup);
-	cpus_read_unlock();
-	free_percpu(works);
-	if (ret < 0)
-		goto err_alloc;
-	hyperv_cpuhp_online = ret;
-
-	ret = vmbus_connect();
+	if (!is_confidential)
+		ret = vmbus_setup_control_plane();
 	if (ret)
 		goto err_connect;
 
@@ -1421,9 +1440,6 @@ static int vmbus_bus_init(void)
 	return 0;
 
 err_connect:
-	cpuhp_remove_state(hyperv_cpuhp_online);
-err_alloc:
-	hv_synic_free();
 	if (vmbus_irq == -1) {
 		hv_remove_vmbus_handler();
 	} else {
-- 
2.43.0


