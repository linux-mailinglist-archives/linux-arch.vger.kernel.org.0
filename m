Return-Path: <linux-arch+bounces-13911-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73600BB84CA
	for <lists+linux-arch@lfdr.de>; Sat, 04 Oct 2025 00:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8827C4C2D37
	for <lists+linux-arch@lfdr.de>; Fri,  3 Oct 2025 22:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35F92BEFFB;
	Fri,  3 Oct 2025 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XG5q5ffV"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A0327A454;
	Fri,  3 Oct 2025 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530445; cv=none; b=ofzUE1bCiFq5CLHbu3hjaW2Yxdc5MRDCCCicIrKS0OY32OuHVMS5PwATahnseVhDGSOxVYNMwud247V0J2w9czbYow6iKzZTvgj9nIhAB7eilAowgifoHG65HzCky/XKvCNyeU/nzM7oFiDod1m5jFcq773pHAxo+6CBSyCmB2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530445; c=relaxed/simple;
	bh=yfJOYFcpcaft9gfk4TP1GboP8J7q/Uygy2ixjcvgtwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/cuyIYB76lNMhY2ww/t7TAJWTTNUzvKx35oFMUjChYkqWih7Fi09s8xzthTYGd7/mSh5t6MlWjtf+sv7uhmTd6xbZv6K5k5CQc3A7zJKFwqtVBjGFviiiDtj8u4SPU4zT3UBqErX7XM/cT3L2C5QJT3AFJSO4oxMcczQJ3Bb98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XG5q5ffV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id DF0D4211C279;
	Fri,  3 Oct 2025 15:27:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DF0D4211C279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759530441;
	bh=8Mh8PV+ES1bK1a1G4y3sHqCiVkIAXlaKpbQtNpSOMQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XG5q5ffVudsGJdQBGGntPtaItzHtiBAlK0S1CjHsz3YXHuBMymwpu1ilfT5vsUpEF
	 qwSkAgfO0+p64iVhjzcanrj3GZ/QcK8BvFNDfRjBvygJvWv3T70VSROn00snI1zb4d
	 AuP6fTtJjF0W+duT83Jo4OIn2q1cCrWAYKT3r3TQ=
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
Subject: [PATCH hyperv-next v6 11/17] Drivers: hv: Rename the SynIC enable and disable routines
Date: Fri,  3 Oct 2025 15:27:04 -0700
Message-ID: <20251003222710.6257-12-romank@linux.microsoft.com>
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

The confidential VMBus requires support for the both hypervisor
facing SynIC and the paravisor one.

Rename the functions that enable and disable SynIC with the
hypervisor. No functional changes.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel_mgmt.c |  2 +-
 drivers/hv/hv.c           | 11 ++++++-----
 drivers/hv/hyperv_vmbus.h |  4 ++--
 drivers/hv/vmbus_drv.c    |  6 +++---
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 1a33c6944b3c..6d66cbc9030b 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -846,7 +846,7 @@ static void vmbus_wait_for_unload(void)
 			/*
 			 * In a CoCo VM the hyp_synic_message_page is not allocated
 			 * in hv_synic_alloc(). Instead it is set/cleared in
-			 * hv_synic_enable_regs() and hv_synic_disable_regs()
+			 * hv_hyp_synic_enable_regs() and hv_hyp_synic_disable_regs()
 			 * such that it is set only when the CPU is online. If
 			 * not all present CPUs are online, the message page
 			 * might be NULL, so skip such CPUs.
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 8e102bcc0be8..76138ebe7c0c 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -268,9 +268,10 @@ void hv_synic_free(void)
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
@@ -336,14 +337,14 @@ void hv_synic_enable_regs(unsigned int cpu)
 
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
@@ -530,7 +531,7 @@ int hv_synic_cleanup(unsigned int cpu)
 always_cleanup:
 	hv_stimer_legacy_cleanup(cpu);
 
-	hv_synic_disable_regs(cpu);
+	hv_hyp_synic_disable_regs(cpu);
 
 	return ret;
 }
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 3c70051c0431..552ed782bcfc 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -190,10 +190,10 @@ extern int hv_synic_alloc(void);
 
 extern void hv_synic_free(void);
 
-extern void hv_synic_enable_regs(unsigned int cpu);
+extern void hv_hyp_synic_enable_regs(unsigned int cpu);
 extern int hv_synic_init(unsigned int cpu);
 
-extern void hv_synic_disable_regs(unsigned int cpu);
+extern void hv_hyp_synic_disable_regs(unsigned int cpu);
 extern int hv_synic_cleanup(unsigned int cpu);
 
 /* Interface */
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index e12f0ba0701f..2b5bf672c467 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2810,7 +2810,7 @@ static void hv_crash_handler(struct pt_regs *regs)
 	 */
 	cpu = smp_processor_id();
 	hv_stimer_cleanup(cpu);
-	hv_synic_disable_regs(cpu);
+	hv_hyp_synic_disable_regs(cpu);
 };
 
 static int hv_synic_suspend(void)
@@ -2835,14 +2835,14 @@ static int hv_synic_suspend(void)
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


