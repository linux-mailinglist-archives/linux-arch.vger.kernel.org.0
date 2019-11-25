Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C4410939E
	for <lists+linux-arch@lfdr.de>; Mon, 25 Nov 2019 19:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfKYSjm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Nov 2019 13:39:42 -0500
Received: from foss.arm.com ([217.140.110.172]:53788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfKYSjm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Nov 2019 13:39:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFDBE31B;
        Mon, 25 Nov 2019 10:39:41 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 652BA3F68E;
        Mon, 25 Nov 2019 10:39:40 -0800 (PST)
Date:   Mon, 25 Nov 2019 18:39:38 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/2] asm-generic/atomic: Prefer __always_inline for
 wrappers
Message-ID: <20191125183936.GG32635@lakrids.cambridge.arm.com>
References: <20191122154221.247680-1-elver@google.com>
 <20191125173756.GF32635@lakrids.cambridge.arm.com>
 <CANpmjNMLEYdW0kaLAiO9fQN1uC7bW6K08zZRG=GG7vq4fBn+WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMLEYdW0kaLAiO9fQN1uC7bW6K08zZRG=GG7vq4fBn+WA@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 25, 2019 at 07:22:33PM +0100, Marco Elver wrote:
> On Mon, 25 Nov 2019 at 18:38, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Fri, Nov 22, 2019 at 04:42:20PM +0100, Marco Elver wrote:
> > > Prefer __always_inline for atomic wrappers. When building for size
> > > (CC_OPTIMIZE_FOR_SIZE), some compilers appear to be less inclined to
> > > inline even relatively small static inline functions that are assumed to
> > > be inlinable such as atomic ops. This can cause problems, for example in
> > > UACCESS regions.
> >
> > From looking at the link below, the problem is tat objtool isn't happy
> > about non-whiteliested calls within UACCESS regions.
> >
> > Is that a problem here? are the kasan/kcsan calls whitelisted?
> 
> We whitelisted all the relevant functions.
> 
> The problem it that small static inline functions private to the
> compilation unit do not get inlined when CC_OPTIMIZE_FOR_SIZE=y (they
> do get inlined when CC_OPTIMIZE_FOR_PERFORMANCE=y).
> 
> For the runtime this is easy to fix, by just making these small
> functions __always_inline (also avoiding these function call overheads
> in the runtime when CC_OPTIMIZE_FOR_SIZE).
> 
> I stumbled upon the issue for the atomic ops, because the runtime uses
> atomic_long_try_cmpxchg outside a user_access_save() region (and it
> should not be moved inside). Essentially I fixed up the runtime, but
> then objtool still complained about the access to
> atomic64_try_cmpxchg. Hence this patch.
> 
> I believe it is the right thing to do, because the final inlining
> decision should *not* be made by wrappers. I would think this patch is
> the right thing to do irrespective of KCSAN or not.

Given the wrappers are trivial, and for !KASAN && !KCSAN, this would
make them equivalent to the things they wrap, that sounds fine to me.

> > > By using __always_inline, we let the real implementation and not the
> > > wrapper determine the final inlining preference.
> >
> > That sounds reasonable to me, assuming that doesn't end up significantly
> > bloating the kernel text. What impact does this have on code size?
> 
> It actually seems to make it smaller.
> 
> x86 tinyconfig:
> - vmlinux baseline: 1316204
> - vmlinux with patches: 1315988 (-216 bytes)

Great! Fancy putting that in the commit message?

> > > This came up when addressing UACCESS warnings with CC_OPTIMIZE_FOR_SIZE
> > > in the KCSAN runtime:
> > > http://lkml.kernel.org/r/58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org
> > >
> > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > >  include/asm-generic/atomic-instrumented.h | 334 +++++++++++-----------
> > >  include/asm-generic/atomic-long.h         | 330 ++++++++++-----------
> > >  scripts/atomic/gen-atomic-instrumented.sh |   6 +-
> > >  scripts/atomic/gen-atomic-long.sh         |   2 +-
> > >  4 files changed, 336 insertions(+), 336 deletions(-)
> >
> > Do we need to do similar for gen-atomic-fallback.sh and the fallbacks
> > defined in scripts/atomic/fallbacks/ ?
> 
> I think they should be, but I think that's debatable. Some of them do
> a little more than just wrap things. If we want to make this
> __always_inline, I would do it in a separate patch independent from
> this series to not stall the fixes here.

I would expect that they would suffer the same problem if used in a
UACCESS region, so if that's what we're trying to fix here, I think that
we need to do likewise there.

The majority are trivial wrappers (shuffling arguments or adding trivial
barriers), so those seem fine. The rest call things that we're inlining
here.

Would you be able to give that a go?

> > > diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> > > index 8b8b2a6f8d68..68532d4f36ca 100755
> > > --- a/scripts/atomic/gen-atomic-instrumented.sh
> > > +++ b/scripts/atomic/gen-atomic-instrumented.sh
> > > @@ -84,7 +84,7 @@ gen_proto_order_variant()
> > >       [ ! -z "${guard}" ] && printf "#if ${guard}\n"
> > >
> > >  cat <<EOF
> > > -static inline ${ret}
> > > +static __always_inline ${ret}
> >
> > We should add an include of <linux/compiler.h> to the preamble if we're
> > explicitly using __always_inline.
> 
> Will add in v2.
> 
> > > diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
> > > index c240a7231b2e..4036d2dd22e9 100755
> > > --- a/scripts/atomic/gen-atomic-long.sh
> > > +++ b/scripts/atomic/gen-atomic-long.sh
> > > @@ -46,7 +46,7 @@ gen_proto_order_variant()
> > >       local retstmt="$(gen_ret_stmt "${meta}")"
> > >
> > >  cat <<EOF
> > > -static inline ${ret}
> > > +static __always_inline ${ret}
> >
> > Likewise here
> 
> Will add in v2.

Great; thanks!

Mark.
