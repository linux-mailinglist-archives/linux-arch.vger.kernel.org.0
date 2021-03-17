Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9A833E9B4
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 07:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCQG0C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 02:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhCQGZc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 02:25:32 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509DEC06174A;
        Tue, 16 Mar 2021 23:25:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso766820pjb.4;
        Tue, 16 Mar 2021 23:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZYPzoCQS87jB7WmWdNUk0Mp+gSQWT5jT3H4y8xrQ2c=;
        b=TemPJTyQirvubOQVp3MTVqgduToCHRC+WNtWDBd6YrW98l1Pd+GeF5AvIKJwKAnEFa
         yoWOuLxS2MA+6CX8FJxOiK2ys/TT5n4G6fkmV7xRVbBVqBss3vGasubJo06SqMRyMcEC
         rUAxNhjzINp1/H7KVCEMcIAtX29iO4FV0nKYYbflWw+F34Vnxre2juX4Xpw0AX/kfJQp
         SEBRqHX0rVUPuOmzT35UM+FwVicG7cWE0RYYldxgae5QjWiIMZeQCqQyxtkA1izVvi5s
         BYCSCPYJwBDLG3YCkSIY9ln+PCe3pj3SchbvdduAJ/OIKyStEpLtwlTuzqiZ4jIgo5Y2
         3sQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZYPzoCQS87jB7WmWdNUk0Mp+gSQWT5jT3H4y8xrQ2c=;
        b=sMv9f8grFAA+E+oFUX6OLBpGRiRNCu/TYGlvIHfdNdHzZVy6qUooKoXyD8rTwmAFwh
         y6NT6e24b/vk95vF3tOrkV7FdABngNfy5zi+h5A1Dq76RO8Vz1gvjS2IkExBj1VMbDqX
         pCBy7pJcXqopUxMpMCRTTCiQxSe/ciau4R1GNWMt6/q+ah9YirLsy64gPsc/ZobitcLj
         XtXavQ6iaA2WVJKJPCvinWhz2LHQqODXC+/8WgmmuTIfSVDMddUHYSo/g7M4+dbdT6Uk
         Zk51TpQpCiGMlcrorKoLiUJ+XBhaBhdMauQBB6MXRHj1L4BCQ7nGMe6OC2c0h3YgbXUV
         SCSA==
X-Gm-Message-State: AOAM530H0QgzqMtNqjjurhL19LpX7wp5LLaepqJUkJu+Cf15GnoNpsVy
        +0d+hX4OLvOq304olaiaM0A=
X-Google-Smtp-Source: ABdhPJxtEqE1tM+WOJOAPCcFt+4coTsAHZiBsWq0FVUjYiDsAWrpBV0tiygByrlVKECbzjDzhh0yOg==
X-Received: by 2002:a17:90a:a898:: with SMTP id h24mr2906137pjq.9.1615962331915;
        Tue, 16 Mar 2021 23:25:31 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id s19sm17959620pfh.168.2021.03.16.23.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:25:31 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 10/14] mm/vmalloc: provide fallback arch huge vmap support functions
Date:   Wed, 17 Mar 2021 16:23:58 +1000
Message-Id: <20210317062402.533919-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210317062402.533919-1-npiggin@gmail.com>
References: <20210317062402.533919-1-npiggin@gmail.com>
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
index 4b897a4a408b..82b45e1f28ff 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -78,10 +78,26 @@ struct vmap_area {
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

