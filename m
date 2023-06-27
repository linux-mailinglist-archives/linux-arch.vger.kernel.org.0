Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C01073F134
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjF0DPQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjF0DPO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:15:14 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C88410F5;
        Mon, 26 Jun 2023 20:15:08 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5704ddda6dfso44572567b3.1;
        Mon, 26 Jun 2023 20:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835708; x=1690427708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iYTDP3CVo/pn4MBpnsVYDf65SVee1q+w6kCUgJokK48=;
        b=kFdRpygS4WguFY2TIXFMCd2xbUYUslDwOhJ095L7ozx9CL0OSI6zj/K4mM+s7TbWhS
         9zIZyA70hoFifzCOd1aewZ1yhLO2rBPOLuIElBxKRi5m6cvGDxzOV5z6misqLTfIRCXL
         XPKfCVIPeKEk1w/EtT2SlKc18aMxKl81RwWtDJHCQOOQwTat12hCBR/UJwcCsUByCQnp
         xPIqCDYl6eeVttXMi5drV03T1r0uzwcB8eqR424vWOHJ9pfaxoKjvFS/+eIWFJtobwVv
         zZV6muAWYcpIcnBMA6UzmFfsZ6RlIit91ynY1KCJiFuPe3YS3HQ1OCdsGe5+lkqZWZwe
         tjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835708; x=1690427708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYTDP3CVo/pn4MBpnsVYDf65SVee1q+w6kCUgJokK48=;
        b=TsEfOsgkGOeTUl6tUWjiB55RONW92XGwPRO8SO4hCF7WS5deMA2dDd1DY3rr8Iyae9
         ChHGaR4VljGbRoleuFaiSBuzG/TLHFShKC1onUj50UytC9LDwSf8zX+gIL0CynjMsjOY
         6L6UM3kedJ4bViXgiJ5Mhw4eem9cVMRTN6eSZm2X5uMipRtD62evkMSLQmLqFxYeX8TF
         bKGOQIj5qUvZG3PK0IAjfMwI3zQCkOQBH5DNqzRRab79h1ochkfb5cirnRQeBPKKOMF0
         xsXh4pHPDsBU7Q1XrggIjiGZXj4v15w54eCKGRsIBizt2A5w2W5a90xSFRKQol1W5CCf
         Pe9w==
X-Gm-Message-State: AC+VfDwFeoEMR12fzilX76hHIKMbjsKOhhoZpc6vWmTqJ+9aqYv5aYFV
        gaNVGdYbRLqDzLgWWt4vqBM=
X-Google-Smtp-Source: ACHHUZ4ATK/fn+XGL+Tqd6Lbx5sr7g8FEnC/NPQWKHVXRjdEDS0JhBnwpRdiXqnqBIQnqfKuzcysxA==
X-Received: by 2002:a81:83ce:0:b0:570:28c6:a321 with SMTP id t197-20020a8183ce000000b0057028c6a321mr38284183ywf.18.1687835707756;
        Mon, 26 Jun 2023 20:15:07 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:07 -0700 (PDT)
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
Subject: [PATCH v6 00/33] Split ptdesc from struct page
Date:   Mon, 26 Jun 2023 20:13:58 -0700
Message-Id: <20230627031431.29653-1-vishal.moola@gmail.com>
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

This is rebased on next-20230626.

There is a minor conflict with patch 24 and the mm-unstable tree in
arch/m68k/mm/motorola.c - The end result of applying the patch should
be the same.

v6:
  Fix compiler warnings/errors

v5:
  More Acked-bys :)
  Cleanup some documentation wording and formatting
  Add pt_rcu_head to ptdesc
  Add memcg to ptdesc (and align it with struct page)
  Ensure all get_free_page() callers prohibit HIGHMEM for 32 bit support.
  Renamed folio_{set, clear}_table() to folio_{set, clear}_pgtable()
  Removed pagetable_clear() as it is not necessary right now
  Dropped s390 _refcount to _pt_frag_refcount conversion

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
 arch/m68k/include/asm/mcf_pgalloc.h           |  47 ++--
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
 39 files changed, 686 insertions(+), 455 deletions(-)

-- 
2.40.1

