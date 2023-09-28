Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664DC7B2129
	for <lists+linux-arch@lfdr.de>; Thu, 28 Sep 2023 17:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjI1P0J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Sep 2023 11:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjI1P0J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Sep 2023 11:26:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D5D99;
        Thu, 28 Sep 2023 08:26:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32547C433C8;
        Thu, 28 Sep 2023 15:26:02 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.6-rc4
Date:   Thu, 28 Sep 2023 23:25:35 +0800
Message-Id: <20230928152535.2617047-1-chenhuacai@loongson.cn>
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

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.6-2

for you to fetch changes up to b1dc55a3d6a86cc2c1ae664ad7280bff4c0fc28f:

  LoongArch: Add support for 64_PCREL relocation type (2023-09-27 16:19:13 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.6-rc4

Fix high_memory calculation and module loader errors with latest binutils.
----------------------------------------------------------------
Huacai Chen (1):
      LoongArch: numa: Fix high_memory calculation

Tiezhu Yang (3):
      LoongArch: Define relocation types for ABI v2.10
      LoongArch: Add support for 32_PCREL relocation type
      LoongArch: Add support for 64_PCREL relocation type

 arch/loongarch/include/asm/elf.h |  9 +++++++++
 arch/loongarch/kernel/module.c   | 22 +++++++++++++++++++++-
 arch/loongarch/kernel/numa.c     |  2 +-
 3 files changed, 31 insertions(+), 2 deletions(-)
