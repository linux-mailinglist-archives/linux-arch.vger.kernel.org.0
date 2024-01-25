Return-Path: <linux-arch+bounces-1576-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471A383C0F4
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 12:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BCA28ABCB
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 11:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0525675D;
	Thu, 25 Jan 2024 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o9rxPBZL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E9355795
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182391; cv=none; b=MJYyKLFpD1V/wcx3cxUZfrK9kNC/Mh8aER68B2NN6ypdafQzKnmsACjuQVXflrahyfh1j3zu9admJl0CuUdS5uXn1vwNEPFGXE+f2Z07CcI4c9MJYJe0oeIJekDsVCh1fmm5jMl6sgwJBiQhf8RbEwppD3h49BDz/XHqYfoHz2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182391; c=relaxed/simple;
	bh=i13AZ6vlGzK6PZ7ioBLkahjbrj9IBafL4dafK+/RwuI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PyChhWSwbldBvzrrwHIx2WksJ+b/A3A3Fxx0MB2cU6bc28hRTFXDLBA7/grILU+A+4BaGE39uQNS+Bv9kT+saWUKAGo8JtiMkMkysYFrtTG2Uiq+QU7liKXAKVIz/QcVsLG+wOY06BTwyGEvWFNdT3mCetZOd4t4Cg/fmChZwew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o9rxPBZL; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33921b95da8so4126673f8f.1
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 03:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706182387; x=1706787187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OB2IW1nCo9uLqanub4h0z041TKeK3DX8sIz1w6b+cd0=;
        b=o9rxPBZLK/GcgakL4l7qfM7kv0QYZDsjVFDDFfL5sip6AyIm5Npeu9VlVt46GjC04M
         CVS9Lz1E+2odSypQTQgFFu+++iYrXoyRHz4V4C+BCjWOqezxDXITkNcGY8DU5pL5p1XF
         XmNZiPKencNynBJy+RBW2XOhKBLYTs/4ypbtKZOQwPFYnjUWhNfWfS97Oej47MGA5WQA
         JaIZmoNl3y2XC10y9AuapSJLZWAoXARdZIggNuSa/Iazd9FmpQ4WnAfMfdUQcyW171Zm
         NbJrkU1OpYV7TT5MZcaiaj5drM3JB+0lsZ93AvQ/Z90Q4adiNnICbKLHIj8Rj3p7LWHb
         op/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182387; x=1706787187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OB2IW1nCo9uLqanub4h0z041TKeK3DX8sIz1w6b+cd0=;
        b=sOjrjBTBW7gPlBL0vU65g5SukcSEiLVmi0/aP2h42723sLj05paYG7GpNpkjzsWXRA
         y04fnC8kQyMPxzmw4UvMjbOGl5w1Wx3ChJES+GGELYH/ydkW2m7+65x1lWKz3cbHmuJj
         Ubdwtq+jujxhxmbckvlv63EAR7NEmw8EeBAbzW92swRrTJDlk2UtXCelOz6Fa2LjpqDh
         qmYggrKuebA+xSfSe0TbGkfhvQeWJaZ/BghBEmd14sQgo/7fvhkHuL6XkkOQLfnwal/D
         xPMXBhQ+mzJ/wAm666iFi7ZmVM+b3Bm4Ho3KrA4LoWeawVVwsWovFjJuZ0RhP+/2ccJX
         OBIw==
X-Gm-Message-State: AOJu0YwehqukDPwqWi4UpM7RqFwC3FBaTM5uKu0mkLdx5pR42MSMfxJn
	x9RxsemNxpRU5Kt68+/WW9FZKsUNC8R5cYpwEbBmFfQOgnU1PzDbMjoThqSuy5wfxOTkzA==
X-Google-Smtp-Source: AGHT+IHpHpLFhahpyGdJG6GA46hHyZSbZH2dVzflN5tDfdI1b9MnX4S3iK0GF03znkc1l/JIhzYBKGtX
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:1d89:b0:337:689e:6358 with SMTP id
 bk9-20020a0560001d8900b00337689e6358mr2607wrb.10.1706182387308; Thu, 25 Jan
 2024 03:33:07 -0800 (PST)
Date: Thu, 25 Jan 2024 12:28:32 +0100
In-Reply-To: <20240125112818.2016733-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=19087; i=ardb@kernel.org;
 h=from:subject; bh=hTH7IeEeDnitmVEmG1phWeF915Vntt3b+X6pDwpSBQU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWT6/c5uZWGey9vDn6gtdyuOt1pd/TaM2wFS37tufHpG
 1tEcuiajlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRS1UM/yz5T8x+cOn/veJf
 97dfM/5UmnyD49qJ4996FynbztWVy0tn+B91MzGMyzX11u8pUxs11/0SMLYQNBEJarpQbLt1nuY RL1YA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125112818.2016733-32-ardb+git@google.com>
