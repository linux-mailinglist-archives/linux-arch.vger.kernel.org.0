Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39825ABF5E
	for <lists+linux-arch@lfdr.de>; Sat,  3 Sep 2022 16:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiICO3G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Sep 2022 10:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiICO3F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Sep 2022 10:29:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A88658B44;
        Sat,  3 Sep 2022 07:29:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCFF661522;
        Sat,  3 Sep 2022 14:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A88C433C1;
        Sat,  3 Sep 2022 14:29:00 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.0-rc4
Date:   Sat,  3 Sep 2022 22:28:23 +0800
Message-Id: <20220903142823.3436925-1-chenhuacai@loongson.cn>
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

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.0-2

for you to fetch changes up to ac9284db6b7b4af150940186b633a233d4ca2bed:

  LoongArch: mm: Remove the unneeded result variable (2022-09-03 18:01:27 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.0-rc4

Fix several build errors or warnings, cleanup some code, and adjust
arch_do_signal_or_restart() to adapt generic entry.
----------------------------------------------------------------
Ard Biesheuvel (1):
      LoongArch: Avoid orphan input sections

Huacai Chen (3):
      LoongArch: Adjust arch_do_signal_or_restart() to adapt generic entry
      LoongArch: Improve dump_tlb() output messages
      LoongArch: Fix section mismatch due to acpi_os_ioremap()

Yupeng Li (1):
      LoongArch: Fix arch_remove_memory() undefined build error

ye xingchen (1):
      LoongArch: mm: Remove the unneeded result variable

 arch/loongarch/Kconfig              |  2 ++
 arch/loongarch/include/asm/acpi.h   |  2 +-
 arch/loongarch/kernel/acpi.c        |  2 +-
 arch/loongarch/kernel/signal.c      |  4 ++--
 arch/loongarch/kernel/vmlinux.lds.S |  2 ++
 arch/loongarch/lib/dump_tlb.c       | 26 +++++++++++++-------------
 arch/loongarch/mm/init.c            | 19 +++++++------------
 7 files changed, 28 insertions(+), 29 deletions(-)
