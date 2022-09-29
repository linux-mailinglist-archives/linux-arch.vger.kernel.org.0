Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793845EEC0E
	for <lists+linux-arch@lfdr.de>; Thu, 29 Sep 2022 04:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiI2Cot (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 22:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiI2Cos (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 22:44:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCD8FAC1;
        Wed, 28 Sep 2022 19:44:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10B38B8232E;
        Thu, 29 Sep 2022 02:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13495C433D6;
        Thu, 29 Sep 2022 02:44:40 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.0-final
Date:   Thu, 29 Sep 2022 10:42:56 +0800
Message-Id: <20220929024256.319721-1-chenhuacai@loongson.cn>
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

The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:

  Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.0-3

for you to fetch changes up to 4f196cb64b693c64f8f981432b1ff326b7ea1c28:

  LoongArch: Clean up loongson3_smp_ops declaration (2022-09-29 10:15:00 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.0-final

Some trivial fixes and cleanup.
----------------------------------------------------------------
Huacai Chen (2):
      LoongArch: Align the address of kernel_entry to 4KB
      LoongArch: Fix and cleanup csr_era handling in do_ri()

Yanteng Si (1):
      LoongArch: Clean up loongson3_smp_ops declaration

 arch/loongarch/include/asm/loongson.h |  2 --
 arch/loongarch/kernel/head.S          |  2 ++
 arch/loongarch/kernel/traps.c         | 15 ++-------------
 3 files changed, 4 insertions(+), 15 deletions(-)
