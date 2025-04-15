Return-Path: <linux-arch+bounces-11410-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4997DA8A66B
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 20:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89090189F7E4
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 18:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D15F233700;
	Tue, 15 Apr 2025 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qs2yULY4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB39C231A2D;
	Tue, 15 Apr 2025 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740481; cv=none; b=IqjSXntbpe+L2dO1CsBsHiQKebZAypvvPuZbWgESOTfWY/qIOij/5YVprrGJbqKeqd2mLvObxmu4aafL6M6lheOqXOgpOGuc28Dh9vaim7+6TtXbV6mzLrwYiWTeltMdeq7itY6NB9he4wW5yP/ZvGbda9e8MJ2Bvzhlj5vviv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740481; c=relaxed/simple;
	bh=UTsKyS2PlZZKA2o+79sqVDK3wxEkcbrub9V0HEY/95Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YMp+zlwOmx+RvM2EuMdWgueD4CpZ3JkWeg7NYNhfq2LOeTneSu93Tz1M0U4OV/ttcKhR9h+S5lxG2TJJ8VJZEdrPBEsTX9NCzDhuI/WQ0ZSyQGb7BZ0a0rHVUlXCGxX36F7/YtUNwc7Sw1hcvG9ALJSxiMPd3Ybb4Gln/TgSGWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qs2yULY4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224100e9a5cso67669075ad.2;
        Tue, 15 Apr 2025 11:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744740479; x=1745345279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3+u66A1OTRBxF+yfRSOAIfy+XQ205gLrpOaXRpAT3KM=;
        b=Qs2yULY4pHijn9aNDQVqtsYrj3dO0wg3qnagnPvO8wsL9rDiSiOFZDdGzij6Tf+G20
         6vPVoMBki5en5fu9qP254qkwiIBXekedtZb762fDZeAskw35lEgyOU7nhMd6kU05NOi9
         LH41DHVmsqs3GlpuseOYAWrGH4V95xpXlOEkCHTFxMLW1AT8cGwRRH1Dlu1qMpnd21Sf
         27ZozTuukmr0By2O6+Viu87CzwDSzk+a+++7XC92gpJ9RLFkbXREn1Aq+zWIJmyY41Z6
         IuVYzHv7wBAlK2Z4N51fzEWV0MF2JgUd/R/x2ymNypfC6dHeFmNMPYlEsbgXs5DbXP4J
         YY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744740479; x=1745345279;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+u66A1OTRBxF+yfRSOAIfy+XQ205gLrpOaXRpAT3KM=;
        b=tUFGc1Zj+4b38zWUwHW/JoM7Y6mRjt/4Dd0gHOqfvC772QboiA1/sSm4Ih8MyiQRkN
         kcT7nb/eQDagfN3Q8+hikg1YpmttPOkS1nu8ahCZrGzVrxPhENpgunBO27FC6894U02p
         5cc3f1/YHBV1d5AjiRxocpmQV3xP9ZWYZ7yNEvM4Zt3faa7K0AZpCZwpl1mc6XxDSuhE
         +XCZvKIBVLDvv5k2jHwYGjnhemDmuQhGx4l+dbHwLC6Twm7tPkhXZfcbCNz+VgKsJUNR
         Fp3+ZyJA/lHrHAs7+i2Wx2BHY85NAHWZiUW2wG09lB9QopHvZRxY0VLY9ojZP57Bpfo8
         E/2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeXsiGKYz0TmDFi9WFvYKEeygqlp/rIRuA4gf2vCyqPZVHQgDf77sbd3AlIf/29xmJTHHnkDeYzIfP@vger.kernel.org, AJvYcCV3KxEa7VBXI7AVQtgumfFFwO8eCYVrScJ6JQSAjryCvDbNDxNdGp05w86S+LktFU+hBGGphaR1E4tUYyWh@vger.kernel.org, AJvYcCVQy19UtAekY9mOOcrmUf7VXBTcVWF4vsEADQTi8wXHCaTjBlKltYtuvB6i/dpkAH5CgGAWwFUF4DkB@vger.kernel.org, AJvYcCXMr91GpOlV+wuIie9lC5CcR3uNj1j/4/kEQq6X3ClpPeNiZ3L4FGgznhZgIYmenMw8BQJhitVGcj0IJFjZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzlCoriAtDcShbAshyLe5mGdDBQaqoMbcBrSzq/WRvKgI7CJavp
	YKvCPjpoQkXBIp5BwjzAR0INul94Oua7GtQ4X+NKigSKCftIVJ0X
