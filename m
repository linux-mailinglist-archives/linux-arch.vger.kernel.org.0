Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A932239EE4B
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 07:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhFHFrM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 01:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFHFrL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 01:47:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5D8361029;
        Tue,  8 Jun 2021 05:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623131119;
        bh=49fVzdt4MSY+UspP64EgJQ791zimRP1gxTciSlJZXt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0Rtshf8pvTrv3vEhpsoWQuj5JjeNYokUzfYJ5STkCXI/OnFwZ+jzE319giZq9upk
         Ip6wZYmg/mXX1RsKoBHJISuKRrHfu3i7LKK8o6lrdj3F/wsMYKU4KSiTq0yf0Te/9Y
         EXkEDnDuymhI/7Es9g0unojNazWzSj6FWZpsSVsuRv7SkD+TKqrUPOkH42sn/s2o3k
         YyeAtmie679nER7vSNNhYu+t0T8vpaLE8THVLmZUT2dI3k363OIVX5xgUfeXV7EiTs
         ihyAaoDmjCZhWOCiJEmXQBaJ0yMnS1SK6yRX7SpN+JL1ZvqVGV5DXW68K81QTP/SNc
         ubRqN6fNQU7pg==
Date:   Tue, 8 Jun 2021 08:45:07 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>, kexec@lists.infradead.org,
        alpha <linux-alpha@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v2 8/9] mm: replace CONFIG_NEED_MULTIPLE_NODES with
 CONFIG_NUMA
Message-ID: <YL8D47Ty8iXZJsK3@kernel.org>
References: <20210604064916.26580-1-rppt@kernel.org>
 <20210604064916.26580-9-rppt@kernel.org>
 <CAMuHMdVa29gUQAdHjKh-qDNpOJaoGwXtUkBM2qnOTi1DWV70xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVa29gUQAdHjKh-qDNpOJaoGwXtUkBM2qnOTi1DWV70xA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Mon, Jun 07, 2021 at 10:53:08AM +0200, Geert Uytterhoeven wrote:
> Hi Mike,
> 
> On Fri, Jun 4, 2021 at 8:50 AM Mike Rapoport <rppt@kernel.org> wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > After removal of DISCINTIGMEM the NEED_MULTIPLE_NODES and NUMA
> > configuration options are equivalent.
> >
> > Drop CONFIG_NEED_MULTIPLE_NODES and use CONFIG_NUMA instead.
> >
> > Done with
> >
> >         $ sed -i 's/CONFIG_NEED_MULTIPLE_NODES/CONFIG_NUMA/' \
> >                 $(git grep -wl CONFIG_NEED_MULTIPLE_NODES)
> >         $ sed -i 's/NEED_MULTIPLE_NODES/NUMA/' \
> >                 $(git grep -wl NEED_MULTIPLE_NODES)
> >
> > with manual tweaks afterwards.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> Thanks for your patch!
> 
> As you dropped the following hunk from v2 of PATCH 5/9, there's now
> one reference left of CONFIG_NEED_MULTIPLE_NODES
> (plus the discontigmem comment):

Aargh, indeed. Thanks for catching this.

And I wondered why you suggested to fix spelling in cover letter for v3 :)
 
> -diff --git a/mm/memory.c b/mm/memory.c
> -index f3ffab9b9e39157b..fd0ebb63be3304f5 100644
> ---- a/mm/memory.c
> -+++ b/mm/memory.c
> -@@ -90,8 +90,7 @@
> - #warning Unfortunate NUMA and NUMA Balancing config, growing
> page-frame for last_cpupid.
> - #endif
> -
> --#ifndef CONFIG_NEED_MULTIPLE_NODES
> --/* use the per-pgdat data instead for discontigmem - mbligh */
> -+#ifdef CONFIG_FLATMEM
> - unsigned long max_mapnr;
> - EXPORT_SYMBOL(max_mapnr);
> -
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Sincerely yours,
Mike.
