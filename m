Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5AB78C83B
	for <lists+linux-arch@lfdr.de>; Tue, 29 Aug 2023 17:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbjH2PDQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Aug 2023 11:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbjH2PCp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Aug 2023 11:02:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F4DD7;
        Tue, 29 Aug 2023 08:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B68D65B87;
        Tue, 29 Aug 2023 15:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC46C433C9;
        Tue, 29 Aug 2023 15:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693321362;
        bh=FjbAiuQ9jLoLhSaBHx2hRI/GtYR5ZNg6bsV2CSQYSM0=;
        h=From:To:Cc:Subject:Date:From;
        b=LSedbXXHYmC9wp0LEE6oo7vlOVwtdG+CPNtB7YhoomC0P8qwa82lO4YjdJLLumUo1
         hjvtcHEIEEWhENwEWh6ozLPQU9GqGdkUqSkvkPQH5daCkROfEu0b+LcAY3LuCjlJZX
         lx1wzfcgIauLG829D+hBPP8vz0Txhp6JNUroIX4rgpdVqAGN/EC/o+C9p/FuLsDtzM
         CpClLZBqTe1kNMi5gwCauhgkd0pJVzcSHYULfy74nilTUMtnOh+EhEzhTxciMLliv0
         pzDQ78cijoaJugHOVe98ij8EEwNi6atWXadZgBF82Mc3QlJxNnGWZUycMhV1tz1cLN
         FTTXaX7kfgk1Q==
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org, guoren@kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [GIT PULL] csky changes for v6.6
Date:   Tue, 29 Aug 2023 11:02:36 -0400
Message-Id: <20230829150236.2701631-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

Please pull the latest csky changes from: 

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.6

for you to fetch changes up to c8171a86b27401aa1f492dd1f080f3102264f1ab:

  csky: Fixup -Wmissing-prototypes warning (2023-08-10 23:06:32 -0400)

----------------------------------------------------------------
arch/csky patches for 6.6

The pull request we've done:
 - Fixup compile warning
 - Fixup update_mmu_cache

----------------------------------------------------------------
Arnd Bergmann (1):
      csky: fix old style declaration in module.c

Guo Ren (2):
      csky: pgtable: Invalidate stale I-cache lines in update_mmu_cache
      csky: Fixup -Wmissing-prototypes warning

Linus Walleij (2):
      csky: Cast argument to virt_to_pfn() to (void *)
      csky: Make pfn accessors static inlines

 arch/arc/include/asm/page.h           |  2 +-
 arch/csky/abiv2/cacheflush.c          |  4 +---
 arch/csky/include/asm/page.h          | 13 ++++++++++---
 arch/csky/include/asm/ptrace.h        |  2 ++
 arch/csky/include/asm/sections.h      |  2 ++
 arch/csky/include/asm/traps.h         | 15 +++++++++++++++
 arch/csky/kernel/module.c             |  2 +-
 arch/csky/kernel/vdso/vgettimeofday.c | 11 +++++++++++
 8 files changed, 43 insertions(+), 8 deletions(-)
