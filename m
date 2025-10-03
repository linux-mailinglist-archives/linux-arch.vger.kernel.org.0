Return-Path: <linux-arch+bounces-13905-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E5BBB847F
	for <lists+linux-arch@lfdr.de>; Sat, 04 Oct 2025 00:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE21D4C059B
	for <lists+linux-arch@lfdr.de>; Fri,  3 Oct 2025 22:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25D527B357;
	Fri,  3 Oct 2025 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BX6hDh3r"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6EB2727E3;
	Fri,  3 Oct 2025 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530443; cv=none; b=Ks+Pb8m5bdbYelt1Q3EX9kIU4+x6Y5fQojOxLgHhlUXP9CnXnDBCAlTqMW9FXucmOKgJraUuelcK2Vaffgw4aN2SI2ex4GEtHRImUhCR5XrgRW3cAahzcDHiXXTNjAoZ4r00rUBT0MtX8bFPONfF3EX69FWJUs3Y7uZFji0Dcp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530443; c=relaxed/simple;
	bh=w6eBcbCBg83KK16MixPSnTYi2YgGONo2iUXGQvGoybs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmM7v6xq2LjAFbL7C2zpLaXi2nK0loc/fB/qtwY7U3c77Xw/ksuIC8ZwC1wRcMG5jn2bV5CAas8WBiSqwt39syxICcZn/tLFcNjm4lEm03yKqVqu/pl60TKTwvABrM83Tr0oWfXWU2IO40IqtJdhOprJmKtDtJDPyJb6sKiIgcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BX6hDh3r; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 133F1211C274;
	Fri,  3 Oct 2025 15:27:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 133F1211C274
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759530437;
	bh=89Wu0GLHW4v0p3+AxQWhCDJatbg72b6BoQ6TL9uJTcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BX6hDh3riHsHEj58970yNsyrAnrRHeH+NnNqlZrjcFLbkbVMoaTSXLXKSOCOkSUBS
	 0FVnrKalghHPl+3eSGm1frDZtkZUOyzPyMDMsZVU2M1+bZkda6KcTyFmPHS4m+Qi+V
	 ur+ZdwJsqKW2S4OvvRsNBkLDVaz9UYVhwBBOtYo8=
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
Subject: [PATCH hyperv-next v6 06/17] Drivers: hv: Rename fields for SynIC message and event pages
Date: Fri,  3 Oct 2025 15:26:59 -0700
Message-ID: <20251003222710.6257-7-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003222710.6257-1-romank@linux.microsoft.com>
References: <20251003222710.6257-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Confidential VMBus requires interacting with two SynICs -- one
provided by the host hypervisor, and one provided by the paravisor.
Each SynIC requires its own message and event pages.

Rename the existing host-accessible SynIC message and event pages
with the "hyp_" prefix to clearly distinguish them from the paravisor
ones. The field name is also changed in mshv_root.* for consistency.

No functional changes.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel_mgmt.c |  6 ++--
 drivers/hv/hv.c           | 66 +++++++++++++++++++--------------------
 drivers/hv/hyperv_vmbus.h |  4 +--
 drivers/hv/mshv_root.h    |  2 +-
 drivers/hv/mshv_synic.c   |  6 ++--
 drivers/hv/vmbus_drv.c    |  6 ++--
 6 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 65dd299e2944..1a33c6944b3c 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -844,14 +844,14 @@ static void vmbus_wait_for_unload(void)
 				= per_cpu_ptr(hv_context.cpu_context, cpu);
 
 			/*
-			 * In a CoCo VM the synic_message_page is not allocated
+			 * In a CoCo VM the hyp_synic_message_page is not allocated
 			 * in hv_synic_alloc(). Instead it is set/cleared in
 			 * hv_synic_enable_regs() and hv_synic_disable_regs()
 			 * such that it is set only when the CPU is online. If
 			 * not all present CPUs are online, the message page
 			 * might be NULL, so skip such CPUs.
 			 */
-			page_addr = hv_cpu->synic_message_page;
+			page_addr = hv_cpu->hyp_synic_message_page;
 			if (!page_addr)
 				continue;
 
