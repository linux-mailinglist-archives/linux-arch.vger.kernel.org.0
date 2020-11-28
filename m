Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4DE2C7253
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbgK1VuV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387464AbgK1TKB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Nov 2020 14:10:01 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF8EC02A1BA;
        Sat, 28 Nov 2020 07:26:40 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b6so7038820pfp.7;
        Sat, 28 Nov 2020 07:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HiUfAFVtYQfdJFI+mGar/loPm26LbyhdUt8nmYytWQQ=;
        b=A3gGRu5dqYV4wlZ1HSMJuyRU2KVVwSna1s3allWsCrZSZpCden2jSG3fkW0rG9vz/j
         OtwCPxKAT8km/uQ1MKkUTu+QQDOSRZz9Hzvlp84CtqVqt2QaW3W+BXA8nw8oS42FCk3D
         Azmf7mgnir2eebHu/lAGtKDiTTWUG2syQoNQrH+d1khykwyjooZsbc2r3TF2hSyHQIhm
         3tDJdb7yepKfdD5AnW43ThT9SNKtq6CeOzsAebOHgQdq/JsCqQdfzhZHOEQjmjzL0m9l
         c+psqyyU7shRB1jTsu/aoB1FFHlHZ8Dg+vWnnloIJjBpih1pKn8m0l3vYMnDVyWGh9bl
         jWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HiUfAFVtYQfdJFI+mGar/loPm26LbyhdUt8nmYytWQQ=;
        b=N9Ftq7ib8pYVRttS07MW/wN5hSuYsR95/HH5U1iT2iuzAEdKWlVQu/vU9izzELjSwR
         exfaqO0+YUjLrfp/1223OOMWyczjXRw3wyhcyU5MjgKcv4oLrgCqjdB4drYj6VjrzCXC
         grORLa/dCDEqjJ/Pedpo5cL7bn3rZqdVET0+1UWBaaJ3hZZUbpnxHaMEhzR2gq9N0l4V
         8WOigCLZ6KxeHMsewmlf826lqg7A4JIZuE5/xoJaWMYiDmIBoleAGqXJLouGu2JNSM10
         7wtyeACCWF7lfMZ80E2PhMulwAMj22IaLQFJtOdaPkQeN4FtEC5RG7QQUUhmMHbkLrVJ
         pXNw==
X-Gm-Message-State: AOAM530ms4g3ka+iu5WocYFR4I0fl5YF+tH54KIVK18+KvGqyKiDGpEX
        qWysDZH4gNPk9UMzho//3C8=
X-Google-Smtp-Source: ABdhPJyehobbdhtJfrsGlBn/msduPYZSxJp3aAhhQmtc5CYMrltqWkZrPiWvHMpKGy2rAjgf56PwLA==
X-Received: by 2002:a17:90a:a781:: with SMTP id f1mr17051655pjq.50.1606577199740;
        Sat, 28 Nov 2020 07:26:39 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
        by smtp.gmail.com with ESMTPSA id d22sm15500173pjw.11.2020.11.28.07.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 07:26:39 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v8 06/12] powerpc: inline huge vmap supported functions
Date:   Sun, 29 Nov 2020 01:25:53 +1000
Message-Id: <20201128152559.999540-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201128152559.999540-1-npiggin@gmail.com>
References: <20201128152559.999540-1-npiggin@gmail.com>
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
index ab426fc0cd4b..de6b558dc187 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1121,22 +1121,6 @@ void radix__ptep_modify_prot_commit(struct vm_area_struct *vma,
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
@@ -1220,8 +1204,3 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 	return 1;
 }
-
-bool arch_vmap_p4d_supported(pgprot_t prot)
-{
-	return false;
-}
-- 
2.23.0

