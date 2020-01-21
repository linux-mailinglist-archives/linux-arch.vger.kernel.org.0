Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA55143D8D
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 14:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAUNB1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 08:01:27 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:35155 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUNB1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 08:01:27 -0500
Received: by mail-qv1-f67.google.com with SMTP id u10so1379340qvi.2
        for <linux-arch@vger.kernel.org>; Tue, 21 Jan 2020 05:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z9x75RFBujs35vp0kR9dshO1qIssZRWX2b+4uOymJ80=;
        b=FCqcb4ygTmSBXXYx4QWOeURFbw2FrZIkV2jK+GI0RDrqM0YVXN0Uovq1h2on15KGzE
         3cKrBBsI+Kb089CmH9jgl7IzkYUNIH/bYmArxTDum6UnYykFFVJiAtvAfGsqaNpaREI0
         K5BJrYvIgf897fvawh7hR8+yNaPTiqWJJvpAcYeWAi64Mjmq0hg+GdYl6o9xUp7/JRCN
         DRG6+FleFXdEKjYuWJDIKV8lnhL77igKISKBXzpJ8k5nFopWlnDSEc8RpjJld0Cfdmt1
         5MIKMSLhqrrOf7ZVxjw1CoeTn4SUIJ84jhadU742gu2A2hBSuQMe1xX8Z3rTfJJhOnoK
         wwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z9x75RFBujs35vp0kR9dshO1qIssZRWX2b+4uOymJ80=;
        b=eFuoH52w1AxvFpQDS6no76FRCjtivmJAwSzGtecqWK3pGdhIVU645bx8NvWW07oiXw
         IScSgOLiBcpTXUw5L1o9k4/4cuF61XOr3tJCtPOt24YHsU/Jg6FEKYc8GGnvcsS5JHCm
         tkSD8/IpzmA+YJ/p3IraUIvQRoh+jWswsyM0S1AJgs/Ak9HdB2Jyv5mh/xMera9qkOrb
         1wSket6Jvg21DSaNJBWahgYQ3+36R06RG8d6xr6lKK6I5Qmiy9W0x49LtNrsgp9PxOHR
         tDK0cos9lxe+glfldsrHPXJTZJW3nosVGJqPpPQbrgZr3iNarqQAeIge+bIulAE8e1pE
         XF2A==
X-Gm-Message-State: APjAAAW+jyQes4zFH3qWLIKXbN246LSfBWSWTDnVDDzmJlnLAug/2H/r
        203fhvPGbchrTP4i0vbwbxTDL1tDi03W08HBqykBmg==
X-Google-Smtp-Source: APXvYqzTs36y76+Ax1v7ZHC0Ws6VwBO4HXtUDbFUhZveQnJnQSlEBxHmvNMaydYMvKVFdtV7j0xnLpmxsRnTAiuAAKA=
X-Received: by 2002:ad4:5a53:: with SMTP id ej19mr4652000qvb.34.1579611685771;
 Tue, 21 Jan 2020 05:01:25 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com> <CACT4Y+bnRoKinPopVqyxj4av6_xa_OUN0wwnidpO3dX3iYq_gg@mail.gmail.com>
In-Reply-To: <CACT4Y+bnRoKinPopVqyxj4av6_xa_OUN0wwnidpO3dX3iYq_gg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 21 Jan 2020 14:01:13 +0100
Message-ID: <CACT4Y+bjAn0g980ZCxCn4MkgCsg7KrA69CExCeJZ63eRON5fXw@mail.gmail.com>
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

