Return-Path: <linux-arch+bounces-12196-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DE0ACD0E2
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 02:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0BC188AC35
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 00:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85988136349;
	Wed,  4 Jun 2025 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rE1XTNUM"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8355928DD0;
	Wed,  4 Jun 2025 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997829; cv=none; b=X8qsTj78FM+bb9CH8/jeBloqzRuHcvKH9A909U/FaH2RcMiOC4dtwYxt4oS7/ltzozcfSQK1H9bI6KmzavWylwW3g8YokzTkJAHElrkqDrC2g/y3WF+WjNYUk4N16d6u/goku1eibd7an7gU35f9tQV7EUL3cqx64UCLs4uPGro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997829; c=relaxed/simple;
	bh=S6NNXMAeozlLImSbXgnHi/ltsm81aFZBRSwp8YUJV7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0AezI/cUDeIRiAkUuGTDiFpZ2yuXXNL1Vezw2U/ZfSTM1XWPyyyb1ndlpNjZx3RA91b/poR0ar6XLEH/+RKYEJb0UuvFqkfCXCojbgXZpIEofzEbbTSUgj+NNJzlzFxAq2ZO9IaR5QgYrrbx1npAWhGbhKjzDPjV3GgeujweGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rE1XTNUM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id E36B92117442;
	Tue,  3 Jun 2025 17:43:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E36B92117442
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748997827;
	bh=6ORUl5m6HwLA9mAuHKQ4DHWFTROfZExIZhOKRTufXW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rE1XTNUMEslshbdMhozLtOclQfcMMQq5tjCzLhXN1g5A9LOgcDhs/3FK1GyrHEZKJ
	 yh/1sO9050A9ALRcjme9lykPY1Y2EVkgXCPibB4PresIDnyFaUnLAKnKz6kl9UVwI5
	 n22hAEfypll5m+FZ43s1D8oK50OxmsfSvxltbT4E=
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
	mingo@redhat.com,
	mhklinux@outlook.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v3 10/15] Drivers: hv: Rename the SynIC enable and disable routines
Date: Tue,  3 Jun 2025 17:43:36 -0700
Message-ID: <20250604004341.7194-11-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604004341.7194-1-romank@linux.microsoft.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
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
hypervisor.

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
index 9a66656d89e0..2b561825089a 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -257,9 +257,10 @@ void hv_synic_free(void)
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
@@ -325,14 +326,14 @@ void hv_synic_enable_regs(unsigned int cpu)
 
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
@@ -515,7 +516,7 @@ int hv_synic_cleanup(unsigned int cpu)
 always_cleanup:
 	hv_stimer_legacy_cleanup(cpu);
 
-	hv_synic_disable_regs(cpu);
+	hv_hyp_synic_disable_regs(cpu);
 
 	return ret;
 }
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 9619edcf9f88..c1df611d1eb2 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -188,10 +188,10 @@ extern int hv_synic_alloc(void);
 
 extern void hv_synic_free(void);
 
-extern void hv_synic_enable_regs(unsigned int cpu);
+extern void hv_hyp_synic_enable_regs(unsigned int cpu);
 extern int hv_synic_init(unsigned int cpu);
 
-extern void hv_synic_disable_regs(unsigned int cpu);
+extern void hv_hyp_synic_disable_regs(unsigned int cpu);
 extern int hv_synic_cleanup(unsigned int cpu);
 
 /* Interface */
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 695b1ba7113c..f7e82a4fe133 100644
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


