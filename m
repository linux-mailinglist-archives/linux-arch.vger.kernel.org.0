Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7DF301AA0
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jan 2021 09:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbhAXIa0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jan 2021 03:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbhAXIY5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jan 2021 03:24:57 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E91C06178C;
        Sun, 24 Jan 2021 00:24:02 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id q2so2976643plk.4;
        Sun, 24 Jan 2021 00:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X4PdAkKAj1M/Yo1TeEkwcmE5+wLYrx2vqWkun80SjU4=;
        b=SFxxpwF4aZqAtiyha8DpNwD8NhP2VPk/75SmbcOcUMe8/tsdfJEhfXIo72nG1U14DU
         /Lfme/sKGozWIGX0E2hSH8Mi7eKm/t+eYpIlLC1+AGsIAouFEPWAWEPQ5E2m1pe4ABGR
         35pNfkvvqCINxLbhZT5Hq4lI7a3fhieQBBuWzw14T0cITiJIeHWoZrFD0AVaieTifYF3
         jM6UOz0iA0NrXmVRl77vIVdAkSKXjl4Bf57i/GvL3hmvpx0acyI1x74L9491tfkkkeMK
         zEfDoR3CJ3WHkKTAVtJmYF4vJM1atUQiY108Xs6ol5GzVxQ9tLCHsdLKFzL4raSrcER4
         X60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X4PdAkKAj1M/Yo1TeEkwcmE5+wLYrx2vqWkun80SjU4=;
        b=nvNPfSS8dKeHNtB9GXqJK1mjFGKCotpkLKYyDU4PYvxnMrNwTFIa7IByfXbi85Z0e5
         QZIMfo0t+xcW3gsRoLyFSeqY16dUomiNjb0dCDy957ewtHG4EHpgo11kqdN4s+VBEa9m
         9exVRrvg2xeym6MT7PQ/Aq06VBjzLFIxIKfqTPwkstgUBf99hoVPxF1F+Q/KDeKyPLNx
         0UqQTVulQk4INzNVaVy7aaqM+aQWQ27cxrPTQeKT5YdJJ0coAY7sEL1fLcMjDj//tJ3V
         laQEBQlJATc7XKKga+JYNxPPOQYRJZPsRb/qUOYiV5gthElfRgMhIUdlAcGSXZG14qGe
         R4Mg==
X-Gm-Message-State: AOAM532IOL3TxAgifO4dr+2YqW29zXwl7p+feGNFek+wnZjcMtASFQkM
        gJWpkjXOlNktkrlWcnm5Bqw=
X-Google-Smtp-Source: ABdhPJwWSI9slFc6FiGRew3Dj4/h6/vkxLw9qnQk1wa1Zw10/YWu1xYbDC+boiJwyVxb/47ASvxmaA==
X-Received: by 2002:a17:902:e84e:b029:de:45bf:1296 with SMTP id t14-20020a170902e84eb02900de45bf1296mr7950370plg.49.1611476641776;
        Sun, 24 Jan 2021 00:24:01 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([124.170.13.62])
        by smtp.gmail.com with ESMTPSA id gb12sm11799757pjb.51.2021.01.24.00.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 00:24:01 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>
Subject: [PATCH v10 12/12] powerpc/64s/radix: Enable huge vmalloc mappings
Date:   Sun, 24 Jan 2021 18:22:30 +1000
Message-Id: <20210124082230.2118861-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210124082230.2118861-1-npiggin@gmail.com>
References: <20210124082230.2118861-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 arch/powerpc/Kconfig                            |  1 +
 arch/powerpc/kernel/module.c                    | 13 +++++++++++--
 3 files changed, 14 insertions(+), 2 deletions(-)

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
index a211b0253cdb..bc2695eeeb4c 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -92,8 +92,17 @@ void *module_alloc(unsigned long size)
 {
 	BUILD_BUG_ON(TASK_SIZE > MODULES_VADDR);
 
-	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END, GFP_KERNEL,
-				    PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
+	/*
+	 * Don't do huge page allocations for modules yet until more testing
+	 * is done. STRICT_MODULE_RWX may require extra work to support this
+	 * too.
+	 */
+
+	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
+				    GFP_KERNEL,
+				    PAGE_KERNEL_EXEC,
+				    VM_NOHUGE | VM_FLUSH_RESET_PERMS,
+				    NUMA_NO_NODE,
 				    __builtin_return_address(0));
 }
 #endif
-- 
2.23.0

