Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E863B7CF316
	for <lists+linux-arch@lfdr.de>; Thu, 19 Oct 2023 10:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344988AbjJSIoL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Oct 2023 04:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345017AbjJSInw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Oct 2023 04:43:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E801BC1;
        Thu, 19 Oct 2023 01:43:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C63C433C7;
        Thu, 19 Oct 2023 08:43:16 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.6-rc7
Date:   Thu, 19 Oct 2023 16:42:27 +0800
Message-Id: <20231019084227.4111684-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb:

  Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.6-3

for you to fetch changes up to 278be83601dd1725d4732241f066d528e160a39d:

  LoongArch: Disable WUC for pgprot_writecombine() like ioremap_wc() (2023-10-18 08:42:52 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.6-rc7

Fix 4-level pagetable building, disable WUC for pgprot_writecombine()
like ioremap_wc(), use correct annotation for exception handlers, and
a trivial cleanup.
----------------------------------------------------------------
Huacai Chen (2):
      LoongArch: Export symbol invalid_pud_table for modules building
      LoongArch: Replace kmap_atomic() with kmap_local_page() in copy_user_highpage()

Icenowy Zheng (1):
      LoongArch: Disable WUC for pgprot_writecombine() like ioremap_wc()

Tiezhu Yang (1):
      LoongArch: Use SYM_CODE_* to annotate exception handlers

 arch/loongarch/include/asm/io.h           |  5 ++---
 arch/loongarch/include/asm/linkage.h      |  8 +++++++
 arch/loongarch/include/asm/pgtable-bits.h |  4 +++-
 arch/loongarch/kernel/entry.S             |  4 ++--
 arch/loongarch/kernel/genex.S             | 16 +++++++-------
 arch/loongarch/kernel/setup.c             | 10 ++++-----
 arch/loongarch/mm/init.c                  |  9 ++++----
 arch/loongarch/mm/tlbex.S                 | 36 +++++++++++++++----------------
 8 files changed, 51 insertions(+), 41 deletions(-)
