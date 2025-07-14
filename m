Return-Path: <linux-arch+bounces-12764-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCE0B04A41
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 00:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6851AA0DC3
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 22:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E3F281531;
	Mon, 14 Jul 2025 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LdNp/KDn"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA94279327;
	Mon, 14 Jul 2025 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531354; cv=none; b=kLvfXZ1dtcFo6cVWz6kah6nb4Qx5+iCf2A57ImTnxaMOsrEoVPU4K05NObyUlw9YSd+Q6hk2/O8nGEF9kwKCOBExFiYoJhHOHH5nYeoGr2oW7JaDLa52gLHl5UvyNdu2VUQE6827p6Ypn2Lyiiiiyqu2c8a0BXCOLObckpFZNj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531354; c=relaxed/simple;
	bh=NwWtU4pQqupYr0rrxiC/LfZQoDejFRAujTn7n0rRKVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSyzHsFRla4ISMFCcnXEbXlu9KVyfQTHnRlAFPYoJhDh0ivdCm4fWPFkU8wD1m9hdp7p3ySTK1DGDMOR5AeR5LjUlnke7zCwrC9b4XJT7hQy2xJ1CKvye2PXTjOhH7PnBKIzD1/veciqTJOAjc2vLoPWzsr+oZrKgI+riNpzlPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LdNp/KDn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id A6F84201A4A1;
	Mon, 14 Jul 2025 15:15:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6F84201A4A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752531349;
	bh=8xRSjjAXOHXCVTJfOWaC61Gx4ioYySGsoSFmStFww+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdNp/KDn3G92CXUx4Z28jlwRu6Z7unV4x9a7ziuTrswy3mjk8BmxeLHU8InX7aAn1
	 l6AzMS9smN+pK3z5ORqp+H1p/uMghs/JfQxpJZdBJf6Mj6/XJ1VTu389YUJuax3ZSs
	 E7+2OyFr159nV9m0oWsRDFXXcyTzizDMIQOnR3gk=
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
Subject: [PATCH hyperv-next v4 10/16] Drivers: hv: Rename the SynIC enable and disable routines
Date: Mon, 14 Jul 2025 15:15:39 -0700
Message-ID: <20250714221545.5615-11-romank@linux.microsoft.com>
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

The confidential VMBus requires support for the both hypervisor
facing SynIC and the paravisor one.

Rename the functions that enable and disable SynIC with the
hypervisor. No functional changes.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/channel_mgmt.c |  2 +-
 drivers/hv/hv.c           | 11 ++++++-----
 drivers/hv/hyperv_vmbus.h |  4 ++--
 drivers/hv/vmbus_drv.c    |  6 +++---
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 6f87220e2ca3..ca2fe10c110a 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -845,7 +845,7 @@ static void vmbus_wait_for_unload(void)
 			/*
 			 * In a CoCo VM the hyp_synic_message_page is not allocated
 			 * in hv_synic_alloc(). Instead it is set/cleared in
-			 * hv_synic_enable_regs() and hv_synic_disable_regs()
+			 * hv_hyp_synic_enable_regs() and hv_hyp_synic_disable_regs()
 			 * such that it is set only when the CPU is online. If
 			 * not all present CPUs are online, the message page
 			 * might be NULL, so skip such CPUs.
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index a8669843c56e..94a81bb3c8c7 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -266,9 +266,10 @@ void hv_synic_free(void)
 }
 
 /*
- * hv_synic_enable_regs - Initialize the Synthetic Interrupt Controller.
+ * hv_hyp_synic_enable_regs - Initialize the Synthetic Interrupt Controller
+ * with the hypervisor.
  */
-void hv_synic_enable_regs(unsigned int cpu)
+void hv_hyp_synic_enable_regs(unsigned int cpu)
 {
 	struct hv_per_cpu_context *hv_cpu =
 		per_cpu_ptr(hv_context.cpu_context, cpu);
@@ -334,14 +335,14 @@ void hv_synic_enable_regs(unsigned int cpu)
 
 int hv_synic_init(unsigned int cpu)
 {
-	hv_synic_enable_regs(cpu);
+	hv_hyp_synic_enable_regs(cpu);
 
 	hv_stimer_legacy_init(cpu, VMBUS_MESSAGE_SINT);
 
 	return 0;
 }
 
-void hv_synic_disable_regs(unsigned int cpu)
+void hv_hyp_synic_disable_regs(unsigned int cpu)
 {
 	struct hv_per_cpu_context *hv_cpu =
 		per_cpu_ptr(hv_context.cpu_context, cpu);
@@ -528,7 +529,7 @@ int hv_synic_cleanup(unsigned int cpu)
 always_cleanup:
 	hv_stimer_legacy_cleanup(cpu);
 
-	hv_synic_disable_regs(cpu);
+	hv_hyp_synic_disable_regs(cpu);
 
 	return ret;
 }
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 16b5cf1bca19..2873703d08a9 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -189,10 +189,10 @@ extern int hv_synic_alloc(void);
 
 extern void hv_synic_free(void);
 
-extern void hv_synic_enable_regs(unsigned int cpu);
+extern void hv_hyp_synic_enable_regs(unsigned int cpu);
 extern int hv_synic_init(unsigned int cpu);
 
-extern void hv_synic_disable_regs(unsigned int cpu);
+extern void hv_hyp_synic_disable_regs(unsigned int cpu);
 extern int hv_synic_cleanup(unsigned int cpu);
 
 /* Interface */
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 72940a64b0b6..13aca5abc7d8 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2809,7 +2809,7 @@ static void hv_crash_handler(struct pt_regs *regs)
 	 */
 	cpu = smp_processor_id();
 	hv_stimer_cleanup(cpu);
-	hv_synic_disable_regs(cpu);
+	hv_hyp_synic_disable_regs(cpu);
 };
 
 static int hv_synic_suspend(void)
@@ -2834,14 +2834,14 @@ static int hv_synic_suspend(void)
 	 * interrupts-disabled context.
 	 */
 
-	hv_synic_disable_regs(0);
+	hv_hyp_synic_disable_regs(0);
 
 	return 0;
 }
 
 static void hv_synic_resume(void)
 {
-	hv_synic_enable_regs(0);
+	hv_hyp_synic_enable_regs(0);
 
 	/*
 	 * Note: we don't need to call hv_stimer_init(0), because the timer
-- 
2.43.0


