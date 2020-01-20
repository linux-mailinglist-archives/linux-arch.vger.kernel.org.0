Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03450142F84
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2020 17:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgATQZo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jan 2020 11:25:44 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41976 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgATQZo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 11:25:44 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so237905otc.8
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 08:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7cSDWZohrZmB4Lsh7kYAZSQYpOg12wvWZ6eMxNAuFio=;
        b=A1XqDsGutwFYPrzCqsKq2d73/8yvcyJB2N6mF7qLKpxGRtCDQBJhJNDfiIp0E4b04M
         jLdXD9eC1j56EauzFYnsgq6TAZRDs8Q7vxfxbCgD3Df/4Mv8pkNU4Ui73qOxG1dpFTKO
         ozGG9ypd8Lpbp9MkJApJbOseJQtLs9MMNFzddPXErWHa3zc8xtbpQ779xaPZspAF4FMe
         zEbYXgFSUilSpJpyfogMDbnBuhrG++MGfxtDebXb7B2/TNzO6rxxEk8RLXt1q8XP46U/
         DYkBHnWfaOb+D0mPBibSXr10JIhJCq7R+8JGaBx3F6a0T6ij3tm//YzNE76wAOpTrj05
         zTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7cSDWZohrZmB4Lsh7kYAZSQYpOg12wvWZ6eMxNAuFio=;
        b=IdMoIT6QZEsaUV3LXwLwwuL7ZmZSl6JWVUcKoAnRcp/RV3ZbQUGBQtq4R2gbOd1fjB
         x0Uo3MhogkbW1C18Xv4RFVh/jQDRt3QBkM0E74GDHNmu2+8y4AW7nbnZIb8/qM+zC7sm
         qx9MhepXHTh4MnGLk1Pe8MYs9AxRQxPhJ6GFdEEJM+7FTeNyYVEngZX0E8rUog+Lw++v
         RsBa9YbhORYfM9iUcMei8OO3432H8C0hKnkssCqK4zmhTfob00f5iAdc4JlUbuDts5qp
         l5TpoZxNpeNT+DzRUf/TCmqJKotdYezHz28G0JQgrdaA6weamyJ87MIBtYoH0bu48Ppe
         pn2A==
X-Gm-Message-State: APjAAAXo96nROnWk7Iy5DtUL56uYnaJoWc4E9y2cCCZs7wegQMI3Ej0O
        arQI0XaRvJX+TVykPV1UGx37LydVHvRrJw4h72qXFA==
X-Google-Smtp-Source: APXvYqx80QzaPWpNwaBjtr4lRxleoT9Gpjc00N18ryoIv2GI2DE3IQCFsyL079bZbygHNdnGpGbmw+e6WM5ylFg7V3w=
X-Received: by 2002:a05:6830:1d7b:: with SMTP id l27mr136144oti.251.1579537542903;
 Mon, 20 Jan 2020 08:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com> <CACT4Y+bnRoKinPopVqyxj4av6_xa_OUN0wwnidpO3dX3iYq_gg@mail.gmail.com>
 <CACT4Y+YuTT6kZ-AkgU0c1o09qmQdFWr4_Sds4jaDg-Va6g6jkA@mail.gmail.com>
 <CACT4Y+acrXkA-ixjQXqNf1EC=fpgTWf3Rcevxxon0DfrPdD-UQ@mail.gmail.com>
 <CANpmjNNcXUF-=Y-hmry9-xEoNpJd0WH+fOcJJM6kv2eRm5v-kg@mail.gmail.com> <CACT4Y+bD3cNxfaWOuhHz338MoVoaHpw-E8+b7v6mo_ir2KD46Q@mail.gmail.com>
In-Reply-To: <CACT4Y+bD3cNxfaWOuhHz338MoVoaHpw-E8+b7v6mo_ir2KD46Q@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jan 2020 17:25:31 +0100
Message-ID: <CANpmjNN-8CLN9v7MehNUXy=iEXOfFHwpAUEPivGM573EQqmCZw@mail.gmail.com>
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

