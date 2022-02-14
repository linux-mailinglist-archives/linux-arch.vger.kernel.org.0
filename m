Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A7D4B5661
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 17:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356513AbiBNQgF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 11:36:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356447AbiBNQfv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 11:35:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7460460D88;
        Mon, 14 Feb 2022 08:35:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10E276145A;
        Mon, 14 Feb 2022 16:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D20C340E9;
        Mon, 14 Feb 2022 16:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644856542;
        bh=NCPtyXY6GSVFAxA9xMH/uI0qVAvzui4f6HWShmHq7S4=;
        h=From:To:Cc:Subject:Date:From;
        b=AD+OGCC91QW3gC/dZKsZFSSWI0QKTWjyYSyPe3ESJoZsA18Yxd+6C2XmKbO+BufBV
         pgOTeKAy/H78mpdds/cyxQ3VhN4bBP5a5vjc0WbkFTjxn+hvTh5aHadh4RocZ3TKWZ
         eb6b0ouxjuiSDysMNzxh//PeMK4OQFXVj3bLmv5B1B7q8Uq/AO4RDRlThvSeYzr3Ly
         Gc0VXxNLiJ5WO1pIX67udGR/GCDjJQpiIxvmjGV1mzioNZwxT26v6bU0vORAmaN8AJ
         nAspwe5m/jH1WNhsqM0Qybjj0jz1yeUDm3LP9c3MsBrk2+9J1cYolEm51L9D0B9ZO/
         R/tiDrFKWPKmA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com,
        deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com,
        dalias@libc.org, davem@davemloft.net, richard@nod.at,
        x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ardb@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 00/14] clean up asm/uaccess.h, kill set_fs for good
Date:   Mon, 14 Feb 2022 17:34:38 +0100
Message-Id: <20220214163452.1568807-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Christoph Hellwig and a few others spent a huge effort on removing
set_fs() from most of the important architectures, but about half the
other architectures were never completed even though most of them don't
actually use set_fs() at all.

I did a patch for microblaze at some point, which turned out to be fairly
generic, and now ported it to most other architectures, using new generic
implementations of access_ok() and __{get,put}_kernel_nocheck().

Three architectures (sparc64, ia64, and sh) needed some extra work,
which I also completed.

The final series contains extra cleanup changes that touch all
architectures. Please review and test these, so we can merge them
for v5.18.

The series is available at
https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=set_fs
for testing.

       Arnd

