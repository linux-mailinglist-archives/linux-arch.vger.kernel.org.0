Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF436234F5
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 21:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiKIUyJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 15:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiKIUyA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 15:54:00 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4D927FC2;
        Wed,  9 Nov 2022 12:53:59 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gw22so17833812pjb.3;
        Wed, 09 Nov 2022 12:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DP2gDnxC84ZwxSYEmb2xdHigIgTSb4Jlj1QnGwsCAFw=;
        b=Va6CZHAg3f/zFbZo9HodKXjThGqLp0oVJDcMTRhMPuBJwMNjwGadE5rwXHrXksLyxC
         cX9emz/hzWrYaPGXCczxnrLfezOjGGAd+GTMErsmmxBA4SsKRNR341GEI+mWnCR8gRt8
         OO0jchbExs1sZE+y0+UXDLXScY2hNTmPeu8MYmo9hinVTP4rvQGZ+ZAOXRy1cGzaHPRv
         XJ3XECO33Hml98f43si4sKd+PM5MlAyElu/pWMnofWnQalxxUvalah0gAQkQkK6tc161
         rZLozxFvh4x7I4ogl87LkxntixMV7mHEopLXzwQgLDOBLZQZ4EjzxeH31m1T9dbSTR9t
         Rjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DP2gDnxC84ZwxSYEmb2xdHigIgTSb4Jlj1QnGwsCAFw=;
        b=MXSh9l9QtqUX8/3rRL8xLz0LV16qk8uHvPKcIH9XjwgYDeEISEGoVtyGUIErqP1KqX
         8eXXhBzPC5rAIVPnS0Ejq+KSoPK2eRaWSfFsb35gRyH8SzYMA9ic5fTm3U47ICbnwHSb
         DwF3l8t7hZVVvgSqazJy0ekNRT5z83Tf50PmgCJ3xrunTdGf+pEgKKEJmGARQPgPFsDT
         cSvJH9zekM/PXkjNfAbOS6G6T9Zl/OhS/HczyXmVzpayiTX5qql4VY98APw0x5aM2JA6
         KRC93Kxn/pqWXle9+oK+vtkn9mMhaVeuIA0+PO2MVA6oLesJSL/2bzTEGDg78WnX0zz5
         UTtg==
X-Gm-Message-State: ACrzQf1sP523uzujMRZM3P7KPILlz5qIF6Yo6ePvc2Vle/FI/vtKtsKg
        9/g2N8zEDKsDtS20YiXK5Zw=
X-Google-Smtp-Source: AMsMyM7sUB0CpNbgm4hVOYLAD+obpuiacN8WK398vmEeuQrG5U1sTJQXc3T6hUE3Tp4Z6X99U2bvnQ==
X-Received: by 2002:a17:90b:180e:b0:213:4abf:ed0a with SMTP id lw14-20020a17090b180e00b002134abfed0amr82250323pjb.119.1668027238814;
        Wed, 09 Nov 2022 12:53:58 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:c616:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a108200b002137d3da760sm1633984pja.39.2022.11.09.12.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:53:58 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [RFC PATCH 02/17] x86/sev: Pvalidate memory gab for decompressing kernel
Date:   Wed,  9 Nov 2022 15:53:37 -0500
Message-Id: <20221109205353.984745-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109205353.984745-1-ltykernel@gmail.com>
References: <20221109205353.984745-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Pvalidate needed pages for decompressing kernel. The E820_TYPE_RAM
entry includes only validated memory. The kernel expects that the
RAM entry's addr is fixed while the entry size is to be extended
to cover addresses to the start of next entry. This patch increases
the RAM entry size to cover all possilble memory addresses until
init_size.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/boot/compressed/head_64.S |  8 +++
 arch/x86/boot/compressed/sev.c     | 84 ++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index d33f060900d2..818edaf5d0cf 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -348,6 +348,14 @@ SYM_CODE_START(startup_64)
 	cld
 	cli
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/* pvalidate memory on demand if SNP is enabled. */
+	pushq	%rsi
+	movq    %rsi, %rdi
+	call 	pvalidate_for_startup_64
+	popq	%rsi
+#endif
+
 	/* Setup data segments. */
 	xorl	%eax, %eax
 	movl	%eax, %ds
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 960968f8bf75..3a5a1ab16095 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -12,8 +12,10 @@
  */
 #include "misc.h"
 
