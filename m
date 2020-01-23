Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1079147414
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 23:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbgAWWzH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 17:55:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40414 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbgAWWzH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 17:55:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id s21so1990366plr.7
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 14:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bdR2VIngUyNsUGbPsP+UPl746ALnDu+ORGiYpHLsy/M=;
        b=JYMcOHTdAKO6qaAxt2V6dRl499d2oCBChvSKIPRVWm/EJYVbbKZob8zLiyhHlveyrk
         p+KvC/twgDmyuyPk4TqU6B4LjpV3xHxY03utbDuKBU6lhgSNxvHuoSu/JTiR4cyLZ6rk
         9oVRRwxoX2c6oxsLLaLz9PYzd4kpQQiuYN/K2ecvoS766fFWpFNMIEYDHx8ebGAd0eir
         OkwhLZFL4pUC0U41ljkGgZ3MUEvNQwNCk8ilet4PeJDEIZLq3ZN9SZjBVSSWs1j8sh6g
         1mBUxNyR5Zd+s2FiiiY/8Ss9qP69I2CyNbfhQxwnpP4ttaB+8MrwJ4bst6KAhAUDRkCJ
         7qUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bdR2VIngUyNsUGbPsP+UPl746ALnDu+ORGiYpHLsy/M=;
        b=R/NTKAwiv4NlB+myxrPmVt0e6/3cFQiBDfCiGCE4y8klEhGEbOwjRlQnwZW7S6Am97
         zLWZcjF/WsR2O926HT9QKIpJEVwsL8CbqOtFQg7IJUlqYDUt2u6v0CfTsrD4XcLGiU7B
         3tn5ZB9YIRG6dTmdRBXjtV9BVCwm+zxtSBbtAp2Lo+mBon6yWMnYQAYNH5aLiZVEvFgp
         Z93VAV4uGUUbr43k+jkX6XATy9qaW9dj1kSasgnd/Z7k4JkH1gjagzRt69S2HDSMm5dR
         GPQuKCkPK/ALOH89k6norQuzJFdJVA89o0UOeFGAEB6nyxQxq6r6+NuVkmJHU4iifp8u
         GNew==
X-Gm-Message-State: APjAAAXIb9fC4ZmLZ0LIiW28f69T9YJNlOC3GS2ebBvWyLNAKKunrn7y
        CHB77yMtK6ODpvP1hrubebelA/jWaXoubh8fXFLDlA==
X-Google-Smtp-Source: APXvYqzdbpR7pO8euiReITGLrsk+/Oy+gyJrt9hmrf3x4sUM9Laf+reGcryH8NHCxinjRW4t04WOyzPtBwugde0z+ec=
X-Received: by 2002:a17:902:9f98:: with SMTP id g24mr423318plq.325.1579820106653;
 Thu, 23 Jan 2020 14:55:06 -0800 (PST)
MIME-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20191216220555.245089-4-brendanhiggins@google.com> <20191217080408.0E805207FF@mail.kernel.org>
In-Reply-To: <20191217080408.0E805207FF@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 23 Jan 2020 14:54:55 -0800
Message-ID: <CAFd5g44Wh9kwXsY_M4GfMp0+wzN_3HhVfa360J-tF48aQ_KADg@mail.gmail.com>
Subject: Re: [RFC v1 3/6] kunit: test: create a single centralized executor
 for all tests
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>, rppt@linux.ibm.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Knut Omang <knut.omang@oracle.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 17, 2019 at 12:04 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-12-16 14:05:52)
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index dba48304b3bd3..c070798ebb765 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -217,11 +217,8 @@ int kunit_run_tests(struct kunit_suite *suite);
> >   * everything else is definitely initialized.
> >   */
> >  #define kunit_test_suite(suite)                                                       \
> > -       static int kunit_suite_init##suite(void)                               \
>
> Oh this should have been __init before.

No, the stuff in this patch shouldn't be init. With the work that Alan
has been doing (adding support for modules, debugfs); the test code
can run after booting, so init in any of this code is incorrect.

> > -       {                                                                      \
> > -               return kunit_run_tests(&suite);                                \
> > -       }                                                                      \
> > -       late_initcall(kunit_suite_init##suite)
> > +       static struct kunit_suite *__kunit_suite_##suite                       \
> > +       __used __aligned(8) __section(.kunit_test_suites) = &suite
> >
> >  /*
> >   * Like kunit_alloc_resource() below, but returns the struct kunit_resource
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > new file mode 100644
> > index 0000000000000..978086cfd257d
> > --- /dev/null
> > +++ b/lib/kunit/executor.c
> > @@ -0,0 +1,43 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Base unit test (KUnit) API.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/printk.h>
> > +#include <kunit/test.h>
> > +
> > +/*
> > + * These symbols point to the .kunit_test_suites section and are defined in
> > + * include/asm-generic/vmlinux.lds.h, and consequently must be extern.
> > + */
> > +extern struct kunit_suite *__kunit_suites_start[];
> > +extern struct kunit_suite *__kunit_suites_end[];
> > +
> > +static bool kunit_run_all_tests(void)
>
> Should be __init?

It could be, I think. Alan's code doesn't call this, so for now we
might as well make it __init.

> > +{
> > +       struct kunit_suite **suite;
>
> Can this be const? And the linker references above too?

Good catch. Will fix.

> > +       bool has_test_failed = false;
> > +
> > +       for (suite = __kunit_suites_start;
> > +            suite < __kunit_suites_end;
> > +            ++suite) {
> > +               if (kunit_run_tests(*suite))
> > +                       has_test_failed = true;
> > +       }
> > +
> > +       return !has_test_failed;
> > +}
> > +
> > +static int kunit_executor_init(void)
>
> Should be __init?

Will do.

> > +{
> > +       if (kunit_run_all_tests())
> > +               return 0;
> > +       else
> > +               return -EFAULT;
>
> Why two functions instead of just one that is the target of the
> late_initcall? Nitpick: deindent that last return and take it out of the
> else.

Yeah, it probably makes more sense to just call kunit_run_all_tests
and have it return an int.

> > +}
> > +
> > +late_initcall(kunit_executor_init);
