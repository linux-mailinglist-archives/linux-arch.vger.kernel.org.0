Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 586CA2DBDD
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2019 13:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfE2LaD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 07:30:03 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40112 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfE2LaD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 07:30:03 -0400
Received: by mail-io1-f65.google.com with SMTP id n5so1484861ioc.7
        for <linux-arch@vger.kernel.org>; Wed, 29 May 2019 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3AdnAOZFu4T3VBLgV3Cb7hGxak9UusYOHweQj/woqpE=;
        b=YbJT7VLF4EXpOP4frqI3h2ZWg+MvdYl1EcxcxoPpSvysi9/h8uPfj9huYGacHLliwq
         lXKJ5Nt8YwVeF2GdICbcjzR1wYLcB0INTyrcb/spYH/BGMoQUR1eYDu0fovRTsEj2+8H
         JAnoXuBFtr2BZZZLuXm9cNAcKYRHASNNO7YEs7iKIwzwCv2lKvEW8MZcUXginzp0sHFh
         tFYcM402isNrOPv26jbdmbaSG7wbEShXq2neN6NSl6sKVpoXZ6rGomBKbemce1H3IOL2
         aT775e4lQJ0z6fLkdelGmbf3nU5fRPwfJsaOA9vTdNE6cezbRgRYTOdsaZXZrbQ6gqoF
         1DJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3AdnAOZFu4T3VBLgV3Cb7hGxak9UusYOHweQj/woqpE=;
        b=JnNabTO3O938hyrMoNAmYaldUwqS4h7jTTSZ03YwPDkbY72D+jIrql4s7Z+7CI2zKs
         JYOAaGCLpW/Sr3c5Rm/M7fKQrmKLm0uzqiDOIyKHaXPfDZkj6ICIpvCoVLy0hirRdQt/
         1CRO9HPO2GomkDy/Zc7IR/ZOCqFG2mVQmN+WGox3fOazPf+v+fCvvnj7B+gda/FG6jfW
         6VbXxx4DWysi/GhTShryQCL52ZkZ+D14PzWzaNejB/fcvnCNNes876uwJRyrZ53bzw4Z
         h817s+XQpehNsFZWJ7ArPgT+nob0K5qa3ntxjo+nGOvWtbwFp72tSNuXKEA4+gGzxBOp
         uURA==
X-Gm-Message-State: APjAAAV8Ndals3v8ZnIPtjoUDU2jePb/1ArPWp2sGaKopywshyATeIc4
        z9Ns7zHVBn78PSiRi6NUdQR02PZJC0ac0X9/CDzwvA==
X-Google-Smtp-Source: APXvYqyVwPDd95rHfY9i4aGvRmgXfEv3sLVceDCkw8CTOnp9BwIu5MYpLT9fOo4M9LLzrdVhRoRmAEORzUqoTj/eBx4=
X-Received: by 2002:a6b:e711:: with SMTP id b17mr12875963ioh.3.1559129402345;
 Wed, 29 May 2019 04:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190528163258.260144-1-elver@google.com> <20190528163258.260144-3-elver@google.com>
 <20190528165036.GC28492@lakrids.cambridge.arm.com> <CACT4Y+bV0CczjRWgHQq3kvioLaaKgN+hnYEKCe5wkbdngrm+8g@mail.gmail.com>
 <CANpmjNNtjS3fUoQ_9FQqANYS2wuJZeFRNLZUq-ku=v62GEGTig@mail.gmail.com>
 <20190529100116.GM2623@hirez.programming.kicks-ass.net> <CANpmjNMvwAny54udYCHfBw1+aphrQmiiTJxqDq7q=h+6fvpO4w@mail.gmail.com>
 <20190529103010.GP2623@hirez.programming.kicks-ass.net> <CACT4Y+aVB3jK_M0-2D_QTq=nncVXTsNp77kjSwBwjqn-3hAJmA@mail.gmail.com>
 <377465ba-3b31-31e7-0f9d-e0a5ab911ca4@virtuozzo.com>
In-Reply-To: <377465ba-3b31-31e7-0f9d-e0a5ab911ca4@virtuozzo.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 29 May 2019 13:29:51 +0200
Message-ID: <CACT4Y+ZDmqqM6YW72Q-=kAurta5ctscLT5p=nQJ5y=82yVMq=w@mail.gmail.com>
Subject: Re: [PATCH 3/3] asm-generic, x86: Add bitops instrumentation for KASAN
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
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

On Wed, May 29, 2019 at 1:23 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> On 5/29/19 1:57 PM, Dmitry Vyukov wrote:
> > On Wed, May 29, 2019 at 12:30 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> On Wed, May 29, 2019 at 12:16:31PM +0200, Marco Elver wrote:
> >>> On Wed, 29 May 2019 at 12:01, Peter Zijlstra <peterz@infradead.org> wrote:
> >>>>
> >>>> On Wed, May 29, 2019 at 11:20:17AM +0200, Marco Elver wrote:
> >>>>> For the default, we decided to err on the conservative side for now,
> >>>>> since it seems that e.g. x86 operates only on the byte the bit is on.
> >>>>
> >>>> This is not correct, see for instance set_bit():
> >>>>
> >>>> static __always_inline void
> >>>> set_bit(long nr, volatile unsigned long *addr)
> >>>> {
> >>>>         if (IS_IMMEDIATE(nr)) {
> >>>>                 asm volatile(LOCK_PREFIX "orb %1,%0"
> >>>>                         : CONST_MASK_ADDR(nr, addr)
> >>>>                         : "iq" ((u8)CONST_MASK(nr))
> >>>>                         : "memory");
> >>>>         } else {
> >>>>                 asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> >>>>                         : : RLONG_ADDR(addr), "Ir" (nr) : "memory");
> >>>>         }
> >>>> }
> >>>>
> >>>> That results in:
> >>>>
> >>>>         LOCK BTSQ nr, (addr)
> >>>>
> >>>> when @nr is not an immediate.
> >>>
> >>> Thanks for the clarification. Given that arm64 already instruments
> >>> bitops access to whole words, and x86 may also do so for some bitops,
> >>> it seems fine to instrument word-sized accesses by default. Is that
> >>> reasonable?
> >>
> >> Eminently -- the API is defined such; for bonus points KASAN should also
> >> do alignment checks on atomic ops. Future hardware will #AC on unaligned
> >> [*] LOCK prefix instructions.
> >>
> >> (*) not entirely accurate, it will only trap when crossing a line.
> >>     https://lkml.kernel.org/r/1556134382-58814-1-git-send-email-fenghua.yu@intel.com
> >
> > Interesting. Does an address passed to bitops also should be aligned,
> > or alignment is supposed to be handled by bitops themselves?
> >
>
> It should be aligned. This even documented in Documentation/core-api/atomic_ops.rst:
>
>         Native atomic bit operations are defined to operate on objects aligned
>         to the size of an "unsigned long" C data type, and are least of that
>         size.  The endianness of the bits within each "unsigned long" are the
>         native endianness of the cpu.
>
>
> > This probably should be done as a separate config as not related to
> > KASAN per se. But obviously via the same
> > {atomicops,bitops}-instrumented.h hooks which will make it
> > significantly easier.
> >
>
> Agreed.

Thanks. I've filed https://bugzilla.kernel.org/show_bug.cgi?id=203751
for checking alignment with all the points and references, so that
it's not lost.
