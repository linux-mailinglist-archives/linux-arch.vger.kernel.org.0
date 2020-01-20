Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3564142DA6
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2020 15:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgATOe7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jan 2020 09:34:59 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39431 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATOe7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 09:34:59 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so27803485qtm.6
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 06:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2RrHqMcOCPUU5FqgQCKkNsIxL0qLg6y6IPiTMnVNNc4=;
        b=FJupk/tj7yTKWcarnSBRVLVipSlAptjaPAxN590dDHdtbsSBOPi5EcsIyiV4eARlw+
         MnbU0EKc8wcxm9LKJ+wdTVg5A0cHrKZlxZlUZc9sR5wqtbDEJLQT+yFQgp+bqhME7RN5
         79EFT7eBj20tTY02xSIMOzH7BA5hycjofagNkNxzVhoib5x4Pn//pVsoWezVfHjo3sDj
         tb1ICwzkVfmzOdUEdpysZ6znpiS9dFxM2E6ChruM1Khoxb6VfNuhAzO9Q88hntytVb/S
         KAH9vVKeex/Z7zPWbtB6F2efn0IYc+vyFqt7VdC4CvQdnjXPjOxiiDc1L9iz2T0zVIYp
         ZecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2RrHqMcOCPUU5FqgQCKkNsIxL0qLg6y6IPiTMnVNNc4=;
        b=SujcnE7nxKrVy49FpqoON8oCyMqp7XCd9eqHc2YT7mCMxp1sqWVuqnxIjIghuOCOUI
         AvPUxuf/ZWzEHwnNmhK3SZoy2HYitwEHPlxvY2oWS1/dBnQ9G2mFjAa3M7/I8BWDrpPA
         NgYU0IHot+yqgjEz9lpnDFUCjjSAW5Ti5I4T3+rFT4YANfaIL+X3ljbVavXRX1+fygVv
         lnYcBdkPFWSHr43URrkwHrXGLfHKHyuRavsYnOEq6hK8aYa493ZxxK03AcHCw80Rh2Ws
         jlA2ez/V8GquMiS3r6l7MCk1Ksa9EuPnPD3p4AC7UuTEeUHWJ3pdKd9kXDctaqiIx3+v
         hHBg==
X-Gm-Message-State: APjAAAV0uJ+4/DmPMN/+JYS9ZVhdOLwp+Zvp/I4UJkIUtPfmQlVPrk2v
        HHFW+W7lrES4ao4bjYdpPq/phCK4/a6se+hHQUhRyg==
X-Google-Smtp-Source: APXvYqzAdq0rpDxVaGskGGRnali0alMaMTOb8ATqh5U3KjnsnpDJR+/GvMZerxqWmQSNanb04s5bbp1HzDTeqGi5Nhc=
X-Received: by 2002:aed:2465:: with SMTP id s34mr20721986qtc.158.1579530897534;
 Mon, 20 Jan 2020 06:34:57 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com>
In-Reply-To: <20200120141927.114373-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 Jan 2020 15:34:45 +0100
Message-ID: <CACT4Y+ajkjCzv2adupX9oVKjNppn-AKsGkGqLMExwjHXG37Lxw@mail.gmail.com>
Subject: Re: [PATCH 1/5] include/linux: Add instrumented.h infrastructure
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, Andrey Konovalov <andreyknvl@google.com>,
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

On Mon, Jan 20, 2020 at 3:19 PM Marco Elver <elver@google.com> wrote:
>
> This adds instrumented.h, which provides generic wrappers for memory
> access instrumentation that the compiler cannot emit for various
> sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> future this will also include KMSAN instrumentation.
>
> Note that, copy_{to,from}_user require special instrumentation,
> providing hooks before and after the access, since we may need to know
> the actual bytes accessed (currently this is relevant for KCSAN, and is
> also relevant in future for KMSAN).

How will KMSAN instrumentation look like?

> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/instrumented.h | 153 +++++++++++++++++++++++++++++++++++
>  1 file changed, 153 insertions(+)
>  create mode 100644 include/linux/instrumented.h
>
> diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> new file mode 100644
> index 000000000000..9f83c8520223
> --- /dev/null
> +++ b/include/linux/instrumented.h
> @@ -0,0 +1,153 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * This header provides generic wrappers for memory access instrumentation that
> + * the compiler cannot emit for: KASAN, KCSAN.
> + */
> +#ifndef _LINUX_INSTRUMENTED_H
> +#define _LINUX_INSTRUMENTED_H
> +
> +#include <linux/compiler.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
> +#include <linux/types.h>
> +
> +/**
> + * instrument_read - instrument regular read access
> + *
> + * Instrument a regular read access. The instrumentation should be inserted
> + * before the actual read happens.
> + *
> + * @ptr address of access
> + * @size size of access
> + */
> +static __always_inline void instrument_read(const volatile void *v, size_t size)
> +{
> +       kasan_check_read(v, size);
> +       kcsan_check_read(v, size);
> +}
> +
> +/**
> + * instrument_write - instrument regular write access
> + *
> + * Instrument a regular write access. The instrumentation should be inserted
> + * before the actual write happens.
> + *
> + * @ptr address of access
> + * @size size of access
> + */
> +static __always_inline void instrument_write(const volatile void *v, size_t size)
> +{
> +       kasan_check_write(v, size);
> +       kcsan_check_write(v, size);
> +}
> +
> +/**
> + * instrument_atomic_read - instrument atomic read access
> + *
> + * Instrument an atomic read access. The instrumentation should be inserted
> + * before the actual read happens.
> + *
> + * @ptr address of access
> + * @size size of access
> + */
> +static __always_inline void instrument_atomic_read(const volatile void *v, size_t size)
> +{
> +       kasan_check_read(v, size);
> +       kcsan_check_atomic_read(v, size);
> +}
> +
> +/**
> + * instrument_atomic_write - instrument atomic write access
> + *
> + * Instrument an atomic write access. The instrumentation should be inserted
> + * before the actual write happens.
> + *
> + * @ptr address of access
> + * @size size of access
> + */
> +static __always_inline void instrument_atomic_write(const volatile void *v, size_t size)
> +{
> +       kasan_check_write(v, size);
> +       kcsan_check_atomic_write(v, size);
> +}
> +
> +/**
> + * instrument_copy_to_user_pre - instrument reads of copy_to_user
> + *
> + * Instrument reads from kernel memory, that are due to copy_to_user (and
> + * variants).
> + *
> + * The instrumentation must be inserted before the accesses. At this point the
> + * actual number of bytes accessed is not yet known.
> + *
> + * @dst destination address
> + * @size maximum access size
> + */
> +static __always_inline void
> +instrument_copy_to_user_pre(const volatile void *src, size_t size)
> +{
> +       /* Check before, to warn before potential memory corruption. */
> +       kasan_check_read(src, size);
> +}
> +
> +/**
> + * instrument_copy_to_user_post - instrument reads of copy_to_user
> + *
> + * Instrument reads from kernel memory, that are due to copy_to_user (and
> + * variants).
> + *
> + * The instrumentation must be inserted after the accesses. At this point the
> + * actual number of bytes accessed should be known.
> + *
> + * @dst destination address
> + * @size maximum access size
> + * @left number of bytes left that were not copied
> + */
> +static __always_inline void
> +instrument_copy_to_user_post(const volatile void *src, size_t size, size_t left)
> +{
> +       /* Check after, to avoid false positive if memory was not accessed. */
> +       kcsan_check_read(src, size - left);

Why don't we check the full range?
Kernel intending to copy something racy to user already looks like a
bug to me, even if user-space has that page unmapped. User-space can
always make the full range succeed. What am I missing?


> +}
> +
> +/**
> + * instrument_copy_from_user_pre - instrument writes of copy_from_user
> + *
> + * Instrument writes to kernel memory, that are due to copy_from_user (and
> + * variants).
> + *
> + * The instrumentation must be inserted before the accesses. At this point the
> + * actual number of bytes accessed is not yet known.
> + *
> + * @dst destination address
> + * @size maximum access size
> + */
> +static __always_inline void
> +instrument_copy_from_user_pre(const volatile void *dst, size_t size)
> +{
> +       /* Check before, to warn before potential memory corruption. */
> +       kasan_check_write(dst, size);
> +}
> +
> +/**
> + * instrument_copy_from_user_post - instrument writes of copy_from_user
> + *
> + * Instrument writes to kernel memory, that are due to copy_from_user (and
> + * variants).
> + *
> + * The instrumentation must be inserted after the accesses. At this point the
> + * actual number of bytes accessed should be known.
> + *
> + * @dst destination address
> + * @size maximum access size
> + * @left number of bytes left that were not copied
> + */
> +static __always_inline void
> +instrument_copy_from_user_post(const volatile void *dst, size_t size, size_t left)
> +{
> +       /* Check after, to avoid false positive if memory was not accessed. */
> +       kcsan_check_write(dst, size - left);
> +}
> +
> +#endif /* _LINUX_INSTRUMENTED_H */
> --
> 2.25.0.341.g760bfbb309-goog
>
