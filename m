Return-Path: <linux-arch+bounces-3512-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51F289D48A
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 10:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139CE1C20E9A
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 08:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43999811E8;
	Tue,  9 Apr 2024 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b1YWviZb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D928061A
	for <linux-arch@vger.kernel.org>; Tue,  9 Apr 2024 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651388; cv=none; b=iPcRulpmHAnZn3F0soWEqdkXQIzyNnCVLBrQUGmXcUp7lfiCAx+vcMBTHTAiBRXUPwFnU+nt1kpM3NdC54QdSfIaOsc9CtXNKC+RgnANebFUqVMjEWbEKEw8FtjMOJJ7ZCvVDfyIh/XnNiryiWSrjQLhgjt30lA6TZatiW6rtCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651388; c=relaxed/simple;
	bh=7WODal0Q00lW8i5Yuv0kiVENnAbtFr9gWKzQLm5s50s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8p+A9Kq8/aK6zB+B3J3fQ7DcofqhNvBwfzMhvQkBeKYjdayxJDtBjHiMiMvAqSTmDDZW8mryTWkxrYMMOZ6wYVgQySUdzNseWX8ZUtL3Ta6+KAwjhL+zwZtVIPLDwr1rFghNg+l3oVfR2J94DnatfmE79ib6epOCYPv8yG0jMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b1YWviZb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4154d38ce9dso60365e9.0
        for <linux-arch@vger.kernel.org>; Tue, 09 Apr 2024 01:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712651382; x=1713256182; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NTEfsMClNdGrGHVBJvVLvc0qaDD7/rXGEcCW5SsbgDo=;
        b=b1YWviZb/aQDvs8iGLWw5ukz+uGwWWtxSRdMXDGh5j1LOKjtGcBf2E38s4sqeJfJJT
         mA3dosEtqBHIYdLYjx1IWDjyUaGLsEuzhy9Dth2ERSULx/H7gfFs+nHuvsUMOq4chKR3
         bMLlO8YNcTj5AO5hxKV9MEmGMUA+maPPtKFBxRdEgbBTBuyNQcZzLi7pjzN97PzR1JQI
         KOiToZSrfySW9NDnm8A2sL2/1b99RY74BBVP73Ebmt1p7qcrbsDw68QT79l9fGEsrheI
         ikE6U9+XFHnQJm0bRYuyYdbbqnS36LRYx0K+cSP+kmLFhjN0+nh1Lg/QOaEGTN22xA6E
         tfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712651382; x=1713256182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTEfsMClNdGrGHVBJvVLvc0qaDD7/rXGEcCW5SsbgDo=;
        b=u9u4KcOqMEhr0H23SekSdigL7hoYxqRaOseUkApKjtQkm4X7Uy6jkaE/dLWHtDVLyI
         wKM0POkk6oFvSY70IEPV1+iKudrYvJ3xy+6J/gsCu5dqjKCm25UifsOCslWp5Nt50dyD
         qLAmdBrDJr4S60585eLmCs3fwWdiQ3xqOBC629q66c+6o5Z1jmOnV8ItfKAaUAEyXfec
         Oxg5pROL6xHeYA+46gqeHn7q+vO4C9bo6JvCglFcM7xxK7C053eiNAd0Il/2J2Xq4s9E
         XBH47eIDhzksZtDbZ5lW3Q5R7V/y7n7d06hyigvbgpSqJ7vmzqSVOVdM5K+TKqY6X2hD
         1vLw==
X-Forwarded-Encrypted: i=1; AJvYcCVWGTyQymib6mMOho1wDUjIhhMf5KmLE6GmlLNa/IhDt/xSXWtliOYU6DJHja6gfhTkBhVsyle7Cqsgcj3KNS3ELxxNPKMD4ReoKw==
X-Gm-Message-State: AOJu0YwzwN/fr0H9ffZS0Ucmz5ND9bj+AQ0nuPIV/zWwT8p/0Nz4qGUs
	9GDhYpMfVgsl0NEAnsXr9HC59RjBTKZduvg5axBrEF/BtJ1SvSsYHfIG25SdSOrWBmo1V9y025d
	oxD+9oUoITJ0l4QMKD19AvrWFgOGIkkhK4ZN3
