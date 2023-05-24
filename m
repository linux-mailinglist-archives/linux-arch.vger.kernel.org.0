Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9C070F6F4
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 14:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjEXMx5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 08:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjEXMx4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 08:53:56 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA0C9E
        for <linux-arch@vger.kernel.org>; Wed, 24 May 2023 05:53:55 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-56204ac465fso12912717b3.2
        for <linux-arch@vger.kernel.org>; Wed, 24 May 2023 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684932834; x=1687524834;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6k7CwLpjQ+oPFx1tTum0+p01nKq3VVI7v5cgsSAfjNo=;
        b=uWMJa+LDM2gRpRToobsw29vCAykfT7ArF/5bmR543aY2MOzA64WG8PyYDRrSCbv5Ue
         Dfvzo5iY0u8OwJh/Usa6lm7EdLSChTnGrEz2jzp6BvPcJkPqFwsqs3Qsp6m8MaB7rsVe
         Q30nnGF4Q1X8bmtQY4DFlFDiPOWhATsr6lDlVzzEXe3o1eHyS2CHxzaE0yFSt2V70z+u
         WJ3FVPyWSm6TsN+Z2cxQZKVi782dXQHli55PJmrocqVNgIsBmSnATCMvQI5VdFkx01cp
         i42stvfX2iLo4xriYKEHP6QY07irj7VIOBgpyAqhKU4jfqvS3UKGZLvMfLg2TeD5ZZyf
         GMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684932834; x=1687524834;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6k7CwLpjQ+oPFx1tTum0+p01nKq3VVI7v5cgsSAfjNo=;
        b=UFp7RFVh6FscU/b+O83e69DOusRIZV13EavbCoWdgTszoLPO/8/g3DoffGjU8NFFpz
         ul84iDxGH6USlx5+LiVcLdpgiutSNCJeOU7gwoIYr1oCQZMU/CQdrP9t8xw+Q50066hw
         zAnwIK01Bgc3zxU9G3VKBHpHO2Fd3OSXzBC7oLEiSP1dGXx4m0xESzRKqL875OSPrBO0
         XfnT8QlVs2zsM9iteeOfR3qov4QziCgzis1mtXpjtxOOoatzBAXkeHeAIRkzp88LGkq9
         mbOF16odnhhwaHjoIb/pGzq+V4uTu9nd282DNAjzC5PMbWZC7IETCumcRRYMwVBLkLYG
         XlFw==
X-Gm-Message-State: AC+VfDwQpZyZM6yNWILZslNLewbqBsTRTaoE2ZlRTOM1VTjG+GE5QmlJ
        fBepkZgkj07ize0pXFojPQcB5UssRtShW3dUo+KZxg==
X-Google-Smtp-Source: ACHHUZ6z6oKt9Hy3F5Ix9UnojbF6veGj5yOEPPCsEXLq14Lr8kcj2dPHJnCRCMemy7klqa4CHkog7mF+U8MQxAM2Elw=
X-Received: by 2002:a0d:f6c3:0:b0:55a:18e2:cdf9 with SMTP id
 g186-20020a0df6c3000000b0055a18e2cdf9mr14705166ywf.49.1684932834217; Wed, 24
 May 2023 05:53:54 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 24 May 2023 14:53:43 +0200
Message-ID: <CACRpkdahOz++MD7f=Bmq2f_nT=TQkY5f5vT5PL=YEB4R2B7Vcw@mail.gmail.com>
Subject: [GIT PULL] Convert virt_to_phys() into static inlines
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>, linux-mm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

I am pretty confident of this branch now, so this needs some
rotation in linux-next for the v6.5 kernel. No errors from zeroday!
So please pull it into the arch tree for v6.5.

If it feels shaky anyway I can set up a separate branch to pull it
into linux-next. I heard you have a way to shake out unknown
issues with stuff like this using randconfigs...

Yours,
Linus Walleij

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/virt-to-pfn-for-arch-v6.5

for you to fetch changes up to 8968d8d2bb4f81035138966a18259859fb6bc1ee:

  m68k/mm: Make pfn accessors static inlines (2023-05-24 14:41:55 +0200)

----------------------------------------------------------------
This is an attempt to harden the typing on virt_to_pfn()
and pfn_to_virt().

Making virt_to_pfn() a static inline taking a strongly typed
(const void *) makes the contract of a passing a pointer of that
type to the function explicit and exposes any misuse of the
macro virt_to_pfn() acting polymorphic and accepting many types
such as (void *), (unitptr_t) or (unsigned long) as arguments
without warnings.

For symmetry, we do the same with pfn_to_virt().

The problem with this inconsistent typing was pointed out by
Russell King:
https://lore.kernel.org/linux-arm-kernel/YoJDKJXc0MJ2QZTb@shell.armlinux.org.uk/

And confirmed by Andrew Morton:
https://lore.kernel.org/linux-mm/20220701160004.2ffff4e5ab59a55499f4c736@linux-foundation.org/

So the recognition of the problem is widespread.

These platforms have been chosen as initial conversion targets:

- ARM
- ARM64/Aarch64
- asm-generic (including for example x86)
- m68k

The idea is that if this goes in, it will block further misuse
of the function signatures due to the large compile coverage,
and then I can go in and fix the remaining architectures on a
one-by-one basis.

Some of the patches have been circulated before but were not
picked up by subsystem maintainers, so now the arch tree is
target for this series.

