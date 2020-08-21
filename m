Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8101D24D472
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 13:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgHULtX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 07:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbgHULrB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 07:47:01 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D789C061386
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 04:47:00 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 62so1060062qkj.7
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 04:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xlnXTlGn+73FaQqYEKMTIwjgsfte17lUDuLFeOhYJVs=;
        b=rcjTeFwXlW60HuBFAs6JyZDV+6ZWsjcxBzcIezje7rj/qz1/x/onwuueFTXxG0cBSU
         4xhHDtSZl7OsOY9RHeHjJl7LmEJUXrYmLwJwLnHYqYMKymo3pg1F4ONvtTfxIC8mS+k+
         1Hm2ZWBL9VftQZ0jqqmc8oaFgaMXaskbC9kQy2X8LjFhD7ZzuxK6i4WrIFfyRdQhYPb0
         uFCDtgtTJWBrCmz2YmEx0Y8u6QjUZWIkMOVb4DMcmHlBanLTfZSp786AY4YstfXA4BHM
         FulPrhF7LsS4lYpvBt0HvMk5L4t7SibR8K/NdaTl/kdA+5i9PrggLylLfV0nDqO1dC9I
         xFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xlnXTlGn+73FaQqYEKMTIwjgsfte17lUDuLFeOhYJVs=;
        b=rewYhnfBsXd/eyt9Trgus5jiXQHINT0utVW7uL7sGMe3bwGeSQnMsN/nRVtpTnGBeM
         F4wjtgDa8vGiVHEBbyr2ItRZAVXIYwgzew0zly6+bt/+aYbQJGScR1VDOJwtTNkXU+cx
         41Xl/hnvdbMLsWsw98zBIQqzZojMtCn7BjXrytR+wu+/oCRjuAi1Q6aNHTTpcMSE+ROi
         DpQFdEow/GAX6BjF5hcAFyuiiw2EKapbvF+sKavmZLfdJWGsaPugjJzDwQdlsWjDaesP
         +TiUT93tyDac1SN1fqLoLnCaGSuZmfCr2ExwMsWucY3SV8AW9IrupFNgDqjVFOtJJInR
         H17g==
X-Gm-Message-State: AOAM532yJPge6c1Rq8nv/kBE9DmobbrxdtUJ6XanzkaevWP62VkYdgom
        +tx0yEedbo/DdA0rKbQILQ7lNDer48tZDmFnQ20FVQ==
X-Google-Smtp-Source: ABdhPJw+sm7ro4I7WA8pyqz8op2A63y9wzx/NdirfDTTYkXEA/iga5FcEuT/Jkw+/5p6jasuF4n0OKFXwyXJEh/reNQ=
X-Received: by 2002:a37:4f8f:: with SMTP id d137mr1061732qkb.43.1598010418680;
 Fri, 21 Aug 2020 04:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200821104926.828511-1-alinde@google.com> <20200821104926.828511-3-alinde@google.com>
In-Reply-To: <20200821104926.828511-3-alinde@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 21 Aug 2020 13:46:46 +0200
Message-ID: <CACT4Y+YQS5d7Xpe-353RsLP=zwF03t-Z1j2ZAEGxMcCUF_D0pw@mail.gmail.com>
Subject: Re: [PATCH 2/3] lib, uaccess: add failure injection to usercopy functions
To:     albert.linde@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Albert van der Linde <alinde@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 21, 2020 at 12:50 PM <albert.linde@gmail.com> wrote:
>
> From: Albert van der Linde <alinde@google.com>
>
> To test fault-tolerance of usercopy accesses, introduce fault injection
> in usercopy functions.
>
> Adds failure injection to usercopy functions. If a failure is expected
> we return either the failure or the total amount of bytes. As many
> usercopy functions can fail partially, permit also partial failures:
> e.g., copy_from_user can fail copying between 0 and n.
>
> Signed-off-by: Albert van der Linde <alinde@google.com>
> ---
>  include/linux/uaccess.h | 31 ++++++++++++++++++++++++++-----
>  lib/iov_iter.c          | 20 +++++++++++++++++---
>  lib/strncpy_from_user.c |  3 +++
>  lib/usercopy.c          | 13 +++++++++++--
>  4 files changed, 57 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 94b285411659..79e736077ef4 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -2,6 +2,7 @@
>  #ifndef __LINUX_UACCESS_H__
>  #define __LINUX_UACCESS_H__
>
> +#include <linux/fault-inject-usercopy.h>
>  #include <linux/instrumented.h>
>  #include <linux/sched.h>
>  #include <linux/thread_info.h>
> @@ -82,10 +83,14 @@ __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
>  static __always_inline __must_check unsigned long
>  __copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
> +       long not_copied = should_fail_usercopy(n);
> +
> +       if (not_copied < 0)
> +               not_copied = n;

