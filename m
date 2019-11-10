Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB968F6804
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2019 09:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfKJIlk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Nov 2019 03:41:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:39564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfKJIlk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 10 Nov 2019 03:41:40 -0500
Received: from rapoport-lnx (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2045B2077C;
        Sun, 10 Nov 2019 08:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573375299;
        bh=VivvRZF7S/gADzD3po2D0GMBa+a0TZ5FLEfZj0Cja2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MhQPa5FrV+cprfH5LgO2ngz5WqWHYxNnhtlF8+EWWiR3YG5Vr0xkKzXyZ33AQdepy
         Y53SeeHSS15YwGONO0eTs1D0QPsAGRYcPqxFn365q39QPKS3BXz4WP3RSRENNf6l8i
         sUwJM9yFWuX0jXXhjx2/CnlEYW9BRJ1kjfyDrNEs=
Date:   Sun, 10 Nov 2019 10:41:26 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>,
        Richard Weinberger <richard@nod.at>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-um@lists.infradead.org,
        sparclinux <sparclinux@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v4 05/13] m68k: mm: use pgtable-nopXd instead of
 4level-fixup
Message-ID: <20191110084125.GA9494@rapoport-lnx>
References: <1572938135-31886-1-git-send-email-rppt@kernel.org>
 <1572938135-31886-6-git-send-email-rppt@kernel.org>
 <20191108113917.a9c6ebb8373cc95fd684b734@linux-foundation.org>
 <CAMuHMdXdoFSVno4WT=F6Q1UwEaZ6AQJmhNUqPpYHJm6uh165iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXdoFSVno4WT=F6Q1UwEaZ6AQJmhNUqPpYHJm6uh165iw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andrew,

On Sat, Nov 09, 2019 at 03:26:29PM +0100, Geert Uytterhoeven wrote:
> Hi Andrew,
> 
> On Fri, Nov 8, 2019 at 8:39 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Tue,  5 Nov 2019 09:15:27 +0200 Mike Rapoport <rppt@kernel.org> wrote:
> > > m68k has two or three levels of page tables and can use appropriate
> > > pgtable-nopXd and folding of the upper layers.
> > >
> > > Replace usage of include/asm-generic/4level-fixup.h and explicit
> > > definitions of __PAGETABLE_PxD_FOLDED in m68k with
> > > include/asm-generic/pgtable-nopmd.h for two-level configurations and with
> > > include/asm-generic/pgtable-nopud.h for three-lelve configurations and
> > > adjust page table manipulation macros and functions accordingly.
> >
> > This one was messed up by linux-next changes in arch/m68k/mm/kmap.c.
> > Can you please take a look?

Can you please elaborate what was the problem?

The patch applies cleanly to v5.4-rc6-mmots-2019-11-08-16-23 (from
github.com/hnaz/linux-mm) and all the page table traversals in
arch/m68k/mm/kmap.c look Ok.

I've build atari_defconfig and it boots fine on aranym.
 
> You mean due to the rename and move of __iounmap() to __free_io_area()
> in commit aa3a1664285d0bec ("m68k: rename __iounmap and mark it static")?
> 
> Commit 42d6c83d6180f800 ("m68k: mm: use pgtable-nopXd instead of
> 4level-fixup") in next-20191108 looks good to me.
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
