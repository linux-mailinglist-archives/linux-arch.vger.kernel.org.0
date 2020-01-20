Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1CED143018
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2020 17:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgATQjw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jan 2020 11:39:52 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34992 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbgATQjw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 11:39:52 -0500
Received: by mail-qt1-f196.google.com with SMTP id e12so270041qto.2
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 08:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZcsttqoOqoppbG6e/pqRXCvsc9U04ANxonvw6+R+xA=;
        b=tMSVAicRbicpyLXDMO4rYsQeKh3JeBuTMmH7INzePJGBSTEWRijFlmLaEkpBkE/S0/
         pPZ9Eqs4i4wySskXaxwgqiQ+9HdlDXQnB+4UkY3WxOmryFKLHp5o3MN7r4jddjcftDpl
         qvV5jFTHJ8gFeE0b+4taMTnl6tSGniO9r0muDyy7osmytx0zBVJP2jQWz5vH+sIbeuiP
         wHAfN+vnfGbWnq6EfmIgO42Aaq4jNmX7q+JIGmkH68GLnk7Gl9JHnMzIlkYAtLt3ChFm
         WqhEQXtyD/4BhCT0YDEBWq96VQmK4fl27mQF0j6ySeBFBPmbWzRhzAU2GzrmBiUAN4Im
         DxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZcsttqoOqoppbG6e/pqRXCvsc9U04ANxonvw6+R+xA=;
        b=Ei7Yb5o6d7Vy3QoBlx+ZNQvexOunuXsF5rrfGakdUIffMi8Ut2tkXIi6pZ4MHV7l9f
         yIzfhrdRZaN1oEK5cwpF3JS4gChT2ynEV3vPgeLI6Sr36GtRfzpXEm+TrptI1dFH4UdW
         cY63z33cfEwUAgwDIvORef33GuFuTV5H8CjyXoC3QRiTX+iE/nRjf7/q45vrQ+O/s7TN
         H9qRI6a130pHkPxjniPK9FwXuy24Dy8acqrxqfrTaxJltMeyzLAfybPhE8ubI/SEAECR
         12nouKbfNuL04G0tPsro+ix43hBRboQV8XLFmool7UN89HLk/Rp09qHU4oXVzaqLrRGL
         mOow==
X-Gm-Message-State: APjAAAUhx/LTu2EI0XuHWABUyIlJ4oy3DuBSpVx+3fkV3FviIXYVH4uA
        buiBUpPCU4jZnNdjmE/aoCWoAs9GujfjMuYmPYWPtg==
X-Google-Smtp-Source: APXvYqzrYE50D8YKSrDPkL1mTaP9NxaA9IUrSzhA5houBQEElh77ireRGTeCqawKKA+jbFPqIc+JLCDWas3HZC0qEcA=
X-Received: by 2002:aed:3b6e:: with SMTP id q43mr129761qte.57.1579538390395;
 Mon, 20 Jan 2020 08:39:50 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com> <CACT4Y+bnRoKinPopVqyxj4av6_xa_OUN0wwnidpO3dX3iYq_gg@mail.gmail.com>
 <CACT4Y+YuTT6kZ-AkgU0c1o09qmQdFWr4_Sds4jaDg-Va6g6jkA@mail.gmail.com>
 <CACT4Y+acrXkA-ixjQXqNf1EC=fpgTWf3Rcevxxon0DfrPdD-UQ@mail.gmail.com>
 <CANpmjNNcXUF-=Y-hmry9-xEoNpJd0WH+fOcJJM6kv2eRm5v-kg@mail.gmail.com>
 <CACT4Y+bD3cNxfaWOuhHz338MoVoaHpw-E8+b7v6mo_ir2KD46Q@mail.gmail.com> <CANpmjNN-8CLN9v7MehNUXy=iEXOfFHwpAUEPivGM573EQqmCZw@mail.gmail.com>
In-Reply-To: <CANpmjNN-8CLN9v7MehNUXy=iEXOfFHwpAUEPivGM573EQqmCZw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 Jan 2020 17:39:39 +0100
Message-ID: <CACT4Y+bgLy=AiCdLauBaSi_Q1gQsqQ08hr1-ipz60k+WFdmiuA@mail.gmail.com>
Subject: Re: [PATCH 1/5] include/linux: Add instrumented.h infrastructure
To:     Marco Elver <elver@google.com>
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

