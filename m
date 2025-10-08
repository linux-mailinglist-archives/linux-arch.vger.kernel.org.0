Return-Path: <linux-arch+bounces-13975-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A80BC6E85
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 01:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F7C14EC424
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 23:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BBF2D94B8;
	Wed,  8 Oct 2025 23:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G6S049s8"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B829D2D738A;
	Wed,  8 Oct 2025 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966474; cv=none; b=Wvq8924fEH04SrF+jwv2/3Lk6pVggNAxqoTDn3QJuiiKROLtWdUU0FE2eMPOlDXyED+gBLQ7aVvApgIWEuRMWBVZzBt403WmIxXI8XH/q5ifDMjWfCQ1fS0a5PL1UZ5h27mL6ETsp6jWOBtfzhYLozMeCkzDthIYuu6K6rv+JLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966474; c=relaxed/simple;
	bh=3sYrfbLh1No9MnApa8e+Dzrxl59vkJn6AMXDBVfJh5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvF954JFBmpjseV7pugqLaqSZ2ENQAbAucXpSEUmuq4QV7rs99BTEuPnMoM6SG46qK34WMHY+MwEOTwHe7GKOItsFXoVGdYzkI5xaBbgOu3828/tRBe1niibfl6LiSGRE5tnka3SJd/hM1y2DuzNTVJcqd3kz0HPprjwT1YPqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G6S049s8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8EA09211C288;
	Wed,  8 Oct 2025 16:34:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8EA09211C288
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759966471;
	bh=U/V7LAyJxRAC6jWs2mHF+EcmxCXjONzJ+HhJb3jU37A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6S049s8SOJ2Eyt8SuORNqtOhsimHPX0JrdpLHyhWTajaoaJFnZnn7qVSQ4uZ6+vj
	 bqWxc7mE/Ywxws829tCnBfyoMtUkVUgxhCiGHY7oo5+GWB70dTCBq4FVeNyNi8qrcF
	 /Mg+TDg6TL5k49F+q8/FgW88R3R5khTrY5HHWIQQ=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bp@alien8.de,
	bagasdotme@gmail.com,
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
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v7 12/17] Drivers: hv: Functions for setting up and tearing down the paravisor SynIC
Date: Wed,  8 Oct 2025 16:34:14 -0700
Message-ID: <20251008233419.20372-13-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008233419.20372-1-romank@linux.microsoft.com>
References: <20251008233419.20372-1-romank@linux.microsoft.com>
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
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/hv.c | 138 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 126 insertions(+), 12 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 76138ebe7c0c..5789b41be76c 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -278,9 +278,8 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
 	union hv_synic_simp simp;
 	union hv_synic_siefp siefp;
 	union hv_synic_sint shared_sint;
-	union hv_synic_scontrol sctrl;
 
-	/* Setup the Synic's message page */
+	/* Setup the Synic's message page with the hypervisor. */
 	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
 	simp.simp_enabled = 1;
 
@@ -299,7 +298,7 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
 
 	hv_set_msr(HV_MSR_SIMP, simp.as_uint64);
 
-	/* Setup the Synic's event page */
+	/* Setup the Synic's event page with the hypervisor. */
 	siefp.as_uint64 = hv_get_msr(HV_MSR_SIEFP);
 	siefp.siefp_enabled = 1;
 
@@ -327,6 +326,11 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
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
@@ -335,9 +339,59 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
 	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
 }
 
