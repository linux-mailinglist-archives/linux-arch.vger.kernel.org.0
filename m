Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D943054E7
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 08:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317159AbhAZXcL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 18:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbhAZEsZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jan 2021 23:48:25 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514ACC06178B;
        Mon, 25 Jan 2021 20:46:15 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l18so1501955pji.3;
        Mon, 25 Jan 2021 20:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gApOKbU6H3fO0DOtJ4xuolfMmes5P/L4pnflvulqjKs=;
        b=J12z3jif/XPiTYZb7Tn6H2wNEPPg9fOcdC17l8zNulNwMm3k5YZYnhlBx+CQtiUN0t
         FNZNd8qgYrkTBrfASSZSofGt+UgLsrMPgvtSXktDLy1B8s7MFTBQYwzXSUMrR3SRv37q
         Yh60PhLt+ONpXaW2TPkwUVrC8mYiY/4CucBgy4AoGqNqtG6En9JS7GBTQgqNpGtl1AiZ
         mSGRgAbVNQTy5/2sJb1B8j7vdP1oW4XmRsN4e3VjlXQmDKg9V8niuzf2xO3N9p7+6rt/
         zZGwfQF/1nWlX1IJQGnFmfnRj2ieyieS2DcomKckIFvFVvY8MYIIaAcj98XGI/sv4fw8
         jEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gApOKbU6H3fO0DOtJ4xuolfMmes5P/L4pnflvulqjKs=;
        b=eJDkX5CRv7aVQVbO0e7f9t4OdkssDym9HtE+Jpe0rJ7HkGIML2vEYsPBS8OwKFGoGX
         7EC2b9iiIUB2VgNfRdzsgTWrrYP9BB1dyJh7g/r5k3eV74cdSLkaVDr1qzcHI6lY37vN
         Wqoe2ESY17BUu04YGw9mHnBWrF56GrM3N3IbPsXEIPMIcKy0XbIcmub6e/6v3PujtsAS
         DbqD6EY+Hh6kh9jooS81JHbXOcq1u2nGhugcyBTnGaD2JTMB9S3A0SO96t9M35QrJ4Mc
         Wtrrn/1eLsCscfXuJ9UBi3knql5PLEXewYeIPiGDiXm5qu/cmZRI6YT5lWdjUXmsMTcG
         Yd/Q==
X-Gm-Message-State: AOAM533X+879ofic8ASBdB5WoToH0nkUWcBZG7LM09lzWYcBuV4ygmoj
        1HtSFgA/xtKH3mc7OKtNnXk=
X-Google-Smtp-Source: ABdhPJy9i7oKiPdhuf/AF9Q80a0Jgn5v98zhIuT84Z/8lhpx28KUNiXyS/LgF6cLICfknkVh6SwdGQ==
X-Received: by 2002:a17:902:d915:b029:de:30a3:fdd6 with SMTP id c21-20020a170902d915b02900de30a3fdd6mr3938742plz.45.1611636374963;
        Mon, 25 Jan 2021 20:46:14 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id 68sm19272293pfg.90.2021.01.25.20.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:46:14 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>
Subject: [PATCH v11 09/13] mm/vmalloc: provide fallback arch huge vmap support functions
Date:   Tue, 26 Jan 2021 14:45:06 +1000
Message-Id: <20210126044510.2491820-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210126044510.2491820-1-npiggin@gmail.com>
References: <20210126044510.2491820-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If an architecture doesn't support a particular page table level as
a huge vmap page size then allow it to skip defining the support
query function.

Suggested-by: Christoph Hellwig <hch@infradead.org>
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