X-Gm-Gg: ASbGncuEqa/uiD9OFLiLkbxC+LqOrxfIQticePXfzrKO7KG85jd30DXMPfNB+yCE3qs
	RGtWmj0Q+X7+a732NGfIhVi5ZdPlwCXqnf2pRA0S7fhj0FItXmbQh+q/Jt4pqBCA/5+clSBrgdL
	MWC+wIYOts59FEVoT0+vPZOs288wUBxYVl7N1QaIaNnLyLEkEwXN1wpto1TOq3TImIQfuBBroTN
	ZS3tG7zUC3MehB19N9ZJLry9ynaSHi0AWX4uV7YcWHGe2UbTtD0rINSeG0C21Sv3pmJP+Hp3auX
	pAaIV0eiUo581xnW1SvRO9P0/C6ypIiHjaafEuveOEjwe52/Pdq6Bz4noiihJD9If0dIYYedi5p
	UePXKdHSZCw3fotncb4c=
X-Google-Smtp-Source: AGHT+IE3KI5J87t62+O99Qs623myYy7MgdASGlwz3y7O+BXjNcAU9vBWFszNqHBSN6TQhEiF2gQpdQ==
X-Received: by 2002:a17:902:c407:b0:223:4816:3e9e with SMTP id d9443c01a7336-22c31a37a1amr944205ad.13.1744740478893;
        Tue, 15 Apr 2025 11:07:58 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb52c2sm120168425ad.194.2025.04.15.11.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:07:58 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de
Cc: x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v3 7/7] Drivers: hv: Replace hyperv_pcpu_input/output_arg with hyperv_pcpu_arg
Date: Tue, 15 Apr 2025 11:07:28 -0700
Message-Id: <20250415180728.1789-8-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415180728.1789-1-mhklinux@outlook.com>
References: <20250415180728.1789-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

All open coded uses of hyperv_pcpu_input_arg and hyperv_pcpu_ouput_arg
have been replaced by hv_hvcall_*() functions. So combine
hyperv_pcpu_input_arg and hyperv_pcpu_output_arg in a single
hyperv_pcpu_arg. Remove logic for managing a separate output arg. Fixup
comment references to the old variable names.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/hyperv/hv_init.c      |  6 ++--
 drivers/hv/hv.c                |  2 +-
 drivers/hv/hv_common.c         | 55 ++++++++++------------------------
 include/asm-generic/mshyperv.h |  6 +---
 4 files changed, 21 insertions(+), 48 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index cc843905c23a..e930fe75f2ca 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -483,16 +483,16 @@ void __init hyperv_init(void)
 	 * A TDX VM with no paravisor only uses TDX GHCI rather than hv_hypercall_pg:
 	 * when the hypercall input is a page, such a VM must pass a decrypted
 	 * page to Hyper-V, e.g. hv_post_message() uses the per-CPU page
-	 * hyperv_pcpu_input_arg, which is decrypted if no paravisor is present.
+	 * hyperv_pcpu_arg, which is decrypted if no paravisor is present.
 	 *
 	 * A TDX VM with the paravisor uses hv_hypercall_pg for most hypercalls,
 	 * which are handled by the paravisor and the VM must use an encrypted
