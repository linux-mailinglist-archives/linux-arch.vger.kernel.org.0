Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410E633E9B7
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 07:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhCQG0F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 02:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhCQGZ4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 02:25:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FC3C06174A;
        Tue, 16 Mar 2021 23:25:56 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so2660250pjh.1;
        Tue, 16 Mar 2021 23:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZnEda0T3pGShx0QqEfgouMD/KA4MVCDJ6OoGinC0gE=;
        b=fLYlcSfNjjYf4im0CmwXX9uFu0R6/2elBdnUDdyYVOlkYQAe04v1WgcG7ZIGlpljT9
         SLjBuUq0fzfMpOxz7InlDaQ4plALW4GVs7HLjWHat3QIhZxnYNHZKbTvtG9NtKWzC/5E
         /MHpVEnov74/4Jb2KNQKv3r6lRMpiz4IbCFj6ozscN3pw0QWY/OlApapX32lg8ev/Geb
         idkPjx22igBJf+xnGC6bLxyblUbSdNaRC7JGRPDPnfOVbd0+5lLwOns57KjSaIMeIuI7
         UL6xeHwUjI8k8Z0g/0VRjA1ERirFFmiNfgZyWk+OUGKwFDiOhV1yCAI+/3GySAB0aDgU
         Xo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZnEda0T3pGShx0QqEfgouMD/KA4MVCDJ6OoGinC0gE=;
        b=OY3wOTPj+Q2Mp3sSZK94peHdF5dHv1oSYpv33qE8qN3nBXG7mRIkNcybg/Ab8ycfqN
         7Tkh0Rw9MbOp3CLO4SKYUBx8h8WOtIW0BKEKb0YgNk7yfq4PVLRywxqZSMJgzjpNt4rx
         8eAsCdByP8f8FckdELAyhMCLOspY8bCg4gWaJLozVsOs2y8lUaYPLo2IEAo7Lv2y3g+1
         mUFEwhLxs8l3Qrt/DXJu6a7qHsYzwtrzuF51Xk4uUlCWOXxKxkbJUFAsO+3NJcu7GR0S
         rtiBqeAxaKx3WOeJv4znPbGas2UNX/e6MaP+RRptZRQQRrqP2WcuupPA7VG9513Wq/co
         S0PA==
X-Gm-Message-State: AOAM532ckFNy/co6vMEA92wLRD3Aghbu+hYQmlYk4mzDZ8m96rvlYnHB
        h7sSvsP39xGuodXXtpfuwIE=
X-Google-Smtp-Source: ABdhPJyRI+bGimVthTrlN06P4ADDSwiZIZdfQrOqluFmWVNVhhZm6lHvDqdPI9QCbgNXHKtlH+H10g==
X-Received: by 2002:a17:902:b60d:b029:e6:7a9:7f4 with SMTP id b13-20020a170902b60db02900e607a907f4mr2850305pls.3.1615962355626;
        Tue, 16 Mar 2021 23:25:55 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id s19sm17959620pfh.168.2021.03.16.23.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:25:55 -0700 (PDT)
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
Subject: [PATCH v13 14/14] powerpc/64s/radix: Enable huge vmalloc mappings
Date:   Wed, 17 Mar 2021 16:24:02 +1000
Message-Id: <20210317062402.533919-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210317062402.533919-1-npiggin@gmail.com>
References: <20210317062402.533919-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This reduces TLB misses by nearly 30x on a `git diff` workload on a
2-node POWER9 (59,800 -> 2,100) and reduces CPU cycles by 0.54%, due
to vfs hashes being allocated with 2MB pages.

Cc: linuxppc-dev@lists.ozlabs.org
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  2 ++
 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/kernel/module.c                  | 22 +++++++++++++++----
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..1f481f904895 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3243,6 +3243,8 @@
 
 	nohugeiomap	[KNL,X86,PPC,ARM64] Disable kernel huge I/O mappings.
 
+	nohugevmalloc	[PPC] Disable kernel huge vmalloc mappings.
+
 	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 386ae12d8523..b7cade9566da 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -181,6 +181,7 @@ config PPC
 	select GENERIC_GETTIMEOFDAY
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if PPC_BOOK3S_64 && PPC_RADIX_MMU
+	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KASAN			if PPC32 && PPC_PAGE_SHIFT <= 14
 	select HAVE_ARCH_KASAN_VMALLOC		if PPC32 && PPC_PAGE_SHIFT <= 14
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index a211b0253cdb..cdb2d88c54e7 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -8,6 +8,7 @@
 #include <linux/moduleloader.h>
 #include <linux/err.h>
 #include <linux/vmalloc.h>
+#include <linux/mm.h>
 #include <linux/bug.h>
 #include <asm/module.h>
 #include <linux/uaccess.h>
@@ -87,13 +88,26 @@ int module_finalize(const Elf_Ehdr *hdr,
 	return 0;
 }
 
-#ifdef MODULES_VADDR
 void *module_alloc(unsigned long size)
 {
+	unsigned long start = VMALLOC_START;
+	unsigned long end = VMALLOC_END;
+
+#ifdef MODULES_VADDR
 	BUILD_BUG_ON(TASK_SIZE > MODULES_VADDR);
+	start = MODULES_VADDR;
+	end = MODULES_END;
+#endif
+
+	/*
+	 * Don't do huge page allocations for modules yet until more testing
+	 * is done. STRICT_MODULE_RWX may require extra work to support this
+	 * too.
+	 */
 
-	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END, GFP_KERNEL,
-				    PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
+	return __vmalloc_node_range(size, 1, start, end, GFP_KERNEL,
+				    PAGE_KERNEL_EXEC,
+				    VM_NO_HUGE_VMAP | VM_FLUSH_RESET_PERMS,
+				    NUMA_NO_NODE,
 				    __builtin_return_address(0));
 }
-#endif
-- 
2.23.0

