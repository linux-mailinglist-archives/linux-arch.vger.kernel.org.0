Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABFF589694
	for <lists+linux-arch@lfdr.de>; Thu,  4 Aug 2022 05:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiHDDey (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Aug 2022 23:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiHDDey (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Aug 2022 23:34:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0F137F80;
        Wed,  3 Aug 2022 20:34:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 281916179D;
        Thu,  4 Aug 2022 03:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC77C433C1;
        Thu,  4 Aug 2022 03:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659584092;
        bh=T1Ymwub/uzjZXfrC9GJFb/5UtxFD4hxNco25aq1tjC4=;
        h=From:To:Cc:Subject:Date:From;
        b=rO3cwY/zU9c5eKQreANJC3rjHNw0RxsbDbc9x4hHJ9TK97Xa8Al+n2PKlIJ7g+NmR
         2fy3QEpnKxTGvxDnTPsL3XNz4dgVp5UU+EnMBhBVZCZZvnCe/GcKziTnQh7VhyEQDS
         hxiD+IV4isOBuZ7iBu2hQ3ZnrnXTNF96yv17m/WELYTQKfhLhasWOwoGChHTNIBJwy
         NbjA8sfFv/1RcQe9UAAFu8ByyZlB87mcIfJBEiY5L8Gypmxjpt+VBF5TXjUVHVGaio
         1mnJBGW8SGaItLELIuJlauErQXGqH494f3STdKbmymRDErCIrkQGUojxrviQ7uueqz
         Bcpsh+NiVbbSQ==
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [GIT PULL] csky changes for v6.0-rc1
Date:   Wed,  3 Aug 2022 23:34:46 -0400
Message-Id: <20220804033446.1250001-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

Please pull the latest csky changes from:

The following changes since commit ff6992735ade75aae3e35d16b17da1008d753d28:

  Linux 5.19-rc7 (2022-07-17 13:30:22 -0700)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.0-rc1

for you to fetch changes up to 45fef4c4b9c94e86d9c13f0b2e7e71bb32254509:

  csky: abiv1: Fixup compile error (2022-07-31 22:39:23 -0400)

----------------------------------------------------------------
arch/csky patches for 6.0-rc1

The pull request we've done:
 - Add jump-label
 - Add qspinlock
 - Enable ARCH_INLINE_READ*/WRITE*/SPIN*
 - Some fixups and a coding convention

----------------------------------------------------------------
Christophe JAILLET (1):
      csky: Use the bitmap API to allocate bitmaps

Guo Ren (7):
      csky: Correct position of _stext
      csky: Move HEAD_TEXT_SECTION out of __init_begin-end
      csky: Add jump-label implementation
      csky: Add qspinlock support
      csky: Enable ARCH_INLINE_READ*/WRITE*/SPIN*
      csky: cmpxchg: Coding convention for BUILD_BUG()
      csky: abiv1: Fixup compile error

Liao Chang (1):
      csky/kprobe: reclaim insn_slot on kprobe unregistration

 arch/csky/Kconfig                      | 29 ++++++++++++++++++
 arch/csky/abiv1/inc/abi/string.h       |  6 ++++
 arch/csky/include/asm/Kbuild           |  4 +--
 arch/csky/include/asm/cmpxchg.h        | 31 +++++++++++++++----
 arch/csky/include/asm/jump_label.h     | 47 +++++++++++++++++++++++++++++
 arch/csky/include/asm/sections.h       | 10 +++++++
 arch/csky/include/asm/spinlock.h       | 12 ++++++++
 arch/csky/include/asm/spinlock_types.h |  9 ++++++
 arch/csky/kernel/Makefile              |  1 +
 arch/csky/kernel/jump_label.c          | 54 ++++++++++++++++++++++++++++++++++
 arch/csky/kernel/probes/kprobes.c      |  4 +++
 arch/csky/kernel/setup.c               |  4 +--
 arch/csky/kernel/vmlinux.lds.S         | 15 +++++-----
 arch/csky/mm/asid.c                    |  5 ++--
 14 files changed, 211 insertions(+), 20 deletions(-)
 create mode 100644 arch/csky/include/asm/jump_label.h
 create mode 100644 arch/csky/include/asm/sections.h
 create mode 100644 arch/csky/include/asm/spinlock.h
 create mode 100644 arch/csky/include/asm/spinlock_types.h
 create mode 100644 arch/csky/kernel/jump_label.c
