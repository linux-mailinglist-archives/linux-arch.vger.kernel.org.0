Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63957D9728
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 18:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406205AbfJPQYK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 12:24:10 -0400
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:58622 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406198AbfJPQYK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Oct 2019 12:24:10 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 10620C300B;
        Wed, 16 Oct 2019 16:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571243048; bh=Q1OWeW46pCK8necNfIb4Cw9P88sWMr95qAMSB5WZ0fs=;
        h=From:To:Cc:Subject:Date:From;
        b=GNRSeiD+nBpYkpwkOSZNxrMIFHMdMmXpHqEClsL06AtAgJBXyUf1Ptp+hlS3r6d2C
         EjhH8bk+lU8LFmOdlWjPimuje4r52uMAvtVkbh7hGCOjjncVug2omGKze/+GDrLjls
         L6/p8sClaz4jRT/iAgpgnHn3U4/w6fqrItaNxY5s94IiEiVDlw0GXUqnWQUeVD4q5T
         M6WKB341jFkyttCEuM5FiSDo4PnvioBPHREC8d6iYf1UKnNiHZDfZbQZMVedoCaCE3
         e6JeBvLZKh54BoFoJ1uEeJ+aD4ssxqTpdUsnmmmzKxb8cB/7m2LqvnGcuwnl6r/0RH
         mABQaLiIsWxNg==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.61])
        by mailhost.synopsys.com (Postfix) with ESMTP id 14661A006D;
        Wed, 16 Oct 2019 16:24:02 +0000 (UTC)
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-mm@kvack.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v3 0/5] elide extraneous generated code for folded p4d/pud/pmd
Date:   Wed, 16 Oct 2019 09:23:55 -0700
Message-Id: <20191016162400.14796-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This series came out of seemingly benign excursion into understanding/removing
__ARCH_USE_5LEVEL_HACK from ARC port showing some extraneous code being
generated despite folded p4d/pud/pmd

| bloat-o-meter2 vmlinux-[AB]*
| add/remove: 0/0 grow/shrink: 3/0 up/down: 130/0 (130)
| function                                     old     new   delta
| free_pgd_range                               548     660    +112
| p4d_clear_bad                                  2      20     +18

The patches here address that

| bloat-o-meter2 vmlinux-[BF]*
| add/remove: 0/2 grow/shrink: 0/1 up/down: 0/-386 (-386)
| function                                     old     new   delta
| pud_clear_bad                                 20       -     -20
| p4d_clear_bad                                 20       -     -20
| free_pgd_range                               660     314    -346

The code savings are not a whole lot, but still worthwhile IMHO.

Please review, test and apply. It seems to survive my usual battery of
multibench, hakcbench etc.

Thx,
-Vineet

---
Changes since v2 [3]
 - No code changes: Fixed the silly typos and collected ACKs

Changes since v1 [1]
 - Per Linus Sugestion remvoed the extra ifdey'ery (hence not
   accumulating Kirill's ACks)
 - Added the RFC patch for pmd_free_tlb() after discussions [2]
 - Also throwing in the ARC patch which started this all (so we get the
   full context of patchset) - I'm ok if this goes via mm tree, should
   be non contentious and can drop this too if Andrew thinks otherwise

[1] http://lists.infradead.org/pipermail/linux-snps-arc/2019-October/006263.html
[2] http://lists.infradead.org/pipermail/linux-snps-arc/2019-October/006277.html
[3] http://lists.infradead.org/pipermail/linux-snps-arc/2019-October/006307.html
---

Vineet Gupta (5):
  ARC: mm: remove __ARCH_USE_5LEVEL_HACK
  asm-generic/tlb: stub out pud_free_tlb() if nopud ...
  asm-generic/tlb: stub out p4d_free_tlb() if nop4d ...
  asm-generic/tlb: stub out pmd_free_tlb() if nopmd
  asm-generic/mm: stub out p{4,u}d_clear_bad() if
    __PAGETABLE_P{4,u}D_FOLDED

 arch/arc/include/asm/pgtable.h      |  1 -
 arch/arc/mm/fault.c                 | 10 ++++++++--
 arch/arc/mm/highmem.c               |  4 +++-
 include/asm-generic/4level-fixup.h  |  1 -
 include/asm-generic/5level-fixup.h  |  1 -
 include/asm-generic/pgtable-nop4d.h |  2 +-
 include/asm-generic/pgtable-nopmd.h |  2 +-
 include/asm-generic/pgtable-nopud.h |  2 +-
 include/asm-generic/pgtable.h       | 11 +++++++++++
 include/asm-generic/tlb.h           |  4 ----
 mm/pgtable-generic.c                |  9 +++++++++
 11 files changed, 34 insertions(+), 13 deletions(-)

-- 
2.20.1

