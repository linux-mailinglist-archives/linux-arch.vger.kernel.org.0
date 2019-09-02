Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D4EA505D
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2019 09:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfIBHxO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Sep 2019 03:53:14 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33555 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbfIBHxO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Sep 2019 03:53:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id p23so12811311oto.0;
        Mon, 02 Sep 2019 00:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXerReUtklcQDMDiAd2B7yy5/iYyeA9QfRGIULHn46Y=;
        b=TimCe+rboTXhKNRwod9wY0LQixXq7N4d44ur73fTW2/Sl9IlzP0TM034In+nMphow6
         xiWiEDZqeMr0hSqMmT3xGkOz7OVg3dbGFxB6DnaI7/rbUfGLp5wGTB8UdW1WjXG8zXJq
         GC35+s1KZNEV6mpr4HpVQXkHzZooeXqyeTqNvhLbts5fV4wZDQecIXdsonD0+BAab9PD
         ij7RgMJOuMnsdBRGk7Iikhn+E+SpUcF8PhWa1X7S/JkgFIr4SpDy+OGKLjntqmbZyPL8
         YXo/hLdpnibizxv/zjuyNQYT5x6g91TVLGViL8KITcv+fUoz2h9zZaMW/KkBcnt6S4gT
         8YrQ==
X-Gm-Message-State: APjAAAX7DS5L5+NH75wZDOV+fHjVTm+zfjVhMTvhhFYG555Vtd1bttjE
        mQDQeXujl1PugjbVRt4e0bk7o6oxmGdZkjYu+9w=
X-Google-Smtp-Source: APXvYqwnZmuBQPAycR4wh+MzLxpLnaIqn9yYtJhnEginGgy5iGXJS00OPV33e9x6cT87GYQg3tA+HlJbqb3xbqDiJRA=
X-Received: by 2002:a9d:61c3:: with SMTP id h3mr14729198otk.39.1567410792636;
 Mon, 02 Sep 2019 00:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190817073253.27819-1-hch@lst.de> <20190817073253.27819-9-hch@lst.de>
 <CAMuHMdWyXGjokWi7tn9JHCTz9YMb_vHn6XKeE7KzH5n-54Sy0A@mail.gmail.com> <20190830160620.GD26887@lst.de>
In-Reply-To: <20190830160620.GD26887@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Sep 2019 09:53:01 +0200
Message-ID: <CAMuHMdXB=DWyu=Y25gih5poeanVnhLEP2MXoozvxdEY6op32FA@mail.gmail.com>
Subject: Re: [PATCH 08/26] m68k: simplify ioremap_nocache
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christoph,

On Fri, Aug 30, 2019 at 6:06 PM Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Aug 19, 2019 at 10:56:02AM +0200, Geert Uytterhoeven wrote:
> > On Sat, Aug 17, 2019 at 9:48 AM Christoph Hellwig <hch@lst.de> wrote:
> > > Just define ioremap_nocache to ioremap instead of duplicating the
> > > inline.  Also defined ioremap_uc in terms of ioremap instead of
> > > the using a double indirection.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Do you mind picking this up through the m68k tree?

Sure. Applied and queued for v5.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
