Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299E9363FD0
	for <lists+linux-arch@lfdr.de>; Mon, 19 Apr 2021 12:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbhDSKr6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Apr 2021 06:47:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:21887 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhDSKr5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Apr 2021 06:47:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FP3RZ1t4YzB09b3;
        Mon, 19 Apr 2021 12:47:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9QVuXNyI7_rG; Mon, 19 Apr 2021 12:47:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FP3RZ0mYfzB09Zy;
        Mon, 19 Apr 2021 12:47:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EF5F18B7BB;
        Mon, 19 Apr 2021 12:47:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZHZ7-PNlqPXU; Mon, 19 Apr 2021 12:47:26 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C10348B7B4;
        Mon, 19 Apr 2021 12:47:26 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B9BAC679FC; Mon, 19 Apr 2021 10:47:26 +0000 (UTC)
Message-Id: <c433e358190fb5d47650463ea1ab755fc7b73e6e.1618828806.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1618828806.git.christophe.leroy@csgroup.eu>
References: <cover.1618828806.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 2/4] powerpc/mm: Leave a gap between early allocated IO
 areas
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org,
        dja@axtens.net
Cc:     Oliver O'Halloran <oohall@gmail.com>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Mon, 19 Apr 2021 10:47:26 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Vmalloc system leaves a gap between allocated areas. It helps catching
overflows.

Do the same for IO areas which are allocated with early_ioremap_range()
until slab_is_available().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/ioremap_32.c | 4 ++--
 arch/powerpc/mm/ioremap_64.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/ioremap_32.c b/arch/powerpc/mm/ioremap_32.c
index 743e11384dea..9d13143b8be4 100644
--- a/arch/powerpc/mm/ioremap_32.c
+++ b/arch/powerpc/mm/ioremap_32.c
@@ -70,10 +70,10 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, pgprot_t prot, void *call
 	 */
 	pr_warn("ioremap() called early from %pS. Use early_ioremap() instead\n", caller);
 
-	err = early_ioremap_range(ioremap_bot - size, p, size, prot);
+	err = early_ioremap_range(ioremap_bot - size - PAGE_SIZE, p, size, prot);
 	if (err)
 		return NULL;
-	ioremap_bot -= size;
+	ioremap_bot -= size + PAGE_SIZE;
 
 	return (void __iomem *)ioremap_bot + offset;
 }
diff --git a/arch/powerpc/mm/ioremap_64.c b/arch/powerpc/mm/ioremap_64.c
index ba5cbb0d66bd..3acece00b33e 100644
--- a/arch/powerpc/mm/ioremap_64.c
+++ b/arch/powerpc/mm/ioremap_64.c
@@ -38,7 +38,7 @@ void __iomem *__ioremap_caller(phys_addr_t addr, unsigned long size,
 		return NULL;
 
 	ret = (void __iomem *)ioremap_bot + offset;
-	ioremap_bot += size;
+	ioremap_bot += size + PAGE_SIZE;
 
 	return ret;
 }
-- 
2.25.0

