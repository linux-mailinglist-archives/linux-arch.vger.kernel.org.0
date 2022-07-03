Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64F15647CB
	for <lists+linux-arch@lfdr.de>; Sun,  3 Jul 2022 16:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiGCOM0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Jul 2022 10:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiGCOMX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Jul 2022 10:12:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87A05FA5;
        Sun,  3 Jul 2022 07:12:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95EA8B80B1B;
        Sun,  3 Jul 2022 14:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01306C341C6;
        Sun,  3 Jul 2022 14:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656857540;
        bh=2fK2Mo95TrQ9YyvETTkhsR/j4qd6wNxp5Cu4kSAA7jw=;
        h=From:To:Cc:Subject:Date:From;
        b=Dk0D1nBvfXpeECpi/rc7AbSXNvOSYMh3QZABip646bL8INt4bVSWQ6WbjmgIJmjQN
         lv26uSYVMuoOBhc5ntut4CgaUZScUPsk00OGR28shXprMLlcbL9AhdAMc+bRI5A8RP
         h6u2fWCjyUxO+qS3bQ2bjnHCMYhhIFHJJmeczlw2vyahAIKe9e7oNHzotLvBJ6twDI
         MRSPwcb1/wKgJYtkMCHgzbytpKqE6AUzXHzhDDr9EtoTSdv3BB/tuj5DwBn43Ztem4
         Dzdpzu9OU8FbK69qhfKwC1BXFEs5O8lOs/EC/Hes9GkcQjZTD0P1tnVmUQIST45NC5
         rEs1Ev3mMCPlQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@kernel.org>,
        Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        WANG Xuerui <kernel@xen0n.name>, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        loongarch@lists.linux.dev
Subject: [PATCH 00/14] arch: make PxD_ORDER generically available
Date:   Sun,  3 Jul 2022 17:11:49 +0300
Message-Id: <20220703141203.147893-1-rppt@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

The question what does PxD_ORDER define raises from time to time and
there is still a conflict between MIPS and DAX definitions.

Some time ago Matthew Wilcox suggested to use PMD_TABLE_ORDER to define
the order of page table allocation: 

[1] https://lore.kernel.org/linux-arch/YPCJftSTUBEnq2lI@casper.infradead.org/

The parisc patch made it in, but mips didn't. 
Now mips defines from asm/include/pgtable.h were copied to loongarch which
made it worse.

Let's deal with it once and for all and rename PxD_ORDER defines to
PxD_TABLE_ORDER or just drop them when the only possible order of page
table is 0.

I think the best way to merge this via mm tree with acks from arch
maintainers.

Matthew Wilcox (Oracle) (1):
  mips: Rename PMD_ORDER to PMD_TABLE_ORDER

Mike Rapoport (13):
  csky: drop definition of PTE_ORDER
  csky: drop definition of PGD_ORDER
  mips: Rename PUD_ORDER to PUD_TABLE_ORDER
  mips: drop definitions of PTE_ORDER
  mips: Rename PGD_ORDER to PGD_TABLE_ORDER
  nios2: drop definition of PTE_ORDER
  nios2: drop definition of PGD_ORDER
  loongarch: drop definition of PTE_ORDER
  loongarch: drop definition of PMD_ORDER
  loongarch: drop definition of PUD_ORDER
  loongarch: drop definition of PGD_ORDER
  parisc: Rename PGD_ORDER to PGD_TABLE_ORDER
  xtensa: drop definition of PGD_ORDER

 arch/csky/include/asm/pgalloc.h      |  2 +-
 arch/csky/include/asm/pgtable.h      |  6 +--
 arch/loongarch/include/asm/pgalloc.h |  6 +--
 arch/loongarch/include/asm/pgtable.h | 27 +++++-------
 arch/loongarch/kernel/asm-offsets.c  |  5 ---
 arch/loongarch/mm/pgtable.c          |  2 +-
 arch/loongarch/mm/tlbex.S            |  6 +--
 arch/mips/include/asm/pgalloc.h      |  8 ++--
 arch/mips/include/asm/pgtable-32.h   | 19 ++++-----
 arch/mips/include/asm/pgtable-64.h   | 61 +++++++++++++---------------
 arch/mips/kernel/asm-offsets.c       |  5 ---
 arch/mips/kvm/mmu.c                  |  2 +-
 arch/mips/mm/pgtable.c               |  2 +-
 arch/mips/mm/tlbex.c                 | 14 +++----
 arch/nios2/include/asm/pgtable.h     |  7 +---
 arch/nios2/mm/init.c                 |  5 +--
 arch/nios2/mm/pgtable.c              |  2 +-
 arch/parisc/include/asm/pgalloc.h    |  6 +--
 arch/parisc/include/asm/pgtable.h    |  8 ++--
 arch/xtensa/include/asm/pgalloc.h    |  2 +-
 arch/xtensa/include/asm/pgtable.h    |  1 -
 21 files changed, 84 insertions(+), 112 deletions(-)


base-commit: 03c765b0e3b4cb5063276b086c76f7a612856a9a
-- 
2.34.1

