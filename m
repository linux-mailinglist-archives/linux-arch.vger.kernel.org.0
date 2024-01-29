Return-Path: <linux-arch+bounces-1792-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE888411B7
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62812888C9
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A7B76021;
	Mon, 29 Jan 2024 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vuO9Qazu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677606F099
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551568; cv=none; b=SvTHV5j5kw2gppiUoNtF8HG4bOA2AZ2DmKguHS5xxppBWOjoAddY2y84oKES8Ww0ZQe0ikfsCixl+PnuqPeX8/qrC5kAkysT5B4eQvru1NgsFr9HRDGkLENbGX4tlfvLIne57Mf7VHi6nRuF/++16HtvCtVXjpBU4Pvx/I7Ej3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551568; c=relaxed/simple;
	bh=NZI+VSlxzyPFRmF15Jcr5EHokjSqQLfxpmgd8iObKfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HGWLuJlvuc24O3z58iawe8DaobW1TOwJH1tL/9Fl3wD/EywiKWsdWsMTJzAUpCdtkPu7XpQ0o1zeHL9kFzS/L/p27jzcZYxVWiZpB9RfZcAc9p6V4EQRgslF7OJRVPoZOvLFCF15kveIXqpWlobO+qPaLCiVEaozUWtXjzvd+A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vuO9Qazu; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40efbe60d32so2967615e9.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 10:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551565; x=1707156365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KJ+eFSML+GjQ9gUM/4lB5AYEA1a3EqVM82ZLULKpZgo=;
        b=vuO9QazuU/q2p74fAXMgjT9VjxXgBIFXO5IYsm27ohPMgFpYSD7LZdOVZZVHWd2jhb
         JDX1r6I/6rFmXgfkoFirVyaprv7lh4Q7aPnXez4JQyf74rIYKuS0DMUnf23Lxw/RWoHz
         gKnNQ+iIJBJXD4KFihFBpcJxRP5Us46Hzi3LJ+Tn7nitjfkf7GlubZTYbhIYbB11WHs6
         +3KlQmAWbj+SAiejztOi+SUnjzKGu4bQ+JHz0l3mRsiuG04ynwPhebb4FH9A+6GJmOWA
         zJi3Sx0HQ3zCSGO9qQGBiaoEh1DYIqHT2O0Petb9lKpc/wvhpq77pE6w/zlrzO2cbnIG
         oWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551565; x=1707156365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJ+eFSML+GjQ9gUM/4lB5AYEA1a3EqVM82ZLULKpZgo=;
        b=ulI5j0XBCrLOqb3uWQne06Z/i4y7wzr71HX7mK/MFc2Ow6CwSrRj2YcIjjxSCee0oR
         deeWlXVT5bAAf3cD6PHLwsy14eZDsvAadRffZ6ozBpUEr4LQ9IFJfcuD4NSNPIFX7n3C
         +hHCUwpz09nwNYBqcL5iN3QLbS3VSrIEymkcc7uqBuLzH9KLqnqD3212Atoaq+76BFj0
         zuLlgxrANASa+sezF6s0s3elb+Xgnzg2I2/M/Ls/hPf+abcU5IaIfK2rbgrS+iDSFedF
         rqumuncRkOPcZagS8s3rQK4HTvvXivORLEW69Rzn95menb3ZyYs+UjXhvgIOKpeEZaBC
         mVUQ==
X-Gm-Message-State: AOJu0YyEEj6XbjWfm02TPeg4re+FNHavoF0+eRXIC9qwsqGmt9kxuKxD
	mvym9oQNOb/RMB33pfb/2yKClGkrL9VbeBJp2WStm7ovgN31iesbwxRHW54cuHua3jvsuQ==
