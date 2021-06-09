Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6383A0CA7
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 08:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhFIGqU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 02:46:20 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:41858 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbhFIGqT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jun 2021 02:46:19 -0400
Received: by mail-vs1-f52.google.com with SMTP id c1so5870817vsh.8;
        Tue, 08 Jun 2021 23:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47baV1P3SWK5Bn+j5B4OfUEOCRj033QYxRPMFVA0Gg8=;
        b=VZHf5R03geRru5zwdLqecjeEgdu8XttW2LpaxKYIVazsxwjnwM/xU1vlyN6ZJfMjjv
         aqQAnBsIfmcjqFCcYv4T5/N7j/eKxJegP8lGeUC2Wgg0i35OXY3BgAJeOfKi/T7VuPr0
         ChgF+MFV5KZr0/OulZzTliaXPzmtt3vW3tyzWLTGiuNyaCK2jT9u018bUJg1oDXpSbjX
         kV32WBoCIj9n2sb5JQmrjjw80biszH8NrUu+BDAOrzmHq1PWS0lrvzltoC9aGm0l8Apo
         OBVI1aqUaEWJXjksxOMQLK+gd99y0s5FUpD1OSQa44n87ffJZzhR4fIWhfPB0ZwJWe+t
         89Gg==
X-Gm-Message-State: AOAM533/Awl+qyO0GFTV9DTpkVOL3xo6Y7CPWdBWyZoqEOV85xPJ2+ek
        987U7ofV11oLubiHdh5+QroKyC8A6FMPEAjm9lo=
X-Google-Smtp-Source: ABdhPJxgZoIMbN5GFh2VWpL6EzDYRXy63LPTY3UqoHKfLRG9A/qZOe2ycSYBUB4Pbup17C6x2oVs/4epAGglyIbvzWw=
X-Received: by 2002:a67:efd6:: with SMTP id s22mr3458501vsp.3.1623221059463;
 Tue, 08 Jun 2021 23:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <1623214799-29817-1-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1623214799-29817-1-git-send-email-anshuman.khandual@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Jun 2021 08:44:08 +0200
Message-ID: <CAMuHMdWXHsJWa24qbj_T0tzRm5CobUrP03P4Wn9WY2VtqLVQmg@mail.gmail.com>
Subject: Re: [PATCH V2] mm/thp: Define default pmd_pgtable()
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Hu <nickhu@andestech.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Zankel <chris@zankel.net>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Anshuman,

On Wed, Jun 9, 2021 at 6:59 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> Currently most platforms define pmd_pgtable() as pmd_page() duplicating the
> same code all over. Instead just define a default value i.e pmd_page() for
> pmd_pgtable() and let platforms override when required via <asm/pgtable.h>.
> All the existing platform that override pmd_pgtable() have been moved into
> their respective <asm/pgtable.h> header in order to precede before the new
> generic definition. This makes it much cleaner with reduced code.

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This patch applies on linux-next (20210608) as there is a merge conflict
> dependency on the following commit.
>
> 40762590e8be ("mm: define default value for FIRST_USER_ADDRESS").
>
> This patch has been built tested across multiple platforms.
>
> Changes in V2:
>
> - Changed m68k per Geert

Thanks for the update!

>  arch/m68k/include/asm/mcf_pgalloc.h      | 2 --
>  arch/m68k/include/asm/mcf_pgtable.h      | 2 ++
>  arch/m68k/include/asm/motorola_pgalloc.h | 1 -
>  arch/m68k/include/asm/motorola_pgtable.h | 2 ++
>  arch/m68k/include/asm/sun3_pgalloc.h     | 1 -
>  arch/m68k/include/asm/sun3_pgtable.h     | 2 ++

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
