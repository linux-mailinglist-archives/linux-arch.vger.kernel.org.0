Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F58789818
	for <lists+linux-arch@lfdr.de>; Sat, 26 Aug 2023 18:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjHZQff (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Aug 2023 12:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjHZQfD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Aug 2023 12:35:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70DE1991;
        Sat, 26 Aug 2023 09:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FC446230C;
        Sat, 26 Aug 2023 16:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDFFC433C7;
        Sat, 26 Aug 2023 16:34:57 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.5-final
Date:   Sun, 27 Aug 2023 00:34:27 +0800
Message-Id: <20230826163427.4193691-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 706a741595047797872e669b3101429ab8d378ef:

  Linux 6.5-rc7 (2023-08-20 15:02:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.5-2

for you to fetch changes up to 9730870b484e9de852b51df08a8b357b1129489e:

  LoongArch: Fix hw_breakpoint_control() for watchpoints (2023-08-26 22:21:57 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.5-final

Fix a ptrace bug, a hw_breakpoint bug, some build errors/warnings and
some trivial cleanups.

----------------------------------------------------------------
Huacai Chen (2):
      LoongArch: Ensure FP/SIMD registers in the core dump file is up to date
      LoongArch: Fix hw_breakpoint_control() for watchpoints

Masahiro Yamada (3):
      LoongArch: Remove unneeded #include <asm/export.h>
      LoongArch: Replace #include <asm/export.h> with #include <linux/export.h>
      LoongArch: Remove <asm/export.h>

Tiezhu Yang (4):
      LoongArch: Do not kill the task in die() if notify_die() returns NOTIFY_STOP
      LoongArch: Return earlier in die() if notify_die() returns NOTIFY_STOP
      LoongArch: Add identifier names to arguments of die() declaration
      LoongArch: Put the body of play_dead() into arch_cpu_idle_dead()

WANG Xuerui (1):
      LoongArch: Replace -ffreestanding with finer-grained -fno-builtin's

Xi Ruoyao (1):
      LoongArch: Remove redundant "source drivers/firmware/Kconfig"

 arch/loongarch/Kconfig                |  2 --
 arch/loongarch/Makefile               |  2 +-
 arch/loongarch/include/asm/Kbuild     |  1 -
 arch/loongarch/include/asm/fpu.h      | 22 ++++++++++++++++++----
 arch/loongarch/include/asm/ptrace.h   |  2 +-
 arch/loongarch/include/asm/smp.h      |  2 --
 arch/loongarch/kernel/fpu.S           |  2 +-
 arch/loongarch/kernel/hw_breakpoint.c |  3 +--
 arch/loongarch/kernel/mcount.S        |  2 +-
 arch/loongarch/kernel/mcount_dyn.S    |  1 -
 arch/loongarch/kernel/process.c       |  7 -------
 arch/loongarch/kernel/ptrace.c        |  4 ++++
 arch/loongarch/kernel/smp.c           |  2 +-
 arch/loongarch/kernel/traps.c         | 14 ++++++++------
 arch/loongarch/lib/clear_user.S       |  2 +-
 arch/loongarch/lib/copy_user.S        |  2 +-
 arch/loongarch/lib/memcpy.S           |  2 +-
 arch/loongarch/lib/memmove.S          |  2 +-
 arch/loongarch/lib/memset.S           |  2 +-
 arch/loongarch/lib/unaligned.S        |  1 -
 arch/loongarch/mm/page.S              |  2 +-
 arch/loongarch/mm/tlbex.S             |  1 -
 22 files changed, 42 insertions(+), 38 deletions(-)
