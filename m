Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71DA8F4238
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 09:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbfKHIfo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 03:35:44 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42177 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfKHIfo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 03:35:44 -0500
Received: by mail-oi1-f196.google.com with SMTP id i185so4547724oif.9;
        Fri, 08 Nov 2019 00:35:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1uMs1sJfEiNP+XnwLWOA56bVLhvU2oQuJJbSb2fF04=;
        b=nBhN2te7LQ1CRA2mpkLtrzNCCqbZbiCnSqlQIGMcJ1WVsvYH8Y+awsROOtshd7+qP9
         wQsrFpVQTLQyvD4QtMuLII59EU5dYLXp9J+Y8dKdVocmENFmqw5qBHVqwfCeWQPQs1ly
         ow3mvH5fOyhLGRBgvkQtIQbowfFfuioAhKB+vVjweuyltUtznKE7YIUS1lnCmsfVZr5O
         yJOslCSjakSXvEP1UEv8busj/guBmcYflbuGQgAKfTiyPp9CCRPU0zMyTs30uhQ5kCVA
         C5S+CifoVaOznWY+iFMMrTTnpkdk3omrQh24B2ouwYbWsfue3EttbAc+asoSr/qy8O2g
         tB5w==
X-Gm-Message-State: APjAAAV6Lo6KFeicuIdIdrDN86NewmNW3VzfGhQ9wGHjy+jj80BcKQ0E
        vD4VZqjQu2sJh9DYZHWUCdz3pD2sSu7+Q9ZWvPg=
X-Google-Smtp-Source: APXvYqxOUOr/TBH5H/Et++6eJWrvXzscFQJINZxRtWaYCdbXL4E/D5dDGUqtPMP+MwKaU6AtU89yWbI44eh67jVJ2zk=
X-Received: by 2002:aca:3a86:: with SMTP id h128mr8105952oia.131.1573202142533;
 Fri, 08 Nov 2019 00:35:42 -0800 (PST)
MIME-Version: 1.0
References: <1572938135-31886-1-git-send-email-rppt@kernel.org> <1572938135-31886-6-git-send-email-rppt@kernel.org>
In-Reply-To: <1572938135-31886-6-git-send-email-rppt@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Nov 2019 09:35:31 +0100
Message-ID: <CAMuHMdXqaw_k=XiY0RYvvR+smE-5tbTBzWiAZOFev731vR3q3A@mail.gmail.com>
Subject: Re: [PATCH v4 05/13] m68k: mm: use pgtable-nopXd instead of 4level-fixup
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
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mike,

On Tue, Nov 5, 2019 at 8:16 AM Mike Rapoport <rppt@kernel.org> wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> m68k has two or three levels of page tables and can use appropriate
> pgtable-nopXd and folding of the upper layers.
>
> Replace usage of include/asm-generic/4level-fixup.h and explicit
> definitions of __PAGETABLE_PxD_FOLDED in m68k with
> include/asm-generic/pgtable-nopmd.h for two-level configurations and with
> include/asm-generic/pgtable-nopud.h for three-lelve configurations and
> adjust page table manipulation macros and functions accordingly.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

One forgotten error message update below.

> --- a/arch/m68k/mm/kmap.c
> +++ b/arch/m68k/mm/kmap.c
> @@ -258,18 +265,23 @@ void __iounmap(void *addr, unsigned long size)
>  {
>         unsigned long virtaddr = (unsigned long)addr;
>         pgd_t *pgd_dir;
> +       p4d_t *p4d_dir;
> +       pud_t *pud_dir;
>         pmd_t *pmd_dir;
>         pte_t *pte_dir;
>
>         while ((long)size > 0) {
>                 pgd_dir = pgd_offset_k(virtaddr);
> -               if (pgd_bad(*pgd_dir)) {
> -                       printk("iounmap: bad pgd(%08lx)\n", pgd_val(*pgd_dir));
> -                       pgd_clear(pgd_dir);
> +               p4d_dir = p4d_offset(pgd_dir, virtaddr);
> +               pud_dir = pud_offset(p4d_dir, virtaddr);
> +               if (pud_bad(*pud_dir)) {
> +                       printk("iounmap: bad pgd(%08lx)\n", pud_val(*pud_dir));

bad pud

> +                       pud_clear(pud_dir);
>                         return;
>                 }
> -               pmd_dir = pmd_offset(pgd_dir, virtaddr);
> +               pmd_dir = pmd_offset(pud_dir, virtaddr);
>
> +#if CONFIG_PGTABLE_LEVELS == 3
>                 if (CPU_IS_020_OR_030) {
>                         int pmd_off = (virtaddr/PTRTREESIZE) & 15;
>                         int pmd_type = pmd_dir->pmd[pmd_off] & _DESCTYPE_MASK;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