+#include <asm/msr-index.h>
 #include <asm/pgtable_types.h>
 #include <asm/sev.h>
+#include <asm/svm.h>
 #include <asm/trapnr.h>
 #include <asm/trap_pf.h>
 #include <asm/msr-index.h>
@@ -21,6 +23,7 @@
 #include <asm/ptrace.h>
 #include <asm/svm.h>
 #include <asm/cpuid.h>
+#include <asm/e820/types.h>
 
 #include "error.h"
 #include "../msr.h"
@@ -117,6 +120,22 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
+/* Check SEV-SNP via MSR */
+static bool sev_snp_runtime_check(void)
+{
+	unsigned long low, high;
+	u64 val;
+
+	asm volatile("rdmsr\n" : "=a" (low), "=d" (high) :
+			"c" (MSR_AMD64_SEV));
+
+	val = (high << 32) | low;
+	if (val & MSR_AMD64_SEV_SNP_ENABLED)
+		return true;
+
+	return false;
+}
+
 static inline bool sev_snp_enabled(void)
 {
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
@@ -456,3 +475,68 @@ void sev_prep_identity_maps(unsigned long top_level_pgt)
 
 	sev_verify_cbit(top_level_pgt);
 }
+
+static void extend_e820_on_demand(struct boot_e820_entry *e820_entry,
+				  u64 needed_ram_end)
+{
+	u64 end, paddr;
+	unsigned long eflags;
+	int rc;
+
+	if (!e820_entry)
+		return;
+
+	/* Validated memory must be aligned by PAGE_SIZE. */
+	end = ALIGN(e820_entry->addr + e820_entry->size, PAGE_SIZE);
+	if (needed_ram_end > end && e820_entry->type == E820_TYPE_RAM) {
+		for (paddr = end; paddr < needed_ram_end; paddr += PAGE_SIZE) {
+			rc = pvalidate(paddr, RMP_PG_SIZE_4K, true);
+			if (rc) {
+				error("Failed to validate address.n");
+				return;
+			}
+		}
+		e820_entry->size = needed_ram_end - e820_entry->addr;
+	}
+}
+
+/*
+ * Explicitly pvalidate needed pages for decompressing the kernel.
+ * The E820_TYPE_RAM entry includes only validated memory. The kernel
+ * expects that the RAM entry's addr is fixed while the entry size is to be
+ * extended to cover addresses to the start of next entry.
+ * The function increases the RAM entry size to cover all possible memory
+ * addresses until init_size.
+ * For example,  init_end = 0x4000000,
+ * [RAM: 0x0 - 0x0],                       M[RAM: 0x0 - 0xa0000]
+ * [RSVD: 0xa0000 - 0x10000]                [RSVD: 0xa0000 - 0x10000]
+ * [ACPI: 0x10000 - 0x20000]      ==>       [ACPI: 0x10000 - 0x20000]
+ * [RSVD: 0x800000 - 0x900000]              [RSVD: 0x800000 - 0x900000]
+ * [RAM: 0x1000000 - 0x2000000]            M[RAM: 0x1000000 - 0x2001000]
+ * [RAM: 0x2001000 - 0x2007000]            M[RAM: 0x2001000 - 0x4000000]
+ * Other RAM memory after init_end is pvalidated by ms_hyperv_init_platform
+ */
+__visible void pvalidate_for_startup_64(struct boot_params *boot_params)
+{
+	struct boot_e820_entry *e820_entry;
+	u64 init_end =
+		boot_params->hdr.pref_address + boot_params->hdr.init_size;
+	u8 i, nr_entries = boot_params->e820_entries;
+	u64 needed_end;
+
+	if (!sev_snp_runtime_check())
+		return;
+
+	for (i = 0; i < nr_entries; ++i) {
+		/* Pvalidate memory holes in e820 RAM entries. */
+		e820_entry = &boot_params->e820_table[i];
+		if (i < nr_entries - 1) {
+			needed_end = boot_params->e820_table[i + 1].addr;
+			if (needed_end < e820_entry->addr)
+				error("e820 table is not sorted.\n");
+		} else {
+			needed_end = init_end;
+		}
+		extend_e820_on_demand(e820_entry, needed_end);
+	}
+}
-- 
2.25.1

