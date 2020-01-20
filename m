Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B153142EF3
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2020 16:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgATPkz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jan 2020 10:40:55 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35098 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgATPkz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 10:40:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id i15so138027oto.2
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 07:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bW+iYMzyJar5RkTMPGCcQG+bJOCaKWAlm479KJ6EAJc=;
        b=VbUJNHV1v/I38PKXDVIMoFye1oZVkkX7SJwJbvOOD7n4G2y8o79w3tA+/PDj1eFIAr
         hBmicIIU24JnBiwvffKhfRYNCEfdtJNfQDpOzvQIxdCjivxW5TSMA7Wa3nZ38oePzy2+
         qMKkH9Hhv9vX7wSW3HPT+pv1+ZtAMMwRYppY6oMhDuRDLM3NRGDeaAU2AHd9NulTvFuI
         4tbxl+rERpJJWSzspLh7RFLS9kNcBnhKkThxr+4aETQngE/KIIi4gJt+HmIyELS1PBJq
         ROXOe+lauiiaT/nNfUG6bmuTrlVOETx5UwWtgS6yFYd3FPJsqD7HNq1LEOU6AJXJQblM
         QIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bW+iYMzyJar5RkTMPGCcQG+bJOCaKWAlm479KJ6EAJc=;
        b=S+OdGefgcQDfus8KmjlJkayey1xj4kvh+gsPyVjugBijOQo6eXYs0K+cZC0QbIfcD7
         ATY21iXL+V7Cfy7mpqW5IG94ZeRvl8AgHTjV+HDAQQ16r7akYpu0bCrkrVhFPM+LuILz
         6ZeiWXD6xTSey/66BgBVhaPcL/eI9N8w7piXHWjuLGSSbl884i3OWkP3RjEkfMzmniu6
         iF8LCWJvxuB2Di9Q61ZoPCsOFNrJIXF4FqqkJ9ilf/W9562TBJmnOnxUHLtIEC+oleGf
         BOooB+jXZwpix2f2wQiaB6TjKWI5JqbDfnqUMbvtrgaBq3ZmOCJdXkmqlzwj6iaekEyW
         d2bA==
X-Gm-Message-State: APjAAAWbVLYja163cXsIsh9Sqn+pNjZkZTs1rm83c9I9UJAnAtemPsAh
        rPOyP5tSTpBNjeQI0PJN3fbloQ+utrVkj5UwsAht2w==
X-Google-Smtp-Source: APXvYqzYSYuKezAl7YpUgPSRKQPA6H2KEbg8/UlKlfYHOFR01Pivkt2lcBRDlUu5Mxcw6HJtVeDKxsfdhfFE+UFLaRQ=
X-Received: by 2002:a05:6830:1d7b:: with SMTP id l27mr15490059oti.251.1579534853838;
 Mon, 20 Jan 2020 07:40:53 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com> <CACT4Y+bnRoKinPopVqyxj4av6_xa_OUN0wwnidpO3dX3iYq_gg@mail.gmail.com>
 <CACT4Y+YuTT6kZ-AkgU0c1o09qmQdFWr4_Sds4jaDg-Va6g6jkA@mail.gmail.com> <CACT4Y+acrXkA-ixjQXqNf1EC=fpgTWf3Rcevxxon0DfrPdD-UQ@mail.gmail.com>
In-Reply-To: <CACT4Y+acrXkA-ixjQXqNf1EC=fpgTWf3Rcevxxon0DfrPdD-UQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jan 2020 16:40:42 +0100
Message-ID: <CANpmjNNcXUF-=Y-hmry9-xEoNpJd0WH+fOcJJM6kv2eRm5v-kg@mail.gmail.com>
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

On Mon, 20 Jan 2020 at 16:09, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Jan 20, 2020 at 3:58 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Mon, Jan 20, 2020 at 3:45 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Mon, Jan 20, 2020 at 3:19 PM Marco Elver <elver@google.com> wrote:
> > > >
> > > > This adds instrumented.h, which provides generic wrappers for memory
> > > > access instrumentation that the compiler cannot emit for various
> > > > sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> > > > future this will also include KMSAN instrumentation.
> > > >
> > > > Note that, copy_{to,from}_user require special instrumentation,
> > > > providing hooks before and after the access, since we may need to know
> > > > the actual bytes accessed (currently this is relevant for KCSAN, and is
> > > > also relevant in future for KMSAN).
> > > >
> > > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > ---
> > > >  include/linux/instrumented.h | 153 +++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 153 insertions(+)
> > > >  create mode 100644 include/linux/instrumented.h
> > > >
> > > > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > > > new file mode 100644
> > > > index 000000000000..9f83c8520223
> > > > --- /dev/null
> > > > +++ b/include/linux/instrumented.h
> > > > @@ -0,0 +1,153 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +
> > > > +/*
> > > > + * This header provides generic wrappers for memory access instrumentation that
> > > > + * the compiler cannot emit for: KASAN, KCSAN.
> > > > + */
> > > > +#ifndef _LINUX_INSTRUMENTED_H
> > > > +#define _LINUX_INSTRUMENTED_H
> > > > +
> > > > +#include <linux/compiler.h>
> > > > +#include <linux/kasan-checks.h>
> > > > +#include <linux/kcsan-checks.h>
> > > > +#include <linux/types.h>
> > > > +
> > > > +/**
> > > > + * instrument_read - instrument regular read access
> > > > + *
> > > > + * Instrument a regular read access. The instrumentation should be inserted
> > > > + * before the actual read happens.
> > > > + *
> > > > + * @ptr address of access
> > > > + * @size size of access
> > > > + */
> > >
> > > Based on offline discussion, that's what we add for KMSAN:
> > >
> > > > +static __always_inline void instrument_read(const volatile void *v, size_t size)
> > > > +{
> > > > +       kasan_check_read(v, size);
> > > > +       kcsan_check_read(v, size);
> > >
> > > KMSAN: nothing
> >
> > KMSAN also has instrumentation in
> > copy_to_user_page/copy_from_user_page. Do we need to do anything for
> > KASAN/KCSAN for these functions?

copy_to_user_page/copy_from_user_page can be instrumented with
instrument_copy_{to,from}_user_. I prefer keeping this series with no
functional change intended for KASAN at least.

> There is also copy_user_highpage.
>
> And ioread/write8/16/32_rep: do we need any instrumentation there. It
> seems we want both KSAN and KCSAN too. One may argue that KCSAN
> instrumentation there is to super critical at this point, but KASAN
> instrumentation is important, if anything to prevent silent memory
> corruptions. How do we instrument there? I don't see how it maps to
> any of the existing instrumentation functions.

These should be able to use the regular instrument_{read,write}. I
prefer keeping this series with no functional change intended for
KASAN at least.

> There is also kmsan_check_skb/kmsan_handle_dma/kmsan_handle_urb that
> does not seem to map to any of the instrumentation functions.

For now, I would rather that there are some one-off special
instrumentation, like for KMSAN. Coming up with a unified interface
here that, without the use-cases even settled, seems hard to justify.
Once instrumentation for these have settled, unifying the interface
would have better justification.

This patch series is merely supposed to introduce instrumented.h and
replace the kasan_checks (also implicitly introducing kcsan_checks
there), however, with no further functional change intended.

I propose that adding entirely new instrumentation for both KASAN and
KCSAN, we should send a separate patch-series.

Thanks,
-- Marco
