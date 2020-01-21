Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE041439BB
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 10:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAUJoU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 04:44:20 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37050 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUJoU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 04:44:20 -0500
Received: by mail-oi1-f196.google.com with SMTP id z64so1972276oia.4
        for <linux-arch@vger.kernel.org>; Tue, 21 Jan 2020 01:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HBcIIfisjpHPiUGpBDs8d1gs27EtkgCyjibCW2LJEj4=;
        b=TJpn6ykwqB4Vn0EAKwJqzsYZixKHikBAzb5djqAgU4H0a4U82v15ofay2fp9I2zjv0
         rFLu8FZZLQvVjoVPJYts8cwSdEFHEe/C6AkGTEh1javqW7yO0B1/U+GCQyWocx7Si555
         lkBE/oxL0/+jSUxCkUXCI9x9ATvdKRF40GfIUgw2VPpkQDmgbI54e7d+KhuQmIhXWWdt
         6/43BN6pIoabijuDCDQPNqJ3/xgyqLvvt13h4kJRKTM9iC+mn10XQL0Wf2XNTDu4HAk5
         ibVvupmClDfK1XmTtFy5fjpUWeNN8RA6cqi+AJO9RdBs/XqauDivcOAB0E/Z8TMtHPjx
         OQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBcIIfisjpHPiUGpBDs8d1gs27EtkgCyjibCW2LJEj4=;
        b=ENihp2EFwOJJM4SNbh/QwSO59eg186SoWSZnHHhRtldPErtU7azYy0Bd9D202JGaDm
         ZBgO97Sty4qmlxAu8e0a9ykGaUNdmQ4x4Om+y//JvygdZ3MDLRJy/V89QHGbtrkbVC4D
         BM34I0221WscvMnReGrZUyusKoyUuBJv/iHVy/9IijcLd0LA95l6Xrc29lNshJ7ob/09
         lsZZSQzRkRMyA/gy/HqygvMDDx2uoe9xEGCQ5wCepXtutqkkZuU0Y51xHU3lHhHWDAB/
         cbpRAmFxiIrwBSwiPKTIJ2f3WC1tr0x+LfOUnTKnz7xokUk9sIPifHZ7dECYY2wdv5Z0
         QEGw==
X-Gm-Message-State: APjAAAVEWvPrs7Ch0YFjfGSi0uIXWCuO50VGyC/sqBLmMTjLowqWWffw
        Vs/65oN/Mh4DlZHUU/NI+Fy2RRPVTBicp9OoKYrLJA==
X-Google-Smtp-Source: APXvYqwBDo7cc0K8uN2ZqwjLs+PJgLgUkGJKSeXtEYuyEFDEVd7xRwW/2gVSkgwP14IWiZZTMpevPZ8zcLLMF268nvc=
X-Received: by 2002:aca:b183:: with SMTP id a125mr2373497oif.83.1579599858446;
 Tue, 21 Jan 2020 01:44:18 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com> <CACT4Y+bnRoKinPopVqyxj4av6_xa_OUN0wwnidpO3dX3iYq_gg@mail.gmail.com>
 <CACT4Y+YuTT6kZ-AkgU0c1o09qmQdFWr4_Sds4jaDg-Va6g6jkA@mail.gmail.com>
 <CACT4Y+acrXkA-ixjQXqNf1EC=fpgTWf3Rcevxxon0DfrPdD-UQ@mail.gmail.com>
 <CANpmjNNcXUF-=Y-hmry9-xEoNpJd0WH+fOcJJM6kv2eRm5v-kg@mail.gmail.com>
 <CACT4Y+bD3cNxfaWOuhHz338MoVoaHpw-E8+b7v6mo_ir2KD46Q@mail.gmail.com>
 <CANpmjNN-8CLN9v7MehNUXy=iEXOfFHwpAUEPivGM573EQqmCZw@mail.gmail.com> <CACT4Y+bgLy=AiCdLauBaSi_Q1gQsqQ08hr1-ipz60k+WFdmiuA@mail.gmail.com>
