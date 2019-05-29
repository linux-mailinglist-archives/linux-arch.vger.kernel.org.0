Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C030B2DAC7
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2019 12:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfE2Kad (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 06:30:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33956 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2Kad (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 06:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1dAPKEgrdA77wQkAtd5gC6oh+a8AzS+LHB60Y9C2ymk=; b=XQxR27+WnVTmp5Ulgy4i5STtT
        Tah9eldsP7kIUyYVcFMpcV2yfiLUNrTuxq7NrctEBZY/BTA5VkVO0y3AG0JU1L7l3DIUdZ0uGqe+W
        HGj2dMWylU+fuC3tbzcuTHkxanPs5RpoOrF0KRZyUwXHA1i3y/6asMWyvb9MPjfDtrLeTYdRgat96
        PV++Vrl5gIlZyVldbQpRWiv71ourwwNj2fyMFURDzRnQUjQ3RXsab5FDy3brTD6QFF79shi3VMh5D
        IXzqdS1f8pqvORPrdrbvVa7LdmBiFmkwRPBPKWrz/uvWtx/hb5UMphU2JrU2FaVKbJ6TWE2pB8A7H
        alLHgBeWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVvqV-0003TW-Mw; Wed, 29 May 2019 10:30:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45FBD201A7E6D; Wed, 29 May 2019 12:30:10 +0200 (CEST)
Date:   Wed, 29 May 2019 12:30:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 3/3] asm-generic, x86: Add bitops instrumentation for
 KASAN
Message-ID: <20190529103010.GP2623@hirez.programming.kicks-ass.net>
References: <20190528163258.260144-1-elver@google.com>
 <20190528163258.260144-3-elver@google.com>
 <20190528165036.GC28492@lakrids.cambridge.arm.com>
 <CACT4Y+bV0CczjRWgHQq3kvioLaaKgN+hnYEKCe5wkbdngrm+8g@mail.gmail.com>
 <CANpmjNNtjS3fUoQ_9FQqANYS2wuJZeFRNLZUq-ku=v62GEGTig@mail.gmail.com>
 <20190529100116.GM2623@hirez.programming.kicks-ass.net>
 <CANpmjNMvwAny54udYCHfBw1+aphrQmiiTJxqDq7q=h+6fvpO4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMvwAny54udYCHfBw1+aphrQmiiTJxqDq7q=h+6fvpO4w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 29, 2019 at 12:16:31PM +0200, Marco Elver wrote:
> On Wed, 29 May 2019 at 12:01, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, May 29, 2019 at 11:20:17AM +0200, Marco Elver wrote:
> > > For the default, we decided to err on the conservative side for now,
> > > since it seems that e.g. x86 operates only on the byte the bit is on.
> >
> > This is not correct, see for instance set_bit():
> >
> > static __always_inline void
> > set_bit(long nr, volatile unsigned long *addr)
> > {
> >         if (IS_IMMEDIATE(nr)) {
> >                 asm volatile(LOCK_PREFIX "orb %1,%0"
> >                         : CONST_MASK_ADDR(nr, addr)
> >                         : "iq" ((u8)CONST_MASK(nr))
> >                         : "memory");
> >         } else {
> >                 asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> >                         : : RLONG_ADDR(addr), "Ir" (nr) : "memory");
> >         }
> > }
> >
> > That results in:
> >
> >         LOCK BTSQ nr, (addr)
> >
> > when @nr is not an immediate.
> 
> Thanks for the clarification. Given that arm64 already instruments
> bitops access to whole words, and x86 may also do so for some bitops,
> it seems fine to instrument word-sized accesses by default. Is that
> reasonable?

Eminently -- the API is defined such; for bonus points KASAN should also
do alignment checks on atomic ops. Future hardware will #AC on unaligned
[*] LOCK prefix instructions.

(*) not entirely accurate, it will only trap when crossing a line.
    https://lkml.kernel.org/r/1556134382-58814-1-git-send-email-fenghua.yu@intel.com
