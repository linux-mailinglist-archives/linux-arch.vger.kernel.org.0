Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C05DAC302C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2019 11:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfJAJ2b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Oct 2019 05:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbfJAJ2a (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Oct 2019 05:28:30 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B6BF2133F;
        Tue,  1 Oct 2019 09:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569922109;
        bh=VG2yYK04844hua7n2UADcKKpGUe94Zt5h5BgaTNY1Z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t6pUcDb04POb2VM6HATh6teK6DkKKTCdUWUyHuaFg4qR84olfdRS9LPQzIFjqITan
         r6TPX/lwLmkjGV3Pg11mQ2oQdPvlfSQjFG+mkybm11YESLhKd62/MCwKpgDeIOqYx/
         u9DEe+Ah4zTGfLKeAQBeN+bbn8UXtIqWLgWvKvmE=
Date:   Tue, 1 Oct 2019 10:28:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Message-ID: <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck>
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
 <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de>
 <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
 <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
 <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck>
 <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nick,

On Mon, Sep 30, 2019 at 02:50:10PM -0700, Nick Desaulniers wrote:
> On Mon, Sep 30, 2019 at 5:18 AM Will Deacon <will@kernel.org> wrote:
> > On Mon, Sep 30, 2019 at 09:05:11PM +0900, Masahiro Yamada wrote:
> > > On Mon, Sep 30, 2019 at 8:26 PM Will Deacon <will@kernel.org> wrote:
> > > > FWIW, we've run into issues with CONFIG_OPTIMIZE_INLINING and local
> > > > variables marked as 'register' where GCC would do crazy things and end
> > > > up corrupting data, so I suspect the use of fixed registers in the arm
> > > > uaccess functions is hitting something similar:
> > > >
> > > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91111
> > >
> > > No. Not similar at all.
> >
> > They're similar in that enabling CONFIG_OPTIMIZE_INLINING causes register
> > variables to go wrong. I agree that the ARM code looks dodgy with
> > that call to uaccess_save_and_enable(), but there are __asmeq macros
> > in there to try to catch that, so it's still very fishy.
> >
> > > I fixed it already. See
> > > https://lore.kernel.org/patchwork/patch/1132459/
> >
> > You fixed the specific case above for 32-bit ARM, but the arm64 case
> > is due to a compiler bug. As it happens, we've reworked our atomics
> > in 5.4 so that particular issue no longer triggers, but the fact remains
> > that GCC has been shown to screw up explicit register allocation for
> > perfectly legitimate code when giving the flexibility to move code out
> > of line.
> 
> So __attribute__((always_inline)) doesn't guarantee that code will be
> inlined.  For instance in LLVM's inliner, it asks/answers "should I
> inline" and "can I inline."  "Should" has to do with a cost model, and
> is very heuristic-y.  "Can" has more to do with the transforms, and
> whether they're all implemented and safe.  If you if you say
> __attribute__((always_inline)), the answer to "can I inline this" can
> still be *no*.  The only way to guarantee inlining is via the C
> preprocessor.  The only way to prevent inlining is via
> __attribute__((no_inline)).  inline and __attribute__((always_inline))
> are a heuristic laden mess and should not be relied upon.  I would
> also look closely at code that *requires* inlining or the lack there
> of to be correct.  That the kernel no longer compiles at -O0 is not a
> good thing IMO, and hurts developers that want a short
> compile/execute/debug cycle.
> 
> In this case, if there's a known codegen bug in a particular compiler
> or certain versions of it, I recommend the use of either the C
> preprocessor or __attribute__((no_inline)) to get the desired behavior
> localized to the function in question, and for us to proceed with
> Masahiro's cleanup.

Hmm, I don't see how that would help. The problem occurs when things
are moved out of line by the compiler (see below).

> The comment above the use of CONFIG_OPTIMIZE_INLINING in
> include/linux/compiler_types.h says:
>   * Force always-inline if the user requests it so via the .config.
> Which makes me grimace (__attribute__((always_inline)) doesn't *force*
> anything as per above), and the idea that forcing things marked inline
> to also be __attribute__((always_inline)) is an "optimization" (re:
> the name of the config; CONFIG_OPTIMIZE_INLINING) is also highly
> suspect.  Aggressive inlining leads to image size bloat, instruction
> cache and register pressure; it is not exclusively an optimization.

Agreed on all of this, but the fact remains that GCC has been shown to
*miscompile* the arm64 kernel with CONFIG_OPTIMIZE_INLINING=y. Please,
look at this thread:

	https://www.spinics.net/lists/arm-kernel/msg730329.html
	https://www.spinics.net/lists/arm-kernel/msg730512.html

GCC decides to pull an atomic operation out-of-line and, in doing so,
gets the register allocations subtly wrong when passing a 'register'
variable into an inline asm. I would like to avoid this sort of thing
happening, since it can result in really nasty bugs that manifest at
runtime and are extremely difficult to debug, which is why I would much
prefer not to have this option on by default for arm64. I sent a patch
already:

	https://lkml.kernel.org/r/20190930114540.27498-1-will@kernel.org

and I'm happy to spin a v2 which depends on !CC_IS_CLANG as well.

Reducing the instruction cache footprint is great, but not if the
resulting code is broken!

Will
