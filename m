Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B198C3559E7
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 19:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhDFRDR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 13:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbhDFRDR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2021 13:03:17 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EA7C061760
        for <linux-arch@vger.kernel.org>; Tue,  6 Apr 2021 10:03:08 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id l8so8152605vsj.13
        for <linux-arch@vger.kernel.org>; Tue, 06 Apr 2021 10:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSGe0bQ5V3W50ybbudz7bPErfQLcHAnbU3s+nR3236o=;
        b=NC4Z5tuEQPH56mSVdL6re/GYvhMXmcZBBZJAe0K5oARYXXzfmQy/y1gj01ihWMSmli
         1Lb/UGbC8aKZb1zPEG9o6M9ucnwbSG6WIoA+FHAPLLbQ01uPDRIuyTwZIpAHLwOG+yq1
         kkZI+8JMwHOnnEn+lyCTAlWm8etMOLtVCp3S1q3K3aO4yA/23/eH2gEXX6vdFz0CJGwN
         VF7c5vQJUcdiwYPAChJeB0X1E472u2faiMpy7Ui5DpvqvQTq4h26rGokMp0GpoEMI+P1
         LV6JUbpNRzT8/BwmE+OHq/ZwSd4sY0JKeDMdURpYfRd1bJM30/6AX5SE7dZl6ySWo0EK
         KluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSGe0bQ5V3W50ybbudz7bPErfQLcHAnbU3s+nR3236o=;
        b=VQTEXrVi88eEvcKcYvp9mODwkQFIK5xyZ9HID75x09yev4WGtxi7zZeJx2g1JHOpS0
         R5ok+f+IIlHVWcn8DeyKdFlLi3h/nrTGaYx38FZLdXWP9qYRQF7s44KkatOKRJELwiEC
         OULJ1e42lfZQW1NEeMAoxQ6JMvAVJeaKcRjamOvxbsN6TepXmCHIZIcL76vwAfWHVnlb
         fKtoq5TeDvDKt+iYdLDx8tcFJZLBjSHkYgTDpYGis2EAnJSvXNw0wvcRHH1ApNuGBpGZ
         vsStlXat8CA9eUApkjUbqJUuyI4LKJda1bPI3dw8go+JQoC961J6mv/xHAhs9QnG7kTu
         4WRg==
X-Gm-Message-State: AOAM532y+tOW+2BtPkA7O1H7qMHcux4+gPy1yR+zya0YVlN8dCRope3Z
        Ch9A1uYe9/IaEvny+NxFICiI08gadMEjhr3MXt6M+w==
X-Google-Smtp-Source: ABdhPJxQSX0S7k4FzbEyhTnhHluxlT34cEUaV5NL9+ccGUPUJJazSLwY0K1+rikJtvM1UuMR3n/GOvlAUPSV1eX6hZs=
X-Received: by 2002:a05:6102:2423:: with SMTP id l3mr16985008vsi.54.1617728587679;
 Tue, 06 Apr 2021 10:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
 <20210401233216.2540591-13-samitolvanen@google.com> <20210406113657.GC96480@C02TD0UTHF1T.local>
In-Reply-To: <20210406113657.GC96480@C02TD0UTHF1T.local>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 6 Apr 2021 10:02:56 -0700
Message-ID: <CABCJKueabmkC3OXSGHKMKS9wJEeRGHBd3b1hK6fM=mMKkj3b1A@mail.gmail.com>
Subject: Re: [PATCH v5 12/18] arm64: implement function_nocfi
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
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
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 6, 2021 at 4:37 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Apr 01, 2021 at 04:32:10PM -0700, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG, the compiler replaces function addresses in
> > instrumented C code with jump table addresses. This change implements
> > the function_nocfi() macro, which returns the actual function address
> > instead.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
>
> I think that it's unfortunate that we have to drop to assembly here, but
> given this is infrequent I agree it's not the end of the world, so:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> > ---
> >  arch/arm64/include/asm/memory.h | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > index 0aabc3be9a75..b55410afd3d1 100644
> > --- a/arch/arm64/include/asm/memory.h
> > +++ b/arch/arm64/include/asm/memory.h
> > @@ -321,6 +321,21 @@ static inline void *phys_to_virt(phys_addr_t x)
> >  #define virt_to_pfn(x)               __phys_to_pfn(__virt_to_phys((unsigned long)(x)))
> >  #define sym_to_pfn(x)                __phys_to_pfn(__pa_symbol(x))
> >
> > +#ifdef CONFIG_CFI_CLANG
> > +/*
> > + * With CONFIG_CFI_CLANG, the compiler replaces function address
> > + * references with the address of the function's CFI jump table
> > + * entry. The function_nocfi macro always returns the address of the
> > + * actual function instead.
> > + */
> > +#define function_nocfi(x) ({                                         \
> > +     void *addr;                                                     \
> > +     asm("adrp %0, " __stringify(x) "\n\t"                           \
> > +         "add  %0, %0, :lo12:" __stringify(x) : "=r" (addr));        \
>
> If it's not too painful, could we please move the asm constrain onto its
> own line? That makes it slightly easier to read, and aligns with what
> we've (mostly) done elsewhere in arm64.

Sure, I'll change this in the next version.

> Not a big deal either way, and the ack stands regardless.
>
> Thanks,
> Mark.

Sami
