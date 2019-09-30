Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03720C1F14
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2019 12:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfI3KhA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Sep 2019 06:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730332AbfI3KhA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Sep 2019 06:37:00 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EDC321855;
        Mon, 30 Sep 2019 10:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569839818;
        bh=Wo5z/Lo2MwuY2XoYEMUTOqsjpMQBIxXOoOM3zyLHIA4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cPYjw/IsA9612Z0eYOJIc0tWM9I/XDAW5lY2LK8tKBQZcWx4bVb08Bf6gcIbYi/Ry
         l3KCqnYmcmSCQr4oNYrWpLfHb2FpE2fD9oOxTo2mxoj0VTvGFCaVZTymMslG/tX+5/
         o51QX/5XpUFPH43g4YwnwvqyjSbRv6t+zkzWcnXw=
Received: by mail-wr1-f47.google.com with SMTP id h7so10676055wrw.8;
        Mon, 30 Sep 2019 03:36:58 -0700 (PDT)
X-Gm-Message-State: APjAAAUfcexawMD1y2jNpaVBioa5B5LfJUgZORwsDs83KJr3SR7LVuXm
        ZO+/cSNEIUHv1n9l7UCPKhjPAggDK4kKEvTDPis=
X-Google-Smtp-Source: APXvYqx0RhuEPqG3vhjBu2ugnclHJxAT1cGcUuXuL2TyU30xlF8X7oiIT3P9zzKTZlcF3tJP6SX0uH+eQ+zlwIH6guI=
X-Received: by 2002:adf:fac3:: with SMTP id a3mr9954344wrs.24.1569839817054;
 Mon, 30 Sep 2019 03:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <1569839484-28170-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1569839484-28170-1-git-send-email-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 30 Sep 2019 18:36:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ3i7FtEtgprNEAGSYPn=H8NjFxk5ekXz40Vov4j2XUOQ@mail.gmail.com>
Message-ID: <CAJF2gTQ3i7FtEtgprNEAGSYPn=H8NjFxk5ekXz40Vov4j2XUOQ@mail.gmail.com>
Subject: Re: [GIT PULL] csky changes for v5.3-rc1
To:     torvalds@linux-foundation.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Abandoned

Sorry for wrong tile, please Ignore this email.

On Mon, Sep 30, 2019 at 6:31 PM <guoren@kernel.org> wrote:
>
> Hi Linus,
>
> The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:
>
>   Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)
>
> are available in the git repository at:
>
>   https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.4-rc1
>
> for you to fetch changes up to 9af032a30172e119a5935f802b066631f8ded2d6:
>
>   csky: Move static keyword to the front of declaration (2019-09-30 11:50:49 +0800)
>
> ----------------------------------------------------------------
> csky-for-linus-5.4-rc1: arch/csky patches for 5.4-rc1
>
> This round of csky subsystem just some fixups.
>
> Fixup:
>  - Fixup mb() synchronization problem
>  - Fixup dma_alloc_coherent with PAGE_SO attribute
>  - Fixup cache_op failed when cross memory ZONEs
>  - Optimize arch_sync_dma_for_cpu/device with dma_inv_range
>  - Fixup ioremap function losing
>  - Fixup arch_get_unmapped_area() implementation
>  - Fixup defer cache flush for 610
>  - Support kernel non-aligned access
>  - Fixup 610 vipt cache flush mechanism
>  - Fixup add zero_fp fixup perf backtrace panic
>  - Move static keyword to the front of declaration
>  - Fixup csky_pmu.max_period assignment
>  - Use generic free_initrd_mem()
>  - entry: Remove unneeded need_resched() loop
>
> CI-Tested: https://gitlab.com/c-sky/buildroot/pipelines/77689888
>
> ----------------------------------------------------------------
> Guo Ren (10):
>       csky: Fixup mb() synchronization problem
>       csky: Fixup dma_alloc_coherent with PAGE_SO attribute
>       csky/dma: Fixup cache_op failed when cross memory ZONEs
>       csky: Optimize arch_sync_dma_for_cpu/device with dma_inv_range
>       csky: Fixup ioremap function losing
>       csky: Fixup arch_get_unmapped_area() implementation
>       csky: Fixup defer cache flush for 610
>       csky: Support kernel non-aligned access
>       csky: Fixup 610 vipt cache flush mechanism
>       csky: Fixup add zero_fp fixup perf backtrace panic
>
> Krzysztof Wilczynski (1):
>       csky: Move static keyword to the front of declaration
>
> Mao Han (1):
>       csky: Fixup csky_pmu.max_period assignment
>
> Mike Rapoport (1):
>       csky: Use generic free_initrd_mem()
>
> Valentin Schneider (1):
>       csky: entry: Remove unneeded need_resched() loop
>
>  arch/csky/abiv1/alignment.c          | 62 +++++++++++++++++++++--------
>  arch/csky/abiv1/cacheflush.c         | 70 ++++++++++++++++++++++-----------
>  arch/csky/abiv1/inc/abi/cacheflush.h | 45 ++++++++++++++-------
>  arch/csky/abiv1/inc/abi/page.h       |  5 ++-
>  arch/csky/abiv1/mmap.c               | 75 ++++++++++++++++++-----------------
>  arch/csky/include/asm/barrier.h      | 15 ++++---
>  arch/csky/include/asm/cache.h        |  1 +
>  arch/csky/include/asm/io.h           | 23 +++++------
>  arch/csky/include/asm/pgtable.h      | 10 +++++
>  arch/csky/kernel/entry.S             | 54 +++++++++++++------------
>  arch/csky/kernel/perf_event.c        |  4 +-
>  arch/csky/kernel/process.c           |  2 +-
>  arch/csky/mm/cachev1.c               |  7 +++-
>  arch/csky/mm/cachev2.c               | 11 +++++-
>  arch/csky/mm/dma-mapping.c           | 76 +++++++++++++-----------------------
>  arch/csky/mm/init.c                  | 16 --------
>  arch/csky/mm/ioremap.c               | 27 ++++++++-----
>  17 files changed, 291 insertions(+), 212 deletions(-)



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