On Mon, Jan 20, 2020 at 3:45 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Jan 20, 2020 at 3:19 PM Marco Elver <elver@google.com> wrote:
> >
> > This adds instrumented.h, which provides generic wrappers for memory
> > access instrumentation that the compiler cannot emit for various
> > sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> > future this will also include KMSAN instrumentation.
> >
> > Note that, copy_{to,from}_user require special instrumentation,
> > providing hooks before and after the access, since we may need to know
> > the actual bytes accessed (currently this is relevant for KCSAN, and is
> > also relevant in future for KMSAN).
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  include/linux/instrumented.h | 153 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 153 insertions(+)
> >  create mode 100644 include/linux/instrumented.h
> >
> > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > new file mode 100644
> > index 000000000000..9f83c8520223
> > --- /dev/null
> > +++ b/include/linux/instrumented.h
> > @@ -0,0 +1,153 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * This header provides generic wrappers for memory access instrumentation that
> > + * the compiler cannot emit for: KASAN, KCSAN.
> > + */
> > +#ifndef _LINUX_INSTRUMENTED_H
> > +#define _LINUX_INSTRUMENTED_H
> > +
> > +#include <linux/compiler.h>
> > +#include <linux/kasan-checks.h>
> > +#include <linux/kcsan-checks.h>
> > +#include <linux/types.h>
> > +
> > +/**
> > + * instrument_read - instrument regular read access
> > + *
> > + * Instrument a regular read access. The instrumentation should be inserted
> > + * before the actual read happens.
> > + *
> > + * @ptr address of access
> > + * @size size of access
> > + */
>
> Based on offline discussion, that's what we add for KMSAN:
>
> > +static __always_inline void instrument_read(const volatile void *v, size_t size)
> > +{
> > +       kasan_check_read(v, size);
> > +       kcsan_check_read(v, size);
>
> KMSAN: nothing
>
> > +}
> > +
> > +/**
> > + * instrument_write - instrument regular write access
> > + *
> > + * Instrument a regular write access. The instrumentation should be inserted
> > + * before the actual write happens.
> > + *
> > + * @ptr address of access
> > + * @size size of access
> > + */
> > +static __always_inline void instrument_write(const volatile void *v, size_t size)
> > +{
> > +       kasan_check_write(v, size);
> > +       kcsan_check_write(v, size);
>
> KMSAN: nothing
>
> > +}
> > +
> > +/**
> > + * instrument_atomic_read - instrument atomic read access
> > + *
> > + * Instrument an atomic read access. The instrumentation should be inserted
> > + * before the actual read happens.
> > + *
> > + * @ptr address of access
> > + * @size size of access
> > + */
> > +static __always_inline void instrument_atomic_read(const volatile void *v, size_t size)
> > +{
> > +       kasan_check_read(v, size);
> > +       kcsan_check_atomic_read(v, size);
>
> KMSAN: nothing
>
> > +}
> > +
> > +/**
> > + * instrument_atomic_write - instrument atomic write access
> > + *
> > + * Instrument an atomic write access. The instrumentation should be inserted
> > + * before the actual write happens.
> > + *
> > + * @ptr address of access
> > + * @size size of access
> > + */
> > +static __always_inline void instrument_atomic_write(const volatile void *v, size_t size)
> > +{
> > +       kasan_check_write(v, size);
> > +       kcsan_check_atomic_write(v, size);
>
> KMSAN: nothing
>
> > +}
> > +
> > +/**
> > + * instrument_copy_to_user_pre - instrument reads of copy_to_user
> > + *
> > + * Instrument reads from kernel memory, that are due to copy_to_user (and
> > + * variants).
> > + *
> > + * The instrumentation must be inserted before the accesses. At this point the
> > + * actual number of bytes accessed is not yet known.
> > + *
> > + * @dst destination address
> > + * @size maximum access size
> > + */
> > +static __always_inline void
> > +instrument_copy_to_user_pre(const volatile void *src, size_t size)
> > +{
> > +       /* Check before, to warn before potential memory corruption. */
> > +       kasan_check_read(src, size);
>
> KMSAN: check that (src,size) is initialized
>
> > +}
> > +
> > +/**
> > + * instrument_copy_to_user_post - instrument reads of copy_to_user
> > + *
> > + * Instrument reads from kernel memory, that are due to copy_to_user (and
> > + * variants).
> > + *
> > + * The instrumentation must be inserted after the accesses. At this point the
> > + * actual number of bytes accessed should be known.
> > + *
> > + * @dst destination address
> > + * @size maximum access size
> > + * @left number of bytes left that were not copied
> > + */
> > +static __always_inline void
> > +instrument_copy_to_user_post(const volatile void *src, size_t size, size_t left)
> > +{
> > +       /* Check after, to avoid false positive if memory was not accessed. */
> > +       kcsan_check_read(src, size - left);
>
> KMSAN: nothing

One detail I noticed for KMSAN is that kmsan_copy_to_user has a
special case when @to address is in kernel-space (compat syscalls
doing tricky things), in that case it only copies metadata. We can't
handle this with existing annotations.


 * actually copied to ensure there was no information leak. If @to belongs to
 * the kernel space (which is possible for compat syscalls), KMSAN just copies
 * the metadata.
 */
void kmsan_copy_to_user(const void *to, const void *from, size_t
to_copy, size_t left);


> > +}
> > +
> > +/**
> > + * instrument_copy_from_user_pre - instrument writes of copy_from_user
> > + *
> > + * Instrument writes to kernel memory, that are due to copy_from_user (and
> > + * variants).
> > + *
> > + * The instrumentation must be inserted before the accesses. At this point the
> > + * actual number of bytes accessed is not yet known.
> > + *
> > + * @dst destination address
> > + * @size maximum access size
> > + */
> > +static __always_inline void
> > +instrument_copy_from_user_pre(const volatile void *dst, size_t size)
> > +{
> > +       /* Check before, to warn before potential memory corruption. */
> > +       kasan_check_write(dst, size);
>
> KMSAN: nothing
>
> > +}
> > +
> > +/**
> > + * instrument_copy_from_user_post - instrument writes of copy_from_user
> > + *
> > + * Instrument writes to kernel memory, that are due to copy_from_user (and
> > + * variants).
> > + *
> > + * The instrumentation must be inserted after the accesses. At this point the
> > + * actual number of bytes accessed should be known.
> > + *
> > + * @dst destination address
> > + * @size maximum access size
> > + * @left number of bytes left that were not copied
> > + */
> > +static __always_inline void
> > +instrument_copy_from_user_post(const volatile void *dst, size_t size, size_t left)
> > +{
> > +       /* Check after, to avoid false positive if memory was not accessed. */
> > +       kcsan_check_write(dst, size - left);
>
> KMSAN: mark (dst, size-left) as initialized
>
> > +}
> > +
> > +#endif /* _LINUX_INSTRUMENTED_H */
> > --
> > 2.25.0.341.g760bfbb309-goog
> >
