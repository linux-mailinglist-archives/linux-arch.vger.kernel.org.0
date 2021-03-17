Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5CB33E9A9
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 07:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCQGZb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 02:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCQGZM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 02:25:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2990C06174A;
        Tue, 16 Mar 2021 23:25:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 30so278172ple.4;
        Tue, 16 Mar 2021 23:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6FRU9caWwWjvnrqszVqRsss5Upxnc33B3OfV8qLPoO8=;
        b=acOv1nNHq0DKxAmKf1vBi80AyxUYmYRKTh2Ey93TwUyRdkZCqWMNbWoGWU+5MekJGP
         bkdrfYR8csV+POZ7R2VaahbTBabix8QECkD93CNRXZRKrtJaqACa02+ligl4FVBcRJYf
         RjRL9pmF/JxgFVriXcGsY0lFBXYliNoOMi+qWVw74A0UwwlZXrE3SMGwlLdKOhtGwxyH
         9lj/12FT4SHFaQn2nzfmOjdPxQPBiXUpk87Lrk7+lEBO/a2gWXWdccsTtyOdbLyQHQyx
         BvmaRP5WJYWW86mzlLmFL8NBGAmVMxsp5jpPJPAvUskm1r4Xns9NfRLajx7uwAQSirTg
         9ZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FRU9caWwWjvnrqszVqRsss5Upxnc33B3OfV8qLPoO8=;
        b=QE5sni4Ls/TTbiUo7XAdS1jgav/Xoc7L9ZMrAeCUB5KqcxqdcQ2vl/AoQaF+NhktMS
         m4sH7w1c1qNLgIQNnU9YBKBDD8NYrNyIYS5wf9v89QMTyvgFd3B0flRdkxiIBUZtpBe4
         1dj0cjtbHr5ruLeSf0d9TZ/DzAb27goLcsuZvDX4eHvASU966F/UxCkYuM21nFXvgr2I
         hLU/SOyfLbLnrT0ji58ddom6ttwxSoTNzMLUpzR9OZtrqNTG6QHb8Nt2Ic7OkJXuutyC
         QMXKuQlnfsvjmOjWaJpQ0VSs6/fjkYjgtK3Ks+57mRYgdaO3KkJImp0GW1T8uy35eaql
         y4YA==
X-Gm-Message-State: AOAM530vXKP0lbbfMw3Dkkmicd8/UqCJj/ucDY9Uu1YF2eyyJp1LRc22
        OB183h7CRiNOMXM3yOZlmas=
X-Google-Smtp-Source: ABdhPJwdKgWAmNPrq81aNVKAYJ1WAYd7AWSS4jrdMlA13JJ+pQXBcMpUBMbODVrBwNM0aQs0yHN98w==
X-Received: by 2002:a17:90b:686:: with SMTP id m6mr2855807pjz.26.1615962312311;
        Tue, 16 Mar 2021 23:25:12 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id s19sm17959620pfh.168.2021.03.16.23.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:25:11 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v13 07/14] powerpc: inline huge vmap supported functions
Date:   Wed, 17 Mar 2021 16:23:55 +1000
Message-Id: <20210317062402.533919-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210317062402.533919-1-npiggin@gmail.com>
References: <20210317062402.533919-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This allows unsupported levels to be constant folded away, and so
p4d_free_pud_page can be removed because it's no longer linked to.

Cc: linuxppc-dev@lists.ozlabs.org
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/vmalloc.h       | 19 ++++++++++++++++---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 21 ---------------------
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/vmalloc.h b/arch/powerpc/include/asm/vmalloc.h
index 105abb73f075..3f0c153befb0 100644
--- a/arch/powerpc/include/asm/vmalloc.h
+++ b/arch/powerpc/include/asm/vmalloc.h
@@ -1,12 +1,25 @@
 #ifndef _ASM_POWERPC_VMALLOC_H
 #define _ASM_POWERPC_VMALLOC_H
 
+#include <asm/mmu.h>
 #include <asm/page.h>
 
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
+	/* HPT does not cope with large pages in the vmalloc area */
+	return radix_enabled();
+}
+
+static inline bool arch_vmap_pmd_supported(pgprot_t prot)
+{
+	return radix_enabled();
+}
 #endif
 
 #endif /* _ASM_POWERPC_VMALLOC_H */
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 743807fc210f..8da62afccee5 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1082,22 +1082,6 @@ void radix__ptep_modify_prot_commit(struct vm_area_struct *vma,
 	set_pte_at(mm, addr, ptep, pte);
 }
 
-bool arch_vmap_pud_supported(pgprot_t prot)
-{
-	/* HPT does not cope with large pages in the vmalloc area */
-	return radix_enabled();
-}
-
-bool arch_vmap_pmd_supported(pgprot_t prot)
-{
-	return radix_enabled();
-}
-
-int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
-{
-	return 0;
-}
-
 int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 {
 	pte_t *ptep = (pte_t *)pud;
@@ -1181,8 +1165,3 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 	return 1;
 }
-
-bool arch_vmap_p4d_supported(pgprot_t prot)
-{
-	return false;
-}
-- 
2.23.0

