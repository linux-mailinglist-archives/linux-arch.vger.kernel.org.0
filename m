Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C5E2C72BC
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbgK1VuR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387426AbgK1THa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Nov 2020 14:07:30 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073ADC02A1B4;
        Sat, 28 Nov 2020 07:26:09 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q10so7064987pfn.0;
        Sat, 28 Nov 2020 07:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GHPYzM4jRC5rTtI6jITOYY+6mqWQDFCFmyVj9lbViqM=;
        b=r3NsuPL716Gbgc91UvbQ7Phv454iWIU3Ws+yRn1NF8ztZyJQEC12d/w6ht7/hkUIB2
         GQ7zk+ZsmiUP5fj1Y+CNw5ilGJdKf4uR1xAysGjstUx2EwVyBaj6ky+/iCCcGC0qaSsg
         59lI7fxzzbMkqSVze/gFz01BoXbyZF1+wGQGjIzJk6gTPmzDzS20twqYprzF16NuikVx
         Y/vMpPW187nLpKZmVnGk2UdsdFIN81xJkOTSUMC3UHpC1rmRNPfRfsv9f9hq2pLTO0of
         tJBpJn8dn4aff5mwgKy4I/VDRXC6xdx0Q+4BBGlWQ3Xj4xlZ36ycPUhKIrWGWIsJCQ58
         c74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GHPYzM4jRC5rTtI6jITOYY+6mqWQDFCFmyVj9lbViqM=;
        b=av+4CakcD3DK+DZYwxGfc/fkewS2K09snFc0Xbm3WQctEcwt62PEqAVrEpUWlEjSS6
         rlclgYi+M10DU2v6I808T+uIdwlHAuH0M3LrtdU18UM2GJxWd1AL7MVFvOMDI6IG4bkz
         L9le1LMiAaN6cZzYtbqtDdDHCRXYQzKFKb+OlwYs+NfTm1IAH1scDbrAVOVtiZHcr5Ux
         kP5dridIHuTkLr3V0/BVuGzq8eHWns0RbtOOg7RtAPl6Oq9NEGRXWl586iDeNgxktQVw
         MMmGlKLSd2E9lE3rk2fpMHRhWeEQxGYM1rinH/L4Wjjqjn49y+JmBAZtRq493y7El3gK
         u+Ag==
X-Gm-Message-State: AOAM531YDAE94n+omI9woDr04YmcnB/BHwmio83DEijK0so3FCFEItAU
        lBsDlkQ8oWFHytzkg++etxU=
X-Google-Smtp-Source: ABdhPJzATmCEtGS9aoj2vYvtmzZ2I4PDKHAI5rV7JzJixtHGXrGtJ2A5RqcQYH/fOjEekJVYwlteoQ==
X-Received: by 2002:aa7:8f09:0:b029:18c:4cc6:891d with SMTP id x9-20020aa78f090000b029018c4cc6891dmr11676493pfr.46.1606577169501;
        Sat, 28 Nov 2020 07:26:09 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
        by smtp.gmail.com with ESMTPSA id d22sm15500173pjw.11.2020.11.28.07.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 07:26:08 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v8 00/12] huge vmalloc mappings
Date:   Sun, 29 Nov 2020 01:25:47 +1000
Message-Id: <20201128152559.999540-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andrew,

Please consider this for -mm.

Thanks,
Nick

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
- Hopefully this time fix the arm64 vmap stack bug, thanks Jonathan
  Cameron for debugging the cause of this (hopefully).

Since v2:
- Rebased on vmalloc cleanups, split series into simpler pieces.
- Fixed several compile errors and warnings
- Keep the page array and accounting in small page units because
  struct vm_struct is an interface (this should fix x86 vmap stack debug
  assert). [Thanks Zefan]
*** BLURB HERE ***

Nicholas Piggin (12):
  mm/vmalloc: fix vmalloc_to_page for huge vmap mappings
  mm: apply_to_pte_range warn and fail if a large pte is encountered
  mm/vmalloc: rename vmap_*_range vmap_pages_*_range
  mm/ioremap: rename ioremap_*_range to vmap_*_range
  mm: HUGE_VMAP arch support cleanup
  powerpc: inline huge vmap supported functions
  arm64: inline huge vmap supported functions
  x86: inline huge vmap supported functions
  mm: Move vmap_range from mm/ioremap.c to mm/vmalloc.c
  mm/vmalloc: add vmap_range_noflush variant
  mm/vmalloc: Hugepage vmalloc mappings
  powerpc/64s/radix: Enable huge vmalloc mappings

 .../admin-guide/kernel-parameters.txt         |   2 +
 arch/Kconfig                                  |   4 +
 arch/arm64/include/asm/vmalloc.h              |  25 +
 arch/arm64/mm/mmu.c                           |  26 -
 arch/powerpc/Kconfig                          |   1 +
 arch/powerpc/include/asm/vmalloc.h            |  21 +
 arch/powerpc/mm/book3s64/radix_pgtable.c      |  21 -
 arch/x86/include/asm/vmalloc.h                |  23 +
 arch/x86/mm/ioremap.c                         |  19 -
 arch/x86/mm/pgtable.c                         |  13 -
 include/linux/io.h                            |   9 -
 include/linux/vmalloc.h                       |  10 +
 init/main.c                                   |   1 -
 mm/ioremap.c                                  | 225 +--------
 mm/memory.c                                   |  66 ++-
 mm/page_alloc.c                               |   5 +-
 mm/vmalloc.c                                  | 453 +++++++++++++++---
 17 files changed, 529 insertions(+), 395 deletions(-)

-- 
2.23.0

