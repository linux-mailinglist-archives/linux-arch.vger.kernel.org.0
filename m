Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771E76E7724
	for <lists+linux-arch@lfdr.de>; Wed, 19 Apr 2023 12:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjDSKGJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Apr 2023 06:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjDSKGG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Apr 2023 06:06:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DB913C10;
        Wed, 19 Apr 2023 03:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DC97634D8;
        Wed, 19 Apr 2023 10:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EA5C433EF;
        Wed, 19 Apr 2023 10:05:54 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.3-final
Date:   Wed, 19 Apr 2023 18:05:17 +0800
Message-Id: <20230419100517.3647508-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 6a8f57ae2eb07ab39a6f0ccad60c760743051026:

  Linux 6.3-rc7 (2023-04-16 15:23:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.3-1

for you to fetch changes up to b5533e990dd1de5872a34cba2f4f7f508c9b2ec3:

  tools/loongarch: Use __SIZEOF_LONG__ to define __BITS_PER_LONG (2023-04-19 12:07:34 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.3-final

Some bug fixes, some build fixes, a comment fix and a trivial cleanup.
----------------------------------------------------------------
Enze Li (1):
      LoongArch: Replace hard-coded values in comments with VALEN

Huacai Chen (6):
      LoongArch: Make WriteCombine configurable for ioremap()
      LoongArch: Fix probing of the CRC32 feature
      LoongArch: Fix build error if CONFIG_SUSPEND is not set
      LoongArch: Enable PG when wakeup from suspend
      LoongArch: Mark 3 symbol exports as non-GPL
      LoongArch: module: set section addresses to 0x0

Qing Zhang (3):
      LoongArch: Fix _CONST64_(x) as unsigned
      LoongArch: Adjust user_watch_state for explicit alignment
      LoongArch: Adjust user_regset_copyin parameter to the correct offset

Tiezhu Yang (3):
      LoongArch: Check unwind_error() in arch_stack_walk()
      LoongArch: Clean up plat_swiotlb_setup() related code
      tools/loongarch: Use __SIZEOF_LONG__ to define __BITS_PER_LONG

 Documentation/admin-guide/kernel-parameters.rst    |  1 +
 Documentation/admin-guide/kernel-parameters.txt    |  6 ++++
 arch/loongarch/Kconfig                             | 16 +++++++++
 arch/loongarch/include/asm/acpi.h                  |  3 ++
 arch/loongarch/include/asm/addrspace.h             |  4 +--
 arch/loongarch/include/asm/bootinfo.h              |  1 -
 arch/loongarch/include/asm/cpu-features.h          |  1 +
 arch/loongarch/include/asm/cpu.h                   | 40 ++++++++++++----------
 arch/loongarch/include/asm/io.h                    |  4 ++-
 arch/loongarch/include/asm/loongarch.h             |  6 ++--
 arch/loongarch/include/asm/module.lds.h            |  8 ++---
 arch/loongarch/include/uapi/asm/ptrace.h           |  3 +-
 arch/loongarch/kernel/cpu-probe.c                  |  9 +++--
 arch/loongarch/kernel/proc.c                       |  1 +
 arch/loongarch/kernel/ptrace.c                     | 25 +++++++++-----
 arch/loongarch/kernel/setup.c                      | 25 ++++++++++++--
 arch/loongarch/kernel/stacktrace.c                 |  2 +-
 arch/loongarch/kernel/unwind.c                     |  1 +
 arch/loongarch/kernel/unwind_prologue.c            |  4 ++-
 arch/loongarch/mm/init.c                           |  4 +--
 arch/loongarch/power/suspend_asm.S                 |  4 +++
 .../arch/loongarch/include/uapi/asm/bitsperlong.h  |  2 +-
 22 files changed, 121 insertions(+), 49 deletions(-)