On Mon, Jan 20, 2020 at 5:25 PM Marco Elver <elver@google.com> wrote:
> > > > > > > This adds instrumented.h, which provides generic wrappers for memory
> > > > > > > access instrumentation that the compiler cannot emit for various
> > > > > > > sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> > > > > > > future this will also include KMSAN instrumentation.
> > > > > > >
> > > > > > > Note that, copy_{to,from}_user require special instrumentation,
> > > > > > > providing hooks before and after the access, since we may need to know
> > > > > > > the actual bytes accessed (currently this is relevant for KCSAN, and is
> > > > > > > also relevant in future for KMSAN).
> > > > > > >
> > > > > > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > > > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > > > > ---
> > > > > > >  include/linux/instrumented.h | 153 +++++++++++++++++++++++++++++++++++
> > > > > > >  1 file changed, 153 insertions(+)
> > > > > > >  create mode 100644 include/linux/instrumented.h
> > > > > > >
> > > > > > > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..9f83c8520223
> > > > > > > --- /dev/null
> > > > > > > +++ b/include/linux/instrumented.h
> > > > > > > @@ -0,0 +1,153 @@
> > > > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * This header provides generic wrappers for memory access instrumentation that
> > > > > > > + * the compiler cannot emit for: KASAN, KCSAN.
> > > > > > > + */
> > > > > > > +#ifndef _LINUX_INSTRUMENTED_H
> > > > > > > +#define _LINUX_INSTRUMENTED_H
> > > > > > > +
> > > > > > > +#include <linux/compiler.h>
> > > > > > > +#include <linux/kasan-checks.h>
> > > > > > > +#include <linux/kcsan-checks.h>
> > > > > > > +#include <linux/types.h>
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * instrument_read - instrument regular read access
> > > > > > > + *
> > > > > > > + * Instrument a regular read access. The instrumentation should be inserted
> > > > > > > + * before the actual read happens.
> > > > > > > + *
> > > > > > > + * @ptr address of access
> > > > > > > + * @size size of access
> > > > > > > + */
> > > > > >
> > > > > > Based on offline discussion, that's what we add for KMSAN:
> > > > > >
> > > > > > > +static __always_inline void instrument_read(const volatile void *v, size_t size)
> > > > > > > +{
> > > > > > > +       kasan_check_read(v, size);
> > > > > > > +       kcsan_check_read(v, size);
> > > > > >
> > > > > > KMSAN: nothing
> > > > >
> > > > > KMSAN also has instrumentation in
> > > > > copy_to_user_page/copy_from_user_page. Do we need to do anything for
> > > > > KASAN/KCSAN for these functions?
> > >
> > > copy_to_user_page/copy_from_user_page can be instrumented with
> > > instrument_copy_{to,from}_user_. I prefer keeping this series with no
> > > functional change intended for KASAN at least.
> > >
> > > > There is also copy_user_highpage.
> > > >
> > > > And ioread/write8/16/32_rep: do we need any instrumentation there. It
> > > > seems we want both KSAN and KCSAN too. One may argue that KCSAN
> > > > instrumentation there is to super critical at this point, but KASAN
> > > > instrumentation is important, if anything to prevent silent memory
> > > > corruptions. How do we instrument there? I don't see how it maps to
> > > > any of the existing instrumentation functions.
> > >
> > > These should be able to use the regular instrument_{read,write}. I
> > > prefer keeping this series with no functional change intended for
> > > KASAN at least.
> >
> > instrument_{read,write} will not contain any KMSAN instrumentation,
> > which means we will effectively remove KMSAN instrumentation, which is
> > weird because we instrumented these functions because of KMSAN in the
> > first place...
> >
> > > > There is also kmsan_check_skb/kmsan_handle_dma/kmsan_handle_urb that
> > > > does not seem to map to any of the instrumentation functions.
> > >
> > > For now, I would rather that there are some one-off special
> > > instrumentation, like for KMSAN. Coming up with a unified interface
> > > here that, without the use-cases even settled, seems hard to justify.
> > > Once instrumentation for these have settled, unifying the interface
> > > would have better justification.
> >
> > I would assume they may also require an annotation that checks the
> > memory region under all 3 tools and we don't have such annotation
> > (same as the previous case and effectively copy_to_user). I would
> > expect such annotation will be used in more places once we start
> > looking for more opportunities.
>
> Agreed, I'm certainly not against adding these. We may need to
> introduce 'instrument_dma_' etc. However, would it be reasonable to do
> this in a separate follow-up patch-series, to avoid stalling bitops
> instrumentation?  Assuming that the 8 hooks in instrumented.h right
> now are reasonable, and such future changes add new hooks, I think
> that would be the more pragmatic approach.

I think it would be a wrong direction. Just like this change does not
introduce all of instrument_test_and_set_bit,
instrument___clear_bit_unlock, instrument_copyin,
instrument_copyout_mcsafe, instrument_atomic_andnot, .... All of these
can be grouped into a very small set of cases with respect to what
type of memory access they do from the point of view of sanitizers.
And we introduce instrumentation for these _types_ of accesses, rather
than application functions (we don't care much if the access is for
atomic operations, copy to/from user, usb, dma, skb or something
else). It seems that our set of instrumentation annotations can't
handle some very basic cases...