It feels that this "if (not_copied < 0)" part should be factored into
some common place because it's duplicated lots of times.
Maybe we need a separate helper similar to should_fail_usercopy that
does not return negative values; or make should_fail_usercopy accept a
flag to return -EFAULT or n; or maybe we simply make
should_fail_usercopy return n instead of -EFAULT?

Also, why do we continue when we already know that we should fail it?
In some places we don't, but in most we still run the actual
raw_copy_from_user. What's the rationale? Can we return early in all
cases?

>         might_fault();
>         instrument_copy_from_user(to, from, n);
>         check_object_size(to, n, false);
> -       return raw_copy_from_user(to, from, n);
> +       return not_copied + raw_copy_from_user(to, from, n - not_copied);

Is returning "not_copied + raw_copy_from_user" fine in all cases?
We can return more than the number of bytes we were asked to copy,
which may be surprising for some callers. Or we can both return an
error and do the copy, which may be surprising for userspace.

>  }
>
>  /**
> @@ -104,18 +109,26 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
>  static __always_inline __must_check unsigned long
>  __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
>  {
> +       long not_copied = should_fail_usercopy(n);
> +
> +       if (not_copied < 0)
> +               not_copied = n;
>         instrument_copy_to_user(to, from, n);
>         check_object_size(from, n, true);
> -       return raw_copy_to_user(to, from, n);
> +       return not_copied + raw_copy_to_user(to, from, n - not_copied);
>  }
>
>  static __always_inline __must_check unsigned long
>  __copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> +       long not_copied = should_fail_usercopy(n);
> +
> +       if (not_copied < 0)
> +               not_copied = n;
>         might_fault();
>         instrument_copy_to_user(to, from, n);
>         check_object_size(from, n, true);
> -       return raw_copy_to_user(to, from, n);
> +       return not_copied + raw_copy_to_user(to, from, n - not_copied);
>  }
>
>  #ifdef INLINE_COPY_FROM_USER
> @@ -123,10 +136,14 @@ static inline __must_check unsigned long
>  _copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
>         unsigned long res = n;
> +       long not_copied = should_fail_usercopy(n);
> +
> +       if (not_copied < 0)
> +               not_copied = n;
>         might_fault();
>         if (likely(access_ok(from, n))) {
>                 instrument_copy_from_user(to, from, n);
> -               res = raw_copy_from_user(to, from, n);
> +               res = not_copied + raw_copy_from_user(to, from, n - not_copied);
>         }
>         if (unlikely(res))
>                 memset(to + (n - res), 0, res);
> @@ -141,10 +158,14 @@ _copy_from_user(void *, const void __user *, unsigned long);
>  static inline __must_check unsigned long
>  _copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> +       long not_copied = should_fail_usercopy(n);
> +
> +       if (not_copied < 0)
> +               not_copied = n;
>         might_fault();
>         if (access_ok(to, n)) {
>                 instrument_copy_to_user(to, from, n);
> -               n = raw_copy_to_user(to, from, n);
> +               n = not_copied + raw_copy_to_user(to, from, n - not_copied);
>         }
>         return n;
>  }
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 5e40786c8f12..c55c9bff9b0c 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -2,6 +2,7 @@
>  #include <crypto/hash.h>
>  #include <linux/export.h>
>  #include <linux/bvec.h>
> +#include <linux/fault-inject-usercopy.h>
>  #include <linux/uio.h>
>  #include <linux/pagemap.h>
>  #include <linux/slab.h>
> @@ -139,18 +140,26 @@
>
>  static int copyout(void __user *to, const void *from, size_t n)
>  {
> +       long not_copied = should_fail_usercopy(n);
> +
> +       if (not_copied < 0)
> +               return not_copied;
>         if (access_ok(to, n)) {
>                 instrument_copy_to_user(to, from, n);
> -               n = raw_copy_to_user(to, from, n);
> +               n = not_copied + raw_copy_to_user(to, from, n - not_copied);
>         }
>         return n;
>  }
>
>  static int copyin(void *to, const void __user *from, size_t n)
>  {
> +       long not_copied = should_fail_usercopy(n);
> +
> +       if (not_copied < 0)
> +               return not_copied;
>         if (access_ok(from, n)) {
>                 instrument_copy_from_user(to, from, n);
> -               n = raw_copy_from_user(to, from, n);
> +               n = not_copied + raw_copy_from_user(to, from, n - not_copied);
>         }
>         return n;
>  }
> @@ -640,9 +649,14 @@ EXPORT_SYMBOL(_copy_to_iter);
>  #ifdef CONFIG_ARCH_HAS_UACCESS_MCSAFE
>  static int copyout_mcsafe(void __user *to, const void *from, size_t n)
>  {
> +       long not_copied = should_fail_usercopy(n);
> +
> +       if (not_copied < 0)
> +               return not_copied;
>         if (access_ok(to, n)) {
>                 instrument_copy_to_user(to, from, n);
> -               n = copy_to_user_mcsafe((__force void *) to, from, n);
> +               n = not_copied + copy_to_user_mcsafe((__force void *) to,
> +                              from, n - not_copied);
>         }
>         return n;
>  }
> diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
> index 34696a348864..f65973007931 100644
> --- a/lib/strncpy_from_user.c
> +++ b/lib/strncpy_from_user.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/compiler.h>
>  #include <linux/export.h>
> +#include <linux/fault-inject-usercopy.h>
>  #include <linux/kasan-checks.h>
>  #include <linux/thread_info.h>
>  #include <linux/uaccess.h>
> @@ -101,6 +102,8 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
>         might_fault();
>         if (unlikely(count <= 0))
>                 return 0;
> +       if (should_fail_usercopy(count))
> +               return -EFAULT;
>
>         max_addr = user_addr_max();
>         src_addr = (unsigned long)untagged_addr(src);
> diff --git a/lib/usercopy.c b/lib/usercopy.c
> index b26509f112f9..e79716b4634b 100644
> --- a/lib/usercopy.c
> +++ b/lib/usercopy.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/bitops.h>
> +#include <linux/fault-inject-usercopy.h>
>  #include <linux/instrumented.h>
>  #include <linux/uaccess.h>
>
> @@ -9,10 +10,14 @@
>  unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
>         unsigned long res = n;
> +       long not_copied = should_fail_usercopy(n);
> +
> +       if (not_copied < 0)
> +               not_copied = n;
>         might_fault();
>         if (likely(access_ok(from, n))) {
>                 instrument_copy_from_user(to, from, n);
> -               res = raw_copy_from_user(to, from, n);
> +               res = not_copied + raw_copy_from_user(to, from, n - not_copied);
>         }
>         if (unlikely(res))
>                 memset(to + (n - res), 0, res);
> @@ -24,10 +29,14 @@ EXPORT_SYMBOL(_copy_from_user);
>  #ifndef INLINE_COPY_TO_USER
>  unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> +       long not_copied = should_fail_usercopy(n);
> +
> +       if (not_copied < 0)
> +               not_copied = n;
>         might_fault();
>         if (likely(access_ok(to, n))) {
>                 instrument_copy_to_user(to, from, n);
> -               n = raw_copy_to_user(to, from, n);
> +               n = not_copied + raw_copy_to_user(to, from, n - not_copied);
>         }
>         return n;
>  }
> --
> 2.28.0.297.g1956fa8f8d-goog
>
