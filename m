Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51D4D142E51
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2020 16:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgATPF4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jan 2020 10:05:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40373 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbgATPF4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 10:05:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id w21so28906747otj.7
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 07:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=smLCZaIYcQF0/52Z19iYa5thG5yG//BBZdb/jdacqzg=;
        b=tojSwQu1bHYhbIog279hFH4kK/1efQmq3Nw5UqFpyhOHvgdGZIQwaKootMm732MoaR
         5uvPwP9TZbXXRqp2YYGWklkJjC1I7wBT5aHBrLDAysGHrTKeZXC4sO+3etTTIOHrkpTI
         q0hqHd/50k0CXZ9Y0L3+sebhGigshfjrvYhpcrBkYdcnm7/H9JZzGN4YusJQFW4a4vHY
         WJl0PVj/Dx2oSsTd1mOPgKK6CzhHZle3m0T5dhljPmXpV+blTBDtH7oao5wAKidwgKxI
         FhHPlmJ7dE2yq2Rc02bDoOhbJGPJcoPpiH6xBAQmFBEvk+AozgxVtu1+/n9vbxVA/CX1
         OAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=smLCZaIYcQF0/52Z19iYa5thG5yG//BBZdb/jdacqzg=;
        b=SMmI8UXAaKUOQ1/M97tTRYxtiC+2c59O33sXWAjodI1c+7QDFgLxc2Ea+9AjvY1Qzi
         DJTnjyGdxQM86xb4hDx8WHG5ae35QtGl+uW17iCBrSHbHlyHzeW0YS4v7gTlXzmdCHh8
         BtTomx3Qt9/bQtOhPs77/iTo/vTfJsavdU8cMqhzlXGQSjrcyeSNwMJYtUrWPYWDEYDw
         1uIRJEqj3u2OCaPEswTzeOJ3cQRtjfVUMAPB5DUnLijfx419TnjsAHjx7v2P1R1ut7r4
         rgAoopPNdQvEEzi+VaIfWIFJ0hpFvrIJnMCZY7SRqrFXIGqrT9BMxYL3lXWQn/+BXy2Q
         fYDA==
X-Gm-Message-State: APjAAAX9mE5kiQcENT7+1WeK+vzFpcrElkA4Mq/e1TfTAT4P0Xf8m5u0
        iC7QKacdmPKN7iDLjxxsC8Vpd1GBdw4X/1iOOhEfvw==
X-Google-Smtp-Source: APXvYqwz9M64ESVRwDt7JHftJjj3plesO1W/y3LCrXrSk8oCjrGQ/XZgT2g/2FVrI4NH9xp+JPV1btnfepl5wjcr37Y=
X-Received: by 2002:a9d:7410:: with SMTP id n16mr16771057otk.23.1579532754151;
 Mon, 20 Jan 2020 07:05:54 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com> <20200120141927.114373-5-elver@google.com>
 <CACT4Y+bUvoePVPV+BqU-cwhF6bR41_eaYkr9WLLMYi-2q11JjQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bUvoePVPV+BqU-cwhF6bR41_eaYkr9WLLMYi-2q11JjQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jan 2020 16:05:42 +0100
Message-ID: <CANpmjNMZpLfNKLOs7JVxP-S7oWbkvyg=bt=uYGU30bMZXYtUHA@mail.gmail.com>
Subject: Re: [PATCH 5/5] copy_to_user, copy_from_user: Use generic instrumented.h
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

On Mon, 20 Jan 2020 at 15:52, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Jan 20, 2020 at 3:19 PM Marco Elver <elver@google.com> wrote:
> >
> > This replaces the KASAN instrumentation with generic instrumentation,
> > implicitly adding KCSAN instrumentation support.
> >
> > For KASAN no functional change is intended.
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  include/linux/uaccess.h | 46 +++++++++++++++++++++++++++++------------
> >  lib/usercopy.c          | 14 ++++++++-----
> >  2 files changed, 42 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> > index 67f016010aad..d3f2d9a8cae3 100644
> > --- a/include/linux/uaccess.h
> > +++ b/include/linux/uaccess.h
> > @@ -2,9 +2,9 @@
> >  #ifndef __LINUX_UACCESS_H__
> >  #define __LINUX_UACCESS_H__
> >
> > +#include <linux/instrumented.h>
> >  #include <linux/sched.h>
> >  #include <linux/thread_info.h>
> > -#include <linux/kasan-checks.h>
> >
> >  #define uaccess_kernel() segment_eq(get_fs(), KERNEL_DS)
> >
> > @@ -58,18 +58,26 @@
> >  static __always_inline __must_check unsigned long
> >  __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
> >  {
> > -       kasan_check_write(to, n);
> > +       unsigned long res;
> > +
> >         check_object_size(to, n, false);
> > -       return raw_copy_from_user(to, from, n);
> > +       instrument_copy_from_user_pre(to, n);
> > +       res = raw_copy_from_user(to, from, n);
> > +       instrument_copy_from_user_post(to, n, res);
> > +       return res;
> >  }
>
> There is also something called strncpy_from_user() that has kasan
> instrumentation now:
> https://elixir.bootlin.com/linux/v5.5-rc6/source/lib/strncpy_from_user.c#L117