X-Google-Smtp-Source: AGHT+IGN60qikBJ2TnvXDkLiAKeGKJtA8lMoXuaba+mNhsm81NX1Ko+ouWfYtBMoYyMS+yzPrbNrpDENV0LLD28XTxw=
X-Received: by 2002:a05:600c:314c:b0:416:7f8a:c6ea with SMTP id
 h12-20020a05600c314c00b004167f8ac6eamr92410wmo.1.1712651381537; Tue, 09 Apr
 2024 01:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403131936.787234-1-linux@roeck-us.net> <20240403131936.787234-2-linux@roeck-us.net>
In-Reply-To: <20240403131936.787234-2-linux@roeck-us.net>
From: David Gow <davidgow@google.com>
Date: Tue, 9 Apr 2024 16:29:27 +0800
Message-ID: <CABVgOSkNmmEn05B3HKopWt4T=6rNHCNgrd1JkQo46CS6C9hYJg@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] bug/kunit: Core support for suppressing warning backtraces
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>, 
	Daniel Diaz <daniel.diaz@linaro.org>, Arthur Grillo <arthurgrillo@riseup.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Maxime Ripard <mripard@kernel.org>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	kunit-dev@googlegroups.com, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	loongarch@lists.linux.dev, netdev@vger.kernel.org, x86@kernel.org, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000433cc20615a5b9e4"

--000000000000433cc20615a5b9e4
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 21:19, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Some unit tests intentionally trigger warning backtraces by passing
> bad parameters to API functions. Such unit tests typically check the
> return value from those calls, not the existence of the warning backtrace.
>
> Such intentionally generated warning backtraces are neither desirable
> nor useful for a number of reasons.
> - They can result in overlooked real problems.
> - A warning that suddenly starts to show up in unit tests needs to be
>   investigated and has to be marked to be ignored, for example by
>   adjusting filter scripts. Such filters are ad-hoc because there is
>   no real standard format for warnings. On top of that, such filter
>   scripts would require constant maintenance.
>
> One option to address problem would be to add messages such as "expected
> warning backtraces start / end here" to the kernel log.  However, that
> would again require filter scripts, it might result in missing real
> problematic warning backtraces triggered while the test is running, and
> the irrelevant backtrace(s) would still clog the kernel log.
>
> Solve the problem by providing a means to identify and suppress specific
> warning backtraces while executing test code. Since the new functionality
> results in an image size increase of about 1% if CONFIG_KUNIT is enabled,
> provide configuration option KUNIT_SUPPRESS_BACKTRACE to be able to disable
> the new functionality. This option is by default enabled since almost all
> systems with CONFIG_KUNIT enabled will want to benefit from it.
>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Daniel Diaz <daniel.diaz@linaro.org>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Kees Cook <keescook@chromium.org>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Sorry it took so long to get to this.

I love the idea, we've needed this for a while.

There are some downsides to this being entirely based on the name of
the function which contains WARN(). Partly because there could be
several WARN()s within a function, and there'd be overlap, and partly
because the function name is never actually printed during a warning
(it may come from the stack trace, but that can be misleading with
inlined functions).  I don't think either of these are showstoppers,
though, but it'd be nice to extend this in the future with (a) other
ways of identifying warnings, such as the format string, and (b) print
the function name in the report, if it's present. The function name is
probably a good middle ground, complexity-wise, though, so I'm happy
to have it thus far.

 I also think we're missing some opportunities to integrate this
better with existing KUnit infrastructure, like the
action/resource/cleanup system. In particular, it'd be nice to have a
way of ensuring that suppressions won't get leaked if the test aborts
between START_SUPPRESSED_WARNING() and END_SUPPRESSED_WARNING(). It's
not difficult to use this as-is, but it'd be nice to have some
helpers, rather than having to, for instance:
KUNIT_DEFINE_ACTION_WRAPPER(kunit_stop_suppressing_warning,
__end_suppress_warning, struct __suppressed_warning *);
DEFINE_SUPPRESSED_WARNING(vfree);
START_SUPPRESSED_WARNING(vfree);
kunit_add_action(test, kunit_stop_suppressing_warning, (void
*)&__kunit_suppress_vfree);

