Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E0B142F3C
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2020 17:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgATQG3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jan 2020 11:06:29 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35819 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgATQG3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 11:06:29 -0500
Received: by mail-qk1-f196.google.com with SMTP id z76so30569684qka.2
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 08:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKBXxvKIRJE9r95Oq/vyPWMrKks8UEDi+Qo4dUocXJw=;
        b=Baf6RJnN+FgpGw0uph9xwLD0Y+xAcJSaSvv3RdARcDa7LNpveANlU1k6FDswjvy2Xc
         LObElRWDHMKUj3ZjRSNTBeO/htrBIYiKHweFN5P4tGQq8ToBhQbvCWcvJrSKxEPS3cBd
         oHUw3dHvbBeOVXV8JvEvvJHoJixZ5NHOGHvztKvlXrnUFBej3ua1JqsCjxG+qkttVE8F
         iRT1A16DFSmFPRw9dEtVOy/TAHOtJc7+TtiB8sAHFVcUtWX/WqYyo/TcgEJcEDcmRV2R
         Rz0lHHDuPohMF0E/czlHX+sLN/V8zBqp2azUpf0GHBEpP5dOVwAoA58Zmf9LD/Oro79O
         wE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKBXxvKIRJE9r95Oq/vyPWMrKks8UEDi+Qo4dUocXJw=;
        b=Ivf7ubcx9fcHrjh7MXCHeUpJsDMKEY+iXbRNiTRtYVujoxDT/oT2OpE+JiTqcbVA/r
         dW6sTdXx38wEBkCr+mJ4W4J9XyuoQz1d1Dc7sRMU0+yA1NHqhm6FSbwPSQI5Cj58DJ3T
         AUK/cFkbkO56brNr/LKRNAsjOaDZ9lgk/+yolJrlSZUBNvrL5gz8I9oG3VBeSOS+8ySt
         31erp0o/6rLSkhJRdRuNnxeis3kdkENB8tGasOtFKb3csgUF9tempOL5O6Cj7xf0O6Ge
         9O+Ezs2rpUAnCyHljWRjvP53U0tUSOuspQZkwIqHGcQdgM4ikt3k0WZnWsSDBO37XBny
         C8/g==
X-Gm-Message-State: APjAAAV2fH88aZDz4vdNeDw5aX5YbCs+V4z3nGYy3jOfkOQInCMUzc8z
        qZiLpJPulATMBfyEjdAWaU5MysDcNfdaJ42diiASyA==
X-Google-Smtp-Source: APXvYqwT5+NGklKeJW9N17LjaUMueBSxha4MJyQJj2jm+eal1mEy4e4CAbkxKeRN2PB93VKB3+yirSo4Y26EHFlBDZ8=
X-Received: by 2002:a05:620a:1136:: with SMTP id p22mr240817qkk.8.1579536388045;
 Mon, 20 Jan 2020 08:06:28 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com> <CACT4Y+bnRoKinPopVqyxj4av6_xa_OUN0wwnidpO3dX3iYq_gg@mail.gmail.com>
 <CACT4Y+YuTT6kZ-AkgU0c1o09qmQdFWr4_Sds4jaDg-Va6g6jkA@mail.gmail.com>
 <CACT4Y+acrXkA-ixjQXqNf1EC=fpgTWf3Rcevxxon0DfrPdD-UQ@mail.gmail.com> <CANpmjNNcXUF-=Y-hmry9-xEoNpJd0WH+fOcJJM6kv2eRm5v-kg@mail.gmail.com>
In-Reply-To: <CANpmjNNcXUF-=Y-hmry9-xEoNpJd0WH+fOcJJM6kv2eRm5v-kg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 Jan 2020 17:06:16 +0100
Message-ID: <CACT4Y+bD3cNxfaWOuhHz338MoVoaHpw-E8+b7v6mo_ir2KD46Q@mail.gmail.com>
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

