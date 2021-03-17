Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C45933E997
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 07:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhCQGYZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 02:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCQGYQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 02:24:16 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A9FC06174A;
        Tue, 16 Mar 2021 23:24:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n17so272221plc.7;
        Tue, 16 Mar 2021 23:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JFW8/FgTFdT7uvRPjc6Otagd8anfs+Ol34lApL1vupo=;
        b=DBS9GbjcOW9+Rbw4XpKBiucRZGyfcZBNzGjjrnOlguKd4ql9Hvmnuk3+7IXUnQM2c/
         iKDk7u4FrjFqde+y6JmRnLhHdwdhyp9DEzQl+9lO/hHt/FNCFqCpiir9dgeisSVkzncI
         ZZy6zAJa6lOLrffaM8SrO3d64RpYflUD2a014EeFmVPyWnRSJ/gj1u8OdsjKWX5O8//Y
         kWyFtT4xfeeS3h62Wng1k2aZndewPi8jwZ3+l72I2Op5eDHuOxE4uQw2zlusBqp/tuga
         OLoauXUxw5PwFXWQn5thCCVULBMOC5mIHN6Z3JUHPzZopDhXxf3mA/p25DqG6FVXrIEM
         Rpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JFW8/FgTFdT7uvRPjc6Otagd8anfs+Ol34lApL1vupo=;
        b=EeWWc+z47UNz+1y5ft2+Spm5piHT33G/1GXDc0u4IM8PaFgj6dwMysPOaRzu1mdp08
         Y/HoLKZ42WBDmpwbOye5R4nbtOvQ3cAHVlUOezJstt9eroyP/ZJ3IcavVgRiip9mGCYL
         cW0aiYZy4KvOXkvABUKGmZEm3AgMM7zMgqymHRmSSZ50xGODWImVckGIWsITkuO+sDoK
         sWTfKIzG5rVPduFLXsa+LBJ6ABfz0zbcZASSCG2rWhZQ3IPvj8UpOrKeLQawKp//PnPZ
         xxJgJTEiRAT9gQG5h4YxaWKvxKDqs2JsrVQ6257GkKJbrzjTE72dTTfDfgm372CocdYG
         6d5w==
X-Gm-Message-State: AOAM532pWINGaDy9m8qQll62hyg2a5J+6hHiyNH7RqhGwSaOs2N0Md2x
        z1XhnnL0C4oiBPAuLFENyLQ=
X-Google-Smtp-Source: ABdhPJwFKdxetbaIOTS0SrvcvdqurekRwLM/u2w5nDyR2H5MRVWMYl1WBScSVdD0LMXytHcjROewxA==
X-Received: by 2002:a17:90a:1509:: with SMTP id l9mr2921447pja.163.1615962254531;
        Tue, 16 Mar 2021 23:24:14 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id s19sm17959620pfh.168.2021.03.16.23.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:24:13 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>
Subject: [PATCH v13 00/14] huge vmalloc mappings
Date:   Wed, 17 Mar 2021 16:23:48 +1000
Message-Id: <20210317062402.533919-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Important compound page fix thanks to Ding Tianhong. 

Thanks,
Nick

Since v12:
- Use compound pages so it works with remap_vmalloc_range [noticed by Ding]
- Fix debug_vm_pgtable.c compile error.

Since v11:
- ARM compile fix (patch 1)
- debug_vm_pgtable compile fix

Since v10:
- Fixed code style, most > 80 colums, tweak patch titles, etc [thanks Christoph]
- Made huge vmalloc code and data structure compile away if unselected
  [Christoph]
- Archs only have to provide arch_vmap_p?d_supported for levels they
  implement [Christoph]

Since v9:
- Fixed intermediate build breakage on x86-32 !PAE [thanks Ding]
- Fixed small page fallback case vm_struct double-free [thanks Ding]

Since v8:
- Fixed nommu compile.
- Added Kconfig option help text
- Added VM_NOHUGE which should help archs implement it [suggested by Rick]

Since v7:
- Rebase, added some acks, compile fix
- Removed "order=" from vmallocinfo, it's a bit confusing (nr_pages
  is in small page size for compatibility).
- Added arch_vmap_pmd_supported() test before starting to allocate
  the large page, rather than only testing it when doing the map, to
  avoid unsupported configs trying to allocate huge pages for no
  reason.

Since v6:
- Fixed a false positive warning introduced in patch 2, found by
  kbuild test robot.

Since v5:
- Split arch changes out better and make the constant folding work
- Avoid most of the 80 column wrap, fix a reference to lib/ioremap.c
- Fix compile error on some archs

*** BLURB HERE ***

Nicholas Piggin (14):
  ARM: mm: add missing pud_page define to 2-level page tables
  mm/vmalloc: fix HUGE_VMAP regression by enabling huge pages in
    vmalloc_to_page
  mm: apply_to_pte_range warn and fail if a large pte is encountered
  mm/vmalloc: rename vmap_*_range vmap_pages_*_range
  mm/ioremap: rename ioremap_*_range to vmap_*_range
  mm: HUGE_VMAP arch support cleanup
  powerpc: inline huge vmap supported functions
  arm64: inline huge vmap supported functions
  x86: inline huge vmap supported functions
  mm/vmalloc: provide fallback arch huge vmap support functions
  mm: Move vmap_range from mm/ioremap.c to mm/vmalloc.c
  mm/vmalloc: add vmap_range_noflush variant
  mm/vmalloc: Hugepage vmalloc mappings
  powerpc/64s/radix: Enable huge vmalloc mappings

 .../admin-guide/kernel-parameters.txt         |   2 +
 arch/Kconfig                                  |  11 +
 arch/arm/include/asm/pgtable-3level.h         |   2 -
 arch/arm/include/asm/pgtable.h                |   3 +
 arch/arm64/include/asm/vmalloc.h              |  24 +
 arch/arm64/mm/mmu.c                           |  26 -
 arch/powerpc/Kconfig                          |   1 +
 arch/powerpc/include/asm/vmalloc.h            |  20 +
 arch/powerpc/kernel/module.c                  |  22 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c      |  21 -
 arch/x86/include/asm/vmalloc.h                |  20 +
 arch/x86/mm/ioremap.c                         |  19 -
 arch/x86/mm/pgtable.c                         |  13 -
 include/linux/io.h                            |   9 -
 include/linux/vmalloc.h                       |  46 ++
 init/main.c                                   |   1 -
 mm/debug_vm_pgtable.c                         |   4 +-
 mm/ioremap.c                                  | 225 +-------
 mm/memory.c                                   |  66 ++-
 mm/page_alloc.c                               |   5 +-
 mm/vmalloc.c                                  | 485 +++++++++++++++---
 21 files changed, 621 insertions(+), 404 deletions(-)

-- 
2.23.0

