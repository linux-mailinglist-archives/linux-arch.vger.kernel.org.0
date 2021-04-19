Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D15363FD1
	for <lists+linux-arch@lfdr.de>; Mon, 19 Apr 2021 12:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbhDSKr6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Apr 2021 06:47:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:26731 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232539AbhDSKr5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Apr 2021 06:47:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FP3RX3d3FzB09b1;
        Mon, 19 Apr 2021 12:47:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PNvDtWqSfhJq; Mon, 19 Apr 2021 12:47:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FP3RX2Dw7zB09Zy;
        Mon, 19 Apr 2021 12:47:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2023B8B7BB;
        Mon, 19 Apr 2021 12:47:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vL0j2I5OqooE; Mon, 19 Apr 2021 12:47:25 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D2F1A8B7B4;
        Mon, 19 Apr 2021 12:47:24 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B2CDC679FC; Mon, 19 Apr 2021 10:47:24 +0000 (UTC)
Message-Id: <cover.1618828806.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 0/4] Convert powerpc to GENERIC_PTDUMP
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org,
        dja@axtens.net
Cc:     Oliver O'Halloran <oohall@gmail.com>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Mon, 19 Apr 2021 10:47:24 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series converts powerpc to generic PTDUMP.

For that, we first need to add missing hugepd support
to pagewalk and ptdump.

v2:
- Reworked the pagewalk modification to add locking and check ops->pte_entry
- Modified powerpc early IO mapping to have gaps between mappings
- Removed the logic that checked for contiguous physical memory
- Removed the articial level calculation in ptdump_pte_entry(), level 4 is ok for all.
- Removed page_size argument to note_page()

Christophe Leroy (4):
  mm: pagewalk: Fix walk for hugepage tables
  powerpc/mm: Leave a gap between early allocated IO areas
  powerpc/mm: Properly coalesce pages in ptdump
  powerpc/mm: Convert powerpc to GENERIC_PTDUMP

 arch/powerpc/Kconfig              |   2 +
 arch/powerpc/Kconfig.debug        |  30 -----
 arch/powerpc/mm/Makefile          |   2 +-
 arch/powerpc/mm/ioremap_32.c      |   4 +-
 arch/powerpc/mm/ioremap_64.c      |   2 +-
 arch/powerpc/mm/mmu_decl.h        |   2 +-
 arch/powerpc/mm/ptdump/8xx.c      |   6 +-
 arch/powerpc/mm/ptdump/Makefile   |   9 +-
 arch/powerpc/mm/ptdump/book3s64.c |   6 +-
 arch/powerpc/mm/ptdump/ptdump.c   | 187 ++++++++----------------------
 arch/powerpc/mm/ptdump/shared.c   |   6 +-
 mm/pagewalk.c                     |  58 ++++++++-
 12 files changed, 127 insertions(+), 187 deletions(-)

-- 
2.25.0