(With the note that the DEFINE_SUPPRESSED_WARNING() will have to be
global, or put on the heap, lest it become a dangling pointer by the
time the suppression has stopped.)

Equally, do we want to make the
__{start,end,is}_suppress[ed]_warning()  functions KUnit 'hooks'? This
would allow them to be used in modules which don't depend directly on
KUnit. I suspect it's not important in this case: but worth keeping in
mind in case we find a situation where we'd need to suppress a warning
elsewhere.

These are all things which could be added/changed in follow-up
patches, though, so I don't think they're blockers. Otherwise, this
looks good: perhaps the naming could be a bit more consistent with
other KUnit things, but that depends on how much we want this to be 'a
part of KUnit' versus an independent bit of functionality.

> v2:
> - Rebased to v6.9-rc1
> - Added Tested-by:, Acked-by:, and Reviewed-by: tags
> - Added CONFIG_KUNIT_SUPPRESS_BACKTRACE configuration option,
>   enabled by default
> v3:
> - Rebased to v6.9-rc2
>
>  include/asm-generic/bug.h | 16 +++++++++---
>  include/kunit/bug.h       | 51 +++++++++++++++++++++++++++++++++++++++
>  include/kunit/test.h      |  1 +
>  include/linux/bug.h       | 13 ++++++++++
>  lib/bug.c                 | 51 ++++++++++++++++++++++++++++++++++++---
>  lib/kunit/Kconfig         |  9 +++++++
>  lib/kunit/Makefile        |  6 +++--
>  lib/kunit/bug.c           | 40 ++++++++++++++++++++++++++++++
>  8 files changed, 178 insertions(+), 9 deletions(-)
>  create mode 100644 include/kunit/bug.h
>  create mode 100644 lib/kunit/bug.c
>
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index 6e794420bd39..c170b6477689 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -18,6 +18,7 @@
>  #endif
>
>  #ifndef __ASSEMBLY__
> +#include <kunit/bug.h>
>  #include <linux/panic.h>
>  #include <linux/printk.h>
>
> @@ -39,8 +40,14 @@ struct bug_entry {
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
>  #ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
>         const char      *file;
> +#ifdef HAVE_BUG_FUNCTION
> +       const char      *function;
> +#endif
>  #else
>         signed int      file_disp;
> +#ifdef HAVE_BUG_FUNCTION
> +       signed int      function_disp;
> +#endif
>  #endif
>         unsigned short  line;
>  #endif
> @@ -96,15 +103,18 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
>  #define __WARN()               __WARN_printf(TAINT_WARN, NULL)
>  #define __WARN_printf(taint, arg...) do {                              \
>                 instrumentation_begin();                                \
> -               warn_slowpath_fmt(__FILE__, __LINE__, taint, arg);      \
> +               if (!IS_SUPPRESSED_WARNING(__func__))                   \
> +                       warn_slowpath_fmt(__FILE__, __LINE__, taint, arg);\
>                 instrumentation_end();                                  \
>         } while (0)
>  #else
>  #define __WARN()               __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
>  #define __WARN_printf(taint, arg...) do {                              \
>                 instrumentation_begin();                                \
> -               __warn_printk(arg);                                     \
> -               __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
> +               if (!IS_SUPPRESSED_WARNING(__func__)) {                 \
> +                       __warn_printk(arg);                             \
> +                       __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
> +               }                                                       \
>                 instrumentation_end();                                  \
>         } while (0)
>  #define WARN_ON_ONCE(condition) ({                             \
> diff --git a/include/kunit/bug.h b/include/kunit/bug.h
> new file mode 100644
> index 000000000000..bd0fe047572b
> --- /dev/null
> +++ b/include/kunit/bug.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KUnit helpers for backtrace suppression
> + *
> + * Copyright (c) 2024 Guenter Roeck <linux@roeck-us.net>
> + */
> +
> +#ifndef _KUNIT_BUG_H
> +#define _KUNIT_BUG_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/kconfig.h>
> +
> +#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
> +
> +#include <linux/stringify.h>
> +#include <linux/types.h>
> +
> +struct __suppressed_warning {
> +       struct list_head node;
> +       const char *function;
> +};
> +
> +void __start_suppress_warning(struct __suppressed_warning *warning);
> +void __end_suppress_warning(struct __suppressed_warning *warning);
> +bool __is_suppressed_warning(const char *function);

