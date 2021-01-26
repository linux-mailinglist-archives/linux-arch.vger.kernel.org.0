Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C046304DCB
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 01:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbhAZXRG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 18:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbhAZEqD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jan 2021 23:46:03 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFFBC061573;
        Mon, 25 Jan 2021 20:45:23 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 11so9801035pfu.4;
        Mon, 25 Jan 2021 20:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AFfFN2OAQ8TwttkY21sH9afv+ooH6c07LAgyNmn2ne8=;
        b=SYAJDvZ64NU29shcQLyX9k6o8kTN0WBUv14l0TWsjcwt8g3sIOk5GSfxvOS92GwMXa
         92FOajX3UORP5tkqQE8zpafN6H0PJy2u9A3rTMrcLw8LMjH7/+qNT+ap0yxO9khh7zAq
         NIWoLk0pvSRhR3EmUFm26IVns/dfQAJVn0JkomMdxpVi6Oi0Bis/Z+KTFbG0Hv3iJvqZ
         yDrOp9taoWmnsfzRZ+bFeBqsEAJz9pC91YSXuzzQ8rIrJHvDtrDcSdwlWV+T95BvQueB
         WRwTdYuxABa/YgIi4hWkzme/RTHYzfOqkWro6yeCdVn8hefk8d9DcQ+qV2MdXbZqJ3q+
         WM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AFfFN2OAQ8TwttkY21sH9afv+ooH6c07LAgyNmn2ne8=;
        b=r+edtqDel9l31JnCXqVZmLFn892/KA5pkUtTpR4jXTXqfOAmftDaGGPDN98otNBaa/
         nJKSvAiKqhlXwZt/UkOoRKcJkCk7HvniyfdzRl/Vg/OnHTZYoDH7ycbd/G8kgilr4IqD
         GBut3TvGjX2hWb7HsB6540S+d4p9igLUwW5JWaP3+6e8KHMWEt09UTj5t592/zQ6xEen
         QRdw/yvr0c8bejoXsjs/WV37bdeNR41Pems05aCUtgNOGmMCoDmGJekLJi499tUbpmn5
         a7q6FGaEk4P5WVMpioaRoU6ocUgThu649+nuXOTicm7g897+lzFoiMk/Uh/Jfth/bgnh
         bDEQ==
X-Gm-Message-State: AOAM531sI4mz2ns7NiRHj8pTIVli6+kGRWGL2mHRuRAOZXME6mskA8fw
        Ac7lNW33RfMrOiOslh7uG7k=
X-Google-Smtp-Source: ABdhPJw2TZnjjQ2toXtftBVanmOt8gohLfB95odGUonFep85R53b56tt4Y6Y/w91de6NlHaKOXitiw==
X-Received: by 2002:a63:df09:: with SMTP id u9mr3890007pgg.187.1611636323069;
        Mon, 25 Jan 2021 20:45:23 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id 68sm19272293pfg.90.2021.01.25.20.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:45:22 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>
Subject: [PATCH v11 00/13] huge vmalloc mappings
Date:   Tue, 26 Jan 2021 14:44:57 +1000
Message-Id: <20210126044510.2491820-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I think I ended up implementing all Christoph's comments because
they turned out better in the end. Cleanups coming in another
series though.

Thanks,
Nick

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

Nicholas Piggin (13):
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
 mm/ioremap.c                                  | 225 +-------
 mm/memory.c                                   |  66 ++-
 mm/page_alloc.c                               |   5 +-
 mm/vmalloc.c                                  | 484 +++++++++++++++---
 18 files changed, 614 insertions(+), 400 deletions(-)

-- 
2.23.0

