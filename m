Return-Path: <linux-arch+bounces-12765-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 722A7B04A45
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 00:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846D71AA0E32
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 22:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934BA27A914;
	Mon, 14 Jul 2025 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="B69YWid3"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2883279795;
	Mon, 14 Jul 2025 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531354; cv=none; b=UBTVaVsJzc4eMTYccuIsAq1RUFVmBlD5WwrgGbrWvhpc1XCdsQa3LS+1MreW+7v+zHVZM3+ldBQ5BufA8oPEIgbb5+GMdS6olmG3cH1ZUGe7pEl5Ix+syuCRKu4YLuVwmP7Io46C6Xmf9s4mUor3kNUq9h+RlTJHitfUT0YURMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531354; c=relaxed/simple;
	bh=/dJZ3cRvOzNN54jl9dU2yCgjMi/kqJvgcAhMV+mc4DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/7KA4k7lvOWcVFJ8fm82L5ZBz9naHkrT3/O7l4edoy5Q5h8wbaNGLoRbR2faZx2H77WaQdqiCvAScUMkvJaTltGpK08wRyNgSHZ/mxDbNG7eXepO4TpVvWV6P+PsrGPCUVP5ZYyLPs3+igsDLtovkOm/wJomdqVMoBtcC4teLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=B69YWid3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id E98CB201A4A0;
	Mon, 14 Jul 2025 15:15:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E98CB201A4A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752531350;
	bh=j00XbzilASNTkMHd9m2L0mBdWZrnYkzsjHSAldQBM9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B69YWid3xVys3P3BR0vAlLZVzI0tdaW4nUP1RbmsJPLJTOVfRLW8U0mgwI8msGb7W
	 pWQDCK8Wkc6ABbSwTLrkroFeqxROp6GbDlJrZGdtB6O1wDNSj+lzhor4apfkmorXGN
	 yrhGr8UDCfLdtMXbKRTvkkMiRlNZp3rAlRiBav3Q=
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
Subject: [PATCH hyperv-next v4 11/16] Drivers: hv: Functions for setting up and tearing down the paravisor SynIC
Date: Mon, 14 Jul 2025 15:15:40 -0700
Message-ID: <20250714221545.5615-12-romank@linux.microsoft.com>
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

The confidential VMBus runs with the paravisor SynIC and requires
configuring it with the paravisor.

Add the functions for configuring the paravisor SynIC. Update
overall SynIC initialization logic to initialize the SynIC if it
is present. Finally, break out SynIC interrupt enable/disable
code into separate functions so that SynIC interrupts can be
enabled or disabled via the paravisor instead of the hypervisor
if the paravisor SynIC is present.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/hv.c | 197 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 185 insertions(+), 12 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 94a81bb3c8c7..9d85d5e62968 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -276,9 +276,8 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
 	union hv_synic_simp simp;
 	union hv_synic_siefp siefp;
 	union hv_synic_sint shared_sint;
-	union hv_synic_scontrol sctrl;
 
-	/* Setup the Synic's message page */
+	/* Setup the Synic's message page with the hypervisor. */
 	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
 	simp.simp_enabled = 1;
 
@@ -297,7 +296,7 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
 
 	hv_set_msr(HV_MSR_SIMP, simp.as_uint64);
 
-	/* Setup the Synic's event page */
+	/* Setup the Synic's event page with the hypervisor. */
 	siefp.as_uint64 = hv_get_msr(HV_MSR_SIEFP);
 	siefp.siefp_enabled = 1;
 
@@ -325,6 +324,11 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
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
@@ -333,13 +337,100 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
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
+	/*
+	 * The SINT is set in hv_hyperv_synic_enable_regs() by calling
+	 * hv_set_msr(). hv_set_msr() in turn has special case code for the
+	 * SINT MSRs that write to the hypervisor version of the MSR *and*
+	 * the paravisor version of the MSR (but *without* the proxy bit when
+	 * VMBus is confidential). Then the code above enables interrupts
+	 * via the paravisor if VMBus is confidential, and otherwise via the
+	 * hypervisor.
+	 */
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
@@ -349,7 +440,6 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
 	union hv_synic_sint shared_sint;
 	union hv_synic_simp simp;
 	union hv_synic_siefp siefp;
-	union hv_synic_scontrol sctrl;
 
 	shared_sint.as_uint64 = hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT);
 
@@ -361,7 +451,7 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
 
 	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
 	/*
-	 * In Isolation VM, sim and sief pages are allocated by
+	 * In Isolation VM, simp and sief pages are allocated by
 	 * paravisor. These pages also will be used by kdump
 	 * kernel. So just reset enable bit here and keep page
 	 * addresses.
@@ -391,14 +481,64 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
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
+	/*
+	 * Don't deallocate memory here as the function is called on
+	 * CPU online and offline operations. The guest will find
+	 * itself without means of communication when resumed.
+	 */
+
+	/* Disable SynIC's message page in the paravisor. */
+	err = hv_para_get_synic_register(HV_MSR_SIMP, &simp.as_uint64);
+	if (err)
+		return;
+	simp.simp_enabled = 0;
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
@@ -411,16 +551,18 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
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
@@ -437,6 +579,17 @@ static bool hv_synic_event_pending(void)
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
@@ -529,7 +682,27 @@ int hv_synic_cleanup(unsigned int cpu)
 always_cleanup:
 	hv_stimer_legacy_cleanup(cpu);
 
+	/*
+	 * First, disable the event and message pages
+	 * used for communicating with the host, and then
+	 * disable the host interrupts if VMBus is not
+	 * confidential.
+	 */
 	hv_hyp_synic_disable_regs(cpu);
+	if (!vmbus_is_confidential())
+		hv_hyp_synic_disable_interrupts();
+
+	/*
+	 * Perform the same steps for the Confidential VMBus.
+	 * The sequencing provides the gurantee that no data
+	 * may be posted for processing before disabling interrupts.
+	 */
+	if (vmbus_is_confidential()) {
+		hv_para_synic_disable_regs(cpu);
+		hv_para_synic_disable_interrupts();
+	}
+	if (vmbus_irq != -1)
+		disable_percpu_irq(vmbus_irq);
 
 	return ret;
 }
-- 
2.43.0


