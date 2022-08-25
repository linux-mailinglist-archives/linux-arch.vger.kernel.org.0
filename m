Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733055A118E
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 15:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242394AbiHYNKz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 09:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242271AbiHYNKx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 09:10:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B37BA50EF;
        Thu, 25 Aug 2022 06:10:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15150B82956;
        Thu, 25 Aug 2022 13:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63130C433C1;
        Thu, 25 Aug 2022 13:10:47 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.0-rc3
Date:   Thu, 25 Aug 2022 21:10:21 +0800
Message-Id: <20220825131021.3671756-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.0-1

for you to fetch changes up to b83699ea1e62951857c2d8648bd93a4744899eb7:

  LoongArch: mm: Avoid unnecessary page fault retires on shared memory types (2022-08-25 19:34:59 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.0-rc3

Fix a bunch of build errors/warnings, a poweroff error and an unbalanced
locking in do_page_fault().
----------------------------------------------------------------
Huacai Chen (6):
      LoongArch: Select PCI_QUIRKS to avoid build error
      LoongArch: Fix build warnings in VDSO
      LoongArch: Cleanup reset routines with new API
      LoongArch: Cleanup headers to avoid circular dependency
      LoongArch: Add subword xchg/cmpxchg emulation
      LoongArch: mm: Avoid unnecessary page fault retires on shared memory types

 arch/loongarch/Kconfig                 |  1 +
 arch/loongarch/include/asm/addrspace.h | 16 ++++++
 arch/loongarch/include/asm/cmpxchg.h   | 98 +++++++++++++++++++++++++++++++++-
 arch/loongarch/include/asm/io.h        | 19 -------
 arch/loongarch/include/asm/page.h      |  2 +-
 arch/loongarch/include/asm/percpu.h    |  8 +++
 arch/loongarch/include/asm/pgtable.h   |  7 ++-
 arch/loongarch/include/asm/reboot.h    | 10 ----
 arch/loongarch/kernel/reset.c          | 69 ++++++++----------------
 arch/loongarch/mm/fault.c              |  4 ++
 arch/loongarch/mm/mmap.c               | 11 +---
 arch/loongarch/vdso/vgetcpu.c          |  2 +
 arch/loongarch/vdso/vgettimeofday.c    | 15 +++---
 13 files changed, 164 insertions(+), 98 deletions(-)
 delete mode 100644 arch/loongarch/include/asm/reboot.h
