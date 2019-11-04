Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41CB9EDBDF
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2019 10:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfKDJsD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Nov 2019 04:48:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfKDJsD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Nov 2019 04:48:03 -0500
Received: from rapoport-lnx (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 703FA222D2;
        Mon,  4 Nov 2019 09:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572860881;
        bh=jF2dTw4x+geuuqWT+rNLEAExdkU6oqK6ll5Aip/G7wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yIO+RdRi15/vhMR8gf577AKF/lpxu4XVhUJZy1DLQjBpIac45yVLkW8bxFv1JrMxI
         yZ1wC+sVzO1/hBGimU5x16z9OqkqLi949PDdXnnhKpHXL9oAbagRWpOMkzhiQoM5bs
         EavnCVX+JUJOuq3PVNevDE54nL9/PZK4/k8P5qpU=
Date:   Mon, 4 Nov 2019 11:47:49 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: Re: [PATCH v3 05/13] m68k: mm: use pgtable-nopXd instead of
 4level-fixup
Message-ID: <20191104094748.GB23288@rapoport-lnx>
References: <1572850587-20314-1-git-send-email-rppt@kernel.org>
 <1572850587-20314-6-git-send-email-rppt@kernel.org>
 <CAMuHMdUG3V7uxzhbetw75vVeobeP0-bQySb3r=0V5XujUF123g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUG3V7uxzhbetw75vVeobeP0-bQySb3r=0V5XujUF123g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 04, 2019 at 09:53:34AM +0100, Geert Uytterhoeven wrote:
> Hi Mike,
> 
> On Mon, Nov 4, 2019 at 7:57 AM Mike Rapoport <rppt@kernel.org> wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > m68k has two or three levels of page tables and can use appropriate
> > pgtable-nopXd and folding of the upper layers.
> >
> > Replace usage of include/asm-generic/4level-fixup.h and explicit
> > definitions of __PAGETABLE_PxD_FOLDED in m68k with
> > include/asm-generic/pgtable-nopmd.h for two-level configurations and with
> > include/asm-generic/pgtable-nopud.h for three-lelve configurations and
> > adjust page table manipulation macros and functions accordingly.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > Acked-by: Greg Ungerer <gerg@linux-m68k.org>
> 
> Thanks for your patch!
> 
> The build error reported for v1 by kbuild test robot when building for
> sun3x is still there (m68k defconfig or sun3x_defconfig):
> 
>     arch/m68k/sun3x/dvma.c: In function ‘dvma_map_cpu’:
>     arch/m68k/sun3x/dvma.c:98:33: error: passing argument 2 of
> ‘pmd_alloc’ from incompatible pointer type
> [-Werror=incompatible-pointer-types]
>        if((pmd = pmd_alloc(&init_mm, pgd, vaddr)) == NULL) {
>                                      ^~~
>     In file included from arch/m68k/sun3x/dvma.c:17:
>     include/linux/mm.h:1875:61: note: expected ‘pud_t *’ {aka ‘struct
> <anonymous> *’} but argument is of type ‘pgd_t *’ {aka ‘struct
> <anonymous> *’}
>      static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud,
> unsigned long address)
>                                                           ~~~~~~~^~~

The initial report was against older mmotm (base:
git://git.cmpxchg.org/linux-mmotm.git master) and I presumed this was the
cause of the error. Will fix in v4.
 
> This indeed boots fine on ARAnyM, which emulates on 68040.
> It would be good to have some boot testing on '020/030, too.
 
To be honest, I have no idea how to to that :)

> > --- a/arch/m68k/mm/kmap.c
> > +++ b/arch/m68k/mm/kmap.c
> 
> > @@ -196,17 +198,21 @@ void __iomem *__ioremap(unsigned long physaddr, unsigned long size, int cachefla
> >                         printk ("\npa=%#lx va=%#lx ", physaddr, virtaddr);
> >  #endif
> >                 pgd_dir = pgd_offset_k(virtaddr);
> > -               pmd_dir = pmd_alloc(&init_mm, pgd_dir, virtaddr);
> > +               p4d_dir = p4d_offset(pgd_dir, virtaddr);
> > +               pud_dir = pud_offset(p4d_dir, virtaddr);
> > +               pmd_dir = pmd_alloc(&init_mm, pud_dir, virtaddr);
> >                 if (!pmd_dir) {
> >                         printk("ioremap: no mem for pmd_dir\n");
> >                         return NULL;
> >                 }
> >
> >                 if (CPU_IS_020_OR_030) {
> > +#if CONFIG_PGTABLE_LEVELS == 3
> 
> This check puzzled me a bit: when we get here, CONFIG_PGTABLE_LEVELS is
> always true.
> However, the check cannot be removed, as the code it protects fails to compile
> when building for Coldfire.
> 
> Perhaps this can be made more clear by reverting the order?
> I.e.
> 
>     #if CONFIG_PGTABLE_LEVELS == 3
>             if (CPU_IS_020_OR_030) {
>                     ...
>             } else
>     #endif
>             {
> 
> Or is there some better way?

I think reverting the order is fine. Here it's a bit ugly because of
'} else {', but for the other cases below it will fine.
 
> >                         pmd_dir->pmd[(virtaddr/PTRTREESIZE) & 15] = physaddr;
> >                         physaddr += PTRTREESIZE;
> >                         virtaddr += PTRTREESIZE;
> >                         size -= PTRTREESIZE;
> > +#endif
> >                 } else {
> >                         pte_dir = pte_alloc_kernel(pmd_dir, virtaddr);
> >                         if (!pte_dir) {
> > @@ -258,19 +264,24 @@ void __iounmap(void *addr, unsigned long size)
> >  {
> >         unsigned long virtaddr = (unsigned long)addr;
> >         pgd_t *pgd_dir;
> > +       p4d_t *p4d_dir;
> > +       pud_t *pud_dir;
> >         pmd_t *pmd_dir;
> >         pte_t *pte_dir;
> >
> >         while ((long)size > 0) {
> >                 pgd_dir = pgd_offset_k(virtaddr);
> > -               if (pgd_bad(*pgd_dir)) {
> > -                       printk("iounmap: bad pgd(%08lx)\n", pgd_val(*pgd_dir));
> > -                       pgd_clear(pgd_dir);
> > +               p4d_dir = p4d_offset(pgd_dir, virtaddr);
> > +               pud_dir = pud_offset(p4d_dir, virtaddr);
> > +               if (pud_bad(*pud_dir)) {
> > +                       printk("iounmap: bad pgd(%08lx)\n", pud_val(*pud_dir));
> > +                       pud_clear(pud_dir);
> >                         return;
> >                 }
> > -               pmd_dir = pmd_offset(pgd_dir, virtaddr);
> > +               pmd_dir = pmd_offset(pud_dir, virtaddr);
> >
> >                 if (CPU_IS_020_OR_030) {
> > +#if CONFIG_PGTABLE_LEVELS == 3
> 
> Likewise.
> 
> >                         int pmd_off = (virtaddr/PTRTREESIZE) & 15;
> >                         int pmd_type = pmd_dir->pmd[pmd_off] & _DESCTYPE_MASK;
> >
> 
> > @@ -341,14 +355,17 @@ void kernel_set_cachemode(void *addr, unsigned long size, int cmode)
> >
> >         while ((long)size > 0) {
> >                 pgd_dir = pgd_offset_k(virtaddr);
> > -               if (pgd_bad(*pgd_dir)) {
> > -                       printk("iocachemode: bad pgd(%08lx)\n", pgd_val(*pgd_dir));
> > -                       pgd_clear(pgd_dir);
> > +               p4d_dir = p4d_offset(pgd_dir, virtaddr);
> > +               pud_dir = pud_offset(p4d_dir, virtaddr);
> > +               if (pud_bad(*pud_dir)) {
> > +                       printk("iocachemode: bad pud(%08lx)\n", pud_val(*pud_dir));
> > +                       pud_clear(pud_dir);
> >                         return;
> >                 }
> > -               pmd_dir = pmd_offset(pgd_dir, virtaddr);
> > +               pmd_dir = pmd_offset(pud_dir, virtaddr);
> >
> >                 if (CPU_IS_020_OR_030) {
> > +#if CONFIG_PGTABLE_LEVELS == 3
> 
> Likewise
> 
> >                         int pmd_off = (virtaddr/PTRTREESIZE) & 15;
> >
> >                         if ((pmd_dir->pmd[pmd_off] & _DESCTYPE_MASK) == _PAGE_PRESENT) {
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