It has passed zeroday builds after a lot of iterations in my
personal tree, but there could be some randconfig outliers.
New added or deeply hidden problems appear all the time so
some minor fallout can be expected.

----------------------------------------------------------------
Linus Walleij (13):
      fs/proc/kcore.c: Pass a pointer to virt_addr_valid()
      m68k: Pass a pointer to virt_to_pfn() virt_to_page()
      ARC: init: Pass a pointer to virt_to_pfn() in init
      riscv: mm: init: Pass a pointer to virt_to_page()
      cifs: Pass a pointer to virt_to_page()
      cifs: Pass a pointer to virt_to_page() in cifsglob
      netfs: Pass a pointer to virt_to_page()
      arm64: vdso: Pass (void *) to virt_to_page()
      xen/netback: Pass (void *) to virt_to_page()
      asm-generic/page.h: Make pfn accessors static inlines
      ARM: mm: Make virt_to_pfn() a static inline
      arm64: memory: Make virt_to_pfn() a static inline
      m68k/mm: Make pfn accessors static inlines

 arch/arc/mm/init.c                   |  2 +-
 arch/arm/common/sharpsl_param.c      |  2 +-
 arch/arm/include/asm/delay.h         |  2 +-
 arch/arm/include/asm/io.h            |  2 +-
 arch/arm/include/asm/memory.h        | 17 ++++++++++++-----
 arch/arm/include/asm/page.h          |  4 ++--
 arch/arm/include/asm/pgtable.h       |  2 +-
 arch/arm/include/asm/proc-fns.h      |  2 --
 arch/arm/include/asm/sparsemem.h     |  2 +-
 arch/arm/include/asm/uaccess-asm.h   |  2 +-
 arch/arm/include/asm/uaccess.h       |  2 +-
 arch/arm/kernel/asm-offsets.c        |  2 +-
 arch/arm/kernel/entry-armv.S         |  2 +-
 arch/arm/kernel/entry-common.S       |  2 +-
 arch/arm/kernel/entry-v7m.S          |  2 +-
 arch/arm/kernel/head-nommu.S         |  3 +--
 arch/arm/kernel/head.S               |  2 +-
 arch/arm/kernel/hibernate.c          |  2 +-
 arch/arm/kernel/suspend.c            |  2 +-
 arch/arm/kernel/tcm.c                |  2 +-
 arch/arm/kernel/vmlinux-xip.lds.S    |  3 +--
 arch/arm/kernel/vmlinux.lds.S        |  3 +--
 arch/arm/mach-berlin/platsmp.c       |  2 +-
 arch/arm/mach-keystone/keystone.c    |  2 +-
 arch/arm/mach-omap2/sleep33xx.S      |  2 +-
 arch/arm/mach-omap2/sleep43xx.S      |  2 +-
 arch/arm/mach-omap2/sleep44xx.S      |  2 +-
 arch/arm/mach-pxa/gumstix.c          |  2 +-
 arch/arm/mach-rockchip/sleep.S       |  2 +-
 arch/arm/mach-sa1100/pm.c            |  2 +-
 arch/arm/mach-shmobile/headsmp-scu.S |  2 +-
 arch/arm/mach-shmobile/headsmp.S     |  2 +-
 arch/arm/mach-socfpga/headsmp.S      |  2 +-
 arch/arm/mach-spear/spear.h          |  2 +-
 arch/arm/mm/cache-fa.S               |  1 -
 arch/arm/mm/cache-v4wb.S             |  1 -
 arch/arm/mm/dma-mapping.c            |  2 +-
 arch/arm/mm/dump.c                   |  2 +-
 arch/arm/mm/init.c                   |  2 +-
 arch/arm/mm/kasan_init.c             |  1 -
 arch/arm/mm/mmu.c                    |  2 +-
 arch/arm/mm/physaddr.c               |  2 +-
 arch/arm/mm/pmsa-v8.c                |  2 +-
 arch/arm/mm/proc-v7.S                |  2 +-
 arch/arm/mm/proc-v7m.S               |  2 +-
 arch/arm/mm/pv-fixup-asm.S           |  2 +-
 arch/arm64/include/asm/memory.h      |  9 ++++++++-
 arch/arm64/kernel/vdso.c             |  2 +-
 arch/m68k/include/asm/mcf_pgtable.h  |  3 +--
 arch/m68k/include/asm/page_mm.h      | 11 +++++++++--
 arch/m68k/include/asm/page_no.h      | 11 +++++++++--
 arch/m68k/include/asm/sun3_pgtable.h |  4 ++--
 arch/m68k/mm/mcfmmu.c                |  3 ++-
 arch/m68k/mm/motorola.c              |  4 ++--
 arch/m68k/mm/sun3mmu.c               |  2 +-
 arch/m68k/sun3/dvma.c                |  2 +-
 arch/m68k/sun3x/dvma.c               |  2 +-
 arch/riscv/mm/init.c                 |  4 ++--
 drivers/memory/ti-emif-sram-pm.S     |  2 +-
 drivers/net/xen-netback/netback.c    |  2 +-
 fs/cifs/cifsglob.h                   |  2 +-
 fs/cifs/smbdirect.c                  |  2 +-
 fs/netfs/iterator.c                  |  2 +-
 fs/proc/kcore.c                      |  2 +-
 include/asm-generic/page.h           | 12 ++++++++++--
 65 files changed, 109 insertions(+), 81 deletions(-)
