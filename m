Return-Path: <linux-arch+bounces-12199-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B713ACD0EB
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 02:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E517F1898CB9
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 00:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D0C150997;
	Wed,  4 Jun 2025 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jEl6ehIt"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD03335971;
	Wed,  4 Jun 2025 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997830; cv=none; b=s+XaPgHYkI6mIPZKq5WQzanrYFa3o6ocTkvyj1ol3FQ2JwoGfiXqxC3DMAbloj8Kh98GIA3QG9ZL6lkw1kX48Bgd+bfOWQ7XyANJRq36BdDc4ZbGjvTSi/l9GX4rVvvp9B9fFuOI1QapJgR1fQOU5ONRP1U9fUg84odHmOV2LhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997830; c=relaxed/simple;
	bh=PM4eGyI5r13CjUV33HbF5W2RIgXYjtVpEONLefd7S8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKZ+nLrJmq8ZlNdPYqH+thUZg2bhO+o1gc8Ghgt5uSNtUedN7zbow2+q9xekSeFeEWGgV3Pm2urTdjcbQtz7fKAuIKCMPwKAi/FUhojrF3TRJNeuGT2x3yEjtOFceg+prBW9TdIaX11trR8WaiFuVpuE5ZSorVq0v7xrIaqYgs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jEl6ehIt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2995A2117444;
	Tue,  3 Jun 2025 17:43:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2995A2117444
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748997827;
	bh=y+ahWosz0MramHAxl570frT28U36/vEXSThjr+v2c/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jEl6ehIt4vXMNVViOEReFy9zFD1dju9+ZS0XbQhYW1jcqxa2EuUofZh5KcbPeiJxJ
	 Qf2QKhvMxfs6FoLAejBtqilRyNZGJLsYSx6qVUPn6qIFFTyU7aw5Vy6pBRVWCv0UlK
	 zCYkubhlL5Xw2XeAfd2gfwrKJ/DAfAzEjLcfYOXE=
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
Subject: [PATCH hyperv-next v3 11/15] Drivers: hv: Functions for setting up and tearing down the paravisor SynIC
Date: Tue,  3 Jun 2025 17:43:37 -0700
Message-ID: <20250604004341.7194-12-romank@linux.microsoft.com>
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

The confidential VMBus runs with the paravisor SynIC and requires
configuring it with the paravisor.

Add the functions for configuring the paravisor SynIC

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/hv.c | 180 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 169 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 2b561825089a..c9649ab3439e 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -203,7 +203,7 @@ int hv_synic_alloc(void)
 				decrypt, "hypervisor SynIC event");
 			if (ret)
 				goto err;