+static void hv_para_synic_enable_regs(unsigned int cpu)
+{
+	union hv_synic_simp simp;
+	union hv_synic_siefp siefp;
+	struct hv_per_cpu_context *hv_cpu
+		= per_cpu_ptr(hv_context.cpu_context, cpu);
+
+	/* Setup the Synic's message page with the paravisor. */
+	simp.as_uint64 = hv_para_get_synic_register(HV_MSR_SIMP);
+	simp.simp_enabled = 1;
+	simp.base_simp_gpa = virt_to_phys(hv_cpu->para_synic_message_page)
+			>> HV_HYP_PAGE_SHIFT;
+	hv_para_set_synic_register(HV_MSR_SIMP, simp.as_uint64);
+
+	/* Setup the Synic's event page with the paravisor. */
+	siefp.as_uint64 = hv_para_get_synic_register(HV_MSR_SIEFP);
+	siefp.siefp_enabled = 1;
+	siefp.base_siefp_gpa = virt_to_phys(hv_cpu->para_synic_event_page)
+			>> HV_HYP_PAGE_SHIFT;
+	hv_para_set_synic_register(HV_MSR_SIEFP, siefp.as_uint64);
+}
+
+static void hv_para_synic_enable_interrupts(void)
+{
+	union hv_synic_scontrol sctrl;
+
+	/* Enable the global synic bit */
+	sctrl.as_uint64 = hv_para_get_synic_register(HV_MSR_SCONTROL);
+	sctrl.enable = 1;
+	hv_para_set_synic_register(HV_MSR_SCONTROL, sctrl.as_uint64);
+}
+
 int hv_synic_init(unsigned int cpu)
 {
+	if (vmbus_is_confidential())
+		hv_para_synic_enable_regs(cpu);
+
+	/*
+	 * The SINT is set in hv_hyp_synic_enable_regs() by calling
+	 * hv_set_msr(). hv_set_msr() in turn has special case code for the
+	 * SINT MSRs that write to the hypervisor version of the MSR *and*
+	 * the paravisor version of the MSR (but *without* the proxy bit when
+	 * VMBus is confidential).
+	 *
+	 * Then enable interrupts via the paravisor if VMBus is confidential,
+	 * and otherwise via the hypervisor.
+	 */
+
 	hv_hyp_synic_enable_regs(cpu);
+	if (vmbus_is_confidential())
+		hv_para_synic_enable_interrupts();
+	else
+		hv_hyp_synic_enable_interrupts();
 
 	hv_stimer_legacy_init(cpu, VMBUS_MESSAGE_SINT);
 
@@ -351,7 +405,6 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
 	union hv_synic_sint shared_sint;
 	union hv_synic_simp simp;
 	union hv_synic_siefp siefp;
-	union hv_synic_scontrol sctrl;
 
 	shared_sint.as_uint64 = hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT);
 
@@ -363,7 +416,7 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
 
 	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
 	/*
-	 * In Isolation VM, sim and sief pages are allocated by
+	 * In Isolation VM, simp and sief pages are allocated by
 	 * paravisor. These pages also will be used by kdump
 	 * kernel. So just reset enable bit here and keep page
 	 * addresses.
@@ -393,14 +446,42 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
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
+	union hv_synic_simp simp;
+	union hv_synic_siefp siefp;
+
+	/* Disable SynIC's message page in the paravisor. */
+	simp.as_uint64 = hv_para_get_synic_register(HV_MSR_SIMP);
+	simp.simp_enabled = 0;
+	hv_para_set_synic_register(HV_MSR_SIMP, simp.as_uint64);
+
+	/* Disable SynIC's event page in the paravisor. */
+	siefp.as_uint64 = hv_para_get_synic_register(HV_MSR_SIEFP);
+	siefp.siefp_enabled = 0;
+	hv_para_set_synic_register(HV_MSR_SIEFP, siefp.as_uint64);
+}
+
+static void hv_para_synic_disable_interrupts(void)
+{
+	union hv_synic_scontrol sctrl;
+
+	/* Disable the global synic bit */
+	sctrl.as_uint64 = hv_para_get_synic_register(HV_MSR_SCONTROL);
+	sctrl.enable = 0;
+	hv_para_set_synic_register(HV_MSR_SCONTROL, sctrl.as_uint64);
 }
 
 #define HV_MAX_TRIES 3
@@ -413,16 +494,18 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
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
@@ -439,6 +522,17 @@ static bool hv_synic_event_pending(void)
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
@@ -531,7 +625,27 @@ int hv_synic_cleanup(unsigned int cpu)
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
+	 * The sequencing provides the guarantee that no data
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


