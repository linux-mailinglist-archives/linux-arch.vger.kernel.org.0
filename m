Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298F02CFA29
	for <lists+linux-arch@lfdr.de>; Sat,  5 Dec 2020 08:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbgLEG7a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Dec 2020 01:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387443AbgLEG7a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2020 01:59:30 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5616C061A53;
        Fri,  4 Dec 2020 22:58:49 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id s2so4379047plr.9;
        Fri, 04 Dec 2020 22:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yJtR5xFkunhGW99GQOAU+TGQjkAsTnnQTxf07zcOvgs=;
        b=F0AUUFvJuyPvisQotGkESCF08thwJoD8pLvQ56/LvEXslmEH0PbmpE3VoVsYHUPh5W
         R4sViBSPmYFfv8z31pBurxkieAdobFffotdSKXfs+2S5OID6ZZ07rbUBM/zOjiNNjRsr
         zRXHtgOhNfM9dDwmlzC1SpPNOSfdH3IMYzmJq72shpEdCADu3y8GX/BBhyMKh4OFH/nx
         JDyVkGBQyzZGwfsyzWil2bss/hIM0VPEQHehTp01lUD6ikeVvH7yq/Jh/MZHF0igWAH4
         QZjVQt0sjl4YqvkXzfsPZHwxpwiK/6DWxbxy+JfSP7qEsFVJoHAQmiRucUWNY0F2KecP
         91GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJtR5xFkunhGW99GQOAU+TGQjkAsTnnQTxf07zcOvgs=;
        b=ghpDcIysLxd4Wz/sY2vySiRQ/xl2s7/7exnzI8QR0FjlqotDhWOw8y8sR8FU3b86RO
         cSuZdADpYZ/CNoOzqKFCkvdpuCA9HS4pMRZnRWK7ZVEN6IZrxynd8g7hRdbLuc0icEh0
         PnXIN0DEwjkaNkmQkO5ENPvK0gbIrTSFpxg5oqHP/GlB5a5wbROWCiNteeEuVoP/ziEB
         jMoVNrUxI7OsEDWiJezNGS5f+w+8sIquVCKdBBgzFZeVl4UUatQWAf5zcMgmKX+Z+9xM
         nZjtAculkP4QKlfq2X+qqlGQWScMLXKkn5NCKiLMZcOMVM777VODgjonTy2ZwCFSub2c
         6TsQ==
X-Gm-Message-State: AOAM533CNc97tzo2+UCHLsCsM05+yVbNOHwlCGH67YYpCM6ShtWkQouz
        abwtuULJlwa6IqHBmQVskDA=
X-Google-Smtp-Source: ABdhPJzkUWSPz0m3VE8zS2RyFMHsvOwCooTxRUR8sFq0DkwXmyrcWvagfoOGE71yDd28mcnPgNNnig==
X-Received: by 2002:a17:90b:a53:: with SMTP id gw19mr7522366pjb.216.1607151529339;
        Fri, 04 Dec 2020 22:58:49 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([1.129.145.238])
        by smtp.gmail.com with ESMTPSA id a14sm1110848pfl.141.2020.12.04.22.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 22:58:49 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v9 12/12] powerpc/64s/radix: Enable huge vmalloc mappings
Date:   Sat,  5 Dec 2020 16:57:25 +1000
Message-Id: <20201205065725.1286370-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201205065725.1286370-1-npiggin@gmail.com>
References: <20201205065725.1286370-1-npiggin@gmail.com>
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
index 44fde25bb221..3538c750c583 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3220,6 +3220,8 @@
 
 	nohugeiomap	[KNL,X86,PPC,ARM64] Disable kernel huge I/O mappings.
 
+	nohugevmalloc	[PPC] Disable kernel huge vmalloc mappings.
+
 	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e9f13fe08492..ae10381dd324 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -178,6 +178,7 @@ config PPC
 	select GENERIC_TIME_VSYSCALL
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

