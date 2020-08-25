Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE8B251B9B
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 16:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHYO6F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 10:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHYO6E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Aug 2020 10:58:04 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4061CC061574;
        Tue, 25 Aug 2020 07:58:04 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u128so7552687pfb.6;
        Tue, 25 Aug 2020 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EV9ZwzCwV4Z9BNt841c3RBiIdIkv89NbNGG9BR4Vsvo=;
        b=tQvGYTFufQJ5ANwInffuD4W0HHbHhK3UMnx7AkOXZ23wS9FDnOwTjxSUnuDU8w4+6H
         WrzNpO/vv8kZIl9tBYikyi80TDvKRYoJRBF/EOhJ27PSG4SngR/Xuxnm4uoZDqEtmWBG
         w9Q0ZzZ9TN1p9oEP0v5cNP2EC/Qk6ju4EZSTPIhwUvYV4CJIzVxROxF6yxMWRxEcdjR3
         Wwb3UgbmDMVI5u10e62d1rDys9XDuhYY/OoRWEe7B70C4tjmS+HdaxNk2nUDyAKQCx1z
         59brznER2AMWT2lF91xyUfS5EzwwaTvRDntW33H3IP4yPpmtQ1udSgwIFm7gpknoBzQ6
         VDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EV9ZwzCwV4Z9BNt841c3RBiIdIkv89NbNGG9BR4Vsvo=;
        b=BtD7YGdTJUT2agGmnvXR8lfXoJjMV0/kJIHjtrC+5M3mHw3OStSb8wm2BskmgUB8G3
         ejNwmKN5P6Hm1Qey8xgbp48plidW0TwIGJqsgnpekMuqezTZsKO0zM6WSEZTbXLUbybv
         iMj0OBVVJ2TXQ+CmBcKk9593NgPGk6GAdUqiRl5Ffyx38L5fmzoE1OG4SNQ2EPpSTkFl
         i8LuphpqHt17nJdXpGr1WNxkNGu8gRPtbOaL1vkJ32QV+jA1q0JM0diit7I+oKz1BnlN
         j59I4R7Lug6tMaiMbUC8fwJvy+AoALTrTE+pTLFthydzQc0502CLOKb2JZkqiYP96v5+
         gAQw==
X-Gm-Message-State: AOAM533rqJ9iksNCfb1bOmojLvYnoxlcDLYxprRDgihjAwE8iLVnoQVs
        mZuGH5yO1GMJ/gSa6NmN0lU=
X-Google-Smtp-Source: ABdhPJxnK3YNImOtYVgHd5D3Y/G4BRiEKbLrVsJXP4BBfTIN6Zbw6lEUoA6/orOoc47WqA6yXSiVLw==
X-Received: by 2002:a17:902:8bcc:: with SMTP id r12mr7892933plo.314.1598367483737;
        Tue, 25 Aug 2020 07:58:03 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id e29sm15755956pfj.92.2020.08.25.07.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 07:58:03 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v7 00/12] huge vmalloc mappings
Date:   Wed, 26 Aug 2020 00:57:41 +1000
Message-Id: <20200825145753.529284-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I think it's ready to go into -mm if it gets acks for the arch
changes.

Thanks,
Nick

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

