Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA4B24D831
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgHUPNZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 11:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgHUPNQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 11:13:16 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2F7C061573;
        Fri, 21 Aug 2020 08:13:15 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y6so996651plk.10;
        Fri, 21 Aug 2020 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/TNFv6HMLiWXamsCOEc67C9ud98FI7LShW37Zy1NZ3Q=;
        b=C61EU6HXNNiIE03XtFMUUqH0afKGOIVNbSDjGdx057g8dEiIh5RJ37CBcBRlcqMGp2
         AqxrungEYkWu+oIKtkmSUOzy/+Au53BUprQpyGz/LZJqP4A/KwsYAATREHIm/WefPvqd
         pu2o5GkG+bynDn1hswfdToNcyF2ifZfTP7XHQXdD/TNqeDCMlpxPcvj2sJ0YFaLLZGCq
         XN6VgMZIrg74vq/qsWlwaKAK0JFLaf9nckuEf2X2UbXEDapC1I136yAjpO7dmUGU4/6C
         PJYr7n4Cgio2Zpo2a7rN8G3HXn2ofcfKbFBH6cjmSGoNCRkS6dI7nw9yqEVwS/tRwOr0
         hRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/TNFv6HMLiWXamsCOEc67C9ud98FI7LShW37Zy1NZ3Q=;
        b=ryolrNDSsgggW6qiryUrM3eho4FYrpkbscQ8BzOL6BCxW/u59WvTrTjqY+tpUryVae
         125ihkCMA8uGvb3LfhI6ROGm8KJMd0yQx9I1eIP/H1kIoWi+FTydvLteIdHtwxaKt1Li
         8cqsnCrGcGyOuq8T87YOnfYiLPAItqIbK7h+n4T6mJL2Keo1/dPH16pEZUesKrOLsz5E
         4iirCeAbSogIffg4bhPgIiczAZcnB+lHfDuUx91NmqDlR7/uZEIMn2vow4/+VuIvYnyv
         jdqcdMv9Su2+FoxTSIANFrviYcToKIpAObF2n8s/jvpsBJYzAfIxBCQDNVP6aFcqfVzA
         3nMg==
X-Gm-Message-State: AOAM530uinAK0sifK2FkAcmFpaIX0Vm3auHVFE7/ccxp1I09U9LBW+5S
        A5hcoXFgOLKmDn+5m+wvK6Y=
X-Google-Smtp-Source: ABdhPJxJ42RePcnQK55+NHJSCK6N+XE6cpbW5VmwJeO028VLoSugON1xyR8CJ90w/V7P+0Hx+E2elg==
X-Received: by 2002:a17:902:8e85:: with SMTP id bg5mr2686443plb.306.1598022795348;
        Fri, 21 Aug 2020 08:13:15 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id s8sm3126985pfc.122.2020.08.21.08.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:13:14 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 08/12] x86: inline huge vmap supported functions
Date:   Sat, 22 Aug 2020 01:12:12 +1000
Message-Id: <20200821151216.1005117-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200821151216.1005117-1-npiggin@gmail.com>
References: <20200821151216.1005117-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This allows unsupported levels to be constant folded away, and so
p4d_free_pud_page can be removed because it's no longer linked to.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/x86/include/asm/vmalloc.h | 22 +++++++++++++++++++---
 arch/x86/mm/ioremap.c          | 19 -------------------
 arch/x86/mm/pgtable.c          | 13 -------------
 3 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/vmalloc.h b/arch/x86/include/asm/vmalloc.h
index 094ea2b565f3..e714b00fc0ca 100644
--- a/arch/x86/include/asm/vmalloc.h
+++ b/arch/x86/include/asm/vmalloc.h
@@ -1,13 +1,29 @@
 #ifndef _ASM_X86_VMALLOC_H
 #define _ASM_X86_VMALLOC_H
 
+#include <asm/cpufeature.h>
 #include <asm/page.h>
 #include <asm/pgtable_areas.h>
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-bool arch_vmap_p4d_supported(pgprot_t prot);
-bool arch_vmap_pud_supported(pgprot_t prot);
-bool arch_vmap_pmd_supported(pgprot_t prot);
+static inline bool arch_vmap_p4d_supported(pgprot_t prot)
+{
+	return false;
+}
+
+static inline bool arch_vmap_pud_supported(pgprot_t prot)
+{
+#ifdef CONFIG_X86_64
+	return boot_cpu_has(X86_FEATURE_GBPAGES);
+#else
+	return false;
+#endif
+}
+
+static inline bool arch_vmap_pmd_supported(pgprot_t prot)
+{
+	return boot_cpu_has(X86_FEATURE_PSE);
+}
 #endif
 
 #endif /* _ASM_X86_VMALLOC_H */
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 159bfca757b9..1465a22a9bfb 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -481,25 +481,6 @@ void iounmap(volatile void __iomem *addr)
 }
 EXPORT_SYMBOL(iounmap);
 
-bool arch_vmap_p4d_supported(pgprot_t prot)
-{
-	return false;
-}
-
-bool arch_vmap_pud_supported(pgprot_t prot)
-{
-#ifdef CONFIG_X86_64
-	return boot_cpu_has(X86_FEATURE_GBPAGES);
-#else
-	return false;
-#endif
-}
-
-bool arch_vmap_pmd_supported(pgprot_t prot)
-{
-	return boot_cpu_has(X86_FEATURE_PSE);
-}
-
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index dfd82f51ba66..801c418ee97d 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -780,14 +780,6 @@ int pmd_clear_huge(pmd_t *pmd)
 	return 0;
 }
 
-/*
- * Until we support 512GB pages, skip them in the vmap area.
- */
-int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
-{
-	return 0;
-}
-
 #ifdef CONFIG_X86_64
 /**
  * pud_free_pmd_page - Clear pud entry and free pmd page.
@@ -859,11 +851,6 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 #else /* !CONFIG_X86_64 */
 
-int pud_free_pmd_page(pud_t *pud, unsigned long addr)
-{
-	return pud_none(*pud);
-}
-
 /*
  * Disable free page handling on x86-PAE. This assures that ioremap()
  * does not update sync'd pmd entries. See vmalloc_sync_one().
-- 
2.23.0

