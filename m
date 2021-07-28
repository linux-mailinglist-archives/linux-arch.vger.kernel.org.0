Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD93D9178
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 17:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbhG1PBN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 11:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236996AbhG1PBA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 11:01:00 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3EAC061757;
        Wed, 28 Jul 2021 08:00:57 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id k13so1524539qth.10;
        Wed, 28 Jul 2021 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AlpYFZELB3hxoanwcJLzp+k0B1S9bWh0moPS2Ma0y3s=;
        b=dhJfvCrdX6+JGPhGDJDiLBEG9UcTs16jDN30lex0VRBKF31MUZUDo/xkZR6v3BkQRH
         3ELG307oxRyzNYMvuDDBFRlHKIl6jcRvUzt4NR6of8GeDOA2OYcikQw0f5cG9mxfulnp
         VjmUF7popt16REpUDoOqa8pCQmkMhujTuv/vkJGqPnLP/tVc2lG4CBxgdvVl3t5eZyS2
         ykUPStBkvttyxhooJeX9AWL6ADzL08OgxAz5sNUmEZqZ00MWEuIuhB5M4D1PPphpvwxs
         bBGC/q3UYISy2ao1M1kL3QSAU433qE5dynEpQ8Rkr8PVmEVvsvHrKThnueDsgMDaTgDp
         AIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AlpYFZELB3hxoanwcJLzp+k0B1S9bWh0moPS2Ma0y3s=;
        b=DuOm9BWSercjUjIMO4aBCV2WJLGlLbd16RIl47FOvH4IgBKtDBoAQh8/72P6HPdxxz
         A32YXdUuLBOzIIDQ4Iu6DPgunJPAKLxLL372KA9YORmaep6jAI+IVpgGH3a1f6hUbQYB
         HBXvHtsbneStUxSt9cSODIlQLkI+ZZy/cpSnv8AH4kLV48gCHqWuHfwdRBorNy+G8UOC
         ++vTH7XbpDlfwUrebueOPy1CJGtg1xWEI4ioACeJvKsw4sa6fgpkfzfoqEajReU9aI6K
         /l9p6QguspYh/NtiYjVm9nmkTLvW5kyqzcEbbJzqXfjHYC3ej8Drd5tjCJ4/CX/+ZxPT
         rwqw==
X-Gm-Message-State: AOAM531IfDyiW/o0SkNf2UN6/LmVoCa65jBPNHZz99KUSYRf8Gfk6rLa
        tCHSjNpAIXH/vS31iU+1+jUDeLx+/Gf1hA==
X-Google-Smtp-Source: ABdhPJyWnjizrUNfAt5HnnUjZjxHyPZkzszUBil/ydfv7NEImOvXH+iaC3mYu7hipeoeIzFjvsaisg==
X-Received: by 2002:ac8:4794:: with SMTP id k20mr24810889qtq.371.1627484456421;
        Wed, 28 Jul 2021 08:00:56 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id c15sm45491qtc.37.2021.07.28.08.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 08:00:56 -0700 (PDT)
Date:   Wed, 28 Jul 2021 08:00:54 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Hildenbrand <david@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 0/8] all: use find_next_*_bit() instead of
 find_first_*_bit() where possible
Message-ID: <YQFxJnB+cH4SU9I3@yury-ThinkPad>
References: <20210612123639.329047-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612123639.329047-1-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Ping again.

The rebased series together with other bitmap patches can be found
here:

https://github.com/norov/linux/tree/bitmap-20210716

