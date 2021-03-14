Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CFE33A3BB
	for <lists+linux-arch@lfdr.de>; Sun, 14 Mar 2021 10:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbhCNJKn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 14 Mar 2021 05:10:43 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:34785 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbhCNJKg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Mar 2021 05:10:36 -0400
X-Originating-IP: 2.7.49.219
Received: from debian.home (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 7201E20002;
        Sun, 14 Mar 2021 09:10:29 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v3 0/3] Move kernel mapping outside the linear mapping 
Date:   Sun, 14 Mar 2021 05:10:24 -0400
Message-Id: <20210314091027.21592-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I decided to split sv48 support in small series to ease the review.

This patchset pushes the kernel mapping (modules and BPF too) to the last
4GB of the 64bit address space, this allows to:
- implement relocatable kernel (that will come later in another
  patchset) that requires to move the kernel mapping out of the linear
  mapping to avoid to copy the kernel at a different physical address.
- have a single kernel that is not relocatable (and then that avoids the
  performance penalty imposed by PIC kernel) for both sv39 and sv48.

The first patch implements this behaviour, the second patch introduces a
documentation that describes the virtual address space layout of the 64bit
kernel and the last patch is taken from my sv48 series where I simply added
the dump of the modules/kernel/BPF mapping.

I removed the Reviewed-by on the first patch since it changed enough from
last time and deserves a second look.

Changes in v3:
- Fix broken nommu build as reported by kernel test robot by protecting
  the kernel mapping only in 64BIT and MMU configs, by reverting the
  introduction of load_sz_pmd and by not exporting load_sz/load_pa anymore
  since they were not initialized in nommu config. 

Changes in v2:
- Fix documentation about direct mapping size which is 124GB instead
  of 126GB.
- Fix SPDX missing header in documentation.
- Fix another checkpatch warning about EXPORT_SYMBOL which was not
  directly below variable declaration.

Alexandre Ghiti (3):
  riscv: Move kernel mapping outside of linear mapping
  Documentation: riscv: Add documentation that describes the VM layout
  riscv: Prepare ptdump for vm layout dynamic addresses

 Documentation/riscv/index.rst       |  1 +
 Documentation/riscv/vm-layout.rst   | 63 +++++++++++++++++++++++
 arch/riscv/boot/loader.lds.S        |  3 +-
 arch/riscv/include/asm/page.h       | 17 ++++++-
 arch/riscv/include/asm/pgtable.h    | 37 ++++++++++----
 arch/riscv/include/asm/set_memory.h |  1 +
 arch/riscv/kernel/head.S            |  3 +-
 arch/riscv/kernel/module.c          |  6 +--
 arch/riscv/kernel/setup.c           |  5 ++
 arch/riscv/kernel/vmlinux.lds.S     |  3 +-
 arch/riscv/mm/fault.c               | 13 +++++
 arch/riscv/mm/init.c                | 78 ++++++++++++++++++++++-------
 arch/riscv/mm/kasan_init.c          |  9 ++++
 arch/riscv/mm/physaddr.c            |  2 +-
 arch/riscv/mm/ptdump.c              | 67 ++++++++++++++++++++-----
 15 files changed, 258 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/riscv/vm-layout.rst

-- 
2.20.1

