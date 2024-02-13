Return-Path: <linux-arch+bounces-2294-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B158530C9
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 13:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED401C262AD
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 12:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61D754BDE;
	Tue, 13 Feb 2024 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OI+Sua7s"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F935477C
	for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828147; cv=none; b=cDPwEuMFoDXT+TqU8Qtj/d3vdXGUIr0NA0wvzPpykyO5pp4D5vC3n6hghEX4IvJIMWPR9kkkz2oMjB1Hn2HGAaXAzNMZ4kTjz9pVXi0iDUZQhAbhlqH4ftFxENY6KZJ2pMR09zLV9fcLuEs+UMNIA3ji0KfYAmkBQU1QdlKV7Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828147; c=relaxed/simple;
	bh=CKqAkVncBI5L3gG4K3ZJpuo/XUJZHNhpt3gf71HxdC0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oVktY0urBTwpGY6u7SzFaplwWehTLYu614ujFrFJtP9O/gwWqtjPnl8R3O9XjpQrSefTAWaTtEIbo0cLfMKT1zuc46xutdvC4haqd0PbFWsuKVrD8evmkb1nFMtF3yhBRBPY34GiuRIfRVq6PTntj39MNrUyYkAmhgLL+8eBFAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OI+Sua7s; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33b248e7cd7so1943909f8f.2
        for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 04:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707828144; x=1708432944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDwWzx+ZIZln/anz+aVU2C0rhpdbzTDoyUXdax0Fzpk=;
        b=OI+Sua7sUU4PKsaALvZwj2d7Pgsbhjr0vEAw1fcZi6Ri16fqRDSrHNTYge2vXXccys
         lpqEhTLKSaAgJvDmFyaS1UEpMFvKf/+wvHY0Jc+hrYxjC3wnQw6PXJn5b5Umtfn3Cnhj
         9CJiAbzOS+1E1xZGhCFjkh030z+n6gjc0WdNkqYthCIbwwuDFQOYQNLD+IoAEMmV7X4W
         FxOs8nzpZOeRO3ul6251ZnXRHfTPcGCPqNTIjZ1WAmF9WkIQVHCedGh8MxdGb3ZIS9IA
         kJmyN5ElWVvs9RLpf1NQ7v76PsPYsgsCKX+L5ORsp2rTKk5XdVYD6B2ETaVU1R7fm5aB
         Srqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828144; x=1708432944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDwWzx+ZIZln/anz+aVU2C0rhpdbzTDoyUXdax0Fzpk=;
        b=ITmnaZ8KlvtPBNYifa4mrTf0Uzyjic6fEk2Tvpvzu5AA928Vg3iAPIZyWIUaOwqNiX
         O/rzlMdJzyvyYrjufnUYraaxwrFcG361Q6DAB4aLtBP55KGPQ2em4PnLtUzzYWZsFNDe
         Enrld8tvcK3UBYh43VBvcmKoeYVmPNaAPmwHPDluoQ3DV4xlq7KYPn+NdO/lQhq/w8hK
         i0o0ovToSHti1Cn9M2U4DibsMIAwVaiRyvpsyBtaOLuAujSggwo+hDAYkiYfBb0bVYQD
         gwfIINJmKWXo+VuC4qYJwWO79K/Xxfzax6m4j2gxuo4Sjkq7txzb8X8iH5p4muTQKCmo
         Ccxw==
X-Gm-Message-State: AOJu0Yx0usg8YzYBc7E4uPxc0ndY6DJWG2+7obI94u/EgoGFEzA6PH7E
	eHpRvqzLT0YY5uaDpFE9HcjTxmLkhpiGkMqJqHOwWgdDgzWEcY4Mt9UtbuxPSRmrVEI1CA==
X-Google-Smtp-Source: AGHT+IHSV6JRPngXNxgsCyiTI5ulNMX4UUy9LGBYPjfqO6WaGi2ScdMvc49dEboUwE8/HxMYXky24lfR
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:1753:b0:33b:5e9f:c62e with SMTP id
 m19-20020a056000175300b0033b5e9fc62emr31121wrf.0.1707828144184; Tue, 13 Feb
 2024 04:42:24 -0800 (PST)
