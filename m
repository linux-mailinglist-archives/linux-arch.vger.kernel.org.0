Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758DC30BC9E
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 12:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBBLHX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 06:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhBBLHF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 06:07:05 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9FDC06174A;
        Tue,  2 Feb 2021 03:06:25 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l18so2137419pji.3;
        Tue, 02 Feb 2021 03:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lMXxcBBy/xQXQTcochNJF8nT4LcHlfjkVSMPRZcRaCo=;
        b=P9X0tKzPVh3X8icAkA+hrs7C0DhgEL50Q07jTDYcmvewtx+OuFtIlQkHhp+Af4lqCo
         Z0/AtcMXsrVmsDoPDxUmtW9HeLGSfabpLVwOv/gjYwFHjM5Z5NB6nNyzBymirEmQsdVT
         Ra4urJDJ00vmsU2WWPnBiLbSUqnDt1Qj6Ii+V9/jKOaavs2rMuyXCLJT43EbLiXpY5Az
         CkPMSrv5YsS8k+Bfce7KxucoIq6pP9X3hRLRet9R4bD+IbPEmrh7nfpEUg7TpuhU3TAz
         8qsbQgqp5nnldr8ua8LJ4if+RjNtzRVcT1GRbzdvo9uSkqYpOT8mZXZ3Pc43Kc9jwQv6
         ElFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMXxcBBy/xQXQTcochNJF8nT4LcHlfjkVSMPRZcRaCo=;
        b=RaLS6UmFZOP+wSGS/0y0L0wVEqcvJDbReywGQ+u3CwOavaYDJKNcHH8fCtKPCiRRCF
         vGYbn/efzCjIoCn+UT5L4HdKi6Fjwh5thU8V1U8UfLqrgdgVUDWA4DBP/nuqIzLx/NJ+
         JQxiGNh4WQDk+LqwEs5t6mm3C/SoHsitcc+/AsC/ns5rf48Ukd2G2v6VppgUSt5wlfb5
         ZkRlU/QEjp4ClLV/3+jLwBbvgeyQ1q1qgNDVzBlZ+8YGC4qZU9/32ON98rnxgWbPu6bu
         033w3Zi4StIUWk8KVTGSUS+JmxC2ikt0CUV+MQMc9xKXGTQeFABHa6GgH+3CkVdoFaB3
         hMig==
X-Gm-Message-State: AOAM533x1Qeojrj4dGP0p4RI01VbTklVekb2R3v++/hsqEWUN2aBswgJ
        lHXTgczB1upoLfEw5eGUw8I=
X-Google-Smtp-Source: ABdhPJw/k7SH87TT2sZ2Wk1zP4IJUTV/dg8VBxSGnAUMlbRhuSf540ulyZxyUqtyvfARihfiitoXyA==
X-Received: by 2002:a17:902:d510:b029:de:72a4:ebf1 with SMTP id b16-20020a170902d510b02900de72a4ebf1mr22189608plg.11.1612263985005;
        Tue, 02 Feb 2021 03:06:25 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-242-11-44.static.tpgi.com.au. [60.242.11.44])
        by smtp.gmail.com with ESMTPSA id g19sm3188979pfk.113.2021.02.02.03.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 03:06:24 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v12 10/14] mm/vmalloc: provide fallback arch huge vmap support functions
Date:   Tue,  2 Feb 2021 21:05:11 +1000
Message-Id: <20210202110515.3575274-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210202110515.3575274-1-npiggin@gmail.com>
References: <20210202110515.3575274-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If an architecture doesn't support a particular page table level as
a huge vmap page size then allow it to skip defining the support
query function.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm64/include/asm/vmalloc.h   |  7 +++----
 arch/powerpc/include/asm/vmalloc.h |  7 +++----
 arch/x86/include/asm/vmalloc.h     | 13 +++++--------
 include/linux/vmalloc.h            | 24 ++++++++++++++++++++----
 4 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
index fc9a12d6cc1a..7a22aeea9bb5 100644
--- a/arch/arm64/include/asm/vmalloc.h
+++ b/arch/arm64/include/asm/vmalloc.h
@@ -4,11 +4,8 @@
 #include <asm/page.h>
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-static inline bool arch_vmap_p4d_supported(pgprot_t prot)
-{
-	return false;
-}
 
