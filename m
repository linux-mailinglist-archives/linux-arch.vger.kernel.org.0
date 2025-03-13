Return-Path: <linux-arch+bounces-10702-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236A5A5EBAF
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 07:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15E6B7AA930
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 06:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874981FCD04;
	Thu, 13 Mar 2025 06:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzD35sGe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D861FC7D7;
	Thu, 13 Mar 2025 06:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741846775; cv=none; b=bnXrSy6ClJo0i/YPbg1YoN/ChVFu5UaJk0ePv6yFgIJG4+0oi7uUjD1QPRWYBq3pMugpCqdx0rpyXTmB646pnhabVyd247WzA0hGgKEu+IMDFySmw2BlXGXrjOpPK8B6eKlPgfWmXWmr4gIVF+eRfoTry7xPnMPVdeGLImZUJTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741846775; c=relaxed/simple;
	bh=D9tV1fNaeEavI8kgVzOD/UPEqZFk3aiyKOW25HgURJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KXJ/mGMSqNO7VkOOJ+lL4j3THRmZHAgqvOk5CVXkUUUMRdfHCpy8Gwz1MID6F+BYapdfCY8d3+DuIeEj3p9nG+OheFrpgmQfWkXtt9HkBXmtkAO/2Ldy2kldsJGMTU+5sTUtQlGmkfiUKMMGdlO9TgyhpqBL22wQpVvL+KliPvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzD35sGe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22398e09e39so10722505ad.3;
        Wed, 12 Mar 2025 23:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741846773; x=1742451573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CDn/tUUQAJnXzR6AU14kpCd/xpQ2+Hi/FbJxM9Yhnsk=;
        b=FzD35sGe2L+1OFo0A9e7kwBbR2WfOT2WqVrnpnUocSgu+TdKMeOXwoxRKAXotrHejM
         P/Khbaqp9yQ7woi/z6efigVjjf2U8cZmVdOWHCmWtb/Tjxl2vagGEHN/BvKR5M/tIVA/
         SXGBRYICJafyMyTlKhEgoPN4zeeZ8BjGQOxiYR/TGrYynRERjUaSQVg747YCdZXiFRA9
         WjT7/fL2yq3rfTL6NQGMpeK6bDjbRUuNGMFAqZ/y9+bBS8HHa9yOR/64rzXya/uMG4q2
         5Qr1/EEukRJIRNsRylggSWpX82eDrHqGrwOWTsKIsiiesq94212fRjM36MWQj3tQk34Z
         e2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741846773; x=1742451573;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CDn/tUUQAJnXzR6AU14kpCd/xpQ2+Hi/FbJxM9Yhnsk=;
        b=O7/BbZHdsHh+NC+9AXvZgoB+hZbzyFfq2GOjOOpTi+1EX+zY/1N9esCcmhbiwySZM4
         lP0RGj+9WrfMAF9vqU2KlaZSP3IbQKk6RsKbFSN1kkEPQRH1KiMZ5poCYSe1KLTOceO6
         uDQmG6j1Xkz7ypmiYXRk+NBnuTvxl1vtfmlguko3ZvY4TVa6CW66GAOmhs4jaa0hbw1K
         pADQP1FZXtejW0m1bx3AbIEGgF7WqFPuRL4GfHptnHw1yvHldSZDIUkDOBkp4461Fp+v
         KhWpWQRVYwHT9TRz57zgFAm/EYtiHEGBS6fNUHfbbzup6W/gBLC2G+ffYb692QUJE3Ye
         4+GA==
X-Forwarded-Encrypted: i=1; AJvYcCU1HSD3WoQh1zHKMhhDCJkPqMFASJE3f4BLL4RD3oV7Vyox/hF3xygMVnwUZG46WQ2828nLwfoDB5kbUhxJ@vger.kernel.org, AJvYcCVZY8CFRDUY3r72TBkqzalmFLGKDo5X+Z65waooPipSRIPyhK6Fu++5NSlmSfINzPcUsYPskUaMpYR/@vger.kernel.org, AJvYcCVi7EQdchalDdb9SICCUnpg6S9ANr7j0nH3HymGaTu/OGr/jgsu/tKH7q29teAWvWogbMBPwuujUB2Z@vger.kernel.org, AJvYcCW623LgNdhMCTYRhYT8VEHwnl4G2gY9S2M/aNDbOxfTrjJkQOkeiWNzhKl6KiDn5XQ06WrHp2Gsd2I7YH/F@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+NF+8JOhR2ooqde2gaJiF60Ko67m6yVPWPp2psDD7qj3UfkvC
	MLRKhHfBN8q1KasWOrHMpf3GGtrLjXxIS7cRcHrEd9eIlg+gfUWK
