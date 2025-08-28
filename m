Return-Path: <linux-arch+bounces-13309-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C87CB3909D
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 03:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6863645F1
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 01:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CAF1DE3DF;
	Thu, 28 Aug 2025 01:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YAldZp5/"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1650F1D9A5D;
	Thu, 28 Aug 2025 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343174; cv=none; b=Kv3ZFUOrEtC/uOwxRTpM51Hg8TFbgRoY6vsE+ZNazgyCJfMP1LsLosOwcm31tW6J2enrBlWv9hexly07OzVbtHK4bzRbWuc9bI6/MqGa5A04qdnPkNbTpyXpgDj5BN76t4rkUVgB75fVdvWDNRKsBb2wAxUYqlYF7Fk3ZvdrTpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343174; c=relaxed/simple;
	bh=r08flTaSSztPJYYjiQoXnmZMJm0xQKh11fghAQVuRn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKAnTpkbJHfTWDS+5KLRB6kG+2SOBYktNOdYwiOMsUGKtHYEQEgGdrAozb8bgwoPhtU/CJsZYKZqyvCwnIxeiUHaaAJyyOPeZKc0mhFt9gb2N2bW4i1AVgn8kS3JpobVZ9s4eNrrxTG+BlLbnAMgmOMsJHPhJbLS62+2wUohpdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YAldZp5/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.174.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 958AF2110808;
	Wed, 27 Aug 2025 18:06:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 958AF2110808
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756343163;
	bh=kSfILZVCrpFfL0Td8JogaSpWEsUDepDbslKrZv/s7XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YAldZp5/OvACAA7xqWuorPLmmc4akdoIJnsLFlYs177FAQF1JrAQjwSN7Ljd5CHQf
	 NSObTctPZF3nzoKzdL5NS8Dzsnf0gB0c0c2YnDMmgWNGDRJLEaAvIKKGSV8ghBT+Ml
	 NCv2NWak56aXuFf/TfVVJp+W2p3Bgygp+xkonJoU=
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
Subject: [PATCH hyperv-next v5 06/16] Drivers: hv: Allocate the paravisor SynIC pages when required
Date: Wed, 27 Aug 2025 18:05:47 -0700
Message-ID: <20250828010557.123869-7-romank@linux.microsoft.com>
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

Confidential VMBus requires interacting with two SynICs -- one
provided by the host hypervisor, and one provided by the paravisor.
Each SynIC requires its own message and event pages.

Refactor and extend the existing code to add allocating and freeing
the message and event pages for the paravisor SynIC when it is
present.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/hv.c           | 184 +++++++++++++++++++-------------------
 drivers/hv/hyperv_vmbus.h |  18 ++++
 2 files changed, 112 insertions(+), 90 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 0b9d20a94157..fe97591bc44d 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -99,10 +99,70 @@ int hv_post_message(union hv_connection_id connection_id,
 }
 EXPORT_SYMBOL_GPL(hv_post_message);
 
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
+	if (ret)
+		pr_err("deallocation failed for %s page, error %d, encrypt %d\n",
+			note, ret, encrypt);
+	else
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
@@ -128,73 +188,37 @@ int hv_synic_alloc(void)
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
 
@@ -210,48 +234,28 @@ int hv_synic_alloc(void)
 
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
index f0ad27af66fe..095a5c758e93 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -122,8 +122,26 @@ enum {
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