In-Reply-To: <CACT4Y+bgLy=AiCdLauBaSi_Q1gQsqQ08hr1-ipz60k+WFdmiuA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 21 Jan 2020 10:44:06 +0100
Message-ID: <CANpmjNPCGM9V++Vq_UtLJoLbzLdVfgJg0kWAkK=E+829may9Uw@mail.gmail.com>
Subject: Re: [PATCH 1/5] include/linux: Add instrumented.h infrastructure
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>, cyphar@cyphar.com,
        Kees Cook <keescook@chromium.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 20 Jan 2020 at 17:39, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Jan 20, 2020 at 5:25 PM Marco Elver <elver@google.com> wrote:
> > > > > > > > This adds instrumented.h, which provides generic wrappers for memory
> > > > > > > > access instrumentation that the compiler cannot emit for various
> > > > > > > > sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> > > > > > > > future this will also include KMSAN instrumentation.
> > > > > > > >
> > > > > > > > Note that, copy_{to,from}_user require special instrumentation,
> > > > > > > > providing hooks before and after the access, since we may need to know
> > > > > > > > the actual bytes accessed (currently this is relevant for KCSAN, and is
> > > > > > > > also relevant in future for KMSAN).
> > > > > > > >
> > > > > > > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > > > > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > > > > > ---
> > > > > > > >  include/linux/instrumented.h | 153 +++++++++++++++++++++++++++++++++++
> > > > > > > >  1 file changed, 153 insertions(+)
> > > > > > > >  create mode 100644 include/linux/instrumented.h
> > > > > > > >
> > > > > > > > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..9f83c8520223
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/include/linux/instrumented.h
> > > > > > > > @@ -0,0 +1,153 @@
> > > > > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > > > > +
> > > > > > > > +/*
> > > > > > > > + * This header provides generic wrappers for memory access instrumentation that
> > > > > > > > + * the compiler cannot emit for: KASAN, KCSAN.
> > > > > > > > + */
> > > > > > > > +#ifndef _LINUX_INSTRUMENTED_H
> > > > > > > > +#define _LINUX_INSTRUMENTED_H
> > > > > > > > +
> > > > > > > > +#include <linux/compiler.h>
> > > > > > > > +#include <linux/kasan-checks.h>
> > > > > > > > +#include <linux/kcsan-checks.h>
> > > > > > > > +#include <linux/types.h>
> > > > > > > > +
> > > > > > > > +/**
> > > > > > > > + * instrument_read - instrument regular read access
> > > > > > > > + *
> > > > > > > > + * Instrument a regular read access. The instrumentation should be inserted
> > > > > > > > + * before the actual read happens.
> > > > > > > > + *
> > > > > > > > + * @ptr address of access
> > > > > > > > + * @size size of access
> > > > > > > > + */
> > > > > > >
> > > > > > > Based on offline discussion, that's what we add for KMSAN:
> > > > > > >
> > > > > > > > +static __always_inline void instrument_read(const volatile void *v, size_t size)
> > > > > > > > +{
> > > > > > > > +       kasan_check_read(v, size);
> > > > > > > > +       kcsan_check_read(v, size);
> > > > > > >
> > > > > > > KMSAN: nothing
> > > > > >
> > > > > > KMSAN also has instrumentation in
> > > > > > copy_to_user_page/copy_from_user_page. Do we need to do anything for
> > > > > > KASAN/KCSAN for these functions?
> > > >
> > > > copy_to_user_page/copy_from_user_page can be instrumented with
> > > > instrument_copy_{to,from}_user_. I prefer keeping this series with no
> > > > functional change intended for KASAN at least.
> > > >
> > > > > There is also copy_user_highpage.
> > > > >
> > > > > And ioread/write8/16/32_rep: do we need any instrumentation there. It
> > > > > seems we want both KSAN and KCSAN too. One may argue that KCSAN
> > > > > instrumentation there is to super critical at this point, but KASAN
> > > > > instrumentation is important, if anything to prevent silent memory
> > > > > corruptions. How do we instrument there? I don't see how it maps to
> > > > > any of the existing instrumentation functions.
> > > >
> > > > These should be able to use the regular instrument_{read,write}. I
> > > > prefer keeping this series with no functional change intended for
> > > > KASAN at least.
> > >
> > > instrument_{read,write} will not contain any KMSAN instrumentation,
> > > which means we will effectively remove KMSAN instrumentation, which is
> > > weird because we instrumented these functions because of KMSAN in the
> > > first place...

I missed this. Yes, you're right.

> > > > > There is also kmsan_check_skb/kmsan_handle_dma/kmsan_handle_urb that
> > > > > does not seem to map to any of the instrumentation functions.
> > > >
> > > > For now, I would rather that there are some one-off special
> > > > instrumentation, like for KMSAN. Coming up with a unified interface
> > > > here that, without the use-cases even settled, seems hard to justify.
> > > > Once instrumentation for these have settled, unifying the interface
> > > > would have better justification.
> > >
> > > I would assume they may also require an annotation that checks the
> > > memory region under all 3 tools and we don't have such annotation
> > > (same as the previous case and effectively copy_to_user). I would
> > > expect such annotation will be used in more places once we start
> > > looking for more opportunities.
> >
> > Agreed, I'm certainly not against adding these. We may need to
> > introduce 'instrument_dma_' etc. However, would it be reasonable to do
> > this in a separate follow-up patch-series, to avoid stalling bitops
> > instrumentation?  Assuming that the 8 hooks in instrumented.h right
> > now are reasonable, and such future changes add new hooks, I think
> > that would be the more pragmatic approach.
>
> I think it would be a wrong direction. Just like this change does not
> introduce all of instrument_test_and_set_bit,
> instrument___clear_bit_unlock, instrument_copyin,
> instrument_copyout_mcsafe, instrument_atomic_andnot, .... All of these
> can be grouped into a very small set of cases with respect to what
> type of memory access they do from the point of view of sanitizers.
> And we introduce instrumentation for these _types_ of accesses, rather
> than application functions (we don't care much if the access is for
> atomic operations, copy to/from user, usb, dma, skb or something
> else). It seems that our set of instrumentation annotations can't
> handle some very basic cases...

With the ioread/write, dma, skb, urb, user-copy cases in mind, it just
appears to me that attempting to find a minimal unifying set of
instrumentation hooks might lead us in circles, given we only have the
following options:

1. Do not introduce 'instrumented.h', and drop this series. With KMSAN
in mind, this is what I mentioned I preferred in the first place, and
just add a few dozen lines in each place we need to instrument. Yes,
yes, it's not as convenient, but at least we'll know it'll be correct
without having to reason about all cases and all sanitizers all at
once (with KMSAN not being in any kernel tree even).

2. This patch series, keeping 'instrumented.h', but only keep what we
use right now. This is knowing we'll likely have to add a number of
special cases (user-copy, ioread/write, etc) for now. Again,
KASAN/KCSAN probably want the same thing, but I don't know how much
conflict there will be with KMSAN after all is said and done. We will
incrementally add what is required, with unifying things later. This
will also satisfy Arnd's constraint of no empty functions:
http://lkml.kernel.org/r/CAK8P3a32sVU4umk2FLnWnMGMQxThvMHAKxVM+G4X-hMgpBsXMA@mail.gmail.com

3. Try to find a minimal set of instrumentation hooks that cater to
all tools (KASAN, KCSAN, KMSAN). Without even having all
instrumentation (without the 'instrumented.h' infrastructure) in
place, I feel this will not be too successful. I think we can do this
once we have instrumentation for all tools, in all places. Then
unifying all of them should be a non-functional-change refactor.
Essentially, this option depends on (1).

However, now we have some constraints which are difficult to satisfy
all at once:
1. Essentially we were told to avoid (1), based on Arnd's suggestion
to simplify the instrumentation. Therefore we thought (2) would be a
good idea.
2. Now that we know what (2) looks like, it seems you prefer (3),
because we should also cater to KMSAN with this patch series.
3. No unused hooks.

Given we have a KMSAN<-(1)<-(3) dependency, but we were told to avoid
(1), empty functions, and KMSAN hasn't yet landed, we can't reasonably
do (3). Since you dislike (2), we're stuck.

Any options I missed?

Thanks,
-- Marco
