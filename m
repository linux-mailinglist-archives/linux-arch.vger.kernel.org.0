Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A2D355463
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 14:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239473AbhDFM7t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 08:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239096AbhDFM7s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Apr 2021 08:59:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5CE4613D0;
        Tue,  6 Apr 2021 12:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617713980;
        bh=MmM0Z9fxkhm9SnK1fIQO8WfodlzxxDy0XGkEAZogl2I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ced3vzglcPx9Dq5ivxegHloEXLqHUvr8HzmjUiElf9G8ZTMaTmyhNp0joHw1JKNqf
         ZRM9DA+kHwYmohQHkWQqZ1mY5MX6JFQVwnqjFhTgpF6IBsYESfOJZOAf0RELyopPJq
         LkabyEZF6sycaumizzGhgcJVYpUNNw9ZTxllksAQoGC0qwN2IigVSJRhHO1esBD9bc
         k+MKBv2YFYHFbZfivBGsRSPcz2wvcaPmknHEprCzG4ndkuBInhHLDt5q5SbcJGQsSC
         KmaNndJU8U3WBfgQ/3iyaX4nEl5Ndzt9vGN5HTeu6tYmP0JWsfixBFtjFrLGaL76Qi
         pBcLmFQkBVvwQ==
Received: by mail-oo1-f50.google.com with SMTP id p2-20020a4aa8420000b02901bc7a7148c4so3650862oom.11;
        Tue, 06 Apr 2021 05:59:40 -0700 (PDT)
X-Gm-Message-State: AOAM532n7cYUjwAs6uDDoeTlXiHt6OUSQdczA6zxR19Aii4NhVMDTBPN
        M7kefO9QCZAv1tmBjTkkciGwbH4QZw0KYyagFu0=
X-Google-Smtp-Source: ABdhPJxDNCj1NGgcj5QYLyY5XEVb262+iXVbnwzUprYhCzBA1PE1J8t6rkdEDSwZ0xpnvPoJA7HzmVROrJw7qRz0qWw=
X-Received: by 2002:a4a:bd97:: with SMTP id k23mr26482678oop.13.1617713980054;
 Tue, 06 Apr 2021 05:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
 <20210401233216.2540591-15-samitolvanen@google.com> <20210406115357.GE96480@C02TD0UTHF1T.local>
In-Reply-To: <20210406115357.GE96480@C02TD0UTHF1T.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 6 Apr 2021 14:59:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFHm5rqKqku5=WF-NcsUNmWp4Ymxu7aO9=XkD-LhLr-dA@mail.gmail.com>
Message-ID: <CAMj1kXFHm5rqKqku5=WF-NcsUNmWp4Ymxu7aO9=XkD-LhLr-dA@mail.gmail.com>
Subject: Re: [PATCH v5 14/18] arm64: add __nocfi to functions that jump to a
 physical address
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "open list:BPF JIT for MIPS (32-BIT AND 64-BIT)" 
        <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 6 Apr 2021 at 13:54, Mark Rutland <mark.rutland@arm.com> wrote:
>
> [adding Ard for EFI runtime services bits]
>
> On Thu, Apr 01, 2021 at 04:32:12PM -0700, Sami Tolvanen wrote:
> > Disable CFI checking for functions that switch to linear mapping and
> > make an indirect call to a physical address, since the compiler only
> > understands virtual addresses and the CFI check for such indirect calls
> > would always fail.
>
> What does physical vs virtual have to do with this? Does the address
> actually matter, or is this just a general thing that when calling an
> assembly function we won't have a trampoline that the caller expects?
>
> I wonder if we need to do something with asmlinkage here, perhaps?
>
> I didn't spot anything in the seriues handling EFI runtime services
> calls, and I strongly suspect we need to do something for those, unless
> they're handled implicitly by something else.
>

All indirect EFI calls are routed via a asm helper that I originally
added to check whether x18 was corrupted by the firmware. So from the
caller side, we should be fine.

All callees are addresses that are provided by the firmware via tables
in memory, so I would assume that this addresses the callee side as
well. AFAICT, it is never left up to the compiler to emit these
indirect calls, or take the address of a firmware routine.

But a test would be nice :-)

> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/arm64/include/asm/mmu_context.h | 2 +-
> >  arch/arm64/kernel/cpu-reset.h        | 8 ++++----
> >  arch/arm64/kernel/cpufeature.c       | 2 +-
> >  3 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> > index 386b96400a57..d3cef9133539 100644
> > --- a/arch/arm64/include/asm/mmu_context.h
> > +++ b/arch/arm64/include/asm/mmu_context.h
> > @@ -119,7 +119,7 @@ static inline void cpu_install_idmap(void)
> >   * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
> >   * avoiding the possibility of conflicting TLB entries being allocated.
> >   */
> > -static inline void cpu_replace_ttbr1(pgd_t *pgdp)
> > +static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp)
>
> Given these are inlines, what's the effect when these are inlined into a
> function that would normally use CFI? Does CFI get supressed for the
> whole function, or just the bit that got inlined?
>
> Is there an attribute that we could place on a function pointer to tell
> the compiler to not check calls via that pointer? If that existed we'd
> be able to scope this much more tightly.
>

I agree that it would be very helpful to be able to define a function
pointer type that is exempt from CFI checks.
