Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4A91B4728
	for <lists+linux-arch@lfdr.de>; Wed, 22 Apr 2020 16:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgDVOZm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Apr 2020 10:25:42 -0400
Received: from foss.arm.com ([217.140.110.172]:50664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgDVOZm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 10:25:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5028E30E;
        Wed, 22 Apr 2020 07:25:41 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8D333F68F;
        Wed, 22 Apr 2020 07:25:39 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hugh Dickins <hughd@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 0/4] arm64: MTE swap and hibernation support
Date:   Wed, 22 Apr 2020 15:25:26 +0100
Message-Id: <20200422142530.32619-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This adds support for swapping and hibernation with MTE tagged memory.
It's based on Catalin's v3 series[1].

To support swap, a new page flag is added which tracks whether a page
has been mapped into user space with MTE enabled (and therefore may have
valid data in the tags). Arch hooks are added to enable the
saving/restoring of these tags (in memory) when the pages are swapped
out.

Hibernation builds on the swap support by simply copying the tags out of
hardware tag storage into normal memory before the hibernation image is
created. On restore the tags are returned to the hardware tag storage.

Feedback on the approach is welcomed.

[1] https://lore.kernel.org/linux-arm-kernel/20200421142603.3894-1-catalin.marinas@arm.com/

Steven Price (4):
  mm: Add PG_ARCH_2 page flag
  mm: Add arch hooks for saving/restoring tags
  arm64: mte: Enable swap of tagged pages
  arm64: mte: Save tags when hibernating

 arch/arm64/Kconfig                |   2 +-
 arch/arm64/include/asm/mte.h      |   6 ++
 arch/arm64/include/asm/pgtable.h  |  44 ++++++++++++
 arch/arm64/kernel/hibernate.c     | 116 ++++++++++++++++++++++++++++++
 arch/arm64/lib/mte.S              |  50 +++++++++++++
 arch/arm64/mm/Makefile            |   2 +-
 arch/arm64/mm/mteswap.c           |  98 +++++++++++++++++++++++++
 fs/proc/page.c                    |   3 +
 include/asm-generic/pgtable.h     |  23 ++++++
 include/linux/kernel-page-flags.h |   1 +
 include/linux/page-flags.h        |   3 +
 include/trace/events/mmflags.h    |   9 ++-
 mm/Kconfig                        |   3 +
 mm/page_io.c                      |   6 ++
 mm/shmem.c                        |   6 ++
 mm/swapfile.c                     |   2 +
 tools/vm/page-types.c             |   2 +
 17 files changed, 373 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/mm/mteswap.c

-- 
2.20.1

