Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76859D7FEC
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2019 21:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfJOTT4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Oct 2019 15:19:56 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:39686 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389569AbfJOTTb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Oct 2019 15:19:31 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0A961C0CD8;
        Tue, 15 Oct 2019 19:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571167170; bh=QoRWNXgQmTXSWkCzboQjwBzdj5f3LiiL+Z3W4U/gMbE=;
        h=From:To:Cc:Subject:Date:From;
        b=X3D1iJXD/KJExvy7ioaMSbK04DGqFIP/0KpMKxCSUxlEQQpvB0iFGxqNN7F9t+5/Q
         Ym2808nWEoG5SozZ+GeXU3EHuWRbSbQxuMgp5B/jEKGcfkWJadE0Zj7+VuMP61SkIG
         witktVhnTUOL3QzgI/TjfgLnfkbxDdcXwsY8lDQnmzjkIMFUfQDvqxZXbhBNOyWJv4
         ZBnmAir2yWCEHCYZmIam8cEiPgC4ZkN/1cjh3VUXIJJtCKucwbKB8RHkvjVxtSTKO5
         9VrdsWbPqOxhwI1pz34A4PwFT5AIZFWsPdPWkYZ/qdjiOi/LAHDFAYYETPVTKgwRkY
         +iG9r3wILX/UQ==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.61])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4B745A006B;
        Tue, 15 Oct 2019 19:19:26 +0000 (UTC)
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v2 0/5] eldie generated code for folded p4d/pud
Date:   Tue, 15 Oct 2019 12:19:21 -0700
Message-Id: <20191015191926.9281-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This series came out of seemingly naive exceursion into understanding/removing
__ARCH_USE_5LEVEL_HACK from ARC port. With removal of 5LEVEL_HACK some
extraneous code was bein generated

| bloat-o-meter2 vmlinux-[AB]*
| add/remove: 0/0 grow/shrink: 3/0 up/down: 130/0 (130)
| function                                     old     new   delta
| free_pgd_range                               548     660    +112
| p4d_clear_bad                                  2      20     +18

Which the patches here elides (for folded p4d/pud/pmd)

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
Changes since v1 [1]
 - Per Linus Sugestion remvoed the extra ifdey'ery (hence not
   accumulating Kirill's ACks)
 - Added the RFC patch for pmd_free_tlb() after discussions [2]
 - Also throwing in the ARC patch which started this all (so we get the
   full context of patchset) - I'm ok if this goes via mm tree, should
   be non contentious and can drop this too if Andrew thinks otherwise

[1] http://lists.infradead.org/pipermail/linux-snps-arc/2019-October/006263.html
[2] http://lists.infradead.org/pipermail/linux-snps-arc/2019-October/006277.html

---

Vineet Gupta (5):
  ARC: mm: remove __ARCH_USE_5LEVEL_HACK
  asm-generic/tlb: stub out pud_free_tlb() if nopud ...
  asm-generic/tlb: stub out p4d_free_tlb() if nop4d ...
  asm-generic/tlb: stub out pmd_free_tlb() if nopmd
  asm-generic/mm: stub out p{4,d}d_clear_bad() if
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
 mm/pgtable-generic.c                |  8 ++++++++
 11 files changed, 33 insertions(+), 13 deletions(-)

-- 
2.20.1

