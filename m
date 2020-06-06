Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2489E1F07F5
	for <lists+linux-arch@lfdr.de>; Sat,  6 Jun 2020 18:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgFFQr7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 6 Jun 2020 12:47:59 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:41736 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgFFQrz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Jun 2020 12:47:55 -0400
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jun 2020 12:47:55 EDT
Date:   Sat, 6 Jun 2020 12:32:45 -0400
From:   Rich Felker <dalias@libc.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Rob Landley <rob@landley.net>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] sh: remove unneeded constructor.
Message-ID: <20200606163244.GZ1079@brightrain.aerifal.cx>
References: <20180731051519.101249-1-ysato@users.sourceforge.jp>
 <CAMuHMdUQReuzR=x54gnC1XdP77RrT1TaWoFFXUhUQ02A+giPqQ@mail.gmail.com>
 <87600us5k9.wl-ysato@users.sourceforge.jp>
 <20180804103550.GA3183@bombadil.infradead.org>
 <CAMuHMdXsz-+zsxouaLP5tTKA46G34iAACSce+RXrD8AiiQc2+A@mail.gmail.com>
 <20180804105149.GB3183@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804105149.GB3183@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 04, 2018 at 03:51:49AM -0700, Matthew Wilcox wrote:
> On Sat, Aug 04, 2018 at 12:47:08PM +0200, Geert Uytterhoeven wrote:
> > You do want to readd the __GFP_ZERO flag to the second user of PGALLOC_GFP,
> > don't you?
> 
> I missed that!  Probably only relevant for SH-64.  But yes ... probably better
> to make this explicit then:
> 
> +++ b/arch/sh/mm/pgtable.c
> @@ -2,8 +2,6 @@
>  #include <linux/mm.h>
>  #include <linux/slab.h>
>  
> -#define PGALLOC_GFP GFP_KERNEL | __GFP_ZERO
> -
>  static struct kmem_cache *pgd_cachep;
>  #if PAGETABLE_LEVELS > 2
>  static struct kmem_cache *pmd_cachep;
> @@ -13,6 +11,7 @@ void pgd_ctor(void *x)
>  {
>         pgd_t *pgd = x;
>  
> +       memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
>         memcpy(pgd + USER_PTRS_PER_PGD,
>                swapper_pg_dir + USER_PTRS_PER_PGD,
>                (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
> @@ -32,7 +31,7 @@ void pgtable_cache_init(void)
>  
>  pgd_t *pgd_alloc(struct mm_struct *mm)
>  {
> -       return kmem_cache_alloc(pgd_cachep, PGALLOC_GFP);
> +       return kmem_cache_alloc(pgd_cachep, GFP_KERNEL);
>  }
>  
>  void pgd_free(struct mm_struct *mm, pgd_t *pgd)
> @@ -48,7 +47,7 @@ void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
>  
>  pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>  {
> -       return kmem_cache_alloc(pmd_cachep, PGALLOC_GFP);
> +       return kmem_cache_alloc(pmd_cachep, GFP_KERNEL | __GFP_ZERO);
>  }
>  
>  void pmd_free(struct mm_struct *mm, pmd_t *pmd)
> 
> --

I've been asked to include this in this or next pull request, and I
think it's right to do so, but I don't have a complete patch from you.
Can you resubmit with a commit message and signed-off-by?

Rich
