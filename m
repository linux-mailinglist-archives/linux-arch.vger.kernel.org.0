Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8583F30BC9D
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 12:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhBBLHP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 06:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhBBLHB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 06:07:01 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7694C06178C;
        Tue,  2 Feb 2021 03:06:19 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y10so8012901plk.7;
        Tue, 02 Feb 2021 03:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80Po72abxrqXJsVTjT2d7/68A0xoEHKX9fHFXJoIAvk=;
        b=XfLg+VI5f5bgpcRh3vSw9o35RJAUV9dl/lmAtKXCSJ6NfuwFDWOjVAvFGjXnBpiZK/
         P5jOH1u8DsW9IeSKnosoJpovBrvVHQRQJvC+ltsT+3oYN+woybj9ZA5Vq+c1ozqe8j4h
         QneAA2n+kDRoygzwm4yAmC1Ej3HmYwvX7K6svIsLd88E3QWWCi8qfDUa37Q/WbkQxKJl
         PbFt246/cWxStZijrqZ2vI39tY2xqhbfSSiO9xb7VCk6WDCnV63cwtLdLj7+yiMtPCIg
         o8zeB4/QVJAKyxtMxxbuXVesWt3W9HyhWBg98YfxxfltCKIzyf9CqNNU+tKLZwRu95mC
         wo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80Po72abxrqXJsVTjT2d7/68A0xoEHKX9fHFXJoIAvk=;
        b=gHOTCMRohT+WSJJasMN9Vrea9T0CLcpKKaEfwhVV1dhWo5kBUCig1ZKu5xpJ18Cdmp
         C5rdTIEE7i2cnOAC1FKEogV61EF1DfT1WRxCaa2PY9HrtZkAp+fAQhpO3gMfXJZSWtCv
         +HYY8i2Ux7cq3jyEKBiSER3BDMDDGAKWsHl2ttWaLxtNEcWVrVSJWEPnTagFsgbELg1R
         T96mc+TyUqjLUIBZG6ckoYqERguB+XOXMqXkYvEaoHctUpwf4t4S4P9LTkkm6hsV3GR9
         6VX5L78GZRsG97+M0SIzhpUTEMyrDbtYbV1ADowgjhB2BEoBPbKEntqgRMowjnuKpKCd
         9oAg==
X-Gm-Message-State: AOAM530xi9MD0t7YoqPENAtaRFfZ1BAjcx3toZ46+PzNRE9eZeCzACTH
        aRg6jo2ZQTXzy2MR6r7jKLO99SBUX1A=
X-Google-Smtp-Source: ABdhPJzDyTRcKp4fR9IJr/GEbjKB+ZCNKiDKt39rj/+LjpNrJJ7S92TDIxZt76PRDLbb34bKrdRGNw==
X-Received: by 2002:a17:90b:4c8c:: with SMTP id my12mr3670789pjb.29.1612263979286;
        Tue, 02 Feb 2021 03:06:19 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-242-11-44.static.tpgi.com.au. [60.242.11.44])
        by smtp.gmail.com with ESMTPSA id g19sm3188979pfk.113.2021.02.02.03.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 03:06:18 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v12 09/14] x86: inline huge vmap supported functions
Date:   Tue,  2 Feb 2021 21:05:10 +1000
Message-Id: <20210202110515.3575274-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210202110515.3575274-1-npiggin@gmail.com>
References: <20210202110515.3575274-1-npiggin@gmail.com>
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

