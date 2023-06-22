Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99A073A9CA
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 22:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjFVU6o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 16:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFVU6k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 16:58:40 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93D52685;
        Thu, 22 Jun 2023 13:58:01 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bff0beb2d82so2082570276.2;
        Thu, 22 Jun 2023 13:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467476; x=1690059476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4Ig2n4cGI8BP25CqcNRq43JhOmkIIdJVFlb5elIpOA=;
        b=mqvv9g7FTX6YZrTAez67m8G0SADgQWX+ct2Q2ktq+TbKMG/cOnFNL1HUEejNSN9nds
         9vEK9L2HpCPHz3mnLHm7QE7bazoap9KPjRBuUT4kw6MBU7tHylSDou09veevPp+Qm5tI
         J6+0hmA98DudaYxzAoNczqxDp5g6z2tqapGcR3NSEAPAgqMiM1eNh+iIzBq7ayejKjj9
         5MP9SwhVaQTCo1G312fdQXe7vTjboPcFBobNzdFt65RtUbRTWvFRUfh7ZZb+Tak5rboQ
         uGsNAcBwqdQTtsTo7UoikA/hvdu33PxWnma34tmu5wLmqc0vL2bNnLhMWuiaLjOulKtx
         4JUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467476; x=1690059476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4Ig2n4cGI8BP25CqcNRq43JhOmkIIdJVFlb5elIpOA=;
        b=T8nREzyu0AIfFz+bk+HY0hPF5qMPGhi9FDohPgTWUfDGef1LEKtVyqXgZZPWTjno/S
         pS/jUOva9BpdIJnYSrniU5E0wWJK+t3tsNS/qJWTHPprMxLmV0nGLLX95DhINFln19GP
         gBjDSr5vF5YEuq4pAebIZoudxZepfqB59eb+08+S8ykjdvHIMuNuc2PcJ46tqPIWUir0
         qf/5/qmTrPvc8ssR8O9x2U25h9sFm5Oxbjo0SrV+Mqis16Iccct90PoG8U00n1uLKsvP
         dTnFnVKfGV5lpcoNKcQa/s2GSEZRZKkYydbRlfTxAiPrA1pFw2m240TDKGrByWIkBLDR
         DkCg==
X-Gm-Message-State: AC+VfDyxX+BxUqykjOGGFvggnQsQ3N6NrZUQvVMBv+6hqRqS9iE6gDnR
        UcQ/Cc05ZRrrowQD/L/hTfk=
X-Google-Smtp-Source: ACHHUZ5QdSwF+iokSIDxxYwBaWLG1oGIRpritBhsZ3H79UKVTTkrzsNTtfFGV/ude8v+TVUUcB2uCQ==
X-Received: by 2002:a05:6902:92:b0:bba:558e:df05 with SMTP id h18-20020a056902009200b00bba558edf05mr14486764ybs.10.1687467476004;
        Thu, 22 Jun 2023 13:57:56 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:57:55 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "David S. Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v5 00/33] Split ptdesc from struct page
Date:   Thu, 22 Jun 2023 13:57:12 -0700
Message-Id: <20230622205745.79707-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The MM subsystem is trying to shrink struct page. This patchset
introduces a memory descriptor for page table tracking - struct ptdesc.

This patchset introduces ptdesc, splits ptdesc from struct page, and
converts many callers of page table constructor/destructors to use ptdescs.

Ptdesc is a foundation to further standardize page tables, and eventually
allow for dynamic allocation of page tables independent of struct page.
However, the use of pages for page table tracking is quite deeply
ingrained and varied across archictectures, so there is still a lot of
work to be done before that can happen.

This is rebased on next-20230621.

There is a minor conflict with patch 24 and the mm-unstable tree in
arch/m68k/mm/motorola.c - The end result of applying the patch should
be the same.


v5:
  More Acked-bys :)
  Cleanup some documentation wording and formatting
  Add pt_rcu_head to ptdesc
  Add memcg to ptdesc (and align it with struct page)
  Ensure all get_free_page() callers prohibit HIGHMEM for 32 bit support.
  Renamed folio_{set, clear}_table() to folio_{set, clear}_pgtable()
  Removed pagetable_clear() as it is not necessary right now
  pagetable_free() now sets page->mapping = NULL
  Dropped s390 _refcount to _pt_frag_refcount conversion patch

