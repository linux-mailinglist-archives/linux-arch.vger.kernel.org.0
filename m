Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBEB61294D
	for <lists+linux-arch@lfdr.de>; Sun, 30 Oct 2022 10:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiJ3JTC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Oct 2022 05:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiJ3JTA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 30 Oct 2022 05:19:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879C3190;
        Sun, 30 Oct 2022 02:18:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01CA560E15;
        Sun, 30 Oct 2022 09:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED56DC433D6;
        Sun, 30 Oct 2022 09:18:55 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.1-rc3
Date:   Sun, 30 Oct 2022 17:16:58 +0800
Message-Id: <20221030091658.1843946-1-chenhuacai@loongson.cn>
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

The following changes since commit 247f34f7b80357943234f93f247a1ae6b6c3a740:

  Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.1-1

for you to fetch changes up to d81916910f7498fe7a768697e0101d488f9fe665:

  platform/loongarch: laptop: Fix possible UAF and simplify generic_acpi_laptop_init() (2022-10-29 16:29:31 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.1-rc3

Remove unused kernel stack padding, fix some build errors/warnings and
two bugs in laptop platform driver.
----------------------------------------------------------------
Huacai Chen (2):
      LoongArch: BPF: Avoid declare variables in switch-case
      platform/loongarch: laptop: Adjust resume order for loongson_hotkey_resume()

Jinyang He (1):
      LoongArch: Remove unused kernel stack padding

Yang Yingliang (1):
      platform/loongarch: laptop: Fix possible UAF and simplify generic_acpi_laptop_init()

Yushan Zhou (1):
      LoongArch: Use flexible-array member instead of zero-length array

 arch/loongarch/include/asm/processor.h       |  2 +-
 arch/loongarch/include/asm/ptrace.h          |  4 ++--
 arch/loongarch/kernel/head.S                 |  3 +--
 arch/loongarch/kernel/process.c              |  4 ++--
 arch/loongarch/kernel/switch.S               |  2 +-
 arch/loongarch/net/bpf_jit.c                 | 31 ++++++++++++----------------
 drivers/platform/loongarch/loongson-laptop.c | 24 ++++++++++++---------
 7 files changed, 34 insertions(+), 36 deletions(-)
