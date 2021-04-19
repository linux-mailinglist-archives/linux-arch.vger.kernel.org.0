Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87217363D21
	for <lists+linux-arch@lfdr.de>; Mon, 19 Apr 2021 10:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbhDSIGs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Apr 2021 04:06:48 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:43683 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbhDSIGr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Apr 2021 04:06:47 -0400
Received: by mail-vs1-f44.google.com with SMTP id l11so8651162vsr.10;
        Mon, 19 Apr 2021 01:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwvYd/DWaoOJ1HtbW/KpV/JDzyp2vv8uTX1cZfUsEX0=;
        b=WE6ACUin04eD5KWWLPRBVBGjhNo9gZgxYIloZ16zynsUKpF0wiEoXRIEkAMZ19i6L9
         C9ZlcJ2fipFD1Z+AxDsOq430l1yUweOAOB6e4AtS2KgQRXGg1O0ifQwMxPWcsfqXLDgF
         sa8OoBpGpl9CAjsIqt6RdyjCDo2Rm/jdf15Y3MJEhEFMgLVcPq+nhf3Zlz4qVJmFuIJN
         iO7WrXqsFEX7FeZwvR427WuWfRMxQKC7sYz8GKkeY/cg054+/dZ79J2dYic0TOt6R5kI
         vkxVe4tBARsubx3KCCT1Net7zkzcpX2RQY2bToUzG4vkrSCO7Xel5pidJMqtPdes69ut
         0O/w==
X-Gm-Message-State: AOAM532L3eG1rqDSRBnO1mXgdcLACHM1Qg3zN+53ub9FFFllq45HggVZ
        +b+/hl6t5wtnLe/zVDYkhhnMZQ0uDq6r8nkF0Co=
X-Google-Smtp-Source: ABdhPJwwUt9O9+bqGQiINGMpCOolsxRJEQXUZKEY13VJPOONKEyBuZYNCnA4RxtIjZn4JPkquDdN6rbln/JdNExFnKQ=
X-Received: by 2002:a05:6102:814:: with SMTP id g20mr319846vsb.42.1618819575411;
 Mon, 19 Apr 2021 01:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <1618550254-14511-1-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1618550254-14511-1-git-send-email-anshuman.khandual@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Apr 2021 10:06:04 +0200
Message-ID: <CAMuHMdXhUV00tdULpJNS5mohfWZx38+kNWv60x_tjiJPz1qR9g@mail.gmail.com>
Subject: Re: [PATCH V2] mm: Define default value for FIRST_USER_ADDRESS
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Chris Zankel <chris@zankel.net>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 16, 2021 at 7:17 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> Currently most platforms define FIRST_USER_ADDRESS as 0UL duplication the
> same code all over. Instead just define a generic default value (i.e 0UL)
> for FIRST_USER_ADDRESS and let the platforms override when required. This
> makes it much cleaner with reduced code.
>
> The default FIRST_USER_ADDRESS here would be skipped in <linux/pgtable.h>
> when the given platform overrides its value via <asm/pgtable.h>.

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  arch/m68k/include/asm/pgtable_mm.h           | 1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
