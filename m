Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F25F71698A5
	for <lists+linux-arch@lfdr.de>; Sun, 23 Feb 2020 17:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgBWQXh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 23 Feb 2020 11:23:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWQXh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 23 Feb 2020 11:23:37 -0500
Received: from localhost.localdomain (89.208.247.74.16clouds.com [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9B25206E0;
        Sun, 23 Feb 2020 16:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582475017;
        bh=tm6U0RsfbLgt6+HZ125jJ+1tmKJHn2WgIllq+q4yaXw=;
        h=From:To:Cc:Subject:Date:From;
        b=rY7tgvt8Od9nK6RFxOXGJBDpww6h3kgy6mXJfeQd0+nv6PoAkMXYLF9NC0D5JnVoa
         Er1J4+DXyq7yG3Cw3culKBS4u/uv4biwxQMXTqO8bJYtdmbhkh9YaUiKukzz3ot6+p
         Ed5wQYLykAr1hx3jgtinLdBov6fjRjKtD7WRSS8Q=
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [GIT PULL] csky updates for 5.6-rc3
Date:   Mon, 24 Feb 2020 00:23:32 +0800
Message-Id: <20200223162332.16495-1-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

Please pull the changes for 5.6-rc3. Sorry, I missed 5.6-rc1 merge window,
but in this pull request the most are the fixes and the rests are between
fixes and features. The only outside modification is the MAINTAINERS file
update with our mailing list.

Best Regards
 Guo Ren

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.6-rc3

for you to fetch changes up to 99db590b083fa2bc60adfcb5c839a62db4ef1d79:

  csky: Replace <linux/clk-provider.h> by <linux/of_clk.h> (2020-02-23 12:48:55 +0800)

----------------------------------------------------------------
csky updates for 5.6-rc3

 - Fix up cache flush implementations.

 - Fix up ftrace modify panic.

 - Fix up CONFIG_SMP boot problem.

 - Fix up pt_regs saving for atomic.S.

 - Fix up fixaddr_init without highmem.

 - Fix up stack protector support.

 - Fix up fake Tightly-Coupled Memory codes compile and use.

 - Fix up some typos and coding convention.

The tag is tested with [1].

 1: https://gitlab.com/c-sky/buildroot/pipelines/120268254

----------------------------------------------------------------
Geert Uytterhoeven (1):
      csky: Replace <linux/clk-provider.h> by <linux/of_clk.h>

Guo Ren (17):
      MAINTAINERS: csky: Add mailing list for csky
      csky: Tightly-Coupled Memory or Sram support
      csky: Separate fixaddr_init from highmem
      csky/mm: Fixup export invalid_pte_table symbol
      csky: Set regs->usp to kernel sp, when the exception is from kernel
      csky/smp: Fixup boot failed when CONFIG_SMP
      csky/Kconfig: Add Kconfig.platforms to support some drivers
      csky: Support icache flush without specific instructions
      csky: Remove unnecessary flush_icache_* implementation
      csky: Enable defer flush_dcache_page for abiv2 cpus (807/810/860)
      csky: Optimize abiv2 copy_to_user_page with VM_EXEC
      csky: Add flush_icache_mm to defer flush icache all
      csky: Fixup ftrace modify panic
      csky: Remove unused cache implementation
      csky: Fixup compile warning for three unimplemented syscalls
      csky: Add setup_initrd check code
      csky: Implement copy_thread_tls

Krzysztof Kozlowski (1):
      csky: Cleanup old Kconfig options

Ma Jun (1):
      csky: Minimize defconfig to support buildroot config.fragment

MaJun (1):
      csky: Add PCI support

Mao Han (1):
      csky: Initial stack protector support

Randy Dunlap (1):
      arch/csky: fix some Kconfig typos

 MAINTAINERS                            |   1 +
 arch/csky/Kconfig                      |  51 +++++++++-
 arch/csky/Kconfig.platforms            |   9 ++
 arch/csky/abiv1/inc/abi/cacheflush.h   |   5 +-
 arch/csky/abiv1/inc/abi/entry.h        |  19 +++-
 arch/csky/abiv2/cacheflush.c           |  84 +++++++++++-----
 arch/csky/abiv2/inc/abi/cacheflush.h   |  33 ++++---
 arch/csky/abiv2/inc/abi/entry.h        |  11 +++
 arch/csky/configs/defconfig            |   8 --
 arch/csky/include/asm/Kbuild           |   1 -
 arch/csky/include/asm/cache.h          |   1 +
 arch/csky/include/asm/cacheflush.h     |   1 +
 arch/csky/include/asm/fixmap.h         |   9 +-
 arch/csky/include/asm/memory.h         |  25 +++++
 arch/csky/include/asm/mmu.h            |   1 +
 arch/csky/include/asm/mmu_context.h    |   2 +
 arch/csky/include/asm/pci.h            |  34 +++++++
 arch/csky/include/asm/pgtable.h        |   6 +-
 arch/csky/include/asm/stackprotector.h |  29 ++++++
 arch/csky/include/asm/tcm.h            |  24 +++++
 arch/csky/include/uapi/asm/unistd.h    |   3 +
 arch/csky/kernel/atomic.S              |   8 +-
 arch/csky/kernel/process.c             |  13 ++-
 arch/csky/kernel/setup.c               |   5 +-
 arch/csky/kernel/smp.c                 |   2 +-
 arch/csky/kernel/time.c                |   2 +-
 arch/csky/kernel/vmlinux.lds.S         |  49 ++++++++++
 arch/csky/mm/Makefile                  |   3 +
 arch/csky/mm/cachev1.c                 |   5 +
 arch/csky/mm/cachev2.c                 |  45 +++++----
 arch/csky/mm/highmem.c                 |  64 +------------
 arch/csky/mm/init.c                    |  92 ++++++++++++++++++
 arch/csky/mm/syscache.c                |  13 +--
 arch/csky/mm/tcm.c                     | 169 +++++++++++++++++++++++++++++++++
 34 files changed, 663 insertions(+), 164 deletions(-)
 create mode 100644 arch/csky/Kconfig.platforms
 create mode 100644 arch/csky/include/asm/memory.h
 create mode 100644 arch/csky/include/asm/pci.h
 create mode 100644 arch/csky/include/asm/stackprotector.h
 create mode 100644 arch/csky/include/asm/tcm.h
 create mode 100644 arch/csky/mm/tcm.c
