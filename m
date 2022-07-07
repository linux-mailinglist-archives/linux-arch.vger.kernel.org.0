Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CB756A31E
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jul 2022 15:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiGGNEh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jul 2022 09:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiGGNEg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jul 2022 09:04:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227282B242;
        Thu,  7 Jul 2022 06:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACAFF616B2;
        Thu,  7 Jul 2022 13:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A621AC3411E;
        Thu,  7 Jul 2022 13:04:31 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v5.19-rc6
Date:   Thu,  7 Jul 2022 21:05:25 +0800
Message-Id: <20220707130525.1434272-1-chenhuacai@loongson.cn>
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

The following changes since commit 88084a3df1672e131ddc1b4e39eeacfd39864acf:

  Linux 5.19-rc5 (2022-07-03 15:39:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-5.19-4

for you to fetch changes up to f0fbe652e8529a180630617a17cd5922298c4f13:

  LoongArch: Fix section mismatch warning (2022-07-07 17:41:01 +0800)

----------------------------------------------------------------
LoongArch fixes for v5.19-rc6

A fix for tinyconfig build error, a fix for section mismatch warning,
and two cleanups of obsolete code.
----------------------------------------------------------------
Huacai Chen (1):
      LoongArch: Fix build errors for tinyconfig

Lukas Bulwahn (1):
      LoongArch: Drop these obsolete selects in Kconfig

Qi Hu (1):
      LoongArch: Remove obsolete mentions of vcsr

Tiezhu Yang (1):
      LoongArch: Fix section mismatch warning

 arch/loongarch/Kconfig                 |  4 ----
 arch/loongarch/include/asm/fpregdef.h  |  1 -
 arch/loongarch/include/asm/page.h      |  1 +
 arch/loongarch/include/asm/processor.h |  2 --
 arch/loongarch/kernel/asm-offsets.c    |  1 -
 arch/loongarch/kernel/fpu.S            | 10 ----------
 arch/loongarch/kernel/numa.c           |  1 -
 arch/loongarch/vdso/Makefile           |  1 +
 8 files changed, 2 insertions(+), 19 deletions(-)
