Return-Path: <linux-arch+bounces-12853-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CD2B09AC9
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 06:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E5927B7530
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 04:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E6D217719;
	Fri, 18 Jul 2025 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAD+mSg2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92F220B7FE;
	Fri, 18 Jul 2025 04:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752814568; cv=none; b=lLDi36uChCUbsvoZA0us8ymCkdrtnoKJg3O3KMmLZh4juJAY4zpIZOjiWqFXNrsAj8qGFy7srMRBS6SKKJN7UQQ+hAJ6RRTnrrFvRQ6rqYqn/aaRmsdAd0HhZSKkIF3sj5X0DoKn6z2YfpQ1HqyS3IajILPrphFl4PH34QsIRCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752814568; c=relaxed/simple;
	bh=qWNTk3s5NMApXRRxOjCX+WO/fKr3OFV7Wg0UAiRzQiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TijvBLiyoaGSeqhXJnX4ks7MxSIV2KygQ9mbqsUOoNQoiPEPBaxrbY7FTLsMtkAJp9EQebaypr+WS4zHqfRTqsh1jhtpnKHJrEXYzU66ftalbyTqE5oatlNRUfg3FsxfZuR8jrP5H22mQuEWLxQy0YzYRqYdryudrWvF7eVqHzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAD+mSg2; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3be5c0eb99so1326313a12.1;
        Thu, 17 Jul 2025 21:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752814566; x=1753419366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aiqelOOvokSP2vkZ7DaRUC0h4xNTtXyC0hk2XiiiVRw=;
        b=MAD+mSg2VvMCII/xudgNR6JWR843jI3mrEswkr4fKeKlCzTBO2oqaF5Zonti+y3kiY
         j1Xv/drxuxV3Ro0xhgd8CXwzQgWApJWRkaRNkll7iXl6Kvl70eY+6PdXzazGKFOs3Ey0
         9Tu5cxamq4KHD8SDKnGh7dUME50St60fKRjRQbfiRggv5WXZmFtp1DAglh9N3UjTkiYM
         /VqAZJQdkHYHakllpFB5GCg5Eb+ciAuIyhgHixMdSg8YN440zNLa72cEvIKSxEJ5u68e
         C1/bW6YL15a6V8Bi89CYIGyyBYGl/QWCGEb6uegIDAMZKr1r1NUiwizWFr2x8aPP8DsG
         YsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752814566; x=1753419366;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aiqelOOvokSP2vkZ7DaRUC0h4xNTtXyC0hk2XiiiVRw=;
        b=R93ZyAbwI7ApNDSiouC9hIhnDgH039V5ojHCfWyfJFRWMmXouLxFmPldx4JwWHoQCA
         KyFl6gTAb/ZeEKCo5hhyTFIxr81YViHsrI9kYLGNgJGsJsxDTmkNrPyudU6rp1ZGlcbE
         dlpRYBFPaXf9Ce1zoBfrlas/soZiVqNA3J/kI73AfqVRurdIXoeBCTq5HQ6b0Vs2JqO2
         Bc0VpNp50U7vvTxE5ni9aDuwh+cGXkSZe4WJLkeJwrQUga9bqWtey8LIt3w0QCcpE1xZ
         S2ijgZtcVIcEmC1LBVoZQRrCgQlM7iVsjkQ+gZdqHKU/hrc+BpHjlO2Klvxblgcjkc46
         xauQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5s91JZou9XBQZZWNb/RBOZnP34/qnqkmJjXdHs01b/lmRdPxBWeVOpcdLqTjpk91PVGByTmq+RcDfhngU@vger.kernel.org, AJvYcCUkpNH5zlLk8BoLE+F1k5fjAa3PAADBzEt0+N9NOgTTQy8tGhlK5W96YCe4khp/q2BT6CmHT8NMtXBG@vger.kernel.org, AJvYcCWPYyGkgxOfNaWGz2STsV6fq/++BZhrdXEov3qFs73lgDsph5sgBz4M2VxGRWXkq9K2FmHqHJOGAftQ@vger.kernel.org, AJvYcCXwPxzvD6m4AanXXsDtsCnPr5MzrMfHabiiiwktDsHYKn76rAZRP9gZ24JBlP0KYbyBym84H76SFhcle0hE@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQZfiGZ/SszFY2aab+2XKNzAmz1uegYFEtde8enHbcGAYtQQR
	37W9h5s0IljjafJ/lg8cVCvNa3+Erh5vad/UKLxCLsWgvw8lmBho3eQU
