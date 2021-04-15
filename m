Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5853610E5
	for <lists+linux-arch@lfdr.de>; Thu, 15 Apr 2021 19:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhDORSk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 13:18:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38735 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233343AbhDORSj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 13:18:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FLmJQ28nVz9vBLm;
        Thu, 15 Apr 2021 19:18:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xQ_LIEXY2H5D; Thu, 15 Apr 2021 19:18:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FLmJQ08Wvz9tyvC;
        Thu, 15 Apr 2021 19:18:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F13E68B804;
        Thu, 15 Apr 2021 19:18:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CN9zIg9V5yLe; Thu, 15 Apr 2021 19:18:13 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B7A058B7F6;
        Thu, 15 Apr 2021 19:18:13 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7341B679F6; Thu, 15 Apr 2021 17:18:13 +0000 (UTC)
Message-Id: <cover.1618506910.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 0/5] Convert powerpc to GENERIC_PTDUMP
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org, linux-mm@kvack.org
Date:   Thu, 15 Apr 2021 17:18:13 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series converts powerpc to generic PTDUMP.

For that, we first need to add missing hugepd support
to pagewalk and ptdump.

Christophe Leroy (5):
  mm: pagewalk: Fix walk for hugepage tables
  mm: ptdump: Fix build failure
  mm: ptdump: Provide page size to notepage()
  mm: ptdump: Support hugepd table entries
  powerpc/mm: Convert powerpc to GENERIC_PTDUMP

 arch/arm64/mm/ptdump.c            |   2 +-
 arch/powerpc/Kconfig              |   2 +
 arch/powerpc/Kconfig.debug        |  30 ------
 arch/powerpc/mm/Makefile          |   2 +-
 arch/powerpc/mm/mmu_decl.h        |   2 +-
 arch/powerpc/mm/ptdump/8xx.c      |   6 +-
 arch/powerpc/mm/ptdump/Makefile   |   9 +-
 arch/powerpc/mm/ptdump/book3s64.c |   6 +-
 arch/powerpc/mm/ptdump/ptdump.c   | 161 +++++++++---------------------
 arch/powerpc/mm/ptdump/shared.c   |   6 +-
 arch/riscv/mm/ptdump.c            |   2 +-
 arch/s390/mm/dump_pagetables.c    |   3 +-
 arch/x86/mm/dump_pagetables.c     |   2 +-
 include/linux/ptdump.h            |   2 +-
 mm/pagewalk.c                     |  54 ++++++++--
 mm/ptdump.c                       |  33 ++++--
 16 files changed, 145 insertions(+), 177 deletions(-)

-- 
2.25.0