Do we want to call these '__kunit_start_suppress_warning', etc., to
match other similar functions exported by KUnit to be used in macros,
et al.

> +
> +#define DEFINE_SUPPRESSED_WARNING(func)        \
> +       struct __suppressed_warning __kunit_suppress_##func = \

We use the __kunit_ prefix here...

> +               { .function = __stringify(func) }
> +
> +#define START_SUPPRESSED_WARNING(func) \
> +       __start_suppress_warning(&__kunit_suppress_##func)
> +
> +#define END_SUPPRESSED_WARNING(func) \
> +       __end_suppress_warning(&__kunit_suppress_##func)
> +
> +#define IS_SUPPRESSED_WARNING(func) \
> +       __is_suppressed_warning(func)
> +

Similarly, do we want to give these KUNIT_ prefixes to match other KUnit macros.

One possibility would be to have both KUNIT_- and non-KUNIT_-
variants, the latter of which accepts a struct kunit*, and registers
the suppression with the test for automated cleanup.


> +#else /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
> +
> +#define DEFINE_SUPPRESSED_WARNING(func)
> +#define START_SUPPRESSED_WARNING(func)
> +#define END_SUPPRESSED_WARNING(func)
> +#define IS_SUPPRESSED_WARNING(func) (false)
> +
> +#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
> +#endif /* __ASSEMBLY__ */
> +#endif /* _KUNIT_BUG_H */
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 61637ef32302..d0c44594d34c 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -10,6 +10,7 @@
>  #define _KUNIT_TEST_H
>
>  #include <kunit/assert.h>
> +#include <kunit/bug.h>
>  #include <kunit/try-catch.h>
>
>  #include <linux/args.h>
> diff --git a/include/linux/bug.h b/include/linux/bug.h
> index 348acf2558f3..c668762dc76a 100644
> --- a/include/linux/bug.h
> +++ b/include/linux/bug.h
> @@ -36,6 +36,9 @@ static inline int is_warning_bug(const struct bug_entry *bug)
>         return bug->flags & BUGFLAG_WARNING;
>  }
>
> +void bug_get_file_function_line(struct bug_entry *bug, const char **file,
> +                               const char **function, unsigned int *line);
> +
>  void bug_get_file_line(struct bug_entry *bug, const char **file,
>                        unsigned int *line);
>
> @@ -62,6 +65,16 @@ static inline enum bug_trap_type report_bug(unsigned long bug_addr,
>  }
>
>  struct bug_entry;
> +static inline void bug_get_file_function_line(struct bug_entry *bug,
> +                                             const char **file,
> +                                             const char **function,
> +                                             unsigned int *line)
> +{
> +       *file = NULL;
> +       *function = NULL;
> +       *line = 0;
> +}
> +
>  static inline void bug_get_file_line(struct bug_entry *bug, const char **file,
>                                      unsigned int *line)
>  {
> diff --git a/lib/bug.c b/lib/bug.c
> index e0ff21989990..aa8bb12b9809 100644
> --- a/lib/bug.c
> +++ b/lib/bug.c
> @@ -26,6 +26,14 @@
>         when CONFIG_DEBUG_BUGVERBOSE is not enabled, so you must generate
>         the values accordingly.
>
> +  2a.Optionally implement support for the "function" entry in struct
> +     bug_entry. This entry must point to the name of the function triggering
> +     the warning or bug trap (normally __func__). This is only needed if
> +     both CONFIG_DEBUG_BUGVERBOSE and CONFIG_KUNIT_SUPPRESS_BACKTRACE are
> +     enabled and if the architecture wants to implement support for suppressing
> +     warning backtraces. The architecture must define HAVE_BUG_FUNCTION if it
> +     adds pointers to function names to struct bug_entry.
> +
>    3. Implement the trap
>       - In the illegal instruction trap handler (typically), verify
>         that the fault was in kernel mode, and call report_bug()
> @@ -127,14 +135,21 @@ static inline struct bug_entry *module_find_bug(unsigned long bugaddr)
>  }
>  #endif
>
> -void bug_get_file_line(struct bug_entry *bug, const char **file,
> -                      unsigned int *line)
> +void bug_get_file_function_line(struct bug_entry *bug, const char **file,
> +                               const char **function, unsigned int *line)
>  {
> +       *function = NULL;
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
>  #ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
>         *file = (const char *)&bug->file_disp + bug->file_disp;
> +#ifdef HAVE_BUG_FUNCTION
> +       *function = (const char *)&bug->function_disp + bug->function_disp;
> +#endif
>  #else
>         *file = bug->file;
> +#ifdef HAVE_BUG_FUNCTION
> +       *function = bug->function;
> +#endif
>  #endif
>         *line = bug->line;
>  #else
> @@ -143,6 +158,13 @@ void bug_get_file_line(struct bug_entry *bug, const char **file,
>  #endif
>  }
>
> +void bug_get_file_line(struct bug_entry *bug, const char **file, unsigned int *line)
> +{
> +       const char *function;
> +
> +       bug_get_file_function_line(bug, file, &function, line);
> +}
> +
>  struct bug_entry *find_bug(unsigned long bugaddr)
>  {
>         struct bug_entry *bug;
> @@ -157,8 +179,9 @@ struct bug_entry *find_bug(unsigned long bugaddr)
>  static enum bug_trap_type __report_bug(unsigned long bugaddr, struct pt_regs *regs)
>  {
>         struct bug_entry *bug;
> -       const char *file;
> +       const char *file, *function;

As mentioned, I'd love to see the function plumbed through and
reported some day, both to make it easier to know what to suppress,
and also because it's possibly more reliable even outside the
suppression use-case. Could be a follow-up patch later, though.


>         unsigned line, warning, once, done;
> +       char __maybe_unused sym[KSYM_SYMBOL_LEN];
>
>         if (!is_valid_bugaddr(bugaddr))
>                 return BUG_TRAP_TYPE_NONE;
> @@ -169,12 +192,32 @@ static enum bug_trap_type __report_bug(unsigned long bugaddr, struct pt_regs *re
>
>         disable_trace_on_warning();
>
> -       bug_get_file_line(bug, &file, &line);
> +       bug_get_file_function_line(bug, &file, &function, &line);
> +#if defined(CONFIG_KUNIT_SUPPRESS_BACKTRACE) && defined(CONFIG_KALLSYMS)
> +       if (!function) {
> +               /*
> +                * This will be seen if report_bug is called on an architecture
> +                * with no architecture-specific support for suppressing warning
> +                * backtraces, if CONFIG_DEBUG_BUGVERBOSE is not enabled, or if
> +                * the calling code is from assembler which does not record a
> +                * function name. Extracting the function name from the bug
> +                * address is less than perfect since compiler optimization may
> +                * result in 'bugaddr' pointing to a function which does not
> +                * actually trigger the warning, but it is better than no
> +                * suppression at all.
> +                */
> +               sprint_symbol_no_offset(sym, bugaddr);
> +               function = sym;
> +       }
> +#endif /* defined(CONFIG_KUNIT_SUPPRESS_BACKTRACE) && defined(CONFIG_KALLSYMS) */
>
>         warning = (bug->flags & BUGFLAG_WARNING) != 0;
>         once = (bug->flags & BUGFLAG_ONCE) != 0;
>         done = (bug->flags & BUGFLAG_DONE) != 0;
>
> +       if (warning && IS_SUPPRESSED_WARNING(function))
> +               return BUG_TRAP_TYPE_WARN;
> +
>         if (warning && once) {
>                 if (done)
>                         return BUG_TRAP_TYPE_WARN;
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 68a6daec0aef..b1b899265acc 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -15,6 +15,15 @@ menuconfig KUNIT
>
>  if KUNIT
>
> +config KUNIT_SUPPRESS_BACKTRACE
> +       bool "KUnit - Enable backtrace suppression"
> +       default y
> +       help
> +         Enable backtrace suppression for KUnit. If enabled, backtraces
> +         generated intentionally by KUnit tests are suppressed. Disable
> +         to reduce kernel image size if image size is more important than
> +         suppression of backtraces generated by KUnit tests.
> +
>  config KUNIT_DEBUGFS
>         bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation" if !KUNIT_ALL_TESTS
>         default KUNIT_ALL_TESTS
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 309659a32a78..545b57c3be48 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -14,8 +14,10 @@ ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
>  kunit-objs +=                          debugfs.o
>  endif
>
> -# KUnit 'hooks' are built-in even when KUnit is built as a module.
> -obj-y +=                               hooks.o
> +# KUnit 'hooks' and bug handling are built-in even when KUnit is built
> +# as a module.
> +obj-y +=                               hooks.o \
> +                                       bug.o
>
>  obj-$(CONFIG_KUNIT_TEST) +=            kunit-test.o
>
> diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
> new file mode 100644
> index 000000000000..f93544d7a9d1
> --- /dev/null
> +++ b/lib/kunit/bug.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit helpers for backtrace suppression
> + *
> + * Copyright (c) 2024 Guenter Roeck <linux@roeck-us.net>
> + */
> +
> +#include <kunit/bug.h>
> +#include <linux/export.h>
> +#include <linux/list.h>
> +#include <linux/string.h>
> +
> +static LIST_HEAD(suppressed_warnings);
> +
> +void __start_suppress_warning(struct __suppressed_warning *warning)
> +{
> +       list_add(&warning->node, &suppressed_warnings);
> +}
> +EXPORT_SYMBOL_GPL(__start_suppress_warning);
> +
> +void __end_suppress_warning(struct __suppressed_warning *warning)
> +{
> +       list_del(&warning->node);
> +}
> +EXPORT_SYMBOL_GPL(__end_suppress_warning);
> +
> +bool __is_suppressed_warning(const char *function)
> +{
> +       struct __suppressed_warning *warning;
> +
> +       if (!function)
> +               return false;
> +
> +       list_for_each_entry(warning, &suppressed_warnings, node) {
> +               if (!strcmp(function, warning->function))
> +                       return true;
> +       }
> +       return false;
> +}
> +EXPORT_SYMBOL_GPL(__is_suppressed_warning);
> --
> 2.39.2
>

Thanks,
-- David

--000000000000433cc20615a5b9e4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
7xDrOPfX3COqq162RFg/MFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AK0lDd6/eSh3qHmXaw1YUfIFy07B25BEcTvWgOdla99gF1O7sOsdYaTz/DFkZI5ghjgaPJCovgla
mRMfNcxZCfoBtsB7mAS6iOYjuwFOZxi9cv6jhfiON6b89QWdMaPeDddg/F2Q0bxZ9Z2ZEBxyT34G
wlDp+1p6RAqlDpHifQJW16h5jWIIwYisvm5QyfxQEVc+XH1lt+taSzCfiBT0ZLgjB9Sg+zAo8ys6
5PHxFaT2a5Td/fj5yJ5hRSrqy/nj/hjT14w3/ZdX5uWg+cus6VjiiR/5qGSZRjHt8JoApD6t6/tg
ITv8ZEy6ByumbU23nkHTMOzzQSxczHkT+0q10/MxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAHS+TgZvH/tCq5FcDC0n9IwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIIOVQ6jwtkykbkD9amzlnbTHyE0Or6zi3BACy3iruk4SMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQwOTA4Mjk0MlowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCtHWwf
mfxClU2onqR3lXpGpINgyKUw3mJPMZ2BKHpZm6FwjOdSewD4tJCFQ08wIVRlRkilRaWBdqvjCd+F
Ow0O2i7RWiS9Uv6B86Cyc5hP/SgbDecrwJ1OzYfm/1AxXEKcPGTip6ms8d3g2EAyQ+SQiM3DM06a
etT36e4P5cxQWoZ1CvbC2swun7Dd7wCN8UuWTrF9E9xiMTPXDHgsQVBXAda8FlwvkjDDqEH7uuId
VmiVn9Osn0BAU4eEpCP/5Q4mJwNM+WIbtK+XsEKX1JIw3ajR9szm85DUUKWBhQfp+x/uF+xWrXNf
PD1HLD5osEEsfCuPtFTZemoY05vKK9H3
--000000000000433cc20615a5b9e4--