X-Google-Smtp-Source: AGHT+IHQBSeNys/uis3YJHXSl03WHh2SW+9GfrXVNKmkG6zseAajGFPK4L092X4fyF6kwH9jlP8AzgXo
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3d98:b0:40e:f742:c838 with SMTP id
 bi24-20020a05600c3d9800b0040ef742c838mr12658wmb.7.1706551564801; Mon, 29 Jan
 2024 10:06:04 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:18 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=20645; i=ardb@kernel.org;
 h=from:subject; bh=55OGssAUsDuXeb2b/A15axTFWbEGM1IToSgXf7PCzwk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7i/vPU3qE5E97KE+L8V2yVGCB7axHB++8zXx0y1dfm
 6mur1umo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEykdysjw5GXq9r/eMs+v/P9
 5VK5ld+sva4Zfg3Qa7pcKf3M+/UFucMMf4XaYhZw3//8NqHo0eE+/+9xHYd3RemZy2kZ93U0ioc s5wUA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-36-ardb+git@google.com>
Subject: [PATCH v3 15/19] x86/sev: Make all code reachable from 1:1 mapping __pitext
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

We cannot safely call any code when still executing from the 1:1 mapping
at early boot. The SEV init code in particular does a fair amount of
work this early, and calls into ordinary APIs, which is not safe, as
these may be instrumented by the sanitizers or by things link
CONFIG_DEBUG_VM or CONFIG_DEBUG_VIRTUAL.

So annotate all SEV code used early as __pitext and along with it, some
of the shared code that it relies on. Also override some definition of
the __pa/__va translation macros to avoid pulling in debug versions.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c     |  6 +++
 arch/x86/include/asm/mem_encrypt.h |  8 ++--
 arch/x86/include/asm/pgtable_64.h  | 12 +++++-
 arch/x86/include/asm/sev.h         |  6 +--
 arch/x86/kernel/head64.c           | 20 ++++++----
 arch/x86/kernel/sev-shared.c       | 40 +++++++++++---------
 arch/x86/kernel/sev.c              | 14 +++----
 arch/x86/lib/memcpy_64.S           |  3 +-
 arch/x86/lib/memset_64.S           |  3 +-
 arch/x86/mm/mem_encrypt_boot.S     |  3 +-
 arch/x86/mm/mem_encrypt_identity.c | 35 ++++++++---------
 11 files changed, 90 insertions(+), 60 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 073291832f44..ada6cd8d600b 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -25,6 +25,9 @@
 #include "error.h"
 #include "../msr.h"
 
+#undef __pa_nodebug
+#define __pa_nodebug __pa
+
 static struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
 struct ghcb *boot_ghcb;
 
@@ -116,6 +119,9 @@ static bool fault_in_kernel_space(unsigned long address)
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
 
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 24af25b1551a..3a6d90f47f32 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -139,12 +139,17 @@ static inline pud_t native_pudp_get_and_clear(pud_t *xp)
 #endif
 }
 
+static inline void set_p4d_kernel(p4d_t *p4dp, p4d_t p4d)
+{
+	WRITE_ONCE(*p4dp, p4d);
+}
+
 static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	pgd_t pgd;
 
 	if (pgtable_l5_enabled() || !IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION)) {
-		WRITE_ONCE(*p4dp, p4d);
+		set_p4d_kernel(p4dp, p4d);
 		return;
 	}
 
@@ -158,6 +163,11 @@ static inline void native_p4d_clear(p4d_t *p4d)
 	native_set_p4d(p4d, native_make_p4d(0));
 }
 