-	 * input page: in such a VM, the hyperv_pcpu_input_arg is encrypted and
+	 * input page: in such a VM, the hyperv_pcpu_arg is encrypted and
 	 * used in the hypercalls, e.g. see hv_mark_gpa_visibility() and
 	 * hv_arch_irq_unmask(). Such a VM uses TDX GHCI for two hypercalls:
 	 * 1. HVCALL_SIGNAL_EVENT: see vmbus_set_event() and _hv_do_fast_hypercall8().
 	 * 2. HVCALL_POST_MESSAGE: the input page must be a decrypted page, i.e.
-	 * hv_post_message() in such a VM can't use the encrypted hyperv_pcpu_input_arg;
+	 * hv_post_message() in such a VM can't use the encrypted hyperv_pcpu_arg;
 	 * instead, hv_post_message() uses the post_msg_page, which is decrypted
 	 * in such a VM and is only used in such a VM.
 	 */
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 3e7d681ff2b7..c8bd40b797ba 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -60,7 +60,7 @@ int hv_post_message(union hv_connection_id connection_id,
 	/*
 	 * A TDX VM with the paravisor must use the decrypted post_msg_page: see
 	 * the comment in struct hv_per_cpu_context. A SNP VM with the paravisor
-	 * can use the encrypted hyperv_pcpu_input_arg because it copies the
+	 * can use the encrypted hyperv_pcpu_arg because it copies the
 	 * input into the GHCB page, which has been decrypted by the paravisor.
 	 */
 	if (hv_isolation_type_tdx() && ms_hyperv.paravisor_present)
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 895448954f37..712937c97fee 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -58,11 +58,8 @@ EXPORT_SYMBOL_GPL(hv_vp_index);
 u32 hv_max_vp_index;
 EXPORT_SYMBOL_GPL(hv_max_vp_index);
 
-void * __percpu *hyperv_pcpu_input_arg;
-EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
-
-void * __percpu *hyperv_pcpu_output_arg;
-EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
+void * __percpu *hyperv_pcpu_arg;
+EXPORT_SYMBOL_GPL(hyperv_pcpu_arg);
 
 static void hv_kmsg_dump_unregister(void);
 
@@ -95,11 +92,8 @@ void __init hv_common_free(void)
 	kfree(hv_vp_index);
 	hv_vp_index = NULL;
 
-	free_percpu(hyperv_pcpu_output_arg);
-	hyperv_pcpu_output_arg = NULL;
-
-	free_percpu(hyperv_pcpu_input_arg);
-	hyperv_pcpu_input_arg = NULL;
+	free_percpu(hyperv_pcpu_arg);
+	hyperv_pcpu_arg = NULL;
 
 	free_percpu(hv_synic_eventring_tail);
 	hv_synic_eventring_tail = NULL;
@@ -294,11 +288,6 @@ static void hv_kmsg_dump_register(void)
 	}
 }
 
