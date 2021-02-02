Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D3730BCA5
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 12:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhBBLIC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 06:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhBBLH0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 06:07:26 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869AAC061793;
        Tue,  2 Feb 2021 03:06:46 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id e12so3066766pls.4;
        Tue, 02 Feb 2021 03:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FaeqGDPDVUhZKacvJWFVXk0fi+RckdTnjepUSOw+GFs=;
        b=GjDhNjlo8WM1mrgLHvbOwrxZc7nRXMU/VBM1Tv3rS4CBALQMxNJhejkdeZWxgsByVQ
         r4yA/LHh0e7VOATygXnQKPpfmunhm+FbzuphRBa8mrDo2u6pt5O43a/qtl6zUGt1RfPF
         VK4vr39Wvi728wAAs7nvRQZo1BcofDZiCLayrH71cK1QQh1IXyidpqT/jXEB+/E2kNyA
         aTI6AcJujut2yUfbv8gauXhu6ABhOF/47kNxf9e8vgmxLCnhWJS7+AwxsGyKRCLVB346
         /71rQxibTZobs+WTxOlJ4F6F8kdQT0qcnnrrhRg+CI8PNVsnkS9xCwNpFdBNipMMn2Wc
         JKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FaeqGDPDVUhZKacvJWFVXk0fi+RckdTnjepUSOw+GFs=;
        b=DTTfaT3J6oFPBJEK6aymlCmmHw1jn2P3vjmlCyOztTX6tE7SSsMR9//0Vw0VyDD6U+
         k7X548+32MEmPU4yRkqUPhwYR4Bh/fTMYeaxzVb/o907EAQ6QJVe6B2vYk5rg/jPiN6H
         D55Clu1v32ai0XHx92AtWERIRD5qNHoPLjaTU8wMIRQewqO2Y9pg1n/b1GdXDM5lavn+
         gRdthWzMa2Z/4YeG4wfx/hiajBWGLj7r32KUDssdtTfOwOoTjTd4fbeDe6wPSnDxirYM
         wEK5hR3T8A0Aq1GYpJ4AdSTbiWwSqjXWH+YtLVdmqYElEfnR91WuntJ1+lnGEN476Q4D
         zy9Q==
X-Gm-Message-State: AOAM532MCK6agIdDLbTMyqAblKFq+fCsiM/WHB4hE39cjoQvwWI7MK+o
        dJotebNQXZKBww5WBsgV3yA=
X-Google-Smtp-Source: ABdhPJynX/oPNKQRM+SLHmtxwuqqGcjp2rkz5lI2AnOP58cVv+dR7CCN1OyW9GXsEsXailS2IkyO1g==
X-Received: by 2002:a17:90b:17ca:: with SMTP id me10mr936389pjb.60.1612264006127;
        Tue, 02 Feb 2021 03:06:46 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-242-11-44.static.tpgi.com.au. [60.242.11.44])
        by smtp.gmail.com with ESMTPSA id g19sm3188979pfk.113.2021.02.02.03.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 03:06:45 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v12 14/14] powerpc/64s/radix: Enable huge vmalloc mappings
Date:   Tue,  2 Feb 2021 21:05:15 +1000
Message-Id: <20210202110515.3575274-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210202110515.3575274-1-npiggin@gmail.com>
References: <20210202110515.3575274-1-npiggin@gmail.com>
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
 arch/powerpc/kernel/module.c                  | 21 +++++++++++++++----
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a10b545c2070..d62df53e5200 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3225,6 +3225,8 @@
 
 	nohugeiomap	[KNL,X86,PPC,ARM64] Disable kernel huge I/O mappings.
 
+	nohugevmalloc	[PPC] Disable kernel huge vmalloc mappings.
+
 	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 107bb4319e0e..781da6829ab7 100644
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
index a211b0253cdb..07026335d24d 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -87,13 +87,26 @@ int module_finalize(const Elf_Ehdr *hdr,
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

