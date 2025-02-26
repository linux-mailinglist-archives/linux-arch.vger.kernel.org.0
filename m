Return-Path: <linux-arch+bounces-10392-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DE9A46C0C
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 21:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB3D3B2915
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 20:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6912F25EFB9;
	Wed, 26 Feb 2025 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGzWV2vQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749382561D6;
	Wed, 26 Feb 2025 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600391; cv=none; b=ce3J65CyxrlttIZc7p4EBAd7NwVJ+1UfL/1bNjiCTVn1JB7kMkkdEPNg6sm8NjAMrcpwBzDUAfHeY2q9YdbtfA18NcJNoO/eBMryOsyhBPr4rGpWw1R/94e1CdPppLCXtCFgMBCwKJH63r4YcGLqootsRKOy4FLlJ9qRlEiMpZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600391; c=relaxed/simple;
	bh=t7eiL7YZuyBFsdO9Fyr9zI0CWzs9OjCk+7iblQ/Zd2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KglOuOFbFfWG3HgYNKCDtXsj0WW+ZLPDAXjkr60IzISTBJ8d/vRguOzk+a4Ceo4qqhYC0qZPlRS/TuDQX4Guaxp5LhZW8WxYgGL1M4mkGwKpzHcQmE8nEb78EKw432G35Pw0QdimSbyba+eYDL+ZFPpBm2xKjsKvA99VS5RSIfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGzWV2vQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22185cddbffso23746455ad.1;
        Wed, 26 Feb 2025 12:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740600389; x=1741205189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=55rg1NeeMLGrUg0GStDtbSRwVMFym0JITZgogy/cZRs=;
        b=nGzWV2vQhHsjsooY6g0sGrbafZ/hIK/f4WCvrhW5CC8Y9brdoSoeVTvUSi1iXzRLBQ
         ulZBKECjRn+VeuLxz/sKYd37v5N3lT28TxzOGUtBHlH4Ko5zfmCmd5K1PirEafMYAOva
         Q4ZB1sWYxQss1XSk7fkx+3PQF59ZyaT+SH0QPiE7SKv8bd53QrvbtNmFb5E///q+R/B9
         epZTI/ViYXbyQEZae8T+OacWZHLDQRiLUKoGPKqdWb3tD+YLHjnAqcNM4LX1mv79jJiS
         wV5x0cycP4m8mPpnHm9FxKpwX0HTfYOOyZzzxrnCophwOLL8vUGVrmK+FsPDBcw8aL2l
         Aqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740600389; x=1741205189;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55rg1NeeMLGrUg0GStDtbSRwVMFym0JITZgogy/cZRs=;
        b=MBwwJs0zA3brxUVW40y6oYIoxzPeeU0vEkW0ZKhx89lc6djnpllqP55yjVXnL9PtKN
         s2v9gwzb31SKhjk9NqyhHlANEl4bJWcqrOlBrl/6jeB5bkO55pRTLL+bzpOB/vKyuYok
         gwDwpEo2fJ/ee4Tqb7pCvSsAA18jt+t86KdcJ453LyT7cfCRqqdh4dty39mVEmk6Ykl7
         q4fkoVpM2yFwlavoqVElTQgjsgOcHo25l8JDpUIKtIYsBeFFAUo1wsZfeqSTDjMJ6U1c
         Zs5mC+mSBKKQklEGICWMPfk4iRc16XixJiUAIwGez02HiuDv5HbG7LkpnEkNcf194Ik+
         BKyg==
X-Forwarded-Encrypted: i=1; AJvYcCUhDOoB5PdeLF+0TDIa17QwCjppmP1iUx6EKNxsEfhSQst7OiEPBl0qEDwX6UGv+kcdtUmDsyHhfJEGNVMh@vger.kernel.org, AJvYcCUnERO4mY+rKIpVnk+QzeoakNvkPh3SJOrAhw1zQGqGGLnO1jWFj0QrJIfqBVPvs7Qar7tC5DOjKTor@vger.kernel.org, AJvYcCXHNqnceO4HeLBDYOnoiWRfhC4bxhgViobtrRFXxsy8GHHQ/EdddDihK+B9HQdRCpwfCGX/oNoxbWes@vger.kernel.org, AJvYcCXUlhXYnzh3BKASspHgEj9szT7X3uBkSm2V1uJDpdouLYptwtZaS2QIES0h6lObh/nTB1NJ+IZ4ZH86MIXW@vger.kernel.org
X-Gm-Message-State: AOJu0YxcKaLI19wOOnjdk/9qAtT2S/JlQVwXuY4FL/wON67D3BWUk2DV
	s5vJa89dd+s3G0/rPHpHU1dUNULPeelD8f90cMs1ps7pntzm+9ZB
X-Gm-Gg: ASbGnct72AKFq9jEkte02aGz+gCwE0vGZyadlJdXOkkUNaJyo7wbxkqqvIy+qN4ouet
	VM4K71BXJCXL1qOoCGBNXsUXF9A3ipuZ+MNw8iIvUHj/7eq1AmoG94DTq4Ru9V/hu5PAmXEVrFj
	LIB4WA3wyYmGfj7ZI8rQjFHJD1X8SzXwdd8Zv19OucVSW0CjSsH3gd+em7WbwYiz5jiRKobIxVL
	WlPmS8NRZnLDbmbTU5mfRctuFmKLNKK/mGDiAUtPNcWMY1ftoLrnwZtegIavsWHHG389TS01KBC
	BwlO1ty8dauYbAkziNylx33clQox0jVktdBNYKyuKhttBzS9wEHc9RPKG59VfqJQtTpaui51kSZ
	dc+WY
X-Google-Smtp-Source: AGHT+IFfPHpLZQ4zp9jwd0HYPB//Ggor8yNfHICfLG5CBu7602xlko+J7WgrZ2Gftb+NHiZOSj9wFQ==
X-Received: by 2002:aa7:8207:0:b0:734:26c6:26d3 with SMTP id d2e1a72fcca58-7349d1ec1a1mr1094802b3a.5.1740600388527;
        Wed, 26 Feb 2025 12:06:28 -0800 (PST)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81bbc7sm3959455b3a.127.2025.02.26.12.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:06:28 -0800 (PST)
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
Subject: [PATCH 7/7] Drivers: hv: Replace hyperv_pcpu_input/output_arg with hyperv_pcpu_arg
Date: Wed, 26 Feb 2025 12:06:12 -0800
Message-Id: <20250226200612.2062-8-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226200612.2062-1-mhklinux@outlook.com>
References: <20250226200612.2062-1-mhklinux@outlook.com>
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
index c5c9511cb7ed..c701d7601f48 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -482,16 +482,16 @@ void __init hyperv_init(void)
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
index d98e83b4a6fd..cdd5dcbdee4e 100644
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
index 0c8a9133cf1a..2f94020b4633 100644
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


