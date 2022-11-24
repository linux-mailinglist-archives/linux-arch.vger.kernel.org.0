Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E4B63759A
	for <lists+linux-arch@lfdr.de>; Thu, 24 Nov 2022 10:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiKXJy3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Nov 2022 04:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiKXJyR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Nov 2022 04:54:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0284E12BFE2;
        Thu, 24 Nov 2022 01:54:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6A0DB8273C;
        Thu, 24 Nov 2022 09:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B6AC433C1;
        Thu, 24 Nov 2022 09:54:07 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.1-rc7
Date:   Thu, 24 Nov 2022 17:51:20 +0800
Message-Id: <20221124095120.3116780-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.1-2

for you to fetch changes up to fa0e381290b134da53e65fb421b65825f23221b4:

  docs/zh_CN/LoongArch: Fix wrong description of FPRs Note (2022-11-23 10:28:08 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.1-rc7

Fix two build warnings, a copy_thread() bug, two page table manipulation
bugs, and some trivial cleanups.
----------------------------------------------------------------
Huacai Chen (5):
      LoongArch: Combine acpi_boot_table_init() and acpi_boot_init()
      LoongArch: SMP: Change prefix from loongson3 to loongson
      LoongArch: Clear FPU/SIMD thread info flags for kernel thread
      LoongArch: Set _PAGE_DIRTY only if _PAGE_WRITE is set in {pmd,pte}_mkdirty()
      LoongArch: Set _PAGE_DIRTY only if _PAGE_MODIFIED is set in {pmd,pte}_mkwrite()

KaiLong Wang (1):
      LoongArch: Fix unsigned comparison with less than zero

Tiezhu Yang (2):
      LoongArch: Makefile: Use "grep -E" instead of "egrep"
      docs/zh_CN/LoongArch: Fix wrong description of FPRs Note

 .../translations/zh_CN/loongarch/introduction.rst  |  4 +-
 arch/loongarch/Makefile                            |  2 +-
 arch/loongarch/include/asm/irq.h                   |  2 +-
 arch/loongarch/include/asm/pgtable.h               | 16 ++++++--
 arch/loongarch/include/asm/smp.h                   | 30 +++++++--------
 arch/loongarch/kernel/acpi.c                       | 31 +++++----------
 arch/loongarch/kernel/irq.c                        |  2 +-
 arch/loongarch/kernel/process.c                    |  9 +++--
 arch/loongarch/kernel/setup.c                      |  1 -
 arch/loongarch/kernel/smp.c                        | 44 +++++++++++-----------
 arch/loongarch/kernel/unwind_prologue.c            |  3 +-
 11 files changed, 71 insertions(+), 73 deletions(-)
