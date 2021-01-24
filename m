Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5FA301A91
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jan 2021 09:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbhAXIZM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jan 2021 03:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbhAXIY2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jan 2021 03:24:28 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BA1C061573;
        Sun, 24 Jan 2021 00:23:40 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id kx7so6458957pjb.2;
        Sun, 24 Jan 2021 00:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80Po72abxrqXJsVTjT2d7/68A0xoEHKX9fHFXJoIAvk=;
        b=JYIpc/oqm/sAsWgaVw4nIYbYX6wxnaKxqEtZNm7YbjwC4PE+yNUmVWfFFc7/DDS1vu
         3Bvb2n4Lkhye1htDxYySk01BKuFM42hGfIYYp/NSXryeL6E+Voz4SH123INkddKD0IBL
         Kqyr/eoCmpBjxN++rd5vW/WXKaozCgA4xl6bXF4b8ZYx64nHsbskvRHVLhXNSzxzHocQ
         wxRHD0kk3MvwDPGLuNi9tIE20PB+2I42NP6a6n8eSVI+UF0EM09H06R1p8Ny1J5sk1Wh
         0nxk5XGh4iImvCFUaIO5Iy+J3AqypcC/fRSz/vfCtV/aTL23HF2BthbLHhB4rU0r8dai
         GszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80Po72abxrqXJsVTjT2d7/68A0xoEHKX9fHFXJoIAvk=;
        b=UNdZDZIiB2/tLMDhCAh50G6HW0abJbwbtTEFoh2NxRyvNPpcBrhAMR5qXjgbvwsGw3
         sOg1nDEfEB8hsF9rlooaUJqHk4dTeSAvNIZ2jwJ6UDygDhHDm0ch6DwejL0c5OTYUfcT
         jdSme0nCf6R8CTaNX3TU0AjDtE3E4PRvQbC/anxFT46ybgXixCu0U/CtFyIPOWVWUneZ
         YMk6WZMMAzgPJDe9z4fUuJiTY2rBc4IhEVdbMxv9ydPDmlOSapdpTjFD9o9Ms0ygEgTQ
         E1G7u9CNfQkTkBvH4OTrplrZSwLIi5473DRpf5ys8eIrXHNwghlgwpSbwq/qyDL5G+l5
         LEWg==
X-Gm-Message-State: AOAM533kNaNX0S+pGgPSsBvbsCKH3zigwLwqz2aButZfz3o+W5jQhFsA
        ygu5e6q36mmVW+SDgZd5ZR8=
X-Google-Smtp-Source: ABdhPJyGxzt4jp0pHuRp4lsmYaC1aRXlAB8zf0kpATtdtfUdYJZXoyFDyRHWsaQurt0XqhzPzOtL+w==
X-Received: by 2002:a17:902:9f89:b029:dc:3032:e439 with SMTP id g9-20020a1709029f89b02900dc3032e439mr1132590plq.35.1611476620596;
        Sun, 24 Jan 2021 00:23:40 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([124.170.13.62])
        by smtp.gmail.com with ESMTPSA id gb12sm11799757pjb.51.2021.01.24.00.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 00:23:40 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v10 08/12] x86: inline huge vmap supported functions
Date:   Sun, 24 Jan 2021 18:22:26 +1000
Message-Id: <20210124082230.2118861-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210124082230.2118861-1-npiggin@gmail.com>
References: <20210124082230.2118861-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 arch/x86/mm/ioremap.c          | 21 ---------------------
 arch/x86/mm/pgtable.c          | 13 -------------
 3 files changed, 19 insertions(+), 37 deletions(-)

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
index fbaf0c447986..12c686c65ea9 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -481,27 +481,6 @@ void iounmap(volatile void __iomem *addr)
 }
 EXPORT_SYMBOL(iounmap);
 
-#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
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
-#endif
-
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f6a9e2e36642..d27cf69e811d 100644
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
@@ -861,11 +853,6 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
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