Yes, however, I think it's a special case for KASAN. The
implementation is already instrumented by the compiler. In the
original commit it says (1771c6e1a567e):

"Note: Unlike others strncpy_from_user() is written mostly in C and KASAN
    sees memory accesses in it.  However, it makes sense to add explicit
    check for all @count bytes that *potentially* could be written to the
    kernel."

I don't think we want unconditional double-instrumentation here. Let
me know if you think otherwise.

Thanks,
-- Marco

> >  static __always_inline __must_check unsigned long
> >  __copy_from_user(void *to, const void __user *from, unsigned long n)
> >  {
> > +       unsigned long res;
> > +
> >         might_fault();
> > -       kasan_check_write(to, n);
> >         check_object_size(to, n, false);
> > -       return raw_copy_from_user(to, from, n);
> > +       instrument_copy_from_user_pre(to, n);
> > +       res = raw_copy_from_user(to, from, n);
> > +       instrument_copy_from_user_post(to, n, res);
> > +       return res;
> >  }
> >
> >  /**
> > @@ -88,18 +96,26 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
> >  static __always_inline __must_check unsigned long
> >  __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
> >  {
> > -       kasan_check_read(from, n);
> > +       unsigned long res;
> > +
> >         check_object_size(from, n, true);
> > -       return raw_copy_to_user(to, from, n);
> > +       instrument_copy_to_user_pre(from, n);
> > +       res = raw_copy_to_user(to, from, n);
> > +       instrument_copy_to_user_post(from, n, res);
> > +       return res;
> >  }
> >
> >  static __always_inline __must_check unsigned long
> >  __copy_to_user(void __user *to, const void *from, unsigned long n)
> >  {
> > +       unsigned long res;
> > +
> >         might_fault();
> > -       kasan_check_read(from, n);
> >         check_object_size(from, n, true);
> > -       return raw_copy_to_user(to, from, n);
> > +       instrument_copy_to_user_pre(from, n);
> > +       res = raw_copy_to_user(to, from, n);
> > +       instrument_copy_to_user_post(from, n, res);
> > +       return res;
> >  }
> >
> >  #ifdef INLINE_COPY_FROM_USER
> > @@ -109,8 +125,9 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
> >         unsigned long res = n;
> >         might_fault();
> >         if (likely(access_ok(from, n))) {
> > -               kasan_check_write(to, n);
> > +               instrument_copy_from_user_pre(to, n);
> >                 res = raw_copy_from_user(to, from, n);
> > +               instrument_copy_from_user_post(to, n, res);
> >         }
> >         if (unlikely(res))
> >                 memset(to + (n - res), 0, res);
> > @@ -125,12 +142,15 @@ _copy_from_user(void *, const void __user *, unsigned long);
> >  static inline __must_check unsigned long
> >  _copy_to_user(void __user *to, const void *from, unsigned long n)
> >  {
> > +       unsigned long res = n;
> > +
> >         might_fault();
> >         if (access_ok(to, n)) {
> > -               kasan_check_read(from, n);
> > -               n = raw_copy_to_user(to, from, n);
> > +               instrument_copy_to_user_pre(from, n);
> > +               res = raw_copy_to_user(to, from, n);
> > +               instrument_copy_to_user_post(from, n, res);
> >         }
> > -       return n;
> > +       return res;
> >  }
> >  #else
> >  extern __must_check unsigned long
> > diff --git a/lib/usercopy.c b/lib/usercopy.c
> > index cbb4d9ec00f2..1c20d4423b86 100644
> > --- a/lib/usercopy.c
> > +++ b/lib/usercopy.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -#include <linux/uaccess.h>
> >  #include <linux/bitops.h>
> > +#include <linux/instrumented.h>
> > +#include <linux/uaccess.h>
> >
> >  /* out-of-line parts */
> >
> > @@ -10,8 +11,9 @@ unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n
> >         unsigned long res = n;
> >         might_fault();
> >         if (likely(access_ok(from, n))) {
> > -               kasan_check_write(to, n);
> > +               instrument_copy_from_user_pre(to, n);
> >                 res = raw_copy_from_user(to, from, n);
> > +               instrument_copy_from_user_post(to, n, res);
> >         }
> >         if (unlikely(res))
> >                 memset(to + (n - res), 0, res);
> > @@ -23,12 +25,14 @@ EXPORT_SYMBOL(_copy_from_user);
> >  #ifndef INLINE_COPY_TO_USER
> >  unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
> >  {
> > +       unsigned long res = n;
> >         might_fault();
> >         if (likely(access_ok(to, n))) {
> > -               kasan_check_read(from, n);
> > -               n = raw_copy_to_user(to, from, n);
> > +               instrument_copy_to_user_pre(from, n);
> > +               res = raw_copy_to_user(to, from, n);
> > +               instrument_copy_to_user_post(from, n, res);
> >         }
> > -       return n;
> > +       return res;
> >  }
> >  EXPORT_SYMBOL(_copy_to_user);
> >  #endif
> > --
> > 2.25.0.341.g760bfbb309-goog
> >
