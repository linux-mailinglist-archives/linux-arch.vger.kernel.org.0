Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED28E25427A
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 11:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgH0Jdx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 05:33:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46054 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgH0Jdw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 05:33:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id 5so3842012otp.12;
        Thu, 27 Aug 2020 02:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=erOE8TrBl8kvb1HNiu2tPG2od/TXcbDQmkj/FRCOogE=;
        b=YXzWRY9ZrUXjPWXnP7UHwOTWlDnTir7IDkajyrrpdZDXEUCYuQT8dBDToy6/81o2HS
         WJsFa7rRtwMm6/QTPBoee6I1INAfOEdy1fSM/YYFPojxT71Op8oUV5bcH2gqGpQwwBs6
         OcCXzY4m5DrRy5NK92tWWcRhmxMoUgO3pUZYzbiGrqjmEn4PYSmOpdoMqnz/3EaEHi34
         odAgrKmAYRstpDOiI04+zUjpBlB7WIfeWnodhRToVUbB48uim1q/oALhhqPmhDWwoFrV
         IyeVzo9FNJ12Cy9vTvVieJSNUOiYGZ7DTTd1mEcV0wvYqSmadVv2LFBruq+OaLBCgIeo
         Rw7g==
X-Gm-Message-State: AOAM531MOHeaGmOkZCWLwRKxS4RZfVMCilZoctPrhzCtltUY49sReP9e
        m3FovEU51riG7L+oz8T3RsjlV1umgA5Y7Hx1+Bs=
X-Google-Smtp-Source: ABdhPJzf5Rkx0MMkmy1DhlPa7m6zteOCzt6mslUfJ+2pjnLB14NhM0Z4C9ViJf9/MwLtHCDrl20l9yZOG5kwebfd3OE=
X-Received: by 2002:a9d:32e5:: with SMTP id u92mr11767634otb.107.1598520831934;
 Thu, 27 Aug 2020 02:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145249.745432-1-npiggin@gmail.com> <20200826145249.745432-10-npiggin@gmail.com>
In-Reply-To: <20200826145249.745432-10-npiggin@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Aug 2020 11:33:40 +0200
Message-ID: <CAMuHMdX5qo+2XpEm5QNbuwWRn508Ewee9rHYtmCBadj0x=3VnA@mail.gmail.com>
Subject: Re: [PATCH v2 09/23] m68k: use asm-generic/mmu_context.h for no-op implementations
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 26, 2020 at 4:53 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

With the below fixed:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/arch/m68k/include/asm/mmu_context.h
> +++ b/arch/m68k/include/asm/mmu_context.h
> @@ -79,19 +76,6 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>         set_context(tsk->mm->context, next->pgd);
>  }
>
> -/*
> - * After we have set current->mm to a new value, this activates
> - * the context for the new mm so we see the new mappings.
> - */
> -static inline void activate_mm(struct mm_struct *active_mm,
> -       struct mm_struct *mm)
> -{
> -       get_mmu_context(mm);
> -       set_context(mm->context, mm->pgd);
> -}

Assumed switch_mm() in [PATCH v2 01/23] is revived with the above body.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