X-Gm-Gg: ASbGncvKgRXNpstgFslxzPQKwewga0fsdp5xMbWPyGto0VQSZHcpH79h1GoTryyNDHq
	aPECPr8K7A5xjNc7vwLqsBHKUUTxNObT8KxH1s0wUE1rW28UBQC5/dVhI7ISTNmiZI4C56m+VWS
	tmOaEDH8cmeeoIpxDPVLofNkTAhOM+v0ojHSlUS16lZoT0RrNpoL9RPAyhkUYzZf3thh7FUdid4
	tjnTKi6uGdG+oKpOyPLET2B+tvgyn5p0KtKuVe4uIH+raG6I4MmTSymgb9xn7en9wLbofJ98Z0u
	xOMrwTSrHdJwM4ewbj/LhKZ7jccGrQdlDt2UH1WZoZQ4kQooRb/lccOWwydsaiVC+QEsQQ0eaht
	8EAXkLp6nw7ncRw0Foep8rOI=
X-Google-Smtp-Source: AGHT+IH82KRGe+NjN4a9AuNj2WKlUNAuqSAMKc4lgjdhO9N+B3gSv2uaj1xcoy9UNuuxNsOvBMDqHw==
X-Received: by 2002:a17:903:4407:b0:224:721:ed9 with SMTP id d9443c01a7336-22428c12cfdmr428144735ad.44.1741846772858;
        Wed, 12 Mar 2025 23:19:32 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68880dfsm5856985ad.38.2025.03.12.23.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 23:19:32 -0700 (PDT)
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
Subject: [PATCH v2 6/6] Drivers: hv: Replace hyperv_pcpu_input/output_arg with hyperv_pcpu_arg
Date: Wed, 12 Mar 2025 23:19:11 -0700
Message-Id: <20250313061911.2491-7-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250313061911.2491-1-mhklinux@outlook.com>
References: <20250313061911.2491-1-mhklinux@outlook.com>
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
index e2dcbc816fc5..854ef5d82807 100644
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
index a6b1cdfbc8d4..f3e219daf9fe 100644
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
 
@@ -85,11 +82,8 @@ void __init hv_common_free(void)
 	kfree(hv_vp_index);
 	hv_vp_index = NULL;
 
-	free_percpu(hyperv_pcpu_output_arg);
-	hyperv_pcpu_output_arg = NULL;
-
-	free_percpu(hyperv_pcpu_input_arg);
-	hyperv_pcpu_input_arg = NULL;
+	free_percpu(hyperv_pcpu_arg);
+	hyperv_pcpu_arg = NULL;
 }
 
 /*
@@ -281,11 +275,6 @@ static void hv_kmsg_dump_register(void)
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
@@ -363,14 +352,8 @@ int __init hv_common_init(void)
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
 
 	hv_vp_index = kmalloc_array(nr_cpu_ids, sizeof(*hv_vp_index),
 				    GFP_KERNEL);
@@ -459,32 +442,27 @@ void __init ms_hyperv_late_init(void)
 
 int hv_common_cpu_init(unsigned int cpu)
 {
-	void **inputarg, **outputarg;
+	void **inputarg;
 	u64 msr_vp_index;
 	gfp_t flags;
-	const int pgcount = hv_output_page_exists() ? 2 : 1;
+	const int pgcount = HV_HVCALL_ARG_PAGES;
 	void *mem;
 	int ret;
 
 	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
 	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
 
-	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_arg);
 
 	/*
-	 * hyperv_pcpu_input_arg and hyperv_pcpu_output_arg memory is already
-	 * allocated if this CPU was previously online and then taken offline
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
@@ -498,13 +476,13 @@ int hv_common_cpu_init(unsigned int cpu)
 
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
@@ -526,9 +504,8 @@ int hv_common_cpu_init(unsigned int cpu)
 int hv_common_cpu_die(unsigned int cpu)
 {
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
index 01e8763edc2c..015f87e35b5a 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -66,8 +66,7 @@ extern bool hv_nested;
 extern u64 hv_current_partition_id;
 extern enum hv_partition_type hv_curr_partition_type;
 
-extern void * __percpu *hyperv_pcpu_input_arg;
-extern void * __percpu *hyperv_pcpu_output_arg;
+extern void * __percpu *hyperv_pcpu_arg;
 
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
@@ -139,9 +138,6 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
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