+#define arch_vmap_pud_supported arch_vmap_pud_supported
 static inline bool arch_vmap_pud_supported(pgprot_t prot)
 {
 	/*
@@ -19,11 +16,13 @@ static inline bool arch_vmap_pud_supported(pgprot_t prot)
 	       !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
 }
 
+#define arch_vmap_pmd_supported arch_vmap_pmd_supported
 static inline bool arch_vmap_pmd_supported(pgprot_t prot)
 {
 	/* See arch_vmap_pud_supported() */
 	return !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
 }
+
 #endif
 
 #endif /* _ASM_ARM64_VMALLOC_H */
diff --git a/arch/powerpc/include/asm/vmalloc.h b/arch/powerpc/include/asm/vmalloc.h
index 3f0c153befb0..4c69ece52a31 100644
--- a/arch/powerpc/include/asm/vmalloc.h
+++ b/arch/powerpc/include/asm/vmalloc.h
@@ -5,21 +5,20 @@
 #include <asm/page.h>
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-static inline bool arch_vmap_p4d_supported(pgprot_t prot)
-{
-	return false;
-}
 
+#define arch_vmap_pud_supported arch_vmap_pud_supported
 static inline bool arch_vmap_pud_supported(pgprot_t prot)
 {
 	/* HPT does not cope with large pages in the vmalloc area */
 	return radix_enabled();
 }
 
+#define arch_vmap_pmd_supported arch_vmap_pmd_supported
 static inline bool arch_vmap_pmd_supported(pgprot_t prot)
 {
 	return radix_enabled();
 }
+
 #endif
 
 #endif /* _ASM_POWERPC_VMALLOC_H */
diff --git a/arch/x86/include/asm/vmalloc.h b/arch/x86/include/asm/vmalloc.h
index e714b00fc0ca..49ce331f3ac6 100644
--- a/arch/x86/include/asm/vmalloc.h
+++ b/arch/x86/include/asm/vmalloc.h
@@ -6,24 +6,21 @@
 #include <asm/pgtable_areas.h>
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-static inline bool arch_vmap_p4d_supported(pgprot_t prot)
-{
-	return false;
-}
 
+#ifdef CONFIG_X86_64
+#define arch_vmap_pud_supported arch_vmap_pud_supported
 static inline bool arch_vmap_pud_supported(pgprot_t prot)
 {
-#ifdef CONFIG_X86_64
 	return boot_cpu_has(X86_FEATURE_GBPAGES);
-#else
-	return false;
-#endif
 }
+#endif
 
+#define arch_vmap_pmd_supported arch_vmap_pmd_supported
 static inline bool arch_vmap_pmd_supported(pgprot_t prot)
 {
 	return boot_cpu_has(X86_FEATURE_PSE);
 }
+
 #endif
 
 #endif /* _ASM_X86_VMALLOC_H */
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 00bd62bd701e..9f7b8b00101b 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -83,10 +83,26 @@ struct vmap_area {
 	};
 };
 
-#ifndef CONFIG_HAVE_ARCH_HUGE_VMAP
-static inline bool arch_vmap_p4d_supported(pgprot_t prot) { return false; }
-static inline bool arch_vmap_pud_supported(pgprot_t prot) { return false; }
-static inline bool arch_vmap_pmd_supported(pgprot_t prot) { return false; }
+/* archs that select HAVE_ARCH_HUGE_VMAP should override one or more of these */
+#ifndef arch_vmap_p4d_supported
+static inline bool arch_vmap_p4d_supported(pgprot_t prot)
+{
+	return false;
+}
+#endif
+
+#ifndef arch_vmap_pud_supported
+static inline bool arch_vmap_pud_supported(pgprot_t prot)
+{
+	return false;
+}
+#endif
+
+#ifndef arch_vmap_pmd_supported
+static inline bool arch_vmap_pmd_supported(pgprot_t prot)
+{
+	return false;
+}
 #endif
 
 /*
-- 
2.23.0

