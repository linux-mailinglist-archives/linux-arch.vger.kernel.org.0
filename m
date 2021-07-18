Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265873CC949
	for <lists+linux-arch@lfdr.de>; Sun, 18 Jul 2021 15:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhGRNPd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Jul 2021 09:15:33 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:56336 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhGRNPd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Jul 2021 09:15:33 -0400
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 16IDCIw1031967;
        Sun, 18 Jul 2021 22:12:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 16IDCIw1031967
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1626613939;
        bh=kc1rcQBGfa+6hfoq/T5JXuXb+iXKX94PdSMwOW/jXE0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X+Ay0LyD9j4uNFmXNKicUmgwMbvfukDHETwWPx+Qe6O8JvbODLxi3mCrO64aXAPz5
         ktQhyNPPviBzXCCp3TiD+22ohEpy7nO4SsTbdgjOGGtmqWVMM1BBhEs9Q3WRxuf36x
         r9ED0l/iAai1s0CLwP0SjpW9QvvVpO0PBmNXwgLcfYs8friRhxhwHwq5zb8uJIzrj7
         Vh6cE3H7Gjb9YhskQK1tySUJ/Q8ePib5VNqte3aFu6IhByKQHbLj+eTiU0SQ1cFhV6
         l8u2wcbHlwLyvUsgarlOgh1JdKlPKNceBLOx7lXq+ZaTMXxC1uzE6zbF+YwdBicVeg
         +sAc84R2E0mmA==
X-Nifty-SrcIP: [209.85.215.176]
Received: by mail-pg1-f176.google.com with SMTP id u14so15853256pga.11;
        Sun, 18 Jul 2021 06:12:19 -0700 (PDT)
X-Gm-Message-State: AOAM530rr42s2gGS7R8paYUAUplgf5c3mg+rAiBP4K4w5af7eVVx5czV
        rd7JXg1H1W9g5Dk4tdeyhmavGzckzAWXdhoeG60=
X-Google-Smtp-Source: ABdhPJzSkHgcEbqBBBiyEW9ocGzd5CZyaxrABLAJkaJthoa3FG9uRh1Uwgr3YHSbvJ9PqJdN2CPNI0/rNElzl2m+Wl0=
X-Received: by 2002:a63:d80a:: with SMTP id b10mr20458153pgh.47.1626613938476;
 Sun, 18 Jul 2021 06:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <YO3txvw87MjKfdpq@localhost.localdomain> <YO8ioz4sHwcUAkdt@localhost.localdomain>
 <CADYN=9+ZO1XHu2YZYy7s+6_qAh1obi2wk+d4A3vKmxtkoNvQLg@mail.gmail.com> <YPFa/tIF38eTJt1B@localhost.localdomain>
In-Reply-To: <YPFa/tIF38eTJt1B@localhost.localdomain>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 18 Jul 2021 22:11:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNATt3tvF9n5LMosirxs50PMQ1RKPp1j1FVAx3yz+uXmvVw@mail.gmail.com>
Message-ID: <CAK7LNATt3tvF9n5LMosirxs50PMQ1RKPp1j1FVAx3yz+uXmvVw@mail.gmail.com>
Subject: Re: [PATCH v2] Decouple build from userspace headers
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 16, 2021 at 7:10 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Fri, Jul 16, 2021 at 11:03:41AM +0200, Anders Roxell wrote:
> > On Wed, 14 Jul 2021 at 19:45, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > >
>
> > In file included from
> > /home/anders/src/kernel/testing/crypto/aegis128-neon-inner.c:7:
> > /home/anders/src/kernel/testing/arch/arm64/include/asm/neon-intrinsics.h:33:10:
> > fatal error: arm_neon.h: No such file or directory
> >    33 | #include <arm_neon.h>
> >       |          ^~~~~~~~~~~~
>
> > If I revert this patch I can build it.
>
> Please, see followup fixes or grab new -mm.
> https://lore.kernel.org/lkml/YO8ioz4sHwcUAkdt@localhost.localdomain/


With the follow-up fix,
this patch is doing many things in a single patch.

Can you split it into a series of smaller patches?


1/4: changes for arch/um/include/shared/irq_user.h
     and arch/um/os-Linux/signal.c


2/4:  remove wrong <stdbool.h> or <stddef.h> inclusions
      (or maybe you need to replace them with <linux/types.h>
      to keep the affected headers self-contained)


3/4: add include/linux/stdarg.h,
     then <stdarg.h> with <linux/stdarg.h>


4/4: move -isystem $(shell $(CC) -print-file-name=include)
     to some sub-Makefiles from the top Makefile.





(please note 4/4 will introduce a breakage in linux-next
if somebody adds a new <stdarg.h> inclusion in this
development cycle.
I hope that will not happen, though)




--
Best Regards
Masahiro Yamada