Subject: [PATCH v2 13/17] x86/sev: Make all code reachable from 1:1 mapping __pitext
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

We cannot safely call any code when still executing from the 1:1 mapping
at early boot. The SEV init code in particular does a fair amount of
work this early, and calls into ordinary APIs, which is not safe.

So annotate all SEV code used early as __pitext and along with it, some
of the shared code that it relies on.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c     |  3 ++
 arch/x86/include/asm/mem_encrypt.h |  8 +--
 arch/x86/include/asm/pgtable.h     |  6 +--
 arch/x86/include/asm/sev.h         |  6 +--
 arch/x86/kernel/sev-shared.c       | 26 +++++-----
 arch/x86/kernel/sev.c              | 14 +++---
 arch/x86/lib/cmdline.c             |  6 +--
 arch/x86/lib/memcpy_64.S           |  3 +-
 arch/x86/lib/memset_64.S           |  3 +-
 arch/x86/mm/mem_encrypt_boot.S     |  3 +-
 arch/x86/mm/mem_encrypt_identity.c | 52 ++++++++++++++------
 arch/x86/mm/pti.c                  |  2 +-
 12 files changed, 81 insertions(+), 51 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 454acd7a2daf..22b9de2724f7 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -116,6 +116,9 @@ static bool fault_in_kernel_space(unsigned long address)
 #undef __init
 #define __init
 
+#undef __pitext
+#define __pitext
+
 #define __BOOT_COMPRESSED
 
 /* Basic instruction decoding support needed */
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 359ada486fa9..48469e22a75e 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -46,8 +46,8 @@ void __init sme_unmap_bootdata(char *real_mode_data);
 
 void __init sme_early_init(void);
 
-void __init sme_encrypt_kernel(struct boot_params *bp);
-void __init sme_enable(struct boot_params *bp);
+void sme_encrypt_kernel(struct boot_params *bp);
+void sme_enable(struct boot_params *bp);
 
 int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
 int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
@@ -75,8 +75,8 @@ static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
 
 static inline void __init sme_early_init(void) { }
 
-static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
-static inline void __init sme_enable(struct boot_params *bp) { }
+static inline void sme_encrypt_kernel(struct boot_params *bp) { }
+static inline void sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
 
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 9d077bca6a10..8f45255a8e32 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1412,7 +1412,7 @@ extern pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma,
  * Returns true for parts of the PGD that map userspace and
  * false for the parts that map the kernel.
  */
-static inline bool pgdp_maps_userspace(void *__ptr)
+static __always_inline bool pgdp_maps_userspace(void *__ptr)
 {
 	unsigned long ptr = (unsigned long)__ptr;
 
@@ -1435,7 +1435,7 @@ static inline int pgd_large(pgd_t pgd) { return 0; }
  * This generates better code than the inline assembly in
  * __set_bit().
  */
-static inline void *ptr_set_bit(void *ptr, int bit)
+static __always_inline void *ptr_set_bit(void *ptr, int bit)
 {
 	unsigned long __ptr = (unsigned long)ptr;
 
@@ -1450,7 +1450,7 @@ static inline void *ptr_clear_bit(void *ptr, int bit)
 	return (void *)__ptr;
 }
 
-static inline pgd_t *kernel_to_user_pgdp(pgd_t *pgdp)
+static __always_inline pgd_t *kernel_to_user_pgdp(pgd_t *pgdp)
 {
 	return ptr_set_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
 }
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 5b4a1ce3d368..e3b55bd15ce1 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -201,14 +201,14 @@ struct snp_guest_request_ioctl;
 void setup_ghcb(void);
 void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
 					 unsigned long npages);
-void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
-					unsigned long npages);
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
index 1d24ec679915..b432cac19d13 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -89,7 +89,8 @@ static bool __init sev_es_check_cpu_features(void)
 	return true;
 }
 
-static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
+static void __always_inline __noreturn sev_es_terminate(unsigned int set,
+							unsigned int reason)
 {
 	u64 val = GHCB_MSR_TERM_REQ;
 
@@ -222,10 +223,9 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
 	return ES_VMM_ERROR;
 }
 
-static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
-					  struct es_em_ctxt *ctxt,
-					  u64 exit_code, u64 exit_info_1,
-					  u64 exit_info_2)
+static enum es_result __pitext
+sev_es_ghcb_hv_call(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+		    u64 exit_code, u64 exit_info_1, u64 exit_info_2)
 {
 	/* Fill in protocol and format specifiers */
 	ghcb->protocol_version = ghcb_version;
@@ -241,7 +241,7 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 	return verify_exception_info(ghcb, ctxt);
 }
 