@@ -892,7 +892,7 @@ static void vmbus_wait_for_unload(void)
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
-		page_addr = hv_cpu->synic_message_page;
+		page_addr = hv_cpu->hyp_synic_message_page;
 		if (!page_addr)
 			continue;
 
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index b14c5f9e0ef2..b7419d0fad1d 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -147,20 +147,20 @@ int hv_synic_alloc(void)
 		 * Skip these pages allocation here.
 		 */
 		if (!ms_hyperv.paravisor_present && !hv_root_partition()) {
-			hv_cpu->synic_message_page =
+			hv_cpu->hyp_synic_message_page =
 				(void *)get_zeroed_page(GFP_ATOMIC);
-			if (!hv_cpu->synic_message_page) {
+			if (!hv_cpu->hyp_synic_message_page) {
 				pr_err("Unable to allocate SYNIC message page\n");
 				goto err;
 			}
 
-			hv_cpu->synic_event_page =
+			hv_cpu->hyp_synic_event_page =
 				(void *)get_zeroed_page(GFP_ATOMIC);
-			if (!hv_cpu->synic_event_page) {
+			if (!hv_cpu->hyp_synic_event_page) {
 				pr_err("Unable to allocate SYNIC event page\n");
 
-				free_page((unsigned long)hv_cpu->synic_message_page);
-				hv_cpu->synic_message_page = NULL;
+				free_page((unsigned long)hv_cpu->hyp_synic_message_page);
+				hv_cpu->hyp_synic_message_page = NULL;
 				goto err;
 			}
 		}
@@ -168,30 +168,30 @@ int hv_synic_alloc(void)
 		if (!ms_hyperv.paravisor_present &&
 		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
 			ret = set_memory_decrypted((unsigned long)
-				hv_cpu->synic_message_page, 1);
+				hv_cpu->hyp_synic_message_page, 1);
 			if (ret) {
 				pr_err("Failed to decrypt SYNIC msg page: %d\n", ret);
-				hv_cpu->synic_message_page = NULL;
+				hv_cpu->hyp_synic_message_page = NULL;
 
 				/*
 				 * Free the event page here so that hv_synic_free()
 				 * won't later try to re-encrypt it.
 				 */
-				free_page((unsigned long)hv_cpu->synic_event_page);
-				hv_cpu->synic_event_page = NULL;
+				free_page((unsigned long)hv_cpu->hyp_synic_event_page);
+				hv_cpu->hyp_synic_event_page = NULL;
 				goto err;
 			}
 
 			ret = set_memory_decrypted((unsigned long)
-				hv_cpu->synic_event_page, 1);
+				hv_cpu->hyp_synic_event_page, 1);
 			if (ret) {
 				pr_err("Failed to decrypt SYNIC event page: %d\n", ret);
-				hv_cpu->synic_event_page = NULL;
+				hv_cpu->hyp_synic_event_page = NULL;
 				goto err;
 			}
 
-			memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
-			memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
+			memset(hv_cpu->hyp_synic_message_page, 0, PAGE_SIZE);
+			memset(hv_cpu->hyp_synic_event_page, 0, PAGE_SIZE);
 		}
 	}
 
@@ -227,28 +227,28 @@ void hv_synic_free(void)
 
 		if (!ms_hyperv.paravisor_present &&
 		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
-			if (hv_cpu->synic_message_page) {
+			if (hv_cpu->hyp_synic_message_page) {
 				ret = set_memory_encrypted((unsigned long)
-					hv_cpu->synic_message_page, 1);
+					hv_cpu->hyp_synic_message_page, 1);
 				if (ret) {
 					pr_err("Failed to encrypt SYNIC msg page: %d\n", ret);
-					hv_cpu->synic_message_page = NULL;
+					hv_cpu->hyp_synic_message_page = NULL;
 				}
 			}
 
-			if (hv_cpu->synic_event_page) {
+			if (hv_cpu->hyp_synic_event_page) {
 				ret = set_memory_encrypted((unsigned long)
-					hv_cpu->synic_event_page, 1);
+					hv_cpu->hyp_synic_event_page, 1);
 				if (ret) {
 					pr_err("Failed to encrypt SYNIC event page: %d\n", ret);
-					hv_cpu->synic_event_page = NULL;
+					hv_cpu->hyp_synic_event_page = NULL;
 				}
 			}
 		}
 
 		free_page((unsigned long)hv_cpu->post_msg_page);
-		free_page((unsigned long)hv_cpu->synic_event_page);
-		free_page((unsigned long)hv_cpu->synic_message_page);
+		free_page((unsigned long)hv_cpu->hyp_synic_event_page);
+		free_page((unsigned long)hv_cpu->hyp_synic_message_page);
 	}
 
 	kfree(hv_context.hv_numa_map);
