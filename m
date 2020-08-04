Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E5723C07C
	for <lists+linux-arch@lfdr.de>; Tue,  4 Aug 2020 22:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgHDUGY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Aug 2020 16:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHDUGW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Aug 2020 16:06:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1731EC061757
        for <linux-arch@vger.kernel.org>; Tue,  4 Aug 2020 13:06:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 74so12987085pfx.13
        for <linux-arch@vger.kernel.org>; Tue, 04 Aug 2020 13:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNm8W6rpYM06BBGBIHZxcMjdzZ3vakXrlXurbxLdgkc=;
        b=v4l5acpzSQAfpQHj1mfUVMR3p5sYyrw5mOo48jHfFk0RTIu1O9uHerBR9X6iqyjRME
         jpuyZUa5ksd0zx3yIUS1JV4PNrR+Ci6JB9Yiqv914mGAbQpinU+OcDkb3wb5U3IcmAkE
         +z3r71HrcS68ERoiCC+g/GVSr0G//Sry7KTWGhvunwYoC76KLfIu0xebOB7N/oBdHvoE
         kvxn8aDuMtop9CYR/dqBjlKopgBJ+9bq0ulQvn+MhzjpQvpiGgk0gB7qT+ZEJW/2bBT7
         ftYbtYibZk1eE5Nez0MLw5pbzDM8YEcwr/pth2mY6N88/dFxTj7Z9s0eU16+k9y7i7qu
         kT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNm8W6rpYM06BBGBIHZxcMjdzZ3vakXrlXurbxLdgkc=;
        b=IfPQ070esKmVwRY7juZWFQmElhZWtXdHIfDSQc25YGr35dMtcbIHO1tQ1Z5lvD8zrM
         d+9rm6PsWeSIixQTqMvliWtJP8hgJcXdIFu3ZMKhfdeh8ZagSD4PTuwNBplu45QK/yVt
         5R/17XQZar8pUFN+XTg8nEj8oZvmncmG+ERmjtXdLJloY/lqOBV3ZTkvuOGB54ReQp7L
         bxgYHt7zm9YrahhnaNS1eZnLfxCIGeXZfX2fL3ttm+gU4YJVXXs0WryhLFpiWlw6DF/P
         Lg9Oa9uF+9scsGLECoTNmVSzU+WOt0l0dGW4tSEgg535gYwRUdhUEJoVXyiOl9kXBFsN
         m0WQ==
X-Gm-Message-State: AOAM5313/XP0RcI0u5wBx80Sucv3vnJBwSbhp7XT1XlDgTHGEMjfmQiW
        VGaC8A+4JTEVDbxzp9UhsDHfFQf2c6G77VkuQuZmTg==
X-Google-Smtp-Source: ABdhPJwDxyLCJxo7OkSto+sYTNQG5C6S3G+O7SAk1MPu1yxc8iqCFPqvVOnR/cM9XZ52e6+sDqLchsL5zLZPTJ6SMvc=
X-Received: by 2002:a62:7b89:: with SMTP id w131mr49836pfc.284.1596571581073;
 Tue, 04 Aug 2020 13:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-8-brendanhiggins@google.com> <202006261423.0BC9D830@keescook>
In-Reply-To: <202006261423.0BC9D830@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 4 Aug 2020 13:06:10 -0700
Message-ID: <CAFd5g46sH+J9Un-2BTYMjruZ6bd+T35MsR2rCAKeVERV_JSoCw@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] kunit: test: create a single centralized
 executor for all tests
To:     Kees Cook <keescook@chromium.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Frank Rowand <frowand.list@gmail.com>, catalin.marinas@arm.com,
        will@kernel.org, Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Chris Zankel <chris@zankel.net>, jcmvbkbc@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 26, 2020 at 2:29 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 26, 2020 at 02:09:12PM -0700, Brendan Higgins wrote:
