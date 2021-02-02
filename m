Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB49830BC8B
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 12:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbhBBLGH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 06:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBBLGE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 06:06:04 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A93C061573;
        Tue,  2 Feb 2021 03:05:24 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id m6so14102616pfk.1;
        Tue, 02 Feb 2021 03:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fqt4DThxdKNuSOBjCZQBQQc5bLu6VHMom1GHVDUjPiM=;
        b=M3wshu9WFXWfg1u2zWH4MoOooVL5HvLFGznDmgd10bY1jLa0swW2qOHHlmejGgZXh6
         MCokFcCI8oAiuqy/5WEZznys9zmJlSxCiSsghopCOTgxmN0ZNzEWB87sMjNrStzUS1mp
         eYBiz7qaoI8T0URRpPzEw+7B1KGSjrigbZS3nVRZE0tVcAsdwxhKkn64BLL+OHYm7uev
         YKcywPeeOgoEYgfBHrO/iX7ks6Ca0xm/pqoVF5OQkn2QHtPXXEcr/FQnmZ2OZQG+WdIW
         FiLzawqcp+gpq5a4PpgzgVRqwkc6nMsMTt6AplOZ4E25dztGgRsujnLQLDdahqXrJ/b3
         6crQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fqt4DThxdKNuSOBjCZQBQQc5bLu6VHMom1GHVDUjPiM=;
        b=MJec/hGkvpwml9KNmTi5chLZ4xxZhy4vELKYXAC+IOV0WGvxQzqCQ9p/+lTrpXgK+l
         05BrhiRZ0dDtX1wZ1tJL+vHdBR+XEUaYwSYZOWCTe01JQAvbzKuHnal+MdfArBpnqQ6Z
         MO3BnZm7WfUU5e2jVtIDJc1pefO/Hfld8wgUVmu+zYgczomNR087QmwcK6+Vxa4ear9X
         CVzwcU72dCat/RJvX5T3EvMJRUfqLBDQR5hPH90HeaLsRzXanBo4n70jdxkP6Ab+cR5g
         pzm3Mk3GxdwWtp1UUdOnS/MqUaRlC7n/D19x+JkpstkgiQ8f7j0Xan6RN/Zp0LWcOTWk
         emRQ==
X-Gm-Message-State: AOAM530eWDKH9JabiH817sG3isMSmPzFiubynqFsW0hJmhtRq1MnsgaZ
        21UnjseMrOKZIEa9Q0KzPto=
X-Google-Smtp-Source: ABdhPJxhnGIeHb6UDmUQMJXJ/+PphBnJNTyr7MTD4n2tqqbe1fej56ZLHpSXYU0W7n4OzBsp04H+Iw==
X-Received: by 2002:a62:3301:0:b029:1d0:2621:372b with SMTP id z1-20020a6233010000b02901d02621372bmr200562pfz.67.1612263924060;
        Tue, 02 Feb 2021 03:05:24 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-242-11-44.static.tpgi.com.au. [60.242.11.44])
        by smtp.gmail.com with ESMTPSA id g19sm3188979pfk.113.2021.02.02.03.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 03:05:23 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>
Subject: [PATCH v12 00/14] huge vmalloc mappings
Date:   Tue,  2 Feb 2021 21:05:01 +1000
Message-Id: <20210202110515.3575274-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Should be getting close now. No doubt there will be a few more
things but I can do incremental fixes for small things if this gets
into -mm.

Thanks,
Nick

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

Since v4:
- Fixed an off-by-page-order bug in v4
- Several minor cleanups.
- Added page order to /proc/vmallocinfo
- Added hugepage to alloc_large_system_hage output.
- Made an architecture config option, powerpc only for now.

Since v3:
- Fixed an off-by-one bug in a loop
- Fix !CONFIG_HAVE_ARCH_HUGE_VMAP build fail

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
 arch/powerpc/kernel/module.c                  |  21 +-
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
 mm/vmalloc.c                                  | 484 +++++++++++++++---
 21 files changed, 619 insertions(+), 404 deletions(-)

-- 
2.23.0