-static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
+static int __pitext __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
 {
 	u64 val;
 
@@ -256,7 +256,7 @@ static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
 	return 0;
 }
 
-static int __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
+static int __pitext __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
 {
 	int ret;
 
@@ -391,7 +391,7 @@ static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 	return xsave_size;
 }
 
-static bool
+static bool __pitext
 snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
@@ -427,7 +427,8 @@ snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 	return false;
 }
 
-static void snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+static void __pitext snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+				  struct cpuid_leaf *leaf)
 {
 	if (sev_cpuid_hv(ghcb, ctxt, leaf))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
@@ -528,7 +529,8 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
  * should be treated as fatal by caller.
  */
-static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+static int __pitext snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+			      struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
@@ -570,7 +572,7 @@ static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_le
  * page yet, so it only supports the MSR based communication with the
  * hypervisor and only the CPUID exit-code.
  */
-void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
+void __pitext do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int subfn = lower_bits(regs->cx, 32);
 	unsigned int fn = lower_bits(regs->ax, 32);
@@ -1043,7 +1045,7 @@ static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
  * mapping needs to be updated in sync with all the changes to virtual memory
  * layout and related mapping facilities throughout the boot process.
  */
-static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
+static void __pitext setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 {
 	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
 	int i;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c67285824e82..e5793505b307 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -682,8 +682,8 @@ static u64 __init get_jump_table_addr(void)
 	return ret;
 }
 
-static void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
-				  unsigned long npages, enum psc_op op)
+static void __pitext early_set_pages_state(unsigned long vaddr, unsigned long paddr,
+					   unsigned long npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
@@ -758,8 +758,8 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
-void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
-					unsigned long npages)
+void __pitext early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+					  unsigned long npages)
 {
 	/*
 	 * This can be invoked in early boot while running identity mapped, so
@@ -2059,7 +2059,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
  *
  * Scan for the blob in that order.
  */
-static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
+static __pitext struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -2085,7 +2085,7 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 	return cc_info;
 }
 
-bool __init snp_init(struct boot_params *bp)
+bool __pitext snp_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -2107,7 +2107,7 @@ bool __init snp_init(struct boot_params *bp)
 	return true;
 }
 
-void __init __noreturn snp_abort(void)
+void __pitext __noreturn snp_abort(void)
 {
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
diff --git a/arch/x86/lib/cmdline.c b/arch/x86/lib/cmdline.c
index 80570eb3c89b..9f040b2882ae 100644
--- a/arch/x86/lib/cmdline.c
+++ b/arch/x86/lib/cmdline.c
@@ -119,7 +119,7 @@ __cmdline_find_option_bool(const char *cmdline, int max_cmdline_size,
  * Returns the length of the argument (regardless of if it was
  * truncated to fit in the buffer), or -1 on not found.
  */
-static int
+static int __pitext
 __cmdline_find_option(const char *cmdline, int max_cmdline_size,
 		      const char *option, char *buffer, int bufsize)
 {
@@ -203,12 +203,12 @@ __cmdline_find_option(const char *cmdline, int max_cmdline_size,
 	return len;
 }
 
-int cmdline_find_option_bool(const char *cmdline, const char *option)
+int __pitext cmdline_find_option_bool(const char *cmdline, const char *option)
 {
 	return __cmdline_find_option_bool(cmdline, COMMAND_LINE_SIZE, option);
 }
 
-int cmdline_find_option(const char *cmdline, const char *option, char *buffer,
+int __pitext cmdline_find_option(const char *cmdline, const char *option, char *buffer,
 			int bufsize)
 {
 	return __cmdline_find_option(cmdline, COMMAND_LINE_SIZE, option,
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 0ae2e1712e2e..48b0908d2c3e 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -4,11 +4,12 @@
 #include <linux/export.h>
 #include <linux/linkage.h>
 #include <linux/cfi_types.h>
+#include <linux/init.h>
 #include <asm/errno.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 
-.section .noinstr.text, "ax"
+	__PITEXT
 
 /*
  * memcpy - Copy a memory block.
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 0199d56cb479..455424dcadc0 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -2,11 +2,12 @@
 /* Copyright 2002 Andi Kleen, SuSE Labs */
 
 #include <linux/export.h>
+#include <linux/init.h>
 #include <linux/linkage.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 
-.section .noinstr.text, "ax"
+	__PITEXT
 
 /*
  * ISO C memset - set a memory block to a byte value. This function uses fast
diff --git a/arch/x86/mm/mem_encrypt_boot.S b/arch/x86/mm/mem_encrypt_boot.S
index e25288ee33c2..f951f4f86e5c 100644
--- a/arch/x86/mm/mem_encrypt_boot.S
+++ b/arch/x86/mm/mem_encrypt_boot.S
@@ -7,6 +7,7 @@
  * Author: Tom Lendacky <thomas.lendacky@amd.com>
  */
 
+#include <linux/init.h>
 #include <linux/linkage.h>
 #include <linux/pgtable.h>
 #include <asm/page.h>
@@ -14,7 +15,7 @@
 #include <asm/msr-index.h>
 #include <asm/nospec-branch.h>
 
-	.text
+	__PITEXT
 	.code64
 SYM_FUNC_START(sme_encrypt_execute)
 
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 67d4530548ce..20b23da4a26d 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -90,7 +90,7 @@ static char sme_cmdline_arg[] __initdata = "mem_encrypt";
 static char sme_cmdline_on[]  __initdata = "on";
 static char sme_cmdline_off[] __initdata = "off";
 
-static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
+static void __pitext sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
 	pgd_t *pgd_p;
@@ -105,7 +105,7 @@ static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 	memset(pgd_p, 0, pgd_size);
 }
 
-static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
+static pud_t __pitext *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -142,7 +142,7 @@ static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 	return pud;
 }
 
-static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
+static void __pitext sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -158,7 +158,7 @@ static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
 }
 
-static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
+static void __pitext sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -184,7 +184,7 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
 }
 
-static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
+static void __pitext __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd_large(ppd);
@@ -194,7 +194,7 @@ static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 	}
 }
 
