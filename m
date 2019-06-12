Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2F442881
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2019 16:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfFLOMy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jun 2019 10:12:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41104 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730763AbfFLOMy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jun 2019 10:12:54 -0400
Received: by mail-io1-f66.google.com with SMTP id w25so13032236ioc.8
        for <linux-arch@vger.kernel.org>; Wed, 12 Jun 2019 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fXeSKZUU3yYcblyjjUr+PT/LFbKmVa2WZrUUbFVZZ0=;
        b=RqyGGNemS8/TLIB5Dxl8WKbnhdoc9LMeuNFDMIXpzQjCM/HDctfvLF5YywpxKCA/Ig
         7yPInDXKSM+OBgqGqsVrQpGGSMEQJnBZzRWTeXWniVKBg7SCoM2gvK6O3d0P8Rg8Knn+
         7kPR7R8/O8zpOPULyC4Ksbu0LYVjAmgEBBVgfE++N7YLTYojHXFhqZ0vW6rhH6pMWPEh
         znEfqS3UxP9YqmjVyDU0ZSD9qVP5VjHuDoMiJyK4TV0iN4rGvAIFGHXw8tdLPBeeAWW2
         UoTRDFKFZJo64q4YbPRkTQD0aMhiZQZ2yxkHKkLHVCVoyrmFLNaqdcqQ0dSaWHA8CBfu
         d5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fXeSKZUU3yYcblyjjUr+PT/LFbKmVa2WZrUUbFVZZ0=;
        b=GnqFoGPuBRzr1gNjX86m43BKIWl3zMV8NrNzrYw06yhIRmUVERXGsV3zS67zFIi3gq
         fMB1Ly6MNtrYGOIcAXHHMfBVW9Fhh3yDi1gUcHte6M/SxB7GU8wPMDHefQxavTybU4pJ
         n6Wih2IJ4QUu92Y2DRBSv2Po95NatjptHq+T2fZvQKmkDKViq/S/+ty1BVgDxu2vjctA
         Nl2o19iLuMouGgVvZaehgatCTSzoWHAg6vX3MmifyD0P6K4SBfMaEMUY2A4rTeKARgxG
         dwXhiihLz2JVhrElzY6IMc0o4AMSzDKNnj7KBo5wkX+/559RBuDo1mWb8E2unv1i9UOb
         GlJw==
X-Gm-Message-State: APjAAAVpAE3ahOOjhKbq2lvAwymfzWpfFOzfkxD+8ivIS4SfvfQdrqmK
        HS5Y546q4A53PQhIIWGBP1SSLssg1ET13NBZCS36WQ==
X-Google-Smtp-Source: APXvYqwkiG/FnYs/yUolUcw3GIjfphJ0LlTz9nHHhg4BtY4TBFOFyCbFjrLUlM9TyKIfKg7WWD3xL1yeGraiKF5DRHU=
X-Received: by 2002:a6b:641a:: with SMTP id t26mr7794304iog.3.1560348773474;
 Wed, 12 Jun 2019 07:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190531150828.157832-1-elver@google.com> <20190531150828.157832-3-elver@google.com>
 <CANpmjNP_-J5dZVtDeHUeDk2TBBkOgoPvGKq42Qd7rezbnFWNGg@mail.gmail.com>
In-Reply-To: <CANpmjNP_-J5dZVtDeHUeDk2TBBkOgoPvGKq42Qd7rezbnFWNGg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Jun 2019 16:12:29 +0200
Message-ID: <CACT4Y+a0H0NiMmydmw1qOA=zUXDmBZXHmh6-fp9nU0UtAPZvxQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] x86: Use static_cpu_has in uaccess region to avoid instrumentation
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 7, 2019 at 11:44 AM Marco Elver <elver@google.com> wrote:
>
> Gentle ping.  I would appreciate quick feedback if this approach is reasonable.
>
> Peter: since you suggested that we should not change objtool, did you
> have a particular approach in mind that is maybe different from v2 and
> v3? Or is this what you were thinking of?
>
> Many thanks!
>
> On Fri, 31 May 2019 at 17:11, Marco Elver <elver@google.com> wrote:
> >
> > This patch is a pre-requisite for enabling KASAN bitops instrumentation;
> > using static_cpu_has instead of boot_cpu_has avoids instrumentation of
> > test_bit inside the uaccess region. With instrumentation, the KASAN
> > check would otherwise be flagged by objtool.
> >
> > For consistency, kernel/signal.c was changed to mirror this change,
> > however, is never instrumented with KASAN (currently unsupported under
> > x86 32bit).
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > Suggested-by: H. Peter Anvin <hpa@zytor.com>
> > ---
> > Changes in v3:
> > * Use static_cpu_has instead of moving boot_cpu_has outside uaccess
> >   region.
> >
> > Changes in v2:
> > * Replaces patch: 'tools/objtool: add kasan_check_* to uaccess
> >   whitelist'
> > ---
> >  arch/x86/ia32/ia32_signal.c | 2 +-
> >  arch/x86/kernel/signal.c    | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
> > index 629d1ee05599..1cee10091b9f 100644
> > --- a/arch/x86/ia32/ia32_signal.c
> > +++ b/arch/x86/ia32/ia32_signal.c
> > @@ -358,7 +358,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
> >                 put_user_ex(ptr_to_compat(&frame->uc), &frame->puc);
> >
> >                 /* Create the ucontext.  */
> > -               if (boot_cpu_has(X86_FEATURE_XSAVE))
> > +               if (static_cpu_has(X86_FEATURE_XSAVE))


Peter Z or A, does it look good to you? Could you please Ack this?


> >                         put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
> >                 else
> >                         put_user_ex(0, &frame->uc.uc_flags);
> > diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> > index 364813cea647..52eb1d551aed 100644
> > --- a/arch/x86/kernel/signal.c
> > +++ b/arch/x86/kernel/signal.c
> > @@ -391,7 +391,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
> >                 put_user_ex(&frame->uc, &frame->puc);
> >
> >                 /* Create the ucontext.  */
> > -               if (boot_cpu_has(X86_FEATURE_XSAVE))
> > +               if (static_cpu_has(X86_FEATURE_XSAVE))
> >                         put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
> >                 else
> >                         put_user_ex(0, &frame->uc.uc_flags);
> > --
> > 2.22.0.rc1.257.g3120a18244-goog
> >