Arnd Bergmann (14):
  uaccess: fix integer overflow on access_ok()
  sparc64: add __{get,put}_kernel_nocheck()
  nds32: fix access_ok() checks in get/put_user
  x86: use more conventional access_ok() definition
  uaccess: add generic __{get,put}_kernel_nofault
  mips: use simpler access_ok()
  uaccess: generalize access_ok()
  arm64: simplify access_ok()
  m68k: drop custom __access_ok()
  uaccess: remove most CONFIG_SET_FS users
  sparc64: remove CONFIG_SET_FS support
  sh: remove CONFIG_SET_FS support
  ia64: remove CONFIG_SET_FS support
  uaccess: drop set_fs leftovers

 arch/Kconfig                              |   3 -
 arch/alpha/Kconfig                        |   1 -
 arch/alpha/include/asm/processor.h        |   4 -
 arch/alpha/include/asm/thread_info.h      |   2 -
 arch/alpha/include/asm/uaccess.h          |  53 +--------
 arch/arc/Kconfig                          |   1 -
 arch/arc/include/asm/segment.h            |  20 ----
 arch/arc/include/asm/thread_info.h        |   3 -
 arch/arc/include/asm/uaccess.h            |  30 -----
 arch/arm/include/asm/uaccess.h            |  22 +---
 arch/arm/kernel/swp_emulate.c             |   2 +-
 arch/arm/kernel/traps.c                   |   2 +-
 arch/arm/lib/uaccess_with_memcpy.c        |  10 --
 arch/arm64/include/asm/uaccess.h          |  29 +----
 arch/csky/Kconfig                         |   1 -
 arch/csky/include/asm/processor.h         |   2 -
 arch/csky/include/asm/segment.h           |  10 --
 arch/csky/include/asm/thread_info.h       |   2 -
 arch/csky/include/asm/uaccess.h           |  12 --
 arch/csky/kernel/asm-offsets.c            |   1 -
 arch/csky/kernel/signal.c                 |   2 +-
 arch/h8300/Kconfig                        |   1 -
 arch/h8300/include/asm/processor.h        |   1 -
 arch/h8300/include/asm/segment.h          |  40 -------
 arch/h8300/include/asm/thread_info.h      |   3 -
 arch/h8300/kernel/entry.S                 |   1 -
 arch/h8300/kernel/head_ram.S              |   1 -
 arch/h8300/mm/init.c                      |   6 -
 arch/h8300/mm/memory.c                    |   1 -
 arch/hexagon/Kconfig                      |   1 -
 arch/hexagon/include/asm/thread_info.h    |   6 -
 arch/hexagon/include/asm/uaccess.h        |  25 ----
 arch/hexagon/kernel/process.c             |   1 -
 arch/ia64/Kconfig                         |   1 -
 arch/ia64/include/asm/processor.h         |   4 -
 arch/ia64/include/asm/thread_info.h       |   2 -
 arch/ia64/include/asm/uaccess.h           |  26 ++---
 arch/ia64/kernel/unaligned.c              |  60 ++++++----
 arch/m68k/include/asm/uaccess.h           |  14 +--
 arch/microblaze/Kconfig                   |   1 -
 arch/microblaze/include/asm/thread_info.h |   6 -
 arch/microblaze/include/asm/uaccess.h     |  43 +------
 arch/microblaze/kernel/asm-offsets.c      |   1 -
 arch/microblaze/kernel/process.c          |   1 -
 arch/mips/include/asm/uaccess.h           |  47 +-------
 arch/nds32/Kconfig                        |   1 -
 arch/nds32/include/asm/thread_info.h      |   4 -
 arch/nds32/include/asm/uaccess.h          |  40 +++----
 arch/nds32/kernel/process.c               |   5 +-
 arch/nds32/mm/alignment.c                 |   3 -
 arch/nios2/Kconfig                        |   1 -
 arch/nios2/include/asm/thread_info.h      |   9 --
 arch/nios2/include/asm/uaccess.h          |  23 +---
 arch/nios2/kernel/signal.c                |  20 ++--
 arch/openrisc/Kconfig                     |   1 -
 arch/openrisc/include/asm/thread_info.h   |   7 --
 arch/openrisc/include/asm/uaccess.h       |  42 +------
 arch/parisc/include/asm/futex.h           |   2 +-
 arch/parisc/include/asm/uaccess.h         |  11 +-
 arch/parisc/lib/memcpy.c                  |   2 +-
 arch/powerpc/include/asm/uaccess.h        |  13 +--
 arch/powerpc/lib/sstep.c                  |   4 +-
 arch/riscv/include/asm/uaccess.h          |  33 +-----
 arch/riscv/kernel/perf_callchain.c        |   2 +-
 arch/s390/include/asm/uaccess.h           |  13 +--
 arch/sh/Kconfig                           |   1 -
 arch/sh/include/asm/processor.h           |   1 -
 arch/sh/include/asm/segment.h             |  33 ------
 arch/sh/include/asm/thread_info.h         |   2 -
 arch/sh/include/asm/uaccess.h             |  24 +---
 arch/sh/kernel/io_trapped.c               |   9 +-
 arch/sh/kernel/process_32.c               |   2 -
 arch/sh/kernel/traps_32.c                 |  30 +++--
 arch/sparc/Kconfig                        |   1 -
 arch/sparc/include/asm/processor_32.h     |   6 -
 arch/sparc/include/asm/processor_64.h     |   4 -
 arch/sparc/include/asm/switch_to_64.h     |   4 +-
 arch/sparc/include/asm/thread_info_64.h   |   4 +-
 arch/sparc/include/asm/uaccess.h          |   3 -
 arch/sparc/include/asm/uaccess_32.h       |  31 +----
 arch/sparc/include/asm/uaccess_64.h       | 135 +++++++++++++---------
 arch/sparc/kernel/process_32.c            |   2 -
 arch/sparc/kernel/process_64.c            |  12 --
 arch/sparc/kernel/signal_32.c             |   2 +-
 arch/sparc/kernel/traps_64.c              |   2 -
 arch/sparc/lib/NGmemcpy.S                 |   3 +-
 arch/sparc/mm/init_64.c                   |   3 -
 arch/um/include/asm/uaccess.h             |   7 +-
 arch/x86/include/asm/uaccess.h            |  44 ++-----
 arch/xtensa/Kconfig                       |   1 -
 arch/xtensa/include/asm/asm-uaccess.h     |  71 ------------
 arch/xtensa/include/asm/processor.h       |   7 --
 arch/xtensa/include/asm/thread_info.h     |   3 -
 arch/xtensa/include/asm/uaccess.h         |  26 +----
 arch/xtensa/kernel/asm-offsets.c          |   3 -
 drivers/hid/uhid.c                        |   2 +-
 drivers/scsi/sg.c                         |   5 -
 fs/exec.c                                 |   6 -
 include/asm-generic/access_ok.h           |  51 ++++++++
 include/asm-generic/uaccess.h             |  46 +-------
 include/linux/syscalls.h                  |   4 -
 include/linux/uaccess.h                   |  59 +++-------
 include/rdma/ib.h                         |   2 +-
 kernel/events/callchain.c                 |   4 -
 kernel/events/core.c                      |   3 -
 kernel/exit.c                             |  14 ---
 kernel/kthread.c                          |   5 -
 kernel/stacktrace.c                       |   3 -
 kernel/trace/bpf_trace.c                  |   4 -
 mm/maccess.c                              | 119 -------------------
 mm/memory.c                               |   8 --
 net/bpfilter/bpfilter_kern.c              |   2 +-
 112 files changed, 315 insertions(+), 1239 deletions(-)
 delete mode 100644 arch/arc/include/asm/segment.h
 delete mode 100644 arch/csky/include/asm/segment.h
 delete mode 100644 arch/h8300/include/asm/segment.h
 delete mode 100644 arch/sh/include/asm/segment.h
 create mode 100644 include/asm-generic/access_ok.h

-- 
2.29.2

Cc: linux@armlinux.org.uk
Cc: will@kernel.org
Cc: guoren@kernel.org
Cc: bcain@codeaurora.org
Cc: geert@linux-m68k.org
Cc: monstr@monstr.eu
Cc: tsbogend@alpha.franken.de
Cc: nickhu@andestech.com
Cc: green.hu@gmail.com
Cc: dinguyen@kernel.org
Cc: shorne@gmail.com
Cc: deller@gmx.de
Cc: mpe@ellerman.id.au
Cc: peterz@infradead.org
Cc: mingo@redhat.com
Cc: mark.rutland@arm.com
Cc: hca@linux.ibm.com
Cc: dalias@libc.org
Cc: davem@davemloft.net
Cc: richard@nod.at
Cc: x86@kernel.org
Cc: jcmvbkbc@gmail.com
Cc: ebiederm@xmission.com
Cc: arnd@arndb.de
Cc: akpm@linux-foundation.org
Cc: ardb@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: openrisc@lists.librecores.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
