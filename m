Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81A736DD54
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 18:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbhD1QrA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 12:47:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36618 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241139AbhD1Qq6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 12:46:58 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FVkzS05MQz9tcb;
        Wed, 28 Apr 2021 18:46:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0mBuk7O_7kHk; Wed, 28 Apr 2021 18:46:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FVkzR6Cxgz9tcY;
        Wed, 28 Apr 2021 18:46:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 720158B839;
        Wed, 28 Apr 2021 18:46:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ikFClZJogkW5; Wed, 28 Apr 2021 18:46:11 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EDB278B831;
        Wed, 28 Apr 2021 18:46:10 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B90C16428C; Wed, 28 Apr 2021 16:46:10 +0000 (UTC)
Message-Id: <cover.1619628001.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 0/4] Implement huge VMAP and VMALLOC on powerpc 8xx
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 28 Apr 2021 16:46:10 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series is a first tentative to implement huge VMAP and VMALLOC
on powerpc 8xx. This series applies on Linux next.
For the time being the 8xx specificities are plugged directly into
generic mm functions. I have no real idea on how to make it a nice
beautiful generic implementation for the time being, hence this RFC
in order to get suggestions.

powerpc 8xx has 4 page sizes:
- 4k
- 16k
- 512k
- 8M

At the time being, vmalloc and vmap only support huge pages which are
leaf at PMD level.

Here the PMD level is 4M, it doesn't correspond to any supported
page size.

For the time being, implement use of 16k and 512k pages which is done
at PTE level.

Support of 8M pages will be implemented later, it requires use of
hugepd tables.

Christophe Leroy (4):
  mm/ioremap: Fix iomap_max_page_shift
  mm/hugetlb: Change parameters of arch_make_huge_pte()
  mm/pgtable: Add stubs for {pmd/pub}_{set/clear}_huge
  mm/vmalloc: Add support for huge pages on VMAP and VMALLOC for powerpc
    8xx

 arch/arm64/include/asm/hugetlb.h              |  3 +-
 arch/arm64/mm/hugetlbpage.c                   |  5 +-
 arch/powerpc/Kconfig                          |  3 +-
 .../include/asm/nohash/32/hugetlb-8xx.h       |  5 +-
 arch/sparc/include/asm/pgtable_64.h           |  3 +-
 arch/sparc/mm/hugetlbpage.c                   |  6 +-
 include/linux/hugetlb.h                       |  4 +-
 include/linux/pgtable.h                       | 26 ++++++-
 mm/hugetlb.c                                  |  6 +-
 mm/ioremap.c                                  |  6 +-
 mm/migrate.c                                  |  4 +-
 mm/vmalloc.c                                  | 74 ++++++++++++++++---
 12 files changed, 111 insertions(+), 34 deletions(-)

-- 
2.25.0

