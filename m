Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4411E6718D4
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jan 2023 11:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjARKWT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Jan 2023 05:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjARKV5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jan 2023 05:21:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27D3442DD;
        Wed, 18 Jan 2023 01:27:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAC0FB81C0F;
        Wed, 18 Jan 2023 09:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F6FC433D2;
        Wed, 18 Jan 2023 09:26:58 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.2-rc5
Date:   Wed, 18 Jan 2023 17:26:51 +0800
Message-Id: <20230118092651.2452402-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.0
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

The following changes since commit 5dc4c995db9eb45f6373a956eb1f69460e69e6d4:

  Linux 6.2-rc4 (2023-01-15 09:22:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.2-1

for you to fetch changes up to dc74a9e8a8c57966a563ab078ba91c8b2c0d0a72:

  LoongArch: Add generic ex-handler unwind in prologue unwinder (2023-01-17 11:42:16 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.2-rc5

Fix a missing elf_hwcap, fix some stack unwinder bugs and two trivial
cleanups.
----------------------------------------------------------------
Huacai Chen (1):
      LoongArch: Add HWCAP_LOONGARCH_CPUCFG to elf_hwcap

Jinyang He (5):
      LoongArch: Adjust PC value when unwind next frame in unwinder
      LoongArch: Get frame info in unwind_start() when regs is not available
      LoongArch: Use correct sp value to get graph addr in stack unwinders
      LoongArch: Strip guess unwinder out from prologue unwinder
      LoongArch: Add generic ex-handler unwind in prologue unwinder

Tiezhu Yang (1):
      LoongArch: Use common function sign_extend64()

Youling Tang (1):
      LoongArch: Simplify larch_insn_gen_xxx implementation

 arch/loongarch/include/asm/ftrace.h     |   2 -
 arch/loongarch/include/asm/inst.h       |   9 +-
 arch/loongarch/include/asm/unwind.h     |  41 +++++-
 arch/loongarch/kernel/Makefile          |   2 +-
 arch/loongarch/kernel/alternative.c     |   6 +-
 arch/loongarch/kernel/cpu-probe.c       |   2 +-
 arch/loongarch/kernel/genex.S           |   3 +
 arch/loongarch/kernel/inst.c            |  45 +-----
 arch/loongarch/kernel/process.c         |  12 +-
 arch/loongarch/kernel/traps.c           |   3 -
 arch/loongarch/kernel/unwind.c          |  32 ++++
 arch/loongarch/kernel/unwind_guess.c    |  49 +------
 arch/loongarch/kernel/unwind_prologue.c | 252 +++++++++++++++++++-------------
 arch/loongarch/mm/tlb.c                 |   2 +-
 14 files changed, 247 insertions(+), 213 deletions(-)
 create mode 100644 arch/loongarch/kernel/unwind.c
