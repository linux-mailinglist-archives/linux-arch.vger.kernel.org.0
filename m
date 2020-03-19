Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B405418BB91
	for <lists+linux-arch@lfdr.de>; Thu, 19 Mar 2020 16:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgCSPt7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Mar 2020 11:49:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbgCSPt6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Mar 2020 11:49:58 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B284521841
        for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2020 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584632998;
        bh=Rkh1vXkhW9rmZk8EPxDBYiPb1mQUKR3iI0zKH1Fg7V0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WZUFhydFW+Cby4n4jF5wJlr3MQjDUpTFw2i9V1LHv+NPUTRvg4c5vXR+39NvQ36hV
         LV2qdarSCIR9wOQ6JSNEy9hrK7Cx7AstvxQJmgf67dj2IdXfO9Yyr1uyLhJbSZ+zZD
         pTmckZRZnqhY2vCuCiqv/Zba/M1uKnMFKJ5yAAq8=
Received: by mail-wr1-f52.google.com with SMTP id f3so3654874wrw.7
        for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2020 08:49:57 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3aZtALtulhIyZ3x2W+oO2sXybkGji6Qb0v14zFgfhZUvYQ86Hu
        DuexZzSMQOWJYpDuN3NemYRtfGnT8OBBl++7CrKMaA==
X-Google-Smtp-Source: ADFU+vsxkngrkFV8I9T5oK6bcpr4TwgtNHg0eR2cNw6mloMNXkw0k55Rziijc9a+w3nNSCb9M7gTmTIBkLDmnkww4I4=
X-Received: by 2002:adf:9dc6:: with SMTP id q6mr4999539wre.70.1584632996131;
 Thu, 19 Mar 2020 08:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200317122220.30393-1-vincenzo.frascino@arm.com>
 <20200317122220.30393-19-vincenzo.frascino@arm.com> <20200317143834.GC632169@arrakis.emea.arm.com>
In-Reply-To: <20200317143834.GC632169@arrakis.emea.arm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 19 Mar 2020 08:49:44 -0700
X-Gmail-Original-Message-ID: <CALCETrVWPNaJMbYoXbnWsALXKrhHMaePOUvY0DmXpvte8Zz9Zw@mail.gmail.com>
Message-ID: <CALCETrVWPNaJMbYoXbnWsALXKrhHMaePOUvY0DmXpvte8Zz9Zw@mail.gmail.com>
Subject: Re: [PATCH v4 18/26] arm64: vdso32: Replace TASK_SIZE_32 check in vgettimeofday
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 17, 2020 at 7:38 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Mar 17, 2020 at 12:22:12PM +0000, Vincenzo Frascino wrote:
> > diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
> > index 54fc1c2ce93f..91138077b073 100644
> > --- a/arch/arm64/kernel/vdso32/vgettimeofday.c
> > +++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
> > @@ -8,11 +8,14 @@
> >  #include <linux/time.h>
> >  #include <linux/types.h>
> >
> > +#define VALID_CLOCK_ID(x) \
> > +     ((x >= 0) && (x < VDSO_BASES))
> > +
> >  int __vdso_clock_gettime(clockid_t clock,
> >                        struct old_timespec32 *ts)
> >  {
> >       /* The checks below are required for ABI consistency with arm */
> > -     if ((u32)ts >= TASK_SIZE_32)
> > +     if ((u32)ts > UINTPTR_MAX - sizeof(*ts) + 1)
> >               return -EFAULT;
> >
> >       return __cvdso_clock_gettime32(clock, ts);
>
> I probably miss something but I can't find the TASK_SIZE check in the
> arch/arm/vdso/vgettimeofday.c code. Is this done elsewhere?
>

Can you not just remove the TASK_SIZE_32 check entirely?  If you pass
a garbage address to the vDSO, you are quite likely to get SIGSEGV.
Why does this particular type of error need special handling?