-			}
+		}
 
 		if (vmbus_is_confidential()) {
 			ret = hv_alloc_page(cpu, &hv_cpu->para_synic_message_page,
@@ -267,7 +267,6 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
 	union hv_synic_simp simp;
 	union hv_synic_siefp siefp;
 	union hv_synic_sint shared_sint;
-	union hv_synic_scontrol sctrl;
 
 	/* Setup the Synic's message page */
 	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
@@ -288,7 +287,7 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
 
 	hv_set_msr(HV_MSR_SIMP, simp.as_uint64);
 
-	/* Setup the Synic's event page */
+	/* Setup the Synic's event page with the hypervisor. */
 	siefp.as_uint64 = hv_get_msr(HV_MSR_SIEFP);
 	siefp.siefp_enabled = 1;
 
@@ -316,6 +315,11 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
 	shared_sint.masked = false;
 	shared_sint.auto_eoi = hv_recommend_using_aeoi();
 	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
+}
+
+static void hv_hyp_synic_enable_interrupts(void)
+{
+	union hv_synic_scontrol sctrl;
 
 	/* Enable the global synic bit */
 	sctrl.as_uint64 = hv_get_msr(HV_MSR_SCONTROL);
@@ -324,13 +328,90 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
 	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
 }
 
+/*
+ * The paravisor might not support proxying SynIC, and this
+ * function may fail.
+ */
+static int hv_para_synic_enable_regs(unsigned int cpu)
+{
+	int err;
+	union hv_synic_simp simp;
+	union hv_synic_siefp siefp;
+	struct hv_per_cpu_context *hv_cpu
+		= per_cpu_ptr(hv_context.cpu_context, cpu);
+
+	/* Setup the Synic's message page with the paravisor. */
+	err = hv_para_get_synic_register(HV_MSR_SIMP, &simp.as_uint64);
+	if (err)
+		return err;
+	simp.simp_enabled = 1;
+	simp.base_simp_gpa = virt_to_phys(hv_cpu->para_synic_message_page)
+			>> HV_HYP_PAGE_SHIFT;
+	err = hv_para_set_synic_register(HV_MSR_SIMP, simp.as_uint64);
+	if (err)
+		return err;
+
+	/* Setup the Synic's event page with the paravisor. */
+	err = hv_para_get_synic_register(HV_MSR_SIEFP, &siefp.as_uint64);
+	if (err)
+		return err;
+	siefp.siefp_enabled = 1;
+	siefp.base_siefp_gpa = virt_to_phys(hv_cpu->para_synic_event_page)
+			>> HV_HYP_PAGE_SHIFT;
+	return hv_para_set_synic_register(HV_MSR_SIEFP, siefp.as_uint64);
+}
+
+static int hv_para_synic_enable_interrupts(void)
+{
+	union hv_synic_scontrol sctrl;
+	int err;
+
+	/* Enable the global synic bit */
+	err = hv_para_get_synic_register(HV_MSR_SCONTROL, &sctrl.as_uint64);
+	if (err)
+		return err;
+	sctrl.enable = 1;
+
+	return hv_para_set_synic_register(HV_MSR_SCONTROL, sctrl.as_uint64);
+}
+
 int hv_synic_init(unsigned int cpu)
 {
+	int err;
+
+	/*
+	 * The paravisor may not support the confidential VMBus,
+	 * check on that first.
+	 */
+	if (vmbus_is_confidential()) {
+		err = hv_para_synic_enable_regs(cpu);
+		if (err)
+			goto fail;
+	}
+
 	hv_hyp_synic_enable_regs(cpu);
+	if (vmbus_is_confidential()) {
+		err = hv_para_synic_enable_interrupts();
+		if (err)
+			goto fail;
+	} else
+		hv_hyp_synic_enable_interrupts();
 
 	hv_stimer_legacy_init(cpu, VMBUS_MESSAGE_SINT);
 
 	return 0;
+
+fail:
+	/*
+	 * The failure may only come from enabling the paravisor SynIC.
+	 * That in turn means that the confidential VMBus cannot be used
+	 * which is not an error: the setup will be re-tried with the
+	 * non-confidential VMBus.
+	 *
+	 * We also don't bother attempting to reset the paravisor registers
+	 * as something isn't working there anyway.
+	 */
+	return err;
 }
 
 void hv_hyp_synic_disable_regs(unsigned int cpu)
@@ -340,7 +421,6 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
 	union hv_synic_sint shared_sint;
 	union hv_synic_simp simp;
 	union hv_synic_siefp siefp;
-	union hv_synic_scontrol sctrl;
 
 	shared_sint.as_uint64 = hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT);
 
@@ -378,14 +458,71 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
 	}
 
 	hv_set_msr(HV_MSR_SIEFP, siefp.as_uint64);
+}
+
+static void hv_hyp_synic_disable_interrupts(void)
+{
+	union hv_synic_scontrol sctrl;
 
 	/* Disable the global synic bit */
 	sctrl.as_uint64 = hv_get_msr(HV_MSR_SCONTROL);
 	sctrl.enable = 0;
 	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
+}
 
