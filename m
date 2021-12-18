Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6644479C2F
	for <lists+linux-arch@lfdr.de>; Sat, 18 Dec 2021 19:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhLRSxY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Dec 2021 13:53:24 -0500
Received: from relay.sw.ru ([185.231.240.75]:47182 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231274AbhLRSxY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 18 Dec 2021 13:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
        Content-Type; bh=YFo/8Hpib8VONfO7wmfYjOxhyZQ5UGqv8EgWQmc4i/A=; b=Gjg8iMb9BPLW
        7UlzROKYWa58VdNyz2XLDFWTXIoD3uhlMsSclSMRoHvHFKbZfINpPVkaNPCiDIU4LA12fDFZtp6Ij
        McvcMIjclTfx35VR5mCk7RMuzEgszspgGHPTBVrfIrhcUEe9M7XN6ErcJRM5jYmiz6i5rbVXXrlXS
        M+GgI=;
Received: from [192.168.15.79] (helo=cobook.home)
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <nikita.yushchenko@virtuozzo.com>)
        id 1myepD-003qf7-A6; Sat, 18 Dec 2021 21:52:55 +0300
From:   Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, kernel@openvz.org
Subject: [PATCH/RFC v2 0/3] tlb: mmu_gather: use batched table free if possible
Date:   Sat, 18 Dec 2021 21:52:03 +0300
Message-Id: <20211218185205.1744125-1-nikita.yushchenko@virtuozzo.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In mmu_gather code, the final table free in __tlb_remove_table_free()
executes a loop, calling arch hook __tlb_remove_table() to free each table
individually.

Several architectures use free_page_and_swap_cache() as their
__tlb_remove_table() implementation. Calling that in loop results into
individual calls to put_page() for each page being freed.

This patchset refactors the code to issue a single release_pages() call
in this case. This is expected to have better performance, especially when
memcg accounting is enabled.

Nikita Yushchenko (3):
  tlb: mmu_gather: introduce CONFIG_MMU_GATHER_TABLE_FREE_COMMON
  mm/swap: introduce free_pages_and_swap_cache_nolru()
  tlb: mmu_gather: use batched table free if possible

 arch/Kconfig                 |  3 +++
 arch/arm/Kconfig             |  1 +
 arch/arm/include/asm/tlb.h   |  5 -----
 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/tlb.h |  5 -----
 arch/x86/Kconfig             |  1 +
 arch/x86/include/asm/tlb.h   | 14 --------------
 include/asm-generic/tlb.h    |  5 +++++
 include/linux/swap.h         |  5 ++++-
 mm/mmu_gather.c              | 25 ++++++++++++++++++++++---
 mm/swap_state.c              | 29 ++++++++++++++++++++++-------
 11 files changed, 59 insertions(+), 35 deletions(-)

-- 
2.30.2

