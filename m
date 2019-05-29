Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9FB02DB3C
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2019 12:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfE2K53 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 06:57:29 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:56090 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfE2K52 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 06:57:28 -0400
Received: by mail-it1-f193.google.com with SMTP id g24so2943875iti.5
        for <linux-arch@vger.kernel.org>; Wed, 29 May 2019 03:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0vRsAP/7oCPDaNFunzfNnWkHNHD3PczMiRqJpFCS8w=;
        b=rtsUS66OXMb2mbLSKawrplR44Ksq1THB3HNVn1DNseo+u89Ythl4ZA2z6G+pEceOyh
         k/Ujhdfy++i5sHhkxmId2PeU6nf7C/H0JkrXQ4NKtvxy9jNs9QGtgLmqXvgaKG7Q6uE9
         COzzdK3rqRrk1kF3xmfAZNC6OAxhCtx3+Ufs6FqeHIl/+5FLLO8wiupl+RIxRJ2xRRh/
         JWgrneJjIv/Cjn/VMPYhERQzIS36u6n5j/PtHggx8SA8mSnnfS9Iq+gsQssSHINbnoYb
         x0TI0mOzhl6XeH2zgr/NbP7SdbKBLRHnV6kQLVCDD+ffvQrBM/J+z7yjbi9AVNCJlI1B
         wFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0vRsAP/7oCPDaNFunzfNnWkHNHD3PczMiRqJpFCS8w=;
        b=hiAdZHDuxlab0xDi+G6emuGhrNe2gaQBFNmTge8mw4eIaOZ3u6jvrreSdyP/g+OBQG
         9rqXvB86aalyKx3oL8bbdj0zfOFwaUSe13Pmx5FlIyX8hoJGXFGW3+N6Wb1kSh5CHE4w
         2tD72tNykHGJDQi42SIs9IQVOx7jn9EDWLEMN/JQxaf3iwcG0z3b8MB+fbgp183MTiNQ
         syw51jdrOWUK4P+J5bw1cGAWpRt7ibMszLV3qB8+UGfxZrQIL/rhtz3ell65CYh0WyJY
         2o8EK/rVSf5L3qUi1jCUlKRYH3NtgUYNbePpoGpo9bz7PbgTYLctCJK9DXiWhTK8vfbZ
         oFGw==
X-Gm-Message-State: APjAAAV+wOC3wbO5AGf+kn7JiNWMNWQqYlklnzx9XalPL7pV+GQ92g87
        jA9t4Xuw6xUWP+0BKy4meO18tvO0N7YfCuVnYcFDkw==
X-Google-Smtp-Source: APXvYqzNQqwEEgQdlwddRMtunB+fpJEWQo9KIVGLWRhkJXU6lluRsHXz3n6M5jRDu9uzYR1I0xbnnWgv6pfB98UiDSM=
X-Received: by 2002:a24:c204:: with SMTP id i4mr6670043itg.83.1559127447315;
 Wed, 29 May 2019 03:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190528163258.260144-1-elver@google.com> <20190528163258.260144-3-elver@google.com>
 <20190528165036.GC28492@lakrids.cambridge.arm.com> <CACT4Y+bV0CczjRWgHQq3kvioLaaKgN+hnYEKCe5wkbdngrm+8g@mail.gmail.com>
 <CANpmjNNtjS3fUoQ_9FQqANYS2wuJZeFRNLZUq-ku=v62GEGTig@mail.gmail.com>
 <20190529100116.GM2623@hirez.programming.kicks-ass.net> <CANpmjNMvwAny54udYCHfBw1+aphrQmiiTJxqDq7q=h+6fvpO4w@mail.gmail.com>
 <20190529103010.GP2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190529103010.GP2623@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 29 May 2019 12:57:15 +0200
Message-ID: <CACT4Y+aVB3jK_M0-2D_QTq=nncVXTsNp77kjSwBwjqn-3hAJmA@mail.gmail.com>
Subject: Re: [PATCH 3/3] asm-generic, x86: Add bitops instrumentation for KASAN
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

On Wed, May 29, 2019 at 12:30 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, May 29, 2019 at 12:16:31PM +0200, Marco Elver wrote:
> > On Wed, 29 May 2019 at 12:01, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, May 29, 2019 at 11:20:17AM +0200, Marco Elver wrote:
> > > > For the default, we decided to err on the conservative side for now,
> > > > since it seems that e.g. x86 operates only on the byte the bit is on.
> > >
> > > This is not correct, see for instance set_bit():
> > >
> > > static __always_inline void
> > > set_bit(long nr, volatile unsigned long *addr)
> > > {
> > >         if (IS_IMMEDIATE(nr)) {
> > >                 asm volatile(LOCK_PREFIX "orb %1,%0"
> > >                         : CONST_MASK_ADDR(nr, addr)
> > >                         : "iq" ((u8)CONST_MASK(nr))
> > >                         : "memory");
> > >         } else {
> > >                 asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> > >                         : : RLONG_ADDR(addr), "Ir" (nr) : "memory");
> > >         }
> > > }
> > >
> > > That results in:
> > >
> > >         LOCK BTSQ nr, (addr)
> > >
> > > when @nr is not an immediate.
> >
> > Thanks for the clarification. Given that arm64 already instruments
> > bitops access to whole words, and x86 may also do so for some bitops,
> > it seems fine to instrument word-sized accesses by default. Is that
> > reasonable?
>
> Eminently -- the API is defined such; for bonus points KASAN should also
> do alignment checks on atomic ops. Future hardware will #AC on unaligned
> [*] LOCK prefix instructions.
>
> (*) not entirely accurate, it will only trap when crossing a line.
>     https://lkml.kernel.org/r/1556134382-58814-1-git-send-email-fenghua.yu@intel.com

Interesting. Does an address passed to bitops also should be aligned,
or alignment is supposed to be handled by bitops themselves?

This probably should be done as a separate config as not related to
KASAN per se. But obviously via the same
{atomicops,bitops}-instrumented.h hooks which will make it
significantly easier.