-static inline bool hv_output_page_exists(void)
-{
-	return hv_root_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
-}
-
 void __init hv_get_partition_id(void)
 {
 	struct hv_output_get_partition_id *output;
@@ -376,14 +365,8 @@ int __init hv_common_init(void)
 	 * (per-CPU) hypercall input page and thus this failure is
 	 * fatal on Hyper-V.
 	 */
-	hyperv_pcpu_input_arg = alloc_percpu(void  *);
-	BUG_ON(!hyperv_pcpu_input_arg);
-
-	/* Allocate the per-CPU state for output arg for root */
-	if (hv_output_page_exists()) {
-		hyperv_pcpu_output_arg = alloc_percpu(void *);
-		BUG_ON(!hyperv_pcpu_output_arg);
-	}
+	hyperv_pcpu_arg = alloc_percpu(void  *);
+	BUG_ON(!hyperv_pcpu_arg);
 
 	if (hv_root_partition()) {
 		hv_synic_eventring_tail = alloc_percpu(u8 *);
@@ -477,33 +460,28 @@ void __init ms_hyperv_late_init(void)
 
 int hv_common_cpu_init(unsigned int cpu)
 {
-	void **inputarg, **outputarg;
+	void **inputarg;
 	u8 **synic_eventring_tail;
 	u64 msr_vp_index;
 	gfp_t flags;
-	const int pgcount = hv_output_page_exists() ? 2 : 1;
+	const int pgcount = HV_HVCALL_ARG_PAGES;
 	void *mem;
 	int ret = 0;
 
 	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
 	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
 
-	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_arg);
 
 	/*
-	 * The per-cpu memory is already allocated if this CPU was previously
-	 * online and then taken offline
+	 * hyperv_pcpu_arg memory is already allocated if this CPU was
+	 * previously online and then taken offline
 	 */
 	if (!*inputarg) {
 		mem = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
 		if (!mem)
 			return -ENOMEM;
 
-		if (hv_output_page_exists()) {
-			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
-			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
-		}
-
 		if (!ms_hyperv.paravisor_present &&
 		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
 			ret = set_memory_decrypted((unsigned long)mem, pgcount);
@@ -517,13 +495,13 @@ int hv_common_cpu_init(unsigned int cpu)
 
 		/*
 		 * In a fully enlightened TDX/SNP VM with more than 64 VPs, if
-		 * hyperv_pcpu_input_arg is not NULL, set_memory_decrypted() ->
+		 * hyperv_pcpu_arg is not NULL, set_memory_decrypted() ->
 		 * ... -> cpa_flush()-> ... -> __send_ipi_mask_ex() tries to
-		 * use hyperv_pcpu_input_arg as the hypercall input page, which
+		 * use hyperv_pcpu_arg as the hypercall input page, which
 		 * must be a decrypted page in such a VM, but the page is still
 		 * encrypted before set_memory_decrypted() returns. Fix this by
 		 * setting *inputarg after the above set_memory_decrypted(): if
-		 * hyperv_pcpu_input_arg is NULL, __send_ipi_mask_ex() returns
+		 * hyperv_pcpu_arg is NULL, __send_ipi_mask_ex() returns
 		 * HV_STATUS_INVALID_PARAMETER immediately, and the function
 		 * hv_send_ipi_mask() falls back to orig_apic.send_IPI_mask(),
 		 * which may be slightly slower than the hypercall, but still
@@ -555,9 +533,8 @@ int hv_common_cpu_die(unsigned int cpu)
 {
 	u8 **synic_eventring_tail;
 	/*
-	 * The hyperv_pcpu_input_arg and hyperv_pcpu_output_arg memory
-	 * is not freed when the CPU goes offline as the hyperv_pcpu_input_arg
-	 * may be used by the Hyper-V vPCI driver in reassigning interrupts
+	 * The hyperv_pcpu_arg memory is not freed when the CPU goes offline as
+	 * it may be used by the Hyper-V vPCI driver in reassigning interrupts
 	 * as part of the offlining process.  The interrupt reassignment
 	 * happens *after* the CPUHP_AP_HYPERV_ONLINE state has run and
 	 * called this function.
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 504c44b1ab9e..a73ddee6d322 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -67,8 +67,7 @@ extern bool hv_nested;
 extern u64 hv_current_partition_id;
 extern enum hv_partition_type hv_curr_partition_type;
 
-extern void * __percpu *hyperv_pcpu_input_arg;
-extern void * __percpu *hyperv_pcpu_output_arg;
+extern void * __percpu *hyperv_pcpu_arg;
 
 u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 u64 hv_do_fast_hypercall8(u16 control, u64 input8);
@@ -155,9 +154,6 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
  * Hypercall input and output argument setup
  */
 
-/* Temporary mapping to be removed at the end of the patch series */
-#define hyperv_pcpu_arg hyperv_pcpu_input_arg
-
 /*
  * Allocate one page that is shared between input and output args, which is
  * sufficient for all current hypercalls. If a future hypercall requires
-- 
2.25.1


