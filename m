Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B037318EC
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jun 2023 14:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245606AbjFOMZf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jun 2023 08:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344948AbjFOMZL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jun 2023 08:25:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0F535B3;
        Thu, 15 Jun 2023 05:23:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33B8262DD5;
        Thu, 15 Jun 2023 12:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EF0C433C8;
        Thu, 15 Jun 2023 12:23:31 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.4-rc7
Date:   Thu, 15 Jun 2023 20:23:11 +0800
Message-Id: <20230615122311.3754870-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
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

The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

  Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.4-1

for you to fetch changes up to 41efbb682de1231c3f6361039f46ad149e3ff5b9:

  LoongArch: Fix debugfs_create_dir() error checking (2023-06-15 14:35:56 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.4-rc7

Some trivial bug fixes for v6.4-rc7.
----------------------------------------------------------------
Hongchen Zhang (1):
      LoongArch: Let pmd_present() return true when splitting pmd

Huacai Chen (1):
      LoongArch: Fix perf event id calculation

Immad Mir (1):
      LoongArch: Fix debugfs_create_dir() error checking

Qi Hu (1):
      LoongArch: Fix the write_fcsr() macro

Qing Zhang (1):
      LoongArch: Avoid uninitialized alignment_mask

 arch/loongarch/include/asm/loongarch.h    | 2 +-
 arch/loongarch/include/asm/pgtable-bits.h | 2 ++
 arch/loongarch/include/asm/pgtable.h      | 3 ++-
 arch/loongarch/kernel/hw_breakpoint.c     | 2 ++
 arch/loongarch/kernel/perf_event.c        | 6 +++---
 arch/loongarch/kernel/unaligned.c         | 2 +-
 6 files changed, 11 insertions(+), 6 deletions(-)
