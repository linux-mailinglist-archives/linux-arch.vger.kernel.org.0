Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB55142DF5
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2020 15:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgATOqK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jan 2020 09:46:10 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39594 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgATOqK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 09:46:10 -0500
Received: by mail-qk1-f195.google.com with SMTP id c16so30295419qko.6
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 06:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3mOQDsNsMEMdcvwZ9EOVAmI2Aq9GLe7RdHuUtWY0eg0=;
        b=smPgCG/VvbG6vsWCWbx8s/aWjNSEuYQgNMoRmlbZ2oDkrLDe3fhXY6npZAVyDCnBZV
         bm1+02gHiSMcHjlL7We8IsbAtwj6Qdy3vD7NYYcfdGUBQyTSzf6RZbpedBYcYEO38RvL
         g0yE2wlGkr520/pJ0nUZpb1iPk5PjPUhbwATseqwXNpnAazq6FlP7BsggOWfGkPZNK8E
         M9/YmFC94YrZvGcwsM11tpKMtd8Pt9IIuZf5y2XQSC4srMK/RKflwNsb2X67O49J/NOo
         Ok04MsFySXa5vIufvVBHtdU3K+0QgO3NTytYBWQuDmCkZT7Y69a3Vdj2lUfqsj7qAKpl
         +3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3mOQDsNsMEMdcvwZ9EOVAmI2Aq9GLe7RdHuUtWY0eg0=;
        b=rXV4VOr3BcAy3jq9sXFEraxHoh82Li+5KK7fkCes+RocnN1hpGY+l8bpDvfvVrHVgG
         iKvM5IG/uk9iexNs1yKcQPbzA0/spCUcp3ibuEWjwJ1B1l8fygxF6DjZ0H9idUfSci1w
         NLB5+mcR6kwp1zmPJ5K1Lp9Chd2iGVw2eEuGwRt7GO0rEDasbhqOwP2rdgn6GlQeDo6b
         ipshNkBJBOdBS+/hMbzQ2uX+KTex3nTkFd4o6ukmwR3F98w9poNbcD6BdtJcaLWCHRT5
         x6S6PWorPiyHAXplTsLkwXE7zclDzAvro77nPmMlCVJzzbTYns+ax8zGyzre0CMoAhio
         Jc6A==
X-Gm-Message-State: APjAAAVNpiICMqxoVQo08tlihhAFNP+wjMKHXzAJeX22N1BOFK+yJl51
        IA1r8uK+4duR+oaKWXBwBvG+fx2zp3i7+di2C3LF2Q==
X-Google-Smtp-Source: APXvYqwYDBXJpwgqX0FiWsgunqp1YsK982AUQrmnhejICBhDZWA+0ZTMGV+eLa9hMePuqmCZqqFSVD6WxjPczxXi1Pw=
X-Received: by 2002:a37:5841:: with SMTP id m62mr50539398qkb.256.1579531569022;
 Mon, 20 Jan 2020 06:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com>
In-Reply-To: <20200120141927.114373-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 Jan 2020 15:45:57 +0100
Message-ID: <CACT4Y+bnRoKinPopVqyxj4av6_xa_OUN0wwnidpO3dX3iYq_gg@mail.gmail.com>
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
>
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

Based on offline discussion, that's what we add for KMSAN:

> +static __always_inline void instrument_read(const volatile void *v, size_t size)
> +{
> +       kasan_check_read(v, size);
> +       kcsan_check_read(v, size);

KMSAN: nothing

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

KMSAN: nothing

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

KMSAN: nothing

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

KMSAN: nothing

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

KMSAN: check that (src,size) is initialized

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

KMSAN: nothing

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

KMSAN: nothing

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

KMSAN: mark (dst, size-left) as initialized

> +}
> +
> +#endif /* _LINUX_INSTRUMENTED_H */
> --
> 2.25.0.341.g760bfbb309-goog
>
