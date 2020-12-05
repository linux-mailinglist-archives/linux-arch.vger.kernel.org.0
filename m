Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18032CFA0D
	for <lists+linux-arch@lfdr.de>; Sat,  5 Dec 2020 07:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgLEG6R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Dec 2020 01:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgLEG6R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2020 01:58:17 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3E4C0613D1;
        Fri,  4 Dec 2020 22:57:37 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id l11so4397364plt.1;
        Fri, 04 Dec 2020 22:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=074wL6ZBgABmXkOs/NT61EJN0HBh0dhkxvXZ++X/yaI=;
        b=J39tLhFdiM/eYZNAhg85XVZeU7vlVYLTE2YpuzmX6S36rV2NljZYLQse33dtlTfU+D
         P0A9XxiD/TRZFku3U3uZmRO+9sMfVlrPdOrUY0ub9mOfSoaFbGi7KBycRjIRZ1I1f7G3
         AOg0CwR2kDU4wX7GGBTPPl2qINMfeDZC+MT4uWns92NjqsKo/IZwtBmm7faHE4YvF91k
         XkzZVlYRiLabOUV2ZGcN1Y2QhSwfLCZwb3ldvzRkdexCD//G76XOV0MFbsjUrZ5g0ov+
         SorgGaftGRsp0BWTZImGOqW1L2K+kHrJOBP8qwt2V6kfphRegH2pVENoKPosU6WKDL5u
         S8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=074wL6ZBgABmXkOs/NT61EJN0HBh0dhkxvXZ++X/yaI=;
        b=m0l4Tce9thPx0yR5gvewkITlMy2FHzvBfhx7Uk3GTM9ZNDcDBJCsOe/pXxt56ReIgQ
         RlHrLhTqqiGKlLfKmi/flIiOY13zMYMXMMTX9Xs6p6abaGiJMKhmfZ4gShtaF9SalMBY
         PUMoaQs/JMRSqo0E8fUtdJJu7g/vAaYLI9McF5IA3VDPeQ1DmXer9USrLqIIs71GyQ1s
         X+mJK/lncUL96MYv4OoQgDEJohbJGWqBAEDPwJeUSLn13oVexZoTMCROdybvj/j2U4Xm
         RLwmwJrPmh6HORblSnv7Hmgq4KvBAqPhj7Ps7LIIGhDX+/fF+daKePslywiM577r7hkF
         X0ZA==
X-Gm-Message-State: AOAM533T8j3aRH1iAcpsF02WCDOn/R6SSwUZIxOnn/Q/Pc1ATYcvT1fO
        8DWYHl0GOxbmgNKSH8tjpEHBBd0Ssq4=
X-Google-Smtp-Source: ABdhPJwD8LBysVSEMi9XYXVOROVfRZw/7sF9SVYYn1E01iFvQoYVyH6bH0o2iaHCD6/K8Gh1B/sbWQ==
X-Received: by 2002:a17:902:9b85:b029:da:1684:cc82 with SMTP id y5-20020a1709029b85b02900da1684cc82mr7368955plp.41.1607151456568;
        Fri, 04 Dec 2020 22:57:36 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([1.129.145.238])
        by smtp.gmail.com with ESMTPSA id a14sm1110848pfl.141.2020.12.04.22.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 22:57:35 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v9 00/12] huge vmalloc mappings
Date:   Sat,  5 Dec 2020 16:57:13 +1000
Message-Id: <20201205065725.1286370-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andrew,

A couple of things Rick noticed, he's working on huge module mappings
to help iTLB pressure and seems to think this series will be useful
infrastructure for his work.

I think it finally should be just about ready.

Thanks,
Nick

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
- Hopefully this time fix the arm64 vmap stack bug, thanks Jonathan
  Cameron for debugging the cause of this (hopefully).

Since v2:
- Rebased on vmalloc cleanups, split series into simpler pieces.
- Fixed several compile errors and warnings
- Keep the page array and accounting in small page units because
  struct vm_struct is an interface (this should fix x86 vmap stack debug
  assert). [Thanks Zefan]

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
 arch/Kconfig                                  |  10 +
 arch/arm64/include/asm/vmalloc.h              |  25 +
 arch/arm64/mm/mmu.c                           |  26 -
 arch/powerpc/Kconfig                          |   1 +
 arch/powerpc/include/asm/vmalloc.h            |  21 +
 arch/powerpc/kernel/module.c                  |  13 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c      |  21 -
 arch/x86/include/asm/vmalloc.h                |  23 +
 arch/x86/mm/ioremap.c                         |  19 -
 arch/x86/mm/pgtable.c                         |  13 -
 include/linux/io.h                            |   9 -
 include/linux/vmalloc.h                       |  27 ++
 init/main.c                                   |   1 -
 mm/ioremap.c                                  | 225 +--------
 mm/memory.c                                   |  66 ++-
 mm/page_alloc.c                               |   5 +-
 mm/vmalloc.c                                  | 454 +++++++++++++++---
 18 files changed, 564 insertions(+), 397 deletions(-)

-- 
2.23.0

