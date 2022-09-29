Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14FD5EEC02
	for <lists+linux-arch@lfdr.de>; Thu, 29 Sep 2022 04:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbiI2Cjk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 22:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiI2CjC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 22:39:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32522126464;
        Wed, 28 Sep 2022 19:38:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5707461FB1;
        Thu, 29 Sep 2022 02:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE3FC433D7;
        Thu, 29 Sep 2022 02:38:51 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v5.19-rc4
Date:   Thu, 29 Sep 2022 10:37:35 +0800
Message-Id: <20220929023735.319481-1-chenhuacai@loongson.cn>
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

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-5.19-3

for you to fetch changes up to ea18d434781105ce61ff3ef7f74c9e51812f0580:

  LoongArch: Make compute_return_era() return void (2022-06-25 18:06:07 +0800)

----------------------------------------------------------------
LoongArch fixes for v5.19-rc4

Some bug fixes and a trivial cleanup.
----------------------------------------------------------------
Huacai Chen (4):
      LoongArch: Fix the !THP build
      LoongArch: Fix the _stext symbol address
      LoongArch: Fix sleeping in atomic context in setup_tlb_handler()
      LoongArch: Fix EENTRY/MERRENTRY setting in setup_tlb_handler()

Tiezhu Yang (2):
      LoongArch: Fix wrong fpu version
      LoongArch: Make compute_return_era() return void

 arch/loongarch/include/asm/branch.h  |  3 +--
 arch/loongarch/include/asm/pgtable.h | 10 +++++-----
 arch/loongarch/kernel/cpu-probe.c    |  2 +-
 arch/loongarch/kernel/head.S         |  2 --
 arch/loongarch/kernel/traps.c        |  3 +--
 arch/loongarch/kernel/vmlinux.lds.S  |  1 +
 arch/loongarch/mm/tlb.c              |  7 ++++---
 7 files changed, 13 insertions(+), 15 deletions(-)
