Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FA73054E1
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 08:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317194AbhAZXez (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 18:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbhAZEtF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jan 2021 23:49:05 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8277FC0617A9;
        Mon, 25 Jan 2021 20:46:36 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u4so1501142pjn.4;
        Mon, 25 Jan 2021 20:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXs4Cj6o6shYfoax70RVYzCwBDZMrsiR3W07FJlkL80=;
        b=em2ETLc2fmMNWMdsL7a3G9C/i2KTlvjJT7ObdcOF6dTxLJN4UJJF3wzgBFleaf53AT
         +brJms1nV0OiCanP6bfpsVN2ia/GEYy+ccuiWozVTDcWecdk0KIATFDQlZ39OQO0/Kca
         scrYlMQV+lAJAIB9Nn2lK939PFP+YnSMedpEA9aA4px/tOJFiwoTWEbBbyOawAP26zXh
         wc32fL8hdoqR6jPo3mfxcPbkjMa8tHoM9HdPHK8IlQugbRXoL2W3KKbknEvcp+iJvwfO
         XWld+RkeESUtoiUNVhst5HZrkyn0mPS0nb0LkOGND9BXhUfYdRrxZ0+bPEJXqchqshYh
         BCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXs4Cj6o6shYfoax70RVYzCwBDZMrsiR3W07FJlkL80=;
        b=H3g3v1wTPMFiXu/qoqYgWHLLD1rm4O6OiTl5pvJ5QHbox8qZjAcXsTTdYtooUAcZ9U
         OBhTjrxinb1pt9rQI+og6VY0KA3sThFmDrp33NahoMdjl77EjPPeilVU6j//x+AfOenr
         Tc8hZkyIcKmLlTBhIN6zlsOPqnHE2geUNDZBXfA0nd8F0iYuNcmJ9TUTQXkb1TpwBu8t
         4Q9QycoOCycJ9EtD+MNpiFuFzkpl5WwyFd7ei1BcSlZ4/8jl3xHs1YK9kEeRI20Mo12H
         b8FRt6VdWKXQiBLJAlYGqH8Yp0GNbRB597IK2zXSdHdYIVPFGdMzjJFnkO6mBhkTPRY0
         NUiQ==
X-Gm-Message-State: AOAM530xq8BM8UOli0onGZBFwLRFSjctEVO+F7YvJW1LuTzsrceWqsJp
        dpA8IP9DETk1jErE8Jq+lss=
X-Google-Smtp-Source: ABdhPJx2FC7TaGsOZdYSD6/GYNfkxxHgUEWaT66Dp7jYgo96FrqrcmfF5Lm5CEJMTTzSqN0js60PAw==
X-Received: by 2002:a17:90b:1b50:: with SMTP id nv16mr3816102pjb.153.1611636396072;
        Mon, 25 Jan 2021 20:46:36 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id 68sm19272293pfg.90.2021.01.25.20.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:46:35 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>
Subject: [PATCH v11 13/13] powerpc/64s/radix: Enable huge vmalloc mappings
Date:   Tue, 26 Jan 2021 14:45:10 +1000
Message-Id: <20210126044510.2491820-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210126044510.2491820-1-npiggin@gmail.com>
References: <20210126044510.2491820-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: linuxppc-dev@lists.ozlabs.org
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