X-Gm-Gg: ASbGncuLAggrKN/Wr4I67IX0CURDOpVgZ23nLVst3znuxfsp4bj7ECOPbfKdvnVgVyi
	6LCVjG1Cw52dXYPpYLu2CAM715CCauFy045kLtJ1L+59IIoi1msdrwa5axJLcLy0epMnJSmZsGV
	Vr8plqYqnBmkcwrojdcHcyRmV+2U4LJ30p5nM3iKbm9HNAXbRT41tQrVB1Z8L82Wsb3whWpbQP7
	TkfPdOxL4hlgQ3v9sP4JFcc06AO47cL0cAMwUfmC/8u3DGCr3+hjsQbXoiREKbgGX8LgnWP7X9u
	eilirqMimr+7iq6GGYJ42G0u0NnoiUVLGV8DlZa8MT0cVc5NWCKHAOi95e3ikU0kDzMn91pclXa
	UER2U+ykLKtRRehraICAV/nMwD6ZwnBHoKdWk/Qq7DguZkU7BLikNZATXfW21I47fhTGdAuGjrN
	CSUQ==
X-Google-Smtp-Source: AGHT+IGDjq2DhqSuXgN/POALmXPVtNVWI+Et+6g2VTK4Goj/AQzWa3UeW+fqHh7e9/h5vhGmctCDVQ==
X-Received: by 2002:a17:90b:1c04:b0:312:e9bd:5d37 with SMTP id 98e67ed59e1d1-31cc2515a29mr2420920a91.6.1752814565898;
        Thu, 17 Jul 2025 21:56:05 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc33715b2sm476907a91.24.2025.07.17.21.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 21:56:05 -0700 (PDT)
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
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de
Cc: x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v4 7/7] Drivers: hv: Replace hyperv_pcpu_input/output_arg with hyperv_pcpu_arg
Date: Thu, 17 Jul 2025 21:55:45 -0700
Message-Id: <20250718045545.517620-8-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250718045545.517620-1-mhklinux@outlook.com>
References: <20250718045545.517620-1-mhklinux@outlook.com>
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
have been replaced by hv_setup_*() functions. So combine
hyperv_pcpu_input_arg and hyperv_pcpu_output_arg in a single
hyperv_pcpu_arg. Remove logic for managing a separate output arg. Fixup
comment references to the old variable names.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/hyperv/hv_init.c      |  6 ++--
 drivers/hv/hv.c                |  2 +-
 drivers/hv/hv_common.c         | 55 ++++++++++------------------------
 drivers/hv/hyperv_vmbus.h      |  2 +-
 include/asm-generic/mshyperv.h |  6 +---
 5 files changed, 22 insertions(+), 49 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index b7a2877c2a92..2979d15223cf 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -453,16 +453,16 @@ void __init hyperv_init(void)
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
index ad063f535f95..3b5dfdecdfe7 100644
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
index ae56397af1ed..cbe4a954ad46 100644
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
@@ -255,11 +249,6 @@ static void hv_kmsg_dump_register(void)
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
@@ -365,14 +354,8 @@ int __init hv_common_init(void)
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
@@ -466,33 +449,28 @@ void __init ms_hyperv_late_init(void)
 
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
@@ -506,13 +484,13 @@ int hv_common_cpu_init(unsigned int cpu)
 
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
@@ -544,9 +522,8 @@ int hv_common_cpu_die(unsigned int cpu)
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
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 0b450e53161e..bef8a57100ec 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -126,7 +126,7 @@ struct hv_per_cpu_context {
 	/*
 	 * The page is only used in hv_post_message() for a TDX VM (with the
 	 * paravisor) to post a messages to Hyper-V: when such a VM calls
-	 * HVCALL_POST_MESSAGE, it can't use the hyperv_pcpu_input_arg (which
+	 * HVCALL_POST_MESSAGE, it can't use the hyperv_pcpu_arg (which
 	 * is encrypted in such a VM) as the hypercall input page, because
 	 * the input page for HVCALL_POST_MESSAGE must be decrypted in such a
 	 * VM, so post_msg_page (which is decrypted in hv_synic_alloc()) is
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 040c4650f411..3ce5b94ad41e 100644
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