> > From: Alan Maguire <alan.maguire@oracle.com>
> >
> > Add a centralized executor to dispatch tests rather than relying on
> > late_initcall to schedule each test suite separately. Centralized
> > execution is for built-in tests only; modules will execute tests when
> > loaded.
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > Co-developed-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  include/kunit/test.h | 67 +++++++++++++++++++++++++++++---------------
> >  lib/kunit/Makefile   |  3 +-
> >  lib/kunit/executor.c | 28 ++++++++++++++++++
> >  lib/kunit/test.c     |  2 +-
> >  4 files changed, 76 insertions(+), 24 deletions(-)
> >  create mode 100644 lib/kunit/executor.c
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 47e61e1d53370..f3e86c3953a2b 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -224,7 +224,7 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite);
> >  unsigned int kunit_test_case_num(struct kunit_suite *suite,
> >                                struct kunit_case *test_case);
> >
> > -int __kunit_test_suites_init(struct kunit_suite **suites);
> > +int __kunit_test_suites_init(struct kunit_suite * const * const suites);
> >
> >  void __kunit_test_suites_exit(struct kunit_suite **suites);
> >
> > @@ -237,34 +237,57 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
> >   * Registers @suites_list with the test framework. See &struct kunit_suite for
> >   * more information.
> >   *
> > - * When builtin, KUnit tests are all run as late_initcalls; this means
> > - * that they cannot test anything where tests must run at a different init
> > - * phase. One significant restriction resulting from this is that KUnit
> > - * cannot reliably test anything that is initialize in the late_init phase;
> > - * another is that KUnit is useless to test things that need to be run in
> > - * an earlier init phase.
> > - *
> > - * An alternative is to build the tests as a module.  Because modules
> > - * do not support multiple late_initcall()s, we need to initialize an
> > - * array of suites for a module.
> > - *
> > - * TODO(brendanhiggins@google.com): Don't run all KUnit tests as
> > - * late_initcalls.  I have some future work planned to dispatch all KUnit
> > - * tests from the same place, and at the very least to do so after
> > - * everything else is definitely initialized.
> > + * If a test suite is built-in, module_init() gets translated into
> > + * an initcall which we don't want as the idea is that for builtins
> > + * the executor will manage execution.  So ensure we do not define
> > + * module_{init|exit} functions for the builtin case when registering
> > + * suites via kunit_test_suites() below.
> >   */
> > -#define kunit_test_suites(suites_list...)                            \
> > -     static struct kunit_suite *suites[] = {suites_list, NULL};      \
> > -     static int kunit_test_suites_init(void)                         \
> > +#ifdef MODULE
> > +#define kunit_test_suites_for_module(__suites)                               \
> > +     static int __init kunit_test_suites_init(void)                  \
> >       {                                                               \
> > -             return __kunit_test_suites_init(suites);                \
> > +             return __kunit_test_suites_init(__suites);              \
> >       }                                                               \
> > -     late_initcall(kunit_test_suites_init);                          \
> > +     module_init(kunit_test_suites_init);                            \
> > +                                                                     \
> >       static void __exit kunit_test_suites_exit(void)                 \
> >       {                                                               \
> > -             return __kunit_test_suites_exit(suites);                \
> > +             return __kunit_test_suites_exit(__suites);              \
> >       }                                                               \
> >       module_exit(kunit_test_suites_exit)
> > +#else
> > +#define kunit_test_suites_for_module(__suites)
> > +#endif /* MODULE */
> > +
> > +#define __kunit_test_suites(unique_array, unique_suites, ...)                       \
> > +     static struct kunit_suite *unique_array[] = { __VA_ARGS__, NULL };     \
> > +     kunit_test_suites_for_module(unique_array);                            \
> > +     static struct kunit_suite **unique_suites                              \
> > +     __used __section(.kunit_test_suites) = unique_array
> > +
> > +/**
> > + * kunit_test_suites() - used to register one or more &struct kunit_suite
> > + *                    with KUnit.
> > + *
> > + * @suites: a statically allocated list of &struct kunit_suite.
> > + *
> > + * Registers @suites with the test framework. See &struct kunit_suite for
> > + * more information.
> > + *
> > + * When builtin,  KUnit tests are all run via executor; this is done
> > + * by placing the array of struct kunit_suite * in the .kunit_test_suites
> > + * ELF section.
> > + *
> > + * An alternative is to build the tests as a module.  Because modules do not
> > + * support multiple initcall()s, we need to initialize an array of suites for a
> > + * module.
> > + *
> > + */
> > +#define kunit_test_suites(...)                                               \
> > +     __kunit_test_suites(__UNIQUE_ID(array),                         \
> > +                         __UNIQUE_ID(suites),                        \
> > +                         __VA_ARGS__)
> >
> >  #define kunit_test_suite(suite)      kunit_test_suites(&suite)
> >
> > diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> > index 724b94311ca36..c49f4ffb6273a 100644
> > --- a/lib/kunit/Makefile
> > +++ b/lib/kunit/Makefile
> > @@ -3,7 +3,8 @@ obj-$(CONFIG_KUNIT) +=                        kunit.o
> >  kunit-objs +=                                test.o \
> >                                       string-stream.o \
> >                                       assert.o \
> > -                                     try-catch.o
> > +                                     try-catch.o \
> > +                                     executor.o
> >
> >  ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
> >  kunit-objs +=                                debugfs.o
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > new file mode 100644
> > index 0000000000000..7015e7328dce7
> > --- /dev/null
> > +++ b/lib/kunit/executor.c
> > @@ -0,0 +1,28 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <kunit/test.h>
> > +
> > +/*
> > + * These symbols point to the .kunit_test_suites section and are defined in
> > + * include/asm-generic/vmlinux.lds.h, and consequently must be extern.
> > + */
> > +extern struct kunit_suite * const * const __kunit_suites_start[];
> > +extern struct kunit_suite * const * const __kunit_suites_end[];
>
> I would expect these to be in include/asm-generic/sections.h but I guess
> it's not required.

I don't have strong opinions either way, but I think this is less
clutter since KUnit is the only one that uses it.

> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!
