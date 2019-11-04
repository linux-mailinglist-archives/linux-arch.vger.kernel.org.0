Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 031F4EDBF1
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2019 10:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfKDJxu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 4 Nov 2019 04:53:50 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37603 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKDJxt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Nov 2019 04:53:49 -0500
Received: by mail-ot1-f66.google.com with SMTP id d5so1808003otp.4;
        Mon, 04 Nov 2019 01:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KliwOsaW5hNOlzjps3zd+1fC4WckuXEun2JezrBsl8M=;
        b=VT4iPDigdyJQyY+eGSEBG2z95byYx+O72g1TWexezzCHEDkvUNFlkg4blTiZW7RrVw
         hFTvX8Fh3YS3PgeysvD64rpU66LFNe0ESLuQthk4M/gtbvNeqY14v1aJQKDJS5FmAU0t
         co6HVuJPCQb6GZ9i7gFZbNRe6B0WmPQ40s9MEWuLf5yDTTVm7PGyJ+69vtGLxSe/DZ1D
         jiW03HC6MneDPJAJ/Wf7qc5+IUGuYlFIuPisg27PfM/D3TIybtr7+aB2qL5tPR82Um70
         MwhtSmE/KagZYuxbQNq/dl8taRjDaG+rsd/WxKjbMO30Vjx5nz3QAInVjLhWJD4H55C/
         US9A==
X-Gm-Message-State: APjAAAWojAaNQobj/aNkU0uZZUivF4zLZ/J3/IvYrc9M8jYO1vu9ey/6
        zUq5upExNYr84e2+Rq2sL70a3GaAcLziZhzF9rUJUQ==
X-Google-Smtp-Source: APXvYqx7SaMbfn6eTvQqNR3qc8KtXh3qCjyaO/t3VTJ32GC2iIHqF0HiXvHrmlIBpl/gTi7AjGyf/NSZNGOTan5JhFg=
X-Received: by 2002:a9d:73cd:: with SMTP id m13mr18480198otk.145.1572861228733;
 Mon, 04 Nov 2019 01:53:48 -0800 (PST)
MIME-Version: 1.0
References: <1572850587-20314-1-git-send-email-rppt@kernel.org>
 <1572850587-20314-6-git-send-email-rppt@kernel.org> <CAMuHMdUG3V7uxzhbetw75vVeobeP0-bQySb3r=0V5XujUF123g@mail.gmail.com>
 <20191104094748.GB23288@rapoport-lnx>
In-Reply-To: <20191104094748.GB23288@rapoport-lnx>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Nov 2019 10:53:37 +0100
Message-ID: <CAMuHMdVHsNyLxhaxZcVdLvQ1PUnb=2_+ECPWVD0234V+qu+kOw@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] m68k: mm: use pgtable-nopXd instead of 4level-fixup
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-um@lists.infradead.org,
        sparclinux <sparclinux@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mike,

On Mon, Nov 4, 2019 at 10:48 AM Mike Rapoport <rppt@kernel.org> wrote:
> On Mon, Nov 04, 2019 at 09:53:34AM +0100, Geert Uytterhoeven wrote:
> > On Mon, Nov 4, 2019 at 7:57 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > m68k has two or three levels of page tables and can use appropriate
> > > pgtable-nopXd and folding of the upper layers.
> > >
> > > Replace usage of include/asm-generic/4level-fixup.h and explicit
> > > definitions of __PAGETABLE_PxD_FOLDED in m68k with
> > > include/asm-generic/pgtable-nopmd.h for two-level configurations and with
> > > include/asm-generic/pgtable-nopud.h for three-lelve configurations and
> > > adjust page table manipulation macros and functions accordingly.
> > >
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > Acked-by: Greg Ungerer <gerg@linux-m68k.org>
> >
> > Thanks for your patch!
> >
> > The build error reported for v1 by kbuild test robot when building for
> > sun3x is still there (m68k defconfig or sun3x_defconfig):
> >
> >     arch/m68k/sun3x/dvma.c: In function ‘dvma_map_cpu’:
> >     arch/m68k/sun3x/dvma.c:98:33: error: passing argument 2 of
> > ‘pmd_alloc’ from incompatible pointer type
> > [-Werror=incompatible-pointer-types]
> >        if((pmd = pmd_alloc(&init_mm, pgd, vaddr)) == NULL) {
> >                                      ^~~
> >     In file included from arch/m68k/sun3x/dvma.c:17:
> >     include/linux/mm.h:1875:61: note: expected ‘pud_t *’ {aka ‘struct
> > <anonymous> *’} but argument is of type ‘pgd_t *’ {aka ‘struct
> > <anonymous> *’}
> >      static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud,
> > unsigned long address)
> >                                                           ~~~~~~~^~~
>
> The initial report was against older mmotm (base:
> git://git.cmpxchg.org/linux-mmotm.git master) and I presumed this was the
> cause of the error. Will fix in v4.

OK, thanks!

My tree is based on m68k/master, which does not include the mmotm tree,
and should be fairly similar to plain v5.4-rc6.

> > This indeed boots fine on ARAnyM, which emulates on 68040.
> > It would be good to have some boot testing on '020/030, too.
>
> To be honest, I have no idea how to to that :)

Sure. This was more a request for the fellow m68k users.
But don't worry too much about it.  If it breaks '020/'030, we can fix
that later.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