On Mon, 20 Jan 2020 at 17:06, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Jan 20, 2020 at 4:40 PM Marco Elver <elver@google.com> wrote:
> > > > > > This adds instrumented.h, which provides generic wrappers for memory
> > > > > > access instrumentation that the compiler cannot emit for various
> > > > > > sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> > > > > > future this will also include KMSAN instrumentation.
> > > > > >
> > > > > > Note that, copy_{to,from}_user require special instrumentation,
> > > > > > providing hooks before and after the access, since we may need to know
> > > > > > the actual bytes accessed (currently this is relevant for KCSAN, and is
> > > > > > also relevant in future for KMSAN).
> > > > > >
> > > > > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > > > ---
> > > > > >  include/linux/instrumented.h | 153 +++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 153 insertions(+)
> > > > > >  create mode 100644 include/linux/instrumented.h
> > > > > >
> > > > > > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > > > > > new file mode 100644
> > > > > > index 000000000000..9f83c8520223
> > > > > > --- /dev/null
> > > > > > +++ b/include/linux/instrumented.h
> > > > > > @@ -0,0 +1,153 @@
> > > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > > +
> > > > > > +/*
> > > > > > + * This header provides generic wrappers for memory access instrumentation that
> > > > > > + * the compiler cannot emit for: KASAN, KCSAN.
> > > > > > + */
> > > > > > +#ifndef _LINUX_INSTRUMENTED_H
> > > > > > +#define _LINUX_INSTRUMENTED_H
> > > > > > +
> > > > > > +#include <linux/compiler.h>
> > > > > > +#include <linux/kasan-checks.h>
> > > > > > +#include <linux/kcsan-checks.h>
> > > > > > +#include <linux/types.h>
> > > > > > +
> > > > > > +/**
> > > > > > + * instrument_read - instrument regular read access
> > > > > > + *
> > > > > > + * Instrument a regular read access. The instrumentation should be inserted
> > > > > > + * before the actual read happens.
> > > > > > + *
> > > > > > + * @ptr address of access
> > > > > > + * @size size of access
> > > > > > + */
> > > > >
> > > > > Based on offline discussion, that's what we add for KMSAN:
> > > > >
> > > > > > +static __always_inline void instrument_read(const volatile void *v, size_t size)
> > > > > > +{
> > > > > > +       kasan_check_read(v, size);
> > > > > > +       kcsan_check_read(v, size);
> > > > >
> > > > > KMSAN: nothing
> > > >
> > > > KMSAN also has instrumentation in
> > > > copy_to_user_page/copy_from_user_page. Do we need to do anything for
> > > > KASAN/KCSAN for these functions?
> >
> > copy_to_user_page/copy_from_user_page can be instrumented with
> > instrument_copy_{to,from}_user_. I prefer keeping this series with no
> > functional change intended for KASAN at least.
> >
> > > There is also copy_user_highpage.
> > >
> > > And ioread/write8/16/32_rep: do we need any instrumentation there. It
> > > seems we want both KSAN and KCSAN too. One may argue that KCSAN
> > > instrumentation there is to super critical at this point, but KASAN
> > > instrumentation is important, if anything to prevent silent memory
> > > corruptions. How do we instrument there? I don't see how it maps to
> > > any of the existing instrumentation functions.
> >
> > These should be able to use the regular instrument_{read,write}. I
> > prefer keeping this series with no functional change intended for
> > KASAN at least.
>
> instrument_{read,write} will not contain any KMSAN instrumentation,
> which means we will effectively remove KMSAN instrumentation, which is
> weird because we instrumented these functions because of KMSAN in the
> first place...
>
> > > There is also kmsan_check_skb/kmsan_handle_dma/kmsan_handle_urb that
> > > does not seem to map to any of the instrumentation functions.
> >
> > For now, I would rather that there are some one-off special
> > instrumentation, like for KMSAN. Coming up with a unified interface
> > here that, without the use-cases even settled, seems hard to justify.
> > Once instrumentation for these have settled, unifying the interface
> > would have better justification.
>
> I would assume they may also require an annotation that checks the
> memory region under all 3 tools and we don't have such annotation
> (same as the previous case and effectively copy_to_user). I would
> expect such annotation will be used in more places once we start
> looking for more opportunities.

Agreed, I'm certainly not against adding these. We may need to
introduce 'instrument_dma_' etc. However, would it be reasonable to do
this in a separate follow-up patch-series, to avoid stalling bitops
instrumentation?  Assuming that the 8 hooks in instrumented.h right
now are reasonable, and such future changes add new hooks, I think
that would be the more pragmatic approach.

Thanks,
-- Marco

>
> > This patch series is merely supposed to introduce instrumented.h and
> > replace the kasan_checks (also implicitly introducing kcsan_checks
> > there), however, with no further functional change intended.
> >
> > I propose that adding entirely new instrumentation for both KASAN and
> > KCSAN, we should send a separate patch-series.
> >
> > Thanks,
> > -- Marco
