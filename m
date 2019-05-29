Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1582DE17
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2019 15:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfE2N0G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 09:26:06 -0400
Received: from foss.arm.com ([217.140.101.70]:46006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfE2N0G (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 May 2019 09:26:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CE4C80D;
        Wed, 29 May 2019 06:26:05 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F6763F59C;
        Wed, 29 May 2019 06:26:02 -0700 (PDT)
Date:   Wed, 29 May 2019 14:26:00 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
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
Message-ID: <20190529132559.GF31777@lakrids.cambridge.arm.com>
References: <20190528163258.260144-1-elver@google.com>
 <20190528163258.260144-3-elver@google.com>
 <20190528165036.GC28492@lakrids.cambridge.arm.com>
 <CACT4Y+bV0CczjRWgHQq3kvioLaaKgN+hnYEKCe5wkbdngrm+8g@mail.gmail.com>
 <CANpmjNNtjS3fUoQ_9FQqANYS2wuJZeFRNLZUq-ku=v62GEGTig@mail.gmail.com>
 <20190529100116.GM2623@hirez.programming.kicks-ass.net>
 <CANpmjNMvwAny54udYCHfBw1+aphrQmiiTJxqDq7q=h+6fvpO4w@mail.gmail.com>
 <20190529103010.GP2623@hirez.programming.kicks-ass.net>
 <CACT4Y+aVB3jK_M0-2D_QTq=nncVXTsNp77kjSwBwjqn-3hAJmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aVB3jK_M0-2D_QTq=nncVXTsNp77kjSwBwjqn-3hAJmA@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 29, 2019 at 12:57:15PM +0200, Dmitry Vyukov wrote:
> On Wed, May 29, 2019 at 12:30 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, May 29, 2019 at 12:16:31PM +0200, Marco Elver wrote:
> > > On Wed, 29 May 2019 at 12:01, Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Wed, May 29, 2019 at 11:20:17AM +0200, Marco Elver wrote:
> > > > > For the default, we decided to err on the conservative side for now,
> > > > > since it seems that e.g. x86 operates only on the byte the bit is on.
> > > >
> > > > This is not correct, see for instance set_bit():
> > > >
> > > > static __always_inline void
> > > > set_bit(long nr, volatile unsigned long *addr)
> > > > {
> > > >         if (IS_IMMEDIATE(nr)) {
> > > >                 asm volatile(LOCK_PREFIX "orb %1,%0"
> > > >                         : CONST_MASK_ADDR(nr, addr)
> > > >                         : "iq" ((u8)CONST_MASK(nr))
> > > >                         : "memory");
> > > >         } else {
> > > >                 asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> > > >                         : : RLONG_ADDR(addr), "Ir" (nr) : "memory");
> > > >         }
> > > > }
> > > >
> > > > That results in:
> > > >
> > > >         LOCK BTSQ nr, (addr)
> > > >
> > > > when @nr is not an immediate.
> > >
> > > Thanks for the clarification. Given that arm64 already instruments
> > > bitops access to whole words, and x86 may also do so for some bitops,
> > > it seems fine to instrument word-sized accesses by default. Is that
> > > reasonable?
> >
> > Eminently -- the API is defined such; for bonus points KASAN should also
> > do alignment checks on atomic ops. Future hardware will #AC on unaligned
> > [*] LOCK prefix instructions.
> >
> > (*) not entirely accurate, it will only trap when crossing a line.
> >     https://lkml.kernel.org/r/1556134382-58814-1-git-send-email-fenghua.yu@intel.com
> 
> Interesting. Does an address passed to bitops also should be aligned,
> or alignment is supposed to be handled by bitops themselves?
> 
> This probably should be done as a separate config as not related to
> KASAN per se. But obviously via the same
> {atomicops,bitops}-instrumented.h hooks which will make it
> significantly easier.

Makes sense to me -- that should be easy to hack into gen_param_check()
in gen-atomic-instrumented.sh, something like:

----
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index e09812372b17..2f6b8f521e57 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -21,6 +21,13 @@ gen_param_check()
        [ ${type#c} != ${type} ] && rw="read"
 
        printf "\tkasan_check_${rw}(${name}, sizeof(*${name}));\n"
+
+       [ "${type#c}" = "v" ] || return
+
+cat <<EOF
+       if (IS_ENABLED(CONFIG_PETERZ))
+               WARN_ON(!IS_ALIGNED(${name}, sizeof(*${name})));
+EOF
 }
 
 #gen_param_check(arg...)
----

On arm64 our atomic instructions always perform an alignment check, so
we'd only miss if an atomic op bailed out after a plain READ_ONCE() of
an unaligned atomic variable.

Thanks,
Mark.