+static inline void set_pgd_kernel(pgd_t *pgdp, pgd_t pgd)
+{
+	WRITE_ONCE(*pgdp, pgd);
+}
+
 static inline void native_set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
 	WRITE_ONCE(*pgdp, pti_set_user_pgtbl(pgdp, pgd));
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
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 0ecd36f5326a..b014f81e0eac 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -91,16 +91,20 @@ static unsigned long __pitext sme_postprocess_startup(struct boot_params *bp,
 
 		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
 			/*
-			 * On SNP, transition the page to shared in the RMP table so that
-			 * it is consistent with the page table attribute change.
+			 * On SNP, transition the page to shared in the RMP
+			 * table so that it is consistent with the page table
+			 * attribute change.
 			 *
-			 * __start_bss_decrypted has a virtual address in the high range
-			 * mapping (kernel .text). PVALIDATE, by way of
-			 * early_snp_set_memory_shared(), requires a valid virtual
-			 * address but the kernel is currently running off of the identity
-			 * mapping so use __pa() to get a *currently* valid virtual address.
+			 * __start_bss_decrypted has a virtual address in the
+			 * high range mapping (kernel .text). PVALIDATE, by way
+			 * of early_snp_set_memory_shared(), requires a valid
+			 * virtual address but the kernel is currently running
+			 * off of the identity mapping so use __pa() to get a
+			 * *currently* valid virtual address.
 			 */
-			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
+			early_snp_set_memory_shared(__pa_nodebug(vaddr),
+						    __pa_nodebug(vaddr),
+						    PTRS_PER_PMD);
 
 			i = pmd_index(vaddr);
 			pmd[i] -= sme_get_me_mask();
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 5db24d0fc557..481dbd009ce9 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -93,7 +93,8 @@ static bool __init sev_es_check_cpu_features(void)
 	return true;
 }
 
-static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
+static __always_inline void __noreturn sev_es_terminate(unsigned int set,
+							unsigned int reason)
 {
 	u64 val = GHCB_MSR_TERM_REQ;
 
@@ -226,10 +227,9 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
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
@@ -239,13 +239,13 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
 	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
 
-	sev_es_wr_ghcb_msr(__pa(ghcb));
+	sev_es_wr_ghcb_msr(__pa_nodebug(ghcb));
 	VMGEXIT();
 
 	return verify_exception_info(ghcb, ctxt);
 }
 
-static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
+static int __pitext __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
 {
 	u64 val;
 
@@ -260,7 +260,7 @@ static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
 	return 0;
 }
 
-static int __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
+static int __pitext __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
 {
 	int ret;
 
@@ -283,7 +283,9 @@ static int __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
 	return ret;
 }
 
-static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+static int __pitext __sev_cpuid_hv_ghcb(struct ghcb *ghcb,
+					struct es_em_ctxt *ctxt,
+					struct cpuid_leaf *leaf)
 {
 	u32 cr4 = native_read_cr4();
 	int ret;
@@ -316,7 +318,8 @@ static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struc
 	return ES_OK;
 }
 
-static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+static int __pitext sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+				 struct cpuid_leaf *leaf)
 {
 	return ghcb ? __sev_cpuid_hv_ghcb(ghcb, ctxt, leaf)
 		    : __sev_cpuid_hv_msr(leaf);
@@ -395,7 +398,7 @@ static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 	return xsave_size;
 }
 
-static bool
+static bool __pitext
 snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
@@ -431,14 +434,16 @@ snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 	return false;
 }
 
-static void snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+static void __pitext snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+				  struct cpuid_leaf *leaf)
 {
 	if (sev_cpuid_hv(ghcb, ctxt, leaf))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 }
 
-static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
-				 struct cpuid_leaf *leaf)
+static int __pitext snp_cpuid_postprocess(struct ghcb *ghcb,
+					 struct es_em_ctxt *ctxt,
+					 struct cpuid_leaf *leaf)
 {
 	struct cpuid_leaf leaf_hv = *leaf;
 
@@ -532,7 +537,8 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
  * should be treated as fatal by caller.
  */
-static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+static int __pitext snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+			      struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
@@ -574,7 +580,7 @@ static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_le
  * page yet, so it only supports the MSR based communication with the
  * hypervisor and only the CPUID exit-code.
  */
-void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
+void __pitext do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int subfn = lower_bits(regs->cx, 32);
 	unsigned int fn = lower_bits(regs->ax, 32);
@@ -1052,7 +1058,7 @@ static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
  * mapping needs to be updated in sync with all the changes to virtual memory
  * layout and related mapping facilities throughout the boot process.
  */
-static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
+static void __pitext setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 {
 	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
 	int i;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1ec753331524..62981b463b76 100644
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
@@ -2062,7 +2062,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
  *
  * Scan for the blob in that order.
  */
-static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
+static __pitext struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -2088,7 +2088,7 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 	return cc_info;
 }
 
-bool __init snp_init(struct boot_params *bp)
+bool __pitext snp_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -2110,7 +2110,7 @@ bool __init snp_init(struct boot_params *bp)
 	return true;
 }
 
