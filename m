Return-Path: <linux-arch+bounces-12767-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545BDB04A51
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 00:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A40B3A7D32
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 22:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59B92857CD;
	Mon, 14 Jul 2025 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VRLrxnv7"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39D3277C90;
	Mon, 14 Jul 2025 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531354; cv=none; b=pr0RbN2HBsBEXYWXGYEcbibSQ+pgtK796Wb/cXJCcpl0eVuryqaloUkANeQyQrFKtx6KQjRboj+9fxCJDMLM3xrOWuIV9HhDJH/cfWd30klGLHtSHah4Qb8vh7YGZh7RvkDbN5zxQDxpIS2F9QYjDTB0NIbkzppsH4WwUwVGhGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531354; c=relaxed/simple;
	bh=jXzX23+vk/ISiT6f/XAQrhNaKxCl3/BgNh+25XnmdTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uO0g4K0mjXbjemfCWeeao7tROvH2ckf4je9I/wlNHVdJT+EJ8qzuHZHLtJZViEgrgRr7JVmPzexExLB6RSCCBZdLAaE61Ee7ty7gtz+hvOEzpm9yT0daW7m5WMpcN1idz+4JYe+C/C/rYMb1aBRKhiGm31suC/sXHSBHm1HlPQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VRLrxnv7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8FCDD201658C;
	Mon, 14 Jul 2025 15:15:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8FCDD201658C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752531348;
	bh=9vC0Ol2Be4TB/mOkPQt+zK1NX2371emadjhTsHwAdXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VRLrxnv7H3+Qp/cT6RNYjjV04mZmQ+0JJ3z9yy/f3UfcPDBZ+kanx1tlm5LtxcUCR
	 yaQpxhIj8kXoIzzOh0T8UGf8YHYx+2OwA3i3+5I+2c6PVLKbTx1Otxnz3k+uQX5FRu
	 h4Pv24JqGVGnCUnQ8aQoIGJ6P9QyO/oVT75BfYiU=
From: Roman Kisel <romank@linux.microsoft.com>
To: alok.a.tiwari@oracle.com,
	arnd@arndb.de,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mhklinux@outlook.com,
	mingo@redhat.com,
	rdunlap@infradead.org,
	tglx@linutronix.de,
	Tianyu.Lan@microsoft.com,
	wei.liu@kernel.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v4 06/16] Drivers: hv: Allocate the paravisor SynIC pages when required
Date: Mon, 14 Jul 2025 15:15:35 -0700
Message-ID: <20250714221545.5615-7-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714221545.5615-1-romank@linux.microsoft.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
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

Refactor and extend the existing code to add allocating and freeing
the message and event pages for the paravisor SynIC when it is
present.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/hv.c           | 184 +++++++++++++++++++-------------------
 drivers/hv/hyperv_vmbus.h |  18 ++++
 2 files changed, 112 insertions(+), 90 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 964b9102477d..e9ee0177d765 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -94,10 +94,70 @@ int hv_post_message(union hv_connection_id connection_id,
 	return hv_result(status);
 }
 
+static int hv_alloc_page(void **page, bool decrypt, const char *note)
+{
+	int ret = 0;
+
+	/*
+	 * After the page changes its encryption status, its contents might
+	 * appear scrambled on some hardware. Thus `get_zeroed_page` would
+	 * zero the page out in vain, so do that explicitly exactly once.
+	 *
+	 * By default, the page is allocated encrypted in a CoCo VM.
+	 */
+	*page = (void *)__get_free_page(GFP_KERNEL);
+	if (!*page)
+		return -ENOMEM;
+
+	if (decrypt)
+		ret = set_memory_decrypted((unsigned long)*page, 1);
+	if (ret)
+		goto failed;
+
+	memset(*page, 0, PAGE_SIZE);
+	return 0;
+
+failed:
+	/*
+	 * Report the failure but don't put the page back on the free list as
+	 * its encryption status is unknown.
+	 */
+	pr_err("allocation failed for %s page, error %d, decrypted %d\n",
+		note, ret, decrypt);
+	*page = NULL;
+	return ret;
+}
+
+static int hv_free_page(void **page, bool encrypt, const char *note)
+{
+	int ret = 0;
+
+	if (!*page)
+		return 0;
+
+	if (encrypt)
+		ret = set_memory_encrypted((unsigned long)*page, 1);
+
+	/*
+	 * In the case of the failure, the page is leaked. Something is wrong,
+	 * prefer to lose the page with the unknown encryption status and stay afloat.
+	 */
+	if (ret) {
+		pr_err("deallocation failed for %s page, error %d, encrypt %d\n",
+			note, ret, encrypt);
+	} else
+		free_page((unsigned long)*page);
+
+	*page = NULL;
+
+	return ret;
+}
+
 int hv_synic_alloc(void)
 {
 	int cpu, ret = -ENOMEM;
 	struct hv_per_cpu_context *hv_cpu;
+	const bool decrypt = !vmbus_is_confidential();
 
 	/*
 	 * First, zero all per-cpu memory areas so hv_synic_free() can
@@ -123,73 +183,37 @@ int hv_synic_alloc(void)
 			     vmbus_on_msg_dpc, (unsigned long)hv_cpu);
 
 		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx()) {
-			hv_cpu->post_msg_page = (void *)get_zeroed_page(GFP_ATOMIC);
-			if (!hv_cpu->post_msg_page) {
-				pr_err("Unable to allocate post msg page\n");
+			ret = hv_alloc_page(&hv_cpu->post_msg_page,
+				decrypt, "post msg");
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
 		if (!ms_hyperv.paravisor_present && !hv_root_partition()) {
-			hv_cpu->hyp_synic_message_page =
-				(void *)get_zeroed_page(GFP_ATOMIC);
-			if (!hv_cpu->hyp_synic_message_page) {
-				pr_err("Unable to allocate SYNIC message page\n");
+			ret = hv_alloc_page(&hv_cpu->hyp_synic_message_page,
+				decrypt, "hypervisor SynIC msg");
+			if (ret)
 				goto err;
-			}
-
-			hv_cpu->hyp_synic_event_page =
-				(void *)get_zeroed_page(GFP_ATOMIC);
-			if (!hv_cpu->hyp_synic_event_page) {
-				pr_err("Unable to allocate SYNIC event page\n");
-
-				free_page((unsigned long)hv_cpu->hyp_synic_message_page);
-				hv_cpu->hyp_synic_message_page = NULL;
+			ret = hv_alloc_page(&hv_cpu->hyp_synic_event_page,
+				decrypt, "hypervisor SynIC event");
+			if (ret)
 				goto err;
-			}
 		}
 
-		if (!ms_hyperv.paravisor_present &&
-		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
-			ret = set_memory_decrypted((unsigned long)
-				hv_cpu->hyp_synic_message_page, 1);
-			if (ret) {
-				pr_err("Failed to decrypt SYNIC msg page: %d\n", ret);
-				hv_cpu->hyp_synic_message_page = NULL;
-
-				/*
-				 * Free the event page here so that hv_synic_free()
-				 * won't later try to re-encrypt it.
-				 */
-				free_page((unsigned long)hv_cpu->hyp_synic_event_page);
-				hv_cpu->hyp_synic_event_page = NULL;
+		if (vmbus_is_confidential()) {
+			ret = hv_alloc_page(&hv_cpu->para_synic_message_page,
+				false, "paravisor SynIC msg");
+			if (ret)
 				goto err;
-			}
-
-			ret = set_memory_decrypted((unsigned long)
-				hv_cpu->hyp_synic_event_page, 1);
-			if (ret) {
-				pr_err("Failed to decrypt SYNIC event page: %d\n", ret);
-				hv_cpu->hyp_synic_event_page = NULL;
+			ret = hv_alloc_page(&hv_cpu->para_synic_event_page,
+				false, "paravisor SynIC event");
+			if (ret)
 				goto err;
-			}
-
-			memset(hv_cpu->hyp_synic_message_page, 0, PAGE_SIZE);
-			memset(hv_cpu->hyp_synic_event_page, 0, PAGE_SIZE);
 		}
 	}
 
