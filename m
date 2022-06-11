Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F125473A5
	for <lists+linux-arch@lfdr.de>; Sat, 11 Jun 2022 12:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiFKKPl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Jun 2022 06:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiFKKPk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Jun 2022 06:15:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF541209F;
        Sat, 11 Jun 2022 03:15:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5CAC60C14;
        Sat, 11 Jun 2022 10:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975C4C34116;
        Sat, 11 Jun 2022 10:15:35 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v5.19-rc2
Date:   Sat, 11 Jun 2022 18:17:14 +0800
Message-Id: <20220611101714.2623823-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
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

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-5.19-1

for you to fetch changes up to 5c95fe8b02011c3b69173e0d86aff6d4c2798601:

  LoongArch: Remove MIPS comment about cycle counter (2022-06-08 11:00:40 +0800)

----------------------------------------------------------------
LoongArch fixes for v5.19-rc2

----------------------------------------------------------------
Huacai Chen (2):
      LoongArch: Fix the !CONFIG_SMP build
      LoongArch: Fix copy_thread() build errors

Jason A. Donenfeld (1):
      LoongArch: Remove MIPS comment about cycle counter

 arch/loongarch/Kconfig               |  1 +
 arch/loongarch/include/asm/hardirq.h |  2 +-
 arch/loongarch/include/asm/percpu.h  |  1 +
 arch/loongarch/include/asm/smp.h     | 23 +++++++----------------
 arch/loongarch/include/asm/timex.h   |  7 -------
 arch/loongarch/kernel/acpi.c         |  4 ++++
 arch/loongarch/kernel/cacheinfo.c    |  1 +
 arch/loongarch/kernel/irq.c          |  7 ++++++-
 arch/loongarch/kernel/process.c      | 14 ++++++++------
 arch/loongarch/kernel/setup.c        |  5 ++---
 arch/loongarch/kernel/smp.c          |  2 --
 11 files changed, 31 insertions(+), 36 deletions(-)
