Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE12E1CB214
	for <lists+linux-arch@lfdr.de>; Fri,  8 May 2020 16:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgEHOkw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 May 2020 10:40:52 -0400
Received: from 8bytes.org ([81.169.241.247]:41590 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbgEHOkw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 May 2020 10:40:52 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 404DF423; Fri,  8 May 2020 16:40:50 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, joro@8bytes.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Date:   Fri,  8 May 2020 16:40:36 +0200
Message-Id: <20200508144043.13893-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

after the recent issue with vmalloc and tracing code[1] on x86 and a
long history of previous issues related to the vmalloc_sync_mappings()
interface, I thought the time has come to remove it. Please
see [2], [3], and [4] for some other issues in the past.

The patches are based on v5.7-rc4 and add tracking of page-table
directory changes to the vmalloc and ioremap code. Depending on which
page-table levels changes have been made, a new per-arch function is
called: arch_sync_kernel_mappings().

On x86-64 with 4-level paging, this function will not be called more
than 64 times in a systems runtime (because vmalloc-space takes 64 PGD
entries which are only populated, but never cleared).

As a side effect this also allows to get rid of vmalloc faults on x86,
making it safe to touch vmalloc'ed memory in the page-fault handler.
Note that this potentially includes per-cpu memory.

The code is tested on x86-64, x86-32 with and without PAE. It also fixes
the issue described in [1]. Additionally this code has been
compile-tested on almost all architectures supported by Linux. I
couldn't find working compilers for hexagon and unicore32, so these are
not tested.

Please review.

Regards,

	Joerg

[1] https://lore.kernel.org/lkml/20200430141120.GA8135@suse.de/
[2] https://lore.kernel.org/lkml/20191009124418.8286-1-joro@8bytes.org/
[3] https://lore.kernel.org/lkml/20190719184652.11391-1-joro@8bytes.org/
[4] https://lore.kernel.org/lkml/20191126111119.GA110513@gmail.com/

Joerg Roedel (7):
  mm: Add functions to track page directory modifications
  mm/vmalloc: Track which page-table levels were modified
  mm/ioremap: Track which page-table levels were modified
  x86/mm/64: Implement arch_sync_kernel_mappings()
  x86/mm/32: Implement arch_sync_kernel_mappings()
  mm: Remove vmalloc_sync_(un)mappings()
  x86/mm: Remove vmalloc faulting

 arch/x86/include/asm/pgtable-2level_types.h |   2 +
 arch/x86/include/asm/pgtable-3level_types.h |   2 +
 arch/x86/include/asm/pgtable_64_types.h     |   2 +
 arch/x86/include/asm/switch_to.h            |  23 ---
 arch/x86/kernel/setup_percpu.c              |   6 +-
 arch/x86/mm/fault.c                         | 176 +-------------------
 arch/x86/mm/init_64.c                       |   5 +
 arch/x86/mm/pti.c                           |   8 +-
 drivers/acpi/apei/ghes.c                    |   6 -
 include/asm-generic/5level-fixup.h          |   5 +-
 include/asm-generic/pgtable.h               |  23 +++
 include/linux/mm.h                          |  46 +++++
 include/linux/vmalloc.h                     |  13 +-
 kernel/notifier.c                           |   1 -
 lib/ioremap.c                               |  46 +++--
 mm/nommu.c                                  |  12 --
 mm/vmalloc.c                                | 109 +++++++-----
 17 files changed, 199 insertions(+), 286 deletions(-)

-- 
2.17.1