Date: Tue, 13 Feb 2024 13:41:54 +0100
In-Reply-To: <20240213124143.1484862-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7378; i=ardb@kernel.org;
 h=from:subject; bh=2k7RKXQoIArwBAJHl4Eso59xaiH+DoTxxKoPT8FFXXc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfV08mQmR4fd8z7E76yaGqsvWu+xtGCDSmZwRVt3ZkcSQ
 23ygpSOUhYGMQ4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJGXcxj+F1rbm+Ys9sk+liz3
 Najh2WTd8973Vi88d7rsM/8CHi3No4wMfYv09jxksrsQ/uDhXafWzeYaO5tW/jDyaTO8tF5Akuc XOwA=
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213124143.1484862-23-ardb+git@google.com>
Subject: [PATCH v4 10/11] x86/sev: Move early startup code into .head.text section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In preparation for implementing rigorous build time checks to enforce
that only code that can support it will be called from the early 1:1
mapping of memory, move SEV init code that is called in this manner to
the .head.text section.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c |  3 +++
 arch/x86/include/asm/sev.h     | 10 ++++-----
 arch/x86/kernel/sev-shared.c   | 23 +++++++++-----------
 arch/x86/kernel/sev.c          | 14 +++++++-----
 4 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 073291832f44..bea0719d70f2 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -116,6 +116,9 @@ static bool fault_in_kernel_space(unsigned long address)
 #undef __init
 #define __init
 
+#undef __head
+#define __head
+
 #define __BOOT_COMPRESSED
 
 /* Basic instruction decoding support needed */
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index bed95e1f4d52..cf671138feef 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -213,16 +213,16 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 struct snp_guest_request_ioctl;
 
 void setup_ghcb(void);
-void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
-					 unsigned long npages);
-void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
-					unsigned long npages);
+void early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+				  unsigned long npages);
+void early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+				 unsigned long npages);
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
 void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
-void __init __noreturn snp_abort(void);
+void __noreturn snp_abort(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index ae79f9505298..0bd7ccbe8732 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -93,7 +93,8 @@ static bool __init sev_es_check_cpu_features(void)
 	return true;
 }
 
-static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
+static void __head __noreturn
+sev_es_terminate(unsigned int set, unsigned int reason)
 {
 	u64 val = GHCB_MSR_TERM_REQ;
 
@@ -330,13 +331,7 @@ static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid
  */
 static const struct snp_cpuid_table *snp_cpuid_get_table(void)
 {
-	void *ptr;
-
-	asm ("lea cpuid_table_copy(%%rip), %0"
-	     : "=r" (ptr)
-	     : "p" (&cpuid_table_copy));
-
-	return ptr;
+	return &RIP_REL_REF(cpuid_table_copy);
 }
 
 /*
@@ -395,7 +390,7 @@ static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 	return xsave_size;
 }
 
-static bool
+static bool __head
 snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
@@ -532,7 +527,8 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
  * should be treated as fatal by caller.
  */
-static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+static int __head
+snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
@@ -574,7 +570,7 @@ static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_le
  * page yet, so it only supports the MSR based communication with the
  * hypervisor and only the CPUID exit-code.
  */
-void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
+void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int subfn = lower_bits(regs->cx, 32);
 	unsigned int fn = lower_bits(regs->ax, 32);
@@ -1025,7 +1021,8 @@ struct cc_setup_data {
  * Search for a Confidential Computing blob passed in as a setup_data entry
  * via the Linux Boot Protocol.
  */
-static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
+static __head
+struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
 {
 	struct cc_setup_data *sd = NULL;
 	struct setup_data *hdr;
@@ -1052,7 +1049,7 @@ static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
  * mapping needs to be updated in sync with all the changes to virtual memory
  * layout and related mapping facilities throughout the boot process.
  */
-static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
+static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 {
 	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
 	int i;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1ef7ae806a01..33c14aa1f06c 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -25,6 +25,7 @@
 #include <linux/psp-sev.h>
 #include <uapi/linux/sev-guest.h>
 
+#include <asm/init.h>
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
 #include <asm/sev.h>
@@ -682,8 +683,9 @@ static u64 __init get_jump_table_addr(void)
 	return ret;
 }
 
-static void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
-				  unsigned long npages, enum psc_op op)
+static void __head
+early_set_pages_state(unsigned long vaddr, unsigned long paddr,
+		      unsigned long npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
@@ -739,7 +741,7 @@ static void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 }
 
-void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
 					 unsigned long npages)
 {
 	/*
@@ -2062,7 +2064,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
  *
  * Scan for the blob in that order.
  */
-static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
+static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -2088,7 +2090,7 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 	return cc_info;
 }
 
-bool __init snp_init(struct boot_params *bp)
+bool __head snp_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -2110,7 +2112,7 @@ bool __init snp_init(struct boot_params *bp)
 	return true;
 }
 
-void __init __noreturn snp_abort(void)
+void __head __noreturn snp_abort(void)
 {
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
-- 
2.43.0.687.g38aa6559b0-goog