@@ -205,48 +229,28 @@ int hv_synic_alloc(void)
 
 void hv_synic_free(void)
 {
-	int cpu, ret;
+	int cpu;
+	const bool encrypt = !vmbus_is_confidential();
 
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
+		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx())
+			hv_free_page(&hv_cpu->post_msg_page,
+				encrypt, "post msg");
+		if (!ms_hyperv.paravisor_present && !hv_root_partition()) {
+			hv_free_page(&hv_cpu->hyp_synic_event_page,
+				encrypt, "hypervisor SynIC event");
+			hv_free_page(&hv_cpu->hyp_synic_message_page,
+				encrypt, "hypervisor SynIC msg");
 		}
-
-		if (!ms_hyperv.paravisor_present &&
-		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
-			if (hv_cpu->hyp_synic_message_page) {
-				ret = set_memory_encrypted((unsigned long)
-					hv_cpu->hyp_synic_message_page, 1);
-				if (ret) {
-					pr_err("Failed to encrypt SYNIC msg page: %d\n", ret);
-					hv_cpu->hyp_synic_message_page = NULL;
-				}
-			}
-
-			if (hv_cpu->hyp_synic_event_page) {
-				ret = set_memory_encrypted((unsigned long)
-					hv_cpu->hyp_synic_event_page, 1);
-				if (ret) {
-					pr_err("Failed to encrypt SYNIC event page: %d\n", ret);
-					hv_cpu->hyp_synic_event_page = NULL;
-				}
-			}
+		if (vmbus_is_confidential()) {
+			hv_free_page(&hv_cpu->para_synic_event_page,
+				false, "paravisor SynIC event");
+			hv_free_page(&hv_cpu->para_synic_message_page,
+				false, "paravisor SynIC msg");
 		}
-
-		free_page((unsigned long)hv_cpu->post_msg_page);
-		free_page((unsigned long)hv_cpu->hyp_synic_event_page);
-		free_page((unsigned long)hv_cpu->hyp_synic_message_page);
 	}
 
 	kfree(hv_context.hv_numa_map);
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index fc3cdb26ff1a..16b5cf1bca19 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -120,8 +120,26 @@ enum {
  * Per cpu state for channel handling
  */
 struct hv_per_cpu_context {
+	/*
+	 * SynIC pages for communicating with the host.
+	 *
+	 * These pages are accessible to the host partition and the hypervisor.
+	 * They may be used for exchanging data with the host partition and the
+	 * hypervisor even when they aren't trusted yet the guest partition
+	 * must be prepared to handle the malicious behavior.
+	 */
 	void *hyp_synic_message_page;
 	void *hyp_synic_event_page;
+	/*
+	 * SynIC pages for communicating with the paravisor.
+	 *
+	 * These pages may be accessed from within the guest partition only in
+	 * CoCo VMs. Neither the host partition nor the hypervisor can access
+	 * these pages in that case; they are used for exchanging data with the
+	 * paravisor.
+	 */
+	void *para_synic_message_page;
+	void *para_synic_event_page;
 
 	/*
 	 * The page is only used in hv_post_message() for a TDX VM (with the
-- 
2.43.0


