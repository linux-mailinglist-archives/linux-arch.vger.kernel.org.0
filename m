Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15AD24D81C
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 17:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgHUPMc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 11:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgHUPMa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 11:12:30 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC48C061573;
        Fri, 21 Aug 2020 08:12:28 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so1148685pgf.0;
        Fri, 21 Aug 2020 08:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRxrDToJB/xPOxG5kGdgUWQPtXDsSaGWKdRXIKBnLww=;
        b=kZUnJ6jz2FEkjkC4B07sDG1MjmzhjlUML84kGzNbhSDyDdfVyIkBqQ1JVaKnlcpnsW
         O4/rnCdzXc5wLDuh66q0rTTJxxarsRrbbSJ3CBzYgOl2Kiph/wZYJr1Qvco+GQ7avZZF
         Dbs74MOkriYYn3Uv1eGMGWPeNA1bNr83Aa+YHScAmKLmebvgMrUyej9FYoVnkrCPjtE3
         /d9DU7qLsc96xQiWL8n/lPwiBLfzsLbk3ZLdsUeHAbC9H8xLy9KN7b5omTiIo5lCszfb
         4BIvgj0FwaU6x9/I2bYSDZEgvwAguArcSIW9qjKYuZ90qn8CQH/xh3SQ44OCN04qHdb/
         qz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRxrDToJB/xPOxG5kGdgUWQPtXDsSaGWKdRXIKBnLww=;
        b=EA68r7e7JOxQzC089+nNHH9Kj1n1ZhweTRlVYDRRfkbCMMoERm2JwwNxgRvd6KpEc5
         ea6H8E/y6CJ3Aeix0tJVBPcxUm+BvyC9p44hg1PO4HjOij7e33AEhTxr28auEaMt5x9D
         nkdR9H5XfmjLLDcLWylnz5fYzKWHP40Pa8JNaWuWe/px8cxTQzLm+EX7uyWagOiLy4v7
         b80pi7dm8tTXGpyjPjTeSJRl4aLWdovWIdwiXL1Qap6byiU+DVzaeMZHThvmoP8bHtlI
         2t1oLCaV+BVkOOMkXyy06MbfXv2M4VI2IvEoBFsyblpjudnindX8A18di6JG28FZU98u
         y56g==
X-Gm-Message-State: AOAM532Gx1MvVzhoP6NRbe41YT+BvvnoK+kcCVTgc5zRSEEVvrxnFSsr
        i9zjSjxyiHgBkB/Bi65YwXjaYB1uPZM=
X-Google-Smtp-Source: ABdhPJxt6gfGs7RCQ4HiMUqjAvNGZuzKIyZP+qM+HUnYFTtKpiyJhyFCAA1UxFk4xgMqZ7BnAojcJw==
X-Received: by 2002:aa7:8757:: with SMTP id g23mr2825194pfo.283.1598022748057;
        Fri, 21 Aug 2020 08:12:28 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id s8sm3126985pfc.122.2020.08.21.08.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:12:27 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v6 00/12] huge vmalloc mappings
Date:   Sat, 22 Aug 2020 01:12:04 +1000
Message-Id: <20200821151216.1005117-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thanks Christophe and Christoph for reviews.

Thanks,
Nick

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
  lib/ioremap: rename ioremap_*_range to vmap_*_range
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
 mm/memory.c                                   |  60 ++-
 mm/page_alloc.c                               |   5 +-
 mm/vmalloc.c                                  | 443 +++++++++++++++---
 17 files changed, 515 insertions(+), 393 deletions(-)

-- 
2.23.0