Vishal Moola (Oracle) (33):
  mm: Add PAGE_TYPE_OP folio functions
  s390: Use _pt_s390_gaddr for gmap address tracking
  pgtable: Create struct ptdesc
  mm: add utility functions for ptdesc
  mm: Convert pmd_pgtable_page() to pmd_ptdesc()
  mm: Convert ptlock_alloc() to use ptdescs
  mm: Convert ptlock_ptr() to use ptdescs
  mm: Convert pmd_ptlock_init() to use ptdescs
  mm: Convert ptlock_init() to use ptdescs
  mm: Convert pmd_ptlock_free() to use ptdescs
  mm: Convert ptlock_free() to use ptdescs
  mm: Create ptdesc equivalents for pgtable_{pte,pmd}_page_{ctor,dtor}
  powerpc: Convert various functions to use ptdescs
  x86: Convert various functions to use ptdescs
  s390: Convert various gmap functions to use ptdescs
  s390: Convert various pgalloc functions to use ptdescs
  mm: Remove page table members from struct page
  pgalloc: Convert various functions to use ptdescs
  arm: Convert various functions to use ptdescs
  arm64: Convert various functions to use ptdescs
  csky: Convert __pte_free_tlb() to use ptdescs
  hexagon: Convert __pte_free_tlb() to use ptdescs
  loongarch: Convert various functions to use ptdescs
  m68k: Convert various functions to use ptdescs
  mips: Convert various functions to use ptdescs
  nios2: Convert __pte_free_tlb() to use ptdescs
  openrisc: Convert __pte_free_tlb() to use ptdescs
  riscv: Convert alloc_{pmd, pte}_late() to use ptdescs
  sh: Convert pte_free_tlb() to use ptdescs
  sparc64: Convert various functions to use ptdescs
  sparc: Convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
  um: Convert {pmd, pte}_free_tlb() to use ptdescs
  mm: Remove pgtable_{pmd, pte}_page_{ctor, dtor}() wrappers

 Documentation/mm/split_page_table_lock.rst    |  12 +-
 .../zh_CN/mm/split_page_table_lock.rst        |  14 +-
 arch/arm/include/asm/tlb.h                    |  12 +-
 arch/arm/mm/mmu.c                             |   7 +-
 arch/arm64/include/asm/tlb.h                  |  14 +-
 arch/arm64/mm/mmu.c                           |   7 +-
 arch/csky/include/asm/pgalloc.h               |   4 +-
 arch/hexagon/include/asm/pgalloc.h            |   8 +-
 arch/loongarch/include/asm/pgalloc.h          |  27 ++-
 arch/loongarch/mm/pgtable.c                   |   7 +-
 arch/m68k/include/asm/mcf_pgalloc.h           |  43 ++--
 arch/m68k/include/asm/sun3_pgalloc.h          |   8 +-
 arch/m68k/mm/motorola.c                       |   4 +-
 arch/mips/include/asm/pgalloc.h               |  32 +--
 arch/mips/mm/pgtable.c                        |   8 +-
 arch/nios2/include/asm/pgalloc.h              |   8 +-
 arch/openrisc/include/asm/pgalloc.h           |   8 +-
 arch/powerpc/mm/book3s64/mmu_context.c        |  10 +-
 arch/powerpc/mm/book3s64/pgtable.c            |  32 +--
 arch/powerpc/mm/pgtable-frag.c                |  46 ++--
 arch/riscv/include/asm/pgalloc.h              |   8 +-
 arch/riscv/mm/init.c                          |  16 +-
 arch/s390/include/asm/pgalloc.h               |   4 +-
 arch/s390/include/asm/tlb.h                   |   4 +-
 arch/s390/mm/gmap.c                           | 207 ++++++++++--------
 arch/s390/mm/pgalloc.c                        | 108 ++++-----
 arch/sh/include/asm/pgalloc.h                 |   9 +-
 arch/sparc/mm/init_64.c                       |  17 +-
 arch/sparc/mm/srmmu.c                         |   5 +-
 arch/um/include/asm/pgalloc.h                 |  18 +-
 arch/x86/mm/pgtable.c                         |  47 ++--
 arch/x86/xen/mmu_pv.c                         |   2 +-
 include/asm-generic/pgalloc.h                 |  88 +++++---
 include/asm-generic/tlb.h                     |  11 +
 include/linux/mm.h                            | 153 +++++++++----
 include/linux/mm_types.h                      |  14 --
 include/linux/page-flags.h                    |  30 ++-
 include/linux/pgtable.h                       |  77 +++++++
 mm/memory.c                                   |   8 +-
 39 files changed, 684 insertions(+), 453 deletions(-)

-- 
2.40.1

