Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B88630B40
	for <lists+linux-arch@lfdr.de>; Sat, 19 Nov 2022 04:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiKSDqm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 22:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiKSDqk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 22:46:40 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12013BF5BA;
        Fri, 18 Nov 2022 19:46:40 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id q9so6648003pfg.5;
        Fri, 18 Nov 2022 19:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DP2gDnxC84ZwxSYEmb2xdHigIgTSb4Jlj1QnGwsCAFw=;
        b=VizoFiyC6m0+qVewF22y7z3UPlL0Ni2vLQg44N7CDbbM8xWC44Wzz15t4B3kp75117
         q/kbcD8R8RLvwVmn9KJkqrHZ/kSPStVNsr4jndlK992jfN81t3oHKdAaf8trVXNIwUt4
         gigRs6KKVFk2FXwtkJPdHjXZSt3QEjYXj1Z0yVDVVzflI22FH5121EDud+AwikWRW/7p
         dmnxmcMHcpi9xZhH+Rprv/ga9TzGoxzIQEGK7huomFGj5jtgFzQTqmEZkt3hPCQ7Vps7
         mnZRj478hBuFuTtSc84OM/3JO2lewa3X5X/1Y1RyQZ2VvQDlBJkXe+CslumMiMJVwK0x
         yR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DP2gDnxC84ZwxSYEmb2xdHigIgTSb4Jlj1QnGwsCAFw=;
        b=hrQsPLEVM9nBOKZZ1Pbjzyl2R/wA1c/4Fsob4D5fE/hcxak6rX7p0RmHC2XvI+N+SN
         QWGFGonea6slURPaHc+sRzmkkkgHG1DpEkBz8Wj7QkOXV9AExbehOEKTUFS5IQ+Gul7J
         iDp5vI4sXxiu6P5ERghv+l5xVzXdcURlYQI7uE2k359vwBZSY8qO8I8g3HcbTadqXY+d
         ojlUjZSVmpwnlru43u3M6asKRQnggvhbeM+xCC9JiII/lFMJHIT0jE8Pmm1c/Qdp7koP
         QWkUx6phedCHchc3FWgjh5od69DfUyv0dBYPzzSFDMIpwHxvXDdvThoSLy+kmAfyAWAy
         KmJA==
X-Gm-Message-State: ANoB5pnu48szRAasAriB5HJjhzZBq3qZASBm3oIIzoYTFoc/NQRgrkra
        IgiRQi54SogIKbsjISuOt0M=
X-Google-Smtp-Source: AA0mqf6EXaF7823hWGBs45o8b/pvnR4W7OZ3VExiL7yrwZVbS8Ia7qNxtQyccE2mZAEkUrUgF69C2A==
X-Received: by 2002:a62:874c:0:b0:556:e951:f8de with SMTP id i73-20020a62874c000000b00556e951f8demr10830626pfe.59.1668829599447;
        Fri, 18 Nov 2022 19:46:39 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:38:f087:1794:92c5:f8f0])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b005360da6b26bsm3913892pfj.159.2022.11.18.19.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:46:38 -0800 (PST)
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
Subject: [RFC PATCH V2 01/18] x86/sev: Pvalidate memory gab for decompressing kernel
Date:   Fri, 18 Nov 2022 22:46:15 -0500
Message-Id: <20221119034633.1728632-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221119034633.1728632-1-ltykernel@gmail.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
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

