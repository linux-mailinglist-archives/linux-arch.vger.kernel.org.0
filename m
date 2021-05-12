Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA4F37B56A
	for <lists+linux-arch@lfdr.de>; Wed, 12 May 2021 07:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhELFVi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 May 2021 01:21:38 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:36271 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230095AbhELFVh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 May 2021 01:21:37 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Fg2gM6bvBz9sf5;
        Wed, 12 May 2021 07:01:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uaQLlcVkEpMb; Wed, 12 May 2021 07:01:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Fg2gL5p7cz9sdw;
        Wed, 12 May 2021 07:01:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 713888B7D6;
        Wed, 12 May 2021 07:01:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nr1Qn5Y6fAJk; Wed, 12 May 2021 07:01:02 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 006F48B769;
        Wed, 12 May 2021 07:01:01 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D2BC764164; Wed, 12 May 2021 05:01:01 +0000 (UTC)
Message-Id: <2c717e3b1fba1894d890feb7669f83025bfa314d.1620795204.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1620795204.git.christophe.leroy@csgroup.eu>
References: <cover.1620795204.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 4/5] mm/vmalloc: Enable mapping of huge pages at pte level
 in vmalloc
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 12 May 2021 05:01:01 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On some architectures like powerpc, there are huge pages that
are mapped at pte level.

Enable it in vmalloc.

For that, architectures can provide arch_vmap_pte_supported_shift()
that returns the shift for pages to map at pte level.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/vmalloc.h |  7 +++++++
 mm/vmalloc.c            | 13 +++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 13c9b19ec923..bf0a1b7a824e 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -112,6 +112,13 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr, uns
 }
 #endif
 
+#ifndef arch_vmap_pte_supported_shift
+static inline int arch_vmap_pte_supported_shift(unsigned long size)
+{
+	return PAGE_SHIFT;
+}
+#endif
+
 /*
  *	Highlevel APIs for driver use
  */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 783d23b8c2f7..3de5291c20cd 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2895,8 +2895,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		return NULL;
 	}
 
-	if (vmap_allow_huge && !(vm_flags & VM_NO_HUGE_VMAP) &&
-			arch_vmap_pmd_supported(prot)) {
+	if (vmap_allow_huge && !(vm_flags & VM_NO_HUGE_VMAP)) {
 		unsigned long size_per_node;
 
 		/*
@@ -2909,11 +2908,13 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		size_per_node = size;
 		if (node == NUMA_NO_NODE)
 			size_per_node /= num_online_nodes();
-		if (size_per_node >= PMD_SIZE) {
+		if (arch_vmap_pmd_supported(prot) && size_per_node >= PMD_SIZE)
 			shift = PMD_SHIFT;
-			align = max(real_align, 1UL << shift);
-			size = ALIGN(real_size, 1UL << shift);
-		}
+		else
+			shift = arch_vmap_pte_supported_shift(size_per_node);
+
+		align = max(real_align, 1UL << shift);
+		size = ALIGN(real_size, 1UL << shift);
 	}
 
 again:
-- 
2.25.0

