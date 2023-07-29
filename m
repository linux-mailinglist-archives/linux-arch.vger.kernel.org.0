Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB82767BDF
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jul 2023 05:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjG2DRU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jul 2023 23:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjG2DRT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jul 2023 23:17:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142AB423B;
        Fri, 28 Jul 2023 20:17:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99ADD62231;
        Sat, 29 Jul 2023 03:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EBBC433C8;
        Sat, 29 Jul 2023 03:17:11 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.5-rc4
Date:   Sat, 29 Jul 2023 11:16:48 +0800
Message-Id: <20230729031648.539276-1-chenhuacai@loongson.cn>
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

The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.5-1

for you to fetch changes up to 1e74ae32805b6630c78bd7fb746fbfe936fb8f86:

  LoongArch: Cleanup __builtin_constant_p() checking for cpu_has_* (2023-07-28 10:30:42 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.5-rc4

Some bug fixes for build system, builtin cmdline handling, bpf and
{copy, clear}_user, together with a trivial cleanup.

----------------------------------------------------------------
Chenguang Zhao (1):
      LoongArch: BPF: Enable bpf_probe_read{, str}() on LoongArch

Huacai Chen (3):
      LoongArch: Only fiddle with CHECKFLAGS if `need-compiler'
      LoongArch: Fix module relocation error with binutils 2.41
      LoongArch: Cleanup __builtin_constant_p() checking for cpu_has_*

Tiezhu Yang (1):
      LoongArch: BPF: Fix check condition to call lu32id in move_imm()

WANG Rui (1):
      LoongArch: Fix return value underflow in exception path

Zhihong Dong (1):
      LoongArch: Fix CMDLINE_EXTEND and CMDLINE_BOOTLOADER handling

 arch/loongarch/Kconfig           |  1 +
 arch/loongarch/Makefile          |  4 +++-
 arch/loongarch/include/asm/fpu.h | 15 ++++-----------
 arch/loongarch/kernel/setup.c    | 16 ++++++++++++++++
 arch/loongarch/lib/clear_user.S  |  3 ++-
 arch/loongarch/lib/copy_user.S   |  3 ++-
 arch/loongarch/net/bpf_jit.h     |  2 +-
 7 files changed, 29 insertions(+), 15 deletions(-)
