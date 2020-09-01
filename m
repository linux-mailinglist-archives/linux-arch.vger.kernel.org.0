Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC482588AF
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 09:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgIAHEC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 03:04:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37875 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgIAHEA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 03:04:00 -0400
Received: by mail-ot1-f65.google.com with SMTP id 37so304916oto.4;
        Tue, 01 Sep 2020 00:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+UCqMpoxNkc8HR8b48PCCPouXs4GQ+iFq6WKu3/gPA=;
        b=HckLls99BmQHfpV4zTbZRYJd4QNX0Ujw2QGAhBeQMLlHzXOaHXIIrU9r8EdF1Lr54C
         c727ScohG9M+ZeRidtTHE+DEuOFDpYRr8FrDUOXYfXviX6smdKWwDVVfLKC9HCYD6fsg
         2zwGKJUKMjEeGYLPovTAS0UyHF5SeDsFZQayLzfvD2pMRtVroaMsPSJqFpWXWUMrnK7p
         aUO+i+d2wGXqN261zbu9/KH6tTBkAJBftwlW0U/Ps3XLamBxSaYfp02ijeC7LT2Awgfb
         c93/pJCJq6XxCNSsswc7OnvHIUiXgKSUl27gg1YQOkksd5TaIgzD0BoBkHDd/SEP2RtA
         geNA==
X-Gm-Message-State: AOAM533mp0Lo2GJj3p7zozeo/CuoUIoXI/VzWHnDCtp1NAWsMB2SP1qO
        6U34SaEzXXX9M26CB4AFxllrbLbT7ryDkg2Ge7m67LDTa/4=
X-Google-Smtp-Source: ABdhPJw+W75f7LvhKPJmBkANHigTowv41ATseQQVo1zrxnPwXtFSjat/hlrHbRc7rhVmMPWs0LwXP4Ln8wspP9PRVow=
X-Received: by 2002:a9d:32e5:: with SMTP id u92mr373423otb.107.1598943839340;
 Tue, 01 Sep 2020 00:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145249.745432-1-npiggin@gmail.com> <20200826145249.745432-10-npiggin@gmail.com>
 <CAMuHMdX5qo+2XpEm5QNbuwWRn508Ewee9rHYtmCBadj0x=3VnA@mail.gmail.com> <1598941313.t5y1w43jgl.astroid@bobo.none>
In-Reply-To: <1598941313.t5y1w43jgl.astroid@bobo.none>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Sep 2020 09:03:48 +0200
Message-ID: <CAMuHMdWfACYhp8434GOx0qx2oHSBTX3Tq+=gtqNtYahnP-t1JQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/23] m68k: use asm-generic/mmu_context.h for no-op implementations
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nick,

On Tue, Sep 1, 2020 at 8:23 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> Excerpts from Geert Uytterhoeven's message of August 27, 2020 7:33 pm:
> > On Wed, Aug 26, 2020 at 4:53 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> >> Cc: linux-m68k@lists.linux-m68k.org
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >
> > With the below fixed:
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> >> --- a/arch/m68k/include/asm/mmu_context.h
> >> +++ b/arch/m68k/include/asm/mmu_context.h
> >> @@ -79,19 +76,6 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
> >>         set_context(tsk->mm->context, next->pgd);
> >>  }
> >>
> >> -/*
> >> - * After we have set current->mm to a new value, this activates
> >> - * the context for the new mm so we see the new mappings.
> >> - */
> >> -static inline void activate_mm(struct mm_struct *active_mm,
> >> -       struct mm_struct *mm)
> >> -{
> >> -       get_mmu_context(mm);
> >> -       set_context(mm->context, mm->pgd);
> >> -}
> >
> > Assumed switch_mm() in [PATCH v2 01/23] is revived with the above body.
>
> I'm not sure what you mean here. We can remove this because it's a copy
> of switch_mm above, and that's what the new header defaults to if you
> don't provide an active_mm.

IC.  I thought it started relying on <asm-generic/mmu_context.h> for this,
where you removed switch_mm().

Seems I missed the definition above.

> Patch 1 should not have changed that, it should only affect the nommu
> architectures (and actually didn't touch m68k because it was not using
> the asm-generic/mmu_context.h header).

OK. Sorry for the noise.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