-void __init __noreturn snp_abort(void)
+void __pitext __noreturn snp_abort(void)
 {
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 0ae2e1712e2e..f56cb062d874 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -2,13 +2,14 @@
 /* Copyright 2002 Andi Kleen */
 
 #include <linux/export.h>
+#include <linux/init.h>
 #include <linux/linkage.h>
 #include <linux/cfi_types.h>
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
index 2e195866a7fe..bc39e04de980 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -85,7 +85,8 @@ struct sme_populate_pgd_data {
  */
 static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
-static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
+
+static void __pitext sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
 	pgd_t *pgd_p;
@@ -100,7 +101,7 @@ static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 	memset(pgd_p, 0, pgd_size);
 }
 
-static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
+static pud_t __pitext *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -112,7 +113,7 @@ static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 		p4d = ppd->pgtable_area;
 		memset(p4d, 0, sizeof(*p4d) * PTRS_PER_P4D);
 		ppd->pgtable_area += sizeof(*p4d) * PTRS_PER_P4D;
-		set_pgd(pgd, __pgd(PGD_FLAGS | __pa(p4d)));
+		set_pgd_kernel(pgd, __pgd(PGD_FLAGS | __pa(p4d)));
 	}
 
 	p4d = p4d_offset(pgd, ppd->vaddr);
@@ -120,7 +121,7 @@ static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 		pud = ppd->pgtable_area;
 		memset(pud, 0, sizeof(*pud) * PTRS_PER_PUD);
 		ppd->pgtable_area += sizeof(*pud) * PTRS_PER_PUD;
-		set_p4d(p4d, __p4d(P4D_FLAGS | __pa(pud)));
+		set_p4d_kernel(p4d, __p4d(P4D_FLAGS | __pa(pud)));
 	}
 
 	pud = pud_offset(p4d, ppd->vaddr);
@@ -137,7 +138,7 @@ static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 	return pud;
 }
 
-static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
+static void __pitext sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -153,7 +154,7 @@ static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
 }
 
-static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
+static void __pitext sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -179,7 +180,7 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
 }
 
-static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
+static void __pitext __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd_large(ppd);
@@ -189,7 +190,7 @@ static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 	}
 }
 
-static void __init __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
+static void __pitext __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd(ppd);
@@ -199,7 +200,7 @@ static void __init __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
 	}
 }
 
-static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
+static void __pitext __sme_map_range(struct sme_populate_pgd_data *ppd,
 				   pmdval_t pmd_flags, pteval_t pte_flags)
 {
 	unsigned long vaddr_end;
@@ -223,22 +224,22 @@ static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
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
 
@@ -275,7 +276,7 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
 	return entries + tables;
 }
 
-void __init sme_encrypt_kernel(struct boot_params *bp)
+void __pitext sme_encrypt_kernel(struct boot_params *bp)
 {
 	unsigned long workarea_start, workarea_end, workarea_len;
 	unsigned long execute_start, execute_end, execute_len;
@@ -310,8 +311,8 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 */
 
 	/* Physical addresses gives us the identity mapped virtual addresses */
-	kernel_start = __pa_symbol(_text);
-	kernel_end = ALIGN(__pa_symbol(_end), PMD_SIZE);
+	kernel_start = __pa(_text);
+	kernel_end = ALIGN(__pa(_end), PMD_SIZE);
 	kernel_len = kernel_end - kernel_start;
 
 	initrd_start = 0;
@@ -488,7 +489,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	native_write_cr3(__native_read_cr3());
 }
 
-void __init sme_enable(struct boot_params *bp)
+void __pitext sme_enable(struct boot_params *bp)
 {
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
-- 
2.43.0.429.g432eaa2c6b-goog