-static void __init __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
+static void __pitext __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd(ppd);
@@ -204,7 +204,7 @@ static void __init __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
 	}
 }
 
-static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
+static void __pitext __sme_map_range(struct sme_populate_pgd_data *ppd,
 				   pmdval_t pmd_flags, pteval_t pte_flags)
 {
 	unsigned long vaddr_end;
@@ -228,22 +228,22 @@ static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
 	__sme_map_range_pte(ppd);
 }
 
-static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
+static void __pitext sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
 }
 
-static void __init sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
+static void __pitext sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
 }
 
-static void __init sme_map_range_decrypted_wp(struct sme_populate_pgd_data *ppd)
+static void __pitext sme_map_range_decrypted_wp(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC_WP, PTE_FLAGS_DEC_WP);
 }
 
-static unsigned long __init sme_pgtable_calc(unsigned long len)
+static unsigned long __pitext sme_pgtable_calc(unsigned long len)
 {
 	unsigned long entries = 0, tables = 0;
 
@@ -280,7 +280,7 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
 	return entries + tables;
 }
 
-void __init sme_encrypt_kernel(struct boot_params *bp)
+void __pitext sme_encrypt_kernel(struct boot_params *bp)
 {
 	unsigned long workarea_start, workarea_end, workarea_len;
 	unsigned long execute_start, execute_end, execute_len;
@@ -493,7 +493,29 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	native_write_cr3(__native_read_cr3());
 }
 
-void __init sme_enable(struct boot_params *bp)
+/**
+ * strncmp - Compare two length-limited strings
+ * @cs: One string
+ * @ct: Another string
+ * @count: The maximum number of bytes to compare
+ */
+static int __pitext __strncmp(const char *cs, const char *ct, size_t count)
+{
+	unsigned char c1, c2;
+
+	while (count) {
+		c1 = *cs++;
+		c2 = *ct++;
+		if (c1 != c2)
+			return c1 < c2 ? -1 : 1;
+		if (!c1)
+			break;
+		count--;
+	}
+	return 0;
+}
+
+void __pitext sme_enable(struct boot_params *bp)
 {
 	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
 	unsigned int eax, ebx, ecx, edx;
@@ -594,9 +616,9 @@ void __init sme_enable(struct boot_params *bp)
 	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0)
 		return;
 
-	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
+	if (!__strncmp(buffer, cmdline_on, sizeof(buffer)))
 		sme_me_mask = me_mask;
-	else if (!strncmp(buffer, cmdline_off, sizeof(buffer)))
+	else if (!__strncmp(buffer, cmdline_off, sizeof(buffer)))
 		sme_me_mask = 0;
 	else
 		sme_me_mask = active_by_default ? me_mask : 0;
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 669ba1c345b3..8fd1b84ab40c 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -121,7 +121,7 @@ static int __init pti_parse_cmdline_nopti(char *arg)
 }
 early_param("nopti", pti_parse_cmdline_nopti);
 
-pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
+pgd_t __pitext __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	/*
 	 * Changes to the high (kernel) portion of the kernelmode page
-- 
2.43.0.429.g432eaa2c6b-goog


