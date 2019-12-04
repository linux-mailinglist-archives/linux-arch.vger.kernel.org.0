Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34521112B88
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2019 13:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfLDMdV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 4 Dec 2019 07:33:21 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45354 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfLDMdV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Dec 2019 07:33:21 -0500
Received: by mail-oi1-f195.google.com with SMTP id v10so4597557oiv.12;
        Wed, 04 Dec 2019 04:33:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S0UWQ5eiPole4dtyMpW+QWxdEfHVw9PtKgJf/N5G9BE=;
        b=SonrTHC0vp7Sgvtcx4CF3OKoS2va/b1Qcq7FYck7P2eQIFF19+VITPX511q2sKk26I
         qTzToMfleDujWMCFeSusEjeGAUpQ/9eMGYmiNr++UhC3swkJ6OUXIRXakQOajp7+Xcz4
         kP1h4HI9rT0cBTu/Yj38v2hUP3bxNQwiKeGZ6QWordh9i4IX6iTWTPcIeITnrWjomlyQ
         KYzOmsU6ut7sOVkStBDoDTmHCZQnHBV892u4jUZmvuoMJqPHWNzBeJHswsyoSltLIhEO
         XRohnK4aFMZX+rSIL0ODpM6kCii7cwzxSxDi1yunwX+ZxZ/SX4aXth6CA5ss299eLStp
         Kgig==
X-Gm-Message-State: APjAAAXeoMexw2L4p4g1Q4VZwcjCQinlLQSsBxo0xonglcqpoESDIjMc
        PIfyArQRPa4BbfC3L+X86nPao5r++wC3vXm6pVM=
X-Google-Smtp-Source: APXvYqzb0EPNSu3UgjjKauWV01/SR7f84yg5f0P7XG0wUME17ghX3UNDGcccyOdk37JFXAIVeBt6IZuJXPTA7xlaSIc=
X-Received: by 2002:aca:36c5:: with SMTP id d188mr2423967oia.54.1575462799999;
 Wed, 04 Dec 2019 04:33:19 -0800 (PST)
MIME-Version: 1.0
References: <20190219103148.192029670@infradead.org> <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com> <20191204104733.GR2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20191204104733.GR2844@hirez.programming.kicks-ass.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Dec 2019 13:32:58 +0100
Message-ID: <CAMuHMdXs_Fm93t=O9jJPLxcREZy-T53Z_U_RtHcvaWyV+ESdjg@mail.gmail.com>
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hoi Peter,

On Wed, Dec 4, 2019 at 11:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Dec 03, 2019 at 12:19:00PM +0100, Geert Uytterhoeven wrote:
> > On Tue, Feb 19, 2019 at 11:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > Generic mmu_gather provides everything SH needs (range tracking and
> > > cache coherency).
> > >
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Nick Piggin <npiggin@gmail.com>
> > > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > > Cc: Rich Felker <dalias@libc.org>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> > I got remote access to an SH7722-based Migo-R again, which spews a long
> > sequence of BUGs during userspace startup.  I've bisected this to commit
> > c5b27a889da92f4a ("sh/tlb: Convert SH to generic mmu_gather").
>
> Whoopsy.. also, is this really the first time anybody booted an SH
> kernel in over a year ?!?

Nah, but the v5.4-rc3 I booted recently on qemu -M r2d had
CONFIG_PGTABLE_LEVELS=2, so it didn't show the problem.

> > Do you have a clue?
>
> Does the below help?

Unfortunately not.

> diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
> index 22d968bfe9bb..73a2c00de6c5 100644
> --- a/arch/sh/include/asm/pgalloc.h
> +++ b/arch/sh/include/asm/pgalloc.h
> @@ -36,9 +36,8 @@ do {                                                  \
>  #if CONFIG_PGTABLE_LEVELS > 2
>  #define __pmd_free_tlb(tlb, pmdp, addr)                        \
>  do {                                                   \
> -       struct page *page = virt_to_page(pmdp);         \
> -       pgtable_pmd_page_dtor(page);                    \
> -       tlb_remove_page((tlb), page);                   \
> +       pgtable_pmd_page_dtor(pmdp);                    \

expected ‘struct page *’ but argument is of type ‘pmd_t * {aka struct
<anonymous> *}’

> +       tlb_remove_page((tlb), (pmdp));                 \

likewise

>  } while (0);
>  #endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