-	if (vmbus_irq != -1)
-		disable_percpu_irq(vmbus_irq);
+static void hv_para_synic_disable_regs(unsigned int cpu)
+{
+	/*
+	 * When a get/set register error is encountered, the function
+	 * returns as the paravisor may not support these registers.
+	 */
+	int err;
+	union hv_synic_simp simp;
+	union hv_synic_siefp siefp;
+
+	struct hv_per_cpu_context *hv_cpu
+		= per_cpu_ptr(hv_context.cpu_context, cpu);
+
+	/* Disable SynIC's message page in the paravisor. */
+	err = hv_para_get_synic_register(HV_MSR_SIMP, &simp.as_uint64);
+	if (err)
+		return;
+	simp.simp_enabled = 0;
+
+	if (hv_cpu->para_synic_message_page) {
+		free_page((u64)(hv_cpu->para_synic_message_page));
+		hv_cpu->para_synic_message_page = NULL;
+	}
+
+	err = hv_para_set_synic_register(HV_MSR_SIMP, simp.as_uint64);
+	if (err)
+		return;
+
+	/* Disable SynIC's event page in the paravisor. */
+	err = hv_para_get_synic_register(HV_MSR_SIEFP, &siefp.as_uint64);
+	if (err)
+		return;
+	siefp.siefp_enabled = 0;
+
+	if (hv_cpu->para_synic_event_page) {
+		free_page((u64)(hv_cpu->para_synic_event_page));
+		hv_cpu->para_synic_event_page = NULL;
+	}
+
+	hv_para_set_synic_register(HV_MSR_SIEFP, siefp.as_uint64);
+}
+
+static void hv_para_synic_disable_interrupts(void)
+{
+	union hv_synic_scontrol sctrl;
+	int err;
+
+	/* Disable the global synic bit */
+	err = hv_para_get_synic_register(HV_MSR_SCONTROL, &sctrl.as_uint64);
+	if (err)
+		return;
+	sctrl.enable = 0;
+	hv_para_set_synic_register(HV_MSR_SCONTROL, sctrl.as_uint64);
 }
 
 #define HV_MAX_TRIES 3
@@ -398,16 +535,18 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
  * that the normal interrupt handling mechanism will find and process the channel interrupt
  * "very soon", and in the process clear the bit.
  */
-static bool hv_synic_event_pending(void)
+static bool __hv_synic_event_pending(union hv_synic_event_flags *event, int sint)
 {
-	struct hv_per_cpu_context *hv_cpu = this_cpu_ptr(hv_context.cpu_context);
-	union hv_synic_event_flags *event =
-		(union hv_synic_event_flags *)hv_cpu->hyp_synic_event_page + VMBUS_MESSAGE_SINT;
-	unsigned long *recv_int_page = event->flags; /* assumes VMBus version >= VERSION_WIN8 */
+	unsigned long *recv_int_page;
 	bool pending;
 	u32 relid;
 	int tries = 0;
 
+	if (!event)
+		return false;
+
+	event += sint;
+	recv_int_page = event->flags; /* assumes VMBus version >= VERSION_WIN8 */
 retry:
 	pending = false;
 	for_each_set_bit(relid, recv_int_page, HV_EVENT_FLAGS_COUNT) {
@@ -424,6 +563,17 @@ static bool hv_synic_event_pending(void)
 	return pending;
 }
 
+static bool hv_synic_event_pending(void)
+{
+	struct hv_per_cpu_context *hv_cpu = this_cpu_ptr(hv_context.cpu_context);
+	union hv_synic_event_flags *hyp_synic_event_page = hv_cpu->hyp_synic_event_page;
+	union hv_synic_event_flags *para_synic_event_page = hv_cpu->para_synic_event_page;
+
+	return
+		__hv_synic_event_pending(hyp_synic_event_page, VMBUS_MESSAGE_SINT) ||
+		__hv_synic_event_pending(para_synic_event_page, VMBUS_MESSAGE_SINT);
+}
+
 static int hv_pick_new_cpu(struct vmbus_channel *channel)
 {
 	int ret = -EBUSY;
@@ -517,6 +667,14 @@ int hv_synic_cleanup(unsigned int cpu)
 	hv_stimer_legacy_cleanup(cpu);
 
 	hv_hyp_synic_disable_regs(cpu);
+	if (vmbus_is_confidential()) {
+		hv_para_synic_disable_regs(cpu);
+		hv_para_synic_disable_interrupts();
+	} else {
+		hv_hyp_synic_disable_interrupts();
+	}
+	if (vmbus_irq != -1)
+		disable_percpu_irq(vmbus_irq);
 
 	return ret;
 }
-- 
2.43.0