On Mon, Jan 20, 2020 at 4:40 PM Marco Elver <elver@google.com> wrote:
> > > > > This adds instrumented.h, which provides generic wrappers for memory
> > > > > access instrumentation that the compiler cannot emit for various
> > > > > sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> > > > > future this will also include KMSAN instrumentation.
> > > > >
> > > > > Note that, copy_{to,from}_user require special instrumentation,
> > > > > providing hooks before and after the access, since we may need to know
> > > > > the actual bytes accessed (currently this is relevant for KCSAN, and is
> > > > > also relevant in future for KMSAN).
> > > > >
> > > > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > > ---
> > > > >  include/linux/instrumented.h | 153 +++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 153 insertions(+)
> > > > >  create mode 100644 include/linux/instrumented.h
> > > > >
> > > > > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > > > > new file mode 100644
> > > > > index 000000000000..9f83c8520223
> > > > > --- /dev/null
> > > > > +++ b/include/linux/instrumented.h
> > > > > @@ -0,0 +1,153 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > +
> > > > > +/*
> > > > > + * This header provides generic wrappers for memory access instrumentation that
> > > > > + * the compiler cannot emit for: KASAN, KCSAN.
> > > > > + */
> > > > > +#ifndef _LINUX_INSTRUMENTED_H
> > > > > +#define _LINUX_INSTRUMENTED_H
> > > > > +
> > > > > +#include <linux/compiler.h>
> > > > > +#include <linux/kasan-checks.h>
> > > > > +#include <linux/kcsan-checks.h>
> > > > > +#include <linux/types.h>
> > > > > +
> > > > > +/**
> > > > > + * instrument_read - instrument regular read access
> > > > > + *
> > > > > + * Instrument a regular read access. The instrumentation should be inserted
> > > > > + * before the actual read happens.
> > > > > + *
> > > > > + * @ptr address of access
> > > > > + * @size size of access
> > > > > + */
> > > >
> > > > Based on offline discussion, that's what we add for KMSAN:
> > > >
> > > > > +static __always_inline void instrument_read(const volatile void *v, size_t size)
> > > > > +{
> > > > > +       kasan_check_read(v, size);
> > > > > +       kcsan_check_read(v, size);
> > > >
> > > > KMSAN: nothing
> > >
> > > KMSAN also has instrumentation in
> > > copy_to_user_page/copy_from_user_page. Do we need to do anything for
> > > KASAN/KCSAN for these functions?
>
> copy_to_user_page/copy_from_user_page can be instrumented with
> instrument_copy_{to,from}_user_. I prefer keeping this series with no
> functional change intended for KASAN at least.
>
> > There is also copy_user_highpage.
> >
> > And ioread/write8/16/32_rep: do we need any instrumentation there. It
> > seems we want both KSAN and KCSAN too. One may argue that KCSAN
> > instrumentation there is to super critical at this point, but KASAN
> > instrumentation is important, if anything to prevent silent memory
> > corruptions. How do we instrument there? I don't see how it maps to
> > any of the existing instrumentation functions.
>
> These should be able to use the regular instrument_{read,write}. I
> prefer keeping this series with no functional change intended for
> KASAN at least.

instrument_{read,write} will not contain any KMSAN instrumentation,
which means we will effectively remove KMSAN instrumentation, which is
weird because we instrumented these functions because of KMSAN in the
first place...

> > There is also kmsan_check_skb/kmsan_handle_dma/kmsan_handle_urb that
> > does not seem to map to any of the instrumentation functions.
>
> For now, I would rather that there are some one-off special
> instrumentation, like for KMSAN. Coming up with a unified interface
> here that, without the use-cases even settled, seems hard to justify.
> Once instrumentation for these have settled, unifying the interface
> would have better justification.

I would assume they may also require an annotation that checks the
memory region under all 3 tools and we don't have such annotation
(same as the previous case and effectively copy_to_user). I would
expect such annotation will be used in more places once we start
looking for more opportunities.

> This patch series is merely supposed to introduce instrumented.h and
> replace the kasan_checks (also implicitly introducing kcsan_checks
> there), however, with no further functional change intended.
>
> I propose that adding entirely new instrumentation for both KASAN and
> KCSAN, we should send a separate patch-series.
>
> Thanks,
> -- Marco