@@ -278,12 +278,12 @@ void hv_synic_enable_regs(unsigned int cpu)
 		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
 		u64 base = (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
-		hv_cpu->synic_message_page =
+		hv_cpu->hyp_synic_message_page =
 			(void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
-		if (!hv_cpu->synic_message_page)
+		if (!hv_cpu->hyp_synic_message_page)
 			pr_err("Fail to map synic message page.\n");
 	} else {
-		simp.base_simp_gpa = virt_to_phys(hv_cpu->synic_message_page)
+		simp.base_simp_gpa = virt_to_phys(hv_cpu->hyp_synic_message_page)
 			>> HV_HYP_PAGE_SHIFT;
 	}
 
@@ -297,12 +297,12 @@ void hv_synic_enable_regs(unsigned int cpu)
 		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
 		u64 base = (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
-		hv_cpu->synic_event_page =
+		hv_cpu->hyp_synic_event_page =
 			(void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
-		if (!hv_cpu->synic_event_page)
+		if (!hv_cpu->hyp_synic_event_page)
 			pr_err("Fail to map synic event page.\n");
 	} else {
-		siefp.base_siefp_gpa = virt_to_phys(hv_cpu->synic_event_page)
+		siefp.base_siefp_gpa = virt_to_phys(hv_cpu->hyp_synic_event_page)
 			>> HV_HYP_PAGE_SHIFT;
 	}
 
@@ -360,8 +360,8 @@ void hv_synic_disable_regs(unsigned int cpu)
 	 */
 	simp.simp_enabled = 0;
 	if (ms_hyperv.paravisor_present || hv_root_partition()) {
-		iounmap(hv_cpu->synic_message_page);
-		hv_cpu->synic_message_page = NULL;
+		iounmap(hv_cpu->hyp_synic_message_page);
+		hv_cpu->hyp_synic_message_page = NULL;
 	} else {
 		simp.base_simp_gpa = 0;
 	}
@@ -372,8 +372,8 @@ void hv_synic_disable_regs(unsigned int cpu)
 	siefp.siefp_enabled = 0;
 
 	if (ms_hyperv.paravisor_present || hv_root_partition()) {
-		iounmap(hv_cpu->synic_event_page);
-		hv_cpu->synic_event_page = NULL;
+		iounmap(hv_cpu->hyp_synic_event_page);
+		hv_cpu->hyp_synic_event_page = NULL;
 	} else {
 		siefp.base_siefp_gpa = 0;
 	}
@@ -403,7 +403,7 @@ static bool hv_synic_event_pending(void)
 {
 	struct hv_per_cpu_context *hv_cpu = this_cpu_ptr(hv_context.cpu_context);
 	union hv_synic_event_flags *event =
-		(union hv_synic_event_flags *)hv_cpu->synic_event_page + VMBUS_MESSAGE_SINT;
+		(union hv_synic_event_flags *)hv_cpu->hyp_synic_event_page + VMBUS_MESSAGE_SINT;
 	unsigned long *recv_int_page = event->flags; /* assumes VMBus version >= VERSION_WIN8 */
 	bool pending;
 	u32 relid;
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 9ac6f5520287..d593af45a5b2 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -121,8 +121,8 @@ enum {
  * Per cpu state for channel handling
  */
 struct hv_per_cpu_context {
-	void *synic_message_page;
-	void *synic_event_page;
+	void *hyp_synic_message_page;
+	void *hyp_synic_event_page;
 
 	/*
 	 * The page is only used in hv_post_message() for a TDX VM (with the
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index e3931b0f1269..db6b42db2fdc 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -169,7 +169,7 @@ struct mshv_girq_routing_table {
 };
 
 struct hv_synic_pages {
-	struct hv_message_page *synic_message_page;
+	struct hv_message_page *hyp_synic_message_page;
 	struct hv_synic_event_flags_page *synic_event_flags_page;
 	struct hv_synic_event_ring_page *synic_event_ring_page;
 };
diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index e6b6381b7c36..f8b0337cdc82 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -394,7 +394,7 @@ mshv_intercept_isr(struct hv_message *msg)
 void mshv_isr(void)
 {
 	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
-	struct hv_message_page **msg_page = &spages->synic_message_page;
+	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
 	struct hv_message *msg;
 	bool handled;
 
@@ -456,7 +456,7 @@ int mshv_synic_init(unsigned int cpu)
 #endif
 	union hv_synic_scontrol sctrl;
 	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
-	struct hv_message_page **msg_page = &spages->synic_message_page;
+	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
 	struct hv_synic_event_flags_page **event_flags_page =
 			&spages->synic_event_flags_page;
 	struct hv_synic_event_ring_page **event_ring_page =
@@ -550,7 +550,7 @@ int mshv_synic_cleanup(unsigned int cpu)
 	union hv_synic_sirbp sirbp;
 	union hv_synic_scontrol sctrl;
 	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
-	struct hv_message_page **msg_page = &spages->synic_message_page;
+	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
 	struct hv_synic_event_flags_page **event_flags_page =
 		&spages->synic_event_flags_page;
 	struct hv_synic_event_ring_page **event_ring_page =
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 3c414560fa5f..e12f0ba0701f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1060,7 +1060,7 @@ static void vmbus_onmessage_work(struct work_struct *work)
 void vmbus_on_msg_dpc(unsigned long data)
 {
 	struct hv_per_cpu_context *hv_cpu = (void *)data;
-	void *page_addr = hv_cpu->synic_message_page;
+	void *page_addr = hv_cpu->hyp_synic_message_page;
 	struct hv_message msg_copy, *msg = (struct hv_message *)page_addr +
 				  VMBUS_MESSAGE_SINT;
 	struct vmbus_channel_message_header *hdr;
@@ -1244,7 +1244,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 	 * The event page can be directly checked to get the id of
 	 * the channel that has the interrupt pending.
 	 */
-	void *page_addr = hv_cpu->synic_event_page;
+	void *page_addr = hv_cpu->hyp_synic_event_page;
 	union hv_synic_event_flags *event
 		= (union hv_synic_event_flags *)page_addr +
 					 VMBUS_MESSAGE_SINT;
@@ -1327,7 +1327,7 @@ static void vmbus_isr(void)
 
 	vmbus_chan_sched(hv_cpu);
 
-	page_addr = hv_cpu->synic_message_page;
+	page_addr = hv_cpu->hyp_synic_message_page;
 	msg = (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
 
 	/* Check if there are actual msgs to be processed */
-- 
2.43.0


