Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C1D24CCE1
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 06:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgHUEol (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 00:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgHUEoi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 00:44:38 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A74EC061385;
        Thu, 20 Aug 2020 21:44:38 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k18so463485pfp.7;
        Thu, 20 Aug 2020 21:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2FijGblDddjp78CZtsuopymeT4GIAirJaILJzMaKauU=;
        b=c7SEuBm9ZYiwMyDgcCjUP4zkcAqcJWkSnCZkOh9wB/Q1IQYWihz+hZnrfBEOh8YtOo
         7oKYdorv5eBuZ6kfHQNFNprGFy29TgABA5JyE/oEjJ7SqNA9UsflqSpOSQH6A6F0HgO4
         n1Ms4wHgOaegdSr9pxT+782mC2bPskftyVMT9UuR05WNlfA31jSh2BBdEfrIikfeKbGT
         7XnmmP3RgtcKmGKSgn73d5a2tMgGTfWoCkCTZCWirqaujLImDZBUJHgejXJwHDcuqYsO
         +931rfrU7AbK0Ggp/BlSjg9QxvFgq51FZw7CPgSBFVbsPK3EMHLVfEyg7WldxgZDwgzs
         czVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2FijGblDddjp78CZtsuopymeT4GIAirJaILJzMaKauU=;
        b=RLucviBJbgBMqzgVgVA9DFSnYR5GO3bQstPC8WlhgUkamXP/qEM/DwQAe68+E8F7Pf
         h2EBjMo4bwlpecMzUQ+D008U0n60UQmb4OfSAY1VhKTOslwGKMBfI3iRCwyCMIcb4X+L
         5SHAa9VR/UhMhZMzzmxb/arlsORLWeac34owHxVRGprjK4erVWMvApfQTvw9BJOIqidD
         H5Y+0d8cBFvMmDKrc22IRlTsEug2Y5CoyIg054c8UQNr69Y5MpZ206BHjMN4DaOzz4RK
         hcNohmlyMfQ3EIwKyxksS6/04xhWsBspCLOdmdkieiZSZwcbpTYAP+UMhwI7GRFzBWao
         miow==
X-Gm-Message-State: AOAM532tpmAZeFO156BGbISAJz23gGkcmFIfQKzlftXA35Jtqn3hHakl
        16HwybZTfUY7ClGjkwVESWA=
X-Google-Smtp-Source: ABdhPJw13X7rw0q4xbArvVS+WyTpffCFf61Owreem8v6Q4CEO1zlzy3RKePEZ/FsBQwm1kKEDBNCCQ==
X-Received: by 2002:a63:cf03:: with SMTP id j3mr1043772pgg.198.1597985077991;
        Thu, 20 Aug 2020 21:44:37 -0700 (PDT)
Received: from bobo.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id l9sm683374pgg.29.2020.08.20.21.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 21:44:37 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v5 0/8] huge vmalloc mappings
Date:   Fri, 21 Aug 2020 14:44:19 +1000
Message-Id: <20200821044427.736424-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I made this powerpc-only for the time being. It shouldn't be too hard to
add support for other archs that define HUGE_VMAP. I have booted x86
with it enabled, just may not have audited everything.

Hi Andrew, would you care to put this in your tree?

Thanks,
Nick

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

Nicholas Piggin (8):
  mm/vmalloc: fix vmalloc_to_page for huge vmap mappings
  mm: apply_to_pte_range warn and fail if a large pte is encountered
  mm/vmalloc: rename vmap_*_range vmap_pages_*_range
  lib/ioremap: rename ioremap_*_range to vmap_*_range
  mm: HUGE_VMAP arch support cleanup
  mm: Move vmap_range from lib/ioremap.c to mm/vmalloc.c
  mm/vmalloc: add vmap_range_noflush variant
  mm/vmalloc: Hugepage vmalloc mappings

 .../admin-guide/kernel-parameters.txt         |   2 +
 arch/Kconfig                                  |   4 +
 arch/arm64/mm/mmu.c                           |  12 +-
 arch/powerpc/Kconfig                          |   1 +
 arch/powerpc/mm/book3s64/radix_pgtable.c      |  10 +-
 arch/x86/mm/ioremap.c                         |  12 +-
 include/linux/io.h                            |   9 -
 include/linux/vmalloc.h                       |  13 +
 init/main.c                                   |   1 -
 mm/ioremap.c                                  | 231 +--------
 mm/memory.c                                   |  60 ++-
 mm/page_alloc.c                               |   4 +-
 mm/vmalloc.c                                  | 456 +++++++++++++++---
 13 files changed, 476 insertions(+), 339 deletions(-)

-- 
2.23.0

