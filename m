Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC8339F1B7
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 11:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFHJPV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 05:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFHJPU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 05:15:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF16C61208;
        Tue,  8 Jun 2021 09:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623143608;
        bh=JiiuTjFCB/4PLSsHGFNFns29l9HBPjAxjVfH42hb+H4=;
        h=From:To:Cc:Subject:Date:From;
        b=BvBM91enChDqY6+VuhfUkSW1HXIS9ONW9olMjxmDaKa7XG0xFJ88O84JgyyOUqCn2
         zUlrusQNc+hVn4BaQ/hZVyUb111Dx/0tXSwwa1nft23bMjs842ThUbJ97WIXp48iAN
         r0g3L51e1nIYJ+KG+xqOOKm8wEM0xnzHCbU/F5o+L0LMd7cx2OoQcnKd39oshKQQ8X
         1xoHEyi5Pr0JMt9c9KNVQ+agiuHE3xgktQcWzhfx+TwlsoVquZYtBqrqsWjBXsXwdc
         kvWtnfkm9HI72rJ+KD+i20Cm8mWhZAuWSSvbBxlTAuV4H0sJOC9f3xiWuy2knlZ9v6
         r+gmfpltnZIlA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>, kexec@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH v3 0/9] Remove DISCONTIGMEM memory model
Date:   Tue,  8 Jun 2021 12:13:07 +0300
Message-Id: <20210608091316.3622-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

SPARSEMEM memory model was supposed to entirely replace DISCONTIGMEM a
(long) while ago. The last architectures that used DISCONTIGMEM were
updated to use other memory models in v5.11 and it is about the time to
entirely remove DISCONTIGMEM from the kernel.

This set removes DISCONTIGMEM from alpha, arc and m68k, simplifies memory
model selection in mm/Kconfig and replaces usage of redundant
CONFIG_NEED_MULTIPLE_NODES and CONFIG_FLAT_NODE_MEM_MAP with CONFIG_NUMA
and CONFIG_FLATMEM respectively. 

I've also removed NUMA support on alpha that was BROKEN for more than 15
years.

There were also minor updates all over arch/ to remove mentions of
DISCONTIGMEM in comments and #ifdefs.

v3:
* Remove stale reference of CONFIG_NEED_MULTIPLE_NODES and stale
  discontigmem comment, per Geert
* Add Vineet Acks
* Fix spelling in cover letter subject

v2: Link: https://lore.kernel.org/lkml/20210604064916.26580-1-rppt@kernel.org
* Fix build errors reported by kbuild bot
* Add additional cleanups in m68k as suggested by Geert

v1: Link: https://lore.kernel.org/lkml/20210602105348.13387-1-rppt@kernel.org

Mike Rapoport (9):
  alpha: remove DISCONTIGMEM and NUMA
  arc: update comment about HIGHMEM implementation
  arc: remove support for DISCONTIGMEM
  m68k: remove support for DISCONTIGMEM
  mm: remove CONFIG_DISCONTIGMEM
  arch, mm: remove stale mentions of DISCONIGMEM
  docs: remove description of DISCONTIGMEM
  mm: replace CONFIG_NEED_MULTIPLE_NODES with CONFIG_NUMA
  mm: replace CONFIG_FLAT_NODE_MEM_MAP with CONFIG_FLATMEM

 Documentation/admin-guide/sysctl/vm.rst |  12 +-
 Documentation/vm/memory-model.rst       |  45 +----
 arch/alpha/Kconfig                      |  22 ---
 arch/alpha/include/asm/machvec.h        |   6 -
 arch/alpha/include/asm/mmzone.h         | 100 -----------
 arch/alpha/include/asm/pgtable.h        |   4 -
 arch/alpha/include/asm/topology.h       |  39 -----
 arch/alpha/kernel/core_marvel.c         |  53 +-----
 arch/alpha/kernel/core_wildfire.c       |  29 +--
 arch/alpha/kernel/pci_iommu.c           |  29 ---
 arch/alpha/kernel/proto.h               |   8 -
 arch/alpha/kernel/setup.c               |  16 --
 arch/alpha/kernel/sys_marvel.c          |   5 -
 arch/alpha/kernel/sys_wildfire.c        |   5 -
 arch/alpha/mm/Makefile                  |   2 -
 arch/alpha/mm/init.c                    |   3 -
 arch/alpha/mm/numa.c                    | 223 ------------------------
 arch/arc/Kconfig                        |  13 --
 arch/arc/include/asm/mmzone.h           |  40 -----
 arch/arc/mm/init.c                      |  21 +--
 arch/arm64/Kconfig                      |   2 +-
 arch/ia64/Kconfig                       |   2 +-
 arch/ia64/kernel/topology.c             |   5 +-
 arch/ia64/mm/numa.c                     |   5 +-
 arch/m68k/Kconfig.cpu                   |  10 --
 arch/m68k/include/asm/mmzone.h          |  10 --
 arch/m68k/include/asm/page.h            |   2 +-
 arch/m68k/include/asm/page_mm.h         |  35 ----
 arch/m68k/mm/init.c                     |  20 ---
 arch/mips/Kconfig                       |   2 +-
 arch/mips/include/asm/mmzone.h          |   8 +-
 arch/mips/include/asm/page.h            |   2 +-
 arch/mips/mm/init.c                     |   7 +-
 arch/nds32/include/asm/memory.h         |   6 -
 arch/powerpc/Kconfig                    |   2 +-
 arch/powerpc/include/asm/mmzone.h       |   4 +-
 arch/powerpc/kernel/setup_64.c          |   2 +-
 arch/powerpc/kernel/smp.c               |   2 +-
 arch/powerpc/kexec/core.c               |   4 +-
 arch/powerpc/mm/Makefile                |   2 +-
 arch/powerpc/mm/mem.c                   |   4 +-
 arch/riscv/Kconfig                      |   2 +-
 arch/s390/Kconfig                       |   2 +-
 arch/sh/include/asm/mmzone.h            |   4 +-
 arch/sh/kernel/topology.c               |   2 +-
 arch/sh/mm/Kconfig                      |   2 +-
 arch/sh/mm/init.c                       |   2 +-
 arch/sparc/Kconfig                      |   2 +-
 arch/sparc/include/asm/mmzone.h         |   4 +-
 arch/sparc/kernel/smp_64.c              |   2 +-
 arch/sparc/mm/init_64.c                 |  12 +-
 arch/x86/Kconfig                        |   2 +-
 arch/x86/kernel/setup_percpu.c          |   6 +-
 arch/x86/mm/init_32.c                   |   4 +-
 arch/xtensa/include/asm/page.h          |   4 -
 include/asm-generic/memory_model.h      |  37 +---
 include/asm-generic/topology.h          |   2 +-
 include/linux/gfp.h                     |   4 +-
 include/linux/memblock.h                |   6 +-
 include/linux/mm.h                      |   4 +-
 include/linux/mmzone.h                  |  20 ++-
 kernel/crash_core.c                     |   4 +-
 mm/Kconfig                              |  36 +---
 mm/memblock.c                           |   8 +-
 mm/memory.c                             |   3 +-
 mm/page_alloc.c                         |  25 +--
 mm/page_ext.c                           |   2 +-
 67 files changed, 101 insertions(+), 911 deletions(-)
 delete mode 100644 arch/alpha/include/asm/mmzone.h
 delete mode 100644 arch/alpha/mm/numa.c
 delete mode 100644 arch/arc/include/asm/mmzone.h
 delete mode 100644 arch/m68k/include/asm/mmzone.h


base-commit: c4681547bcce777daf576925a966ffa824edd09d
-- 
2.28.0

