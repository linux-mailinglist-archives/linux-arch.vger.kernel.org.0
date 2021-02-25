Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE681324BAE
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 09:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhBYIGA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 03:06:00 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:41463 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhBYIF7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2021 03:05:59 -0500
X-Originating-IP: 81.185.161.35
Received: from localhost.localdomain (35.161.185.81.rev.sfr.net [81.185.161.35])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 8449C240013;
        Thu, 25 Feb 2021 08:05:05 +0000 (UTC)
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
Subject: [PATCH 0/3] Move kernel mapping outside the linear mapping
Date:   Thu, 25 Feb 2021 03:04:50 -0500
Message-Id: <20210225080453.1314-1-alex@ghiti.fr>
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

Alexandre Ghiti (3):
  riscv: Move kernel mapping outside of linear mapping
  Documentation: riscv: Add documentation that describes the VM layout
  riscv: Prepare ptdump for vm layout dynamic addresses

 Documentation/riscv/index.rst       |  1 +
 Documentation/riscv/vm-layout.rst   | 61 ++++++++++++++++++++++
 arch/riscv/boot/loader.lds.S        |  3 +-
 arch/riscv/include/asm/page.h       | 18 ++++++-
 arch/riscv/include/asm/pgtable.h    | 37 +++++++++----
 arch/riscv/include/asm/set_memory.h |  1 +
 arch/riscv/kernel/head.S            |  3 +-
 arch/riscv/kernel/module.c          |  6 +--
 arch/riscv/kernel/setup.c           |  3 ++
 arch/riscv/kernel/vmlinux.lds.S     |  3 +-
 arch/riscv/mm/fault.c               | 13 +++++
 arch/riscv/mm/init.c                | 81 +++++++++++++++++++++++------
 arch/riscv/mm/kasan_init.c          |  9 ++++
 arch/riscv/mm/physaddr.c            |  2 +-
 arch/riscv/mm/ptdump.c              | 67 +++++++++++++++++++-----
 15 files changed, 258 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/riscv/vm-layout.rst

-- 
2.20.1