On Sat, Jun 12, 2021 at 05:36:31AM -0700, Yury Norov wrote:
> find_first_*_bit() is simpler and faster than 'next' version [1], and they
> work identically if start == 0. But in many cases kernel code uses the
> 'next' version where 'first' can be used. This series addresses this issue.
> 
> Patches 1-3 move find.h under include/linux as it simplifies development.
> Patches 4-8 switch the kernel and tools to find_first_*_bit() implementation
> where appropriate. 
> 
> Yury Norov (8):
>   bitops: protect find_first_{,zero}_bit properly
>   bitops: move find_bit_*_le functions from le.h to find.h
>   include: move find.h from asm_generic to linux
>   arch: remove GENERIC_FIND_FIRST_BIT entirely
>   lib: add find_first_and_bit()
>   cpumask: use find_first_and_bit()
>   all: replace find_next{,_zero}_bit with find_first{,_zero}_bit where
>     appropriate
>   tools: sync tools/bitmap with mother linux
> 
>  MAINTAINERS                                   |   4 +-
>  arch/alpha/include/asm/bitops.h               |   2 -
>  arch/arc/Kconfig                              |   1 -
>  arch/arc/include/asm/bitops.h                 |   1 -
>  arch/arm/include/asm/bitops.h                 |   1 -
>  arch/arm64/Kconfig                            |   1 -
>  arch/arm64/include/asm/bitops.h               |   1 -
>  arch/csky/include/asm/bitops.h                |   1 -
>  arch/h8300/include/asm/bitops.h               |   1 -
>  arch/hexagon/include/asm/bitops.h             |   1 -
>  arch/ia64/include/asm/bitops.h                |   2 -
>  arch/m68k/include/asm/bitops.h                |   2 -
>  arch/mips/Kconfig                             |   1 -
>  arch/mips/include/asm/bitops.h                |   1 -
>  arch/openrisc/include/asm/bitops.h            |   1 -
>  arch/parisc/include/asm/bitops.h              |   2 -
>  arch/powerpc/include/asm/bitops.h             |   2 -
>  arch/powerpc/platforms/pasemi/dma_lib.c       |   4 +-
>  arch/riscv/include/asm/bitops.h               |   1 -
>  arch/s390/Kconfig                             |   1 -
>  arch/s390/include/asm/bitops.h                |   1 -
>  arch/s390/kvm/kvm-s390.c                      |   2 +-
>  arch/sh/include/asm/bitops.h                  |   1 -
>  arch/sparc/include/asm/bitops_32.h            |   1 -
>  arch/sparc/include/asm/bitops_64.h            |   2 -
>  arch/x86/Kconfig                              |   1 -
>  arch/x86/include/asm/bitops.h                 |   2 -
>  arch/x86/um/Kconfig                           |   1 -
>  arch/xtensa/include/asm/bitops.h              |   1 -
>  drivers/block/rnbd/rnbd-clt.c                 |   2 +-
>  drivers/dma/ti/edma.c                         |   2 +-
>  drivers/iio/adc/ad7124.c                      |   2 +-
>  drivers/infiniband/hw/irdma/hw.c              |  16 +-
>  drivers/media/cec/core/cec-core.c             |   2 +-
>  drivers/media/mc/mc-devnode.c                 |   2 +-
>  drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
>  drivers/scsi/lpfc/lpfc_sli.c                  |  10 +-
>  drivers/soc/ti/k3-ringacc.c                   |   4 +-
>  drivers/tty/n_tty.c                           |   2 +-
>  drivers/virt/acrn/ioreq.c                     |   3 +-
>  fs/f2fs/segment.c                             |   8 +-
>  fs/ocfs2/cluster/heartbeat.c                  |   2 +-
>  fs/ocfs2/dlm/dlmdomain.c                      |   4 +-
>  fs/ocfs2/dlm/dlmmaster.c                      |  18 +--
>  fs/ocfs2/dlm/dlmrecovery.c                    |   2 +-
>  fs/ocfs2/dlm/dlmthread.c                      |   2 +-
>  include/asm-generic/bitops.h                  |   1 -
>  include/asm-generic/bitops/le.h               |  64 --------
>  include/linux/bitmap.h                        |   1 +
>  include/linux/cpumask.h                       |  30 ++--
>  .../bitops => include/linux}/find.h           | 149 +++++++++++++++++-
>  lib/Kconfig                                   |   3 -
>  lib/find_bit.c                                |  21 +++
>  lib/find_bit_benchmark.c                      |  21 +++
>  lib/genalloc.c                                |   2 +-
>  net/ncsi/ncsi-manage.c                        |   4 +-
>  tools/include/asm-generic/bitops.h            |   1 -
>  tools/include/linux/bitmap.h                  |   7 +-
>  .../bitops => tools/include/linux}/find.h     |  54 +++++--
>  tools/lib/find_bit.c                          |  20 +++
>  60 files changed, 319 insertions(+), 185 deletions(-)
>  rename {tools/include/asm-generic/bitops => include/linux}/find.h (50%)
>  rename {include/asm-generic/bitops => tools/include/linux}/find.h (83%)
> 
> -- 
> 2.30.2
