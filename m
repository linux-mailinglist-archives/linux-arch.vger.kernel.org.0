Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D51207CC3
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406390AbgFXUP2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406318AbgFXUP1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:15:27 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C1AC061573
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:15:26 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b92so1672324pjc.4
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IdPEcGBnqX+qJ5FRufYsC8Fmx34kZgyoik6khE35S6c=;
        b=LAgCJBjwd1W/QzoEvVFv6uT/xdusvMrDmvZmLReTUlSLsK29qb2r44fWyhO1UhPjLz
         uCqW0klYugm6yeBpcqwbanjBuPn8Y4d1Tu+ugG6egYFyGEsuoDAliH69triCGqr36dmi
         BMDc2ZPjjlfibF6w3Ngt7Ai+eI0QCED0XjXlZ9iFn4S8F1kjfO+ZbKzEVcatJwMuVMIJ
         QzCxLBIbzHXagWgFw39ff0eRVBOF+fHHz/VqrbQU+1mjgX/mE+n7M899/K/IafH7EGgM
         IhB3AOn5dcpYIYEwgO3/nAL0oNHI/8GAMY6MwEGOhWPMzMzE8W8bLyDD9+yilUzPos45
         Mszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IdPEcGBnqX+qJ5FRufYsC8Fmx34kZgyoik6khE35S6c=;
        b=NT8Mvddy1LE8dN0Nbfc6/6L1qW9EbaXmkjk8w/N4pmhA8ympX3S+9/tUvB0CJRS7lG
         wYQqHN6KObMVObU09CCMgzSfDSxaTi/mIX0eiBpXRNbw/SFT+ShjwZzNSWwIiZpM4oIo
         HvXoD1f7YTZvn75jkvXyu7kBkUNtB67Rdn8lN4LCyur9V2odHEOdE8cX5s1EkkUBiGhh
         jvZ3XOuVt36pRhLPZykVJ/CEicNlca6kqd9Rgnose3TgE9CVGcL3vY7lToNYXNHV09H9
         ApreUZhBjz7n3/rx3O0qParQat0Te24Hi2LA1X+vqFmgxG+eIn9ZqdZdPEjqGyzrMoMQ
         2jjQ==
X-Gm-Message-State: AOAM530JvgH8I6NDNth9PCsfTQD3V319bOekiymmt5PVgjzFJAMU+VU6
        vjnOeMgoV79/MxsOjgZocOk4I3OinfKPgfFb/ZjbVg==
X-Google-Smtp-Source: ABdhPJwWls4hrMzUFcn8SBHGpHRCDnSeZUXTbN8ExG/y1RAi8xwaghxvTb/oqHElrII6pYkocNgNnEUPoflPuaWhmtc=
X-Received: by 2002:a17:90a:3321:: with SMTP id m30mr30079924pjb.20.1593029725879;
 Wed, 24 Jun 2020 13:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200228012036.15682-1-brendanhiggins@google.com>
 <20200228012036.15682-5-brendanhiggins@google.com> <e5de96ed-fb76-d322-fa40-c6e870e76c36@gmail.com>
In-Reply-To: <e5de96ed-fb76-d322-fa40-c6e870e76c36@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 24 Jun 2020 13:15:14 -0700
Message-ID: <CAFd5g45Fi8n9YsMqV0FNrz3+wtoVtvg_Hvo7yg-MdJwwqxXqTQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] init: main: add KUnit to kernel init
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
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
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 2, 2020 at 11:13 AM Frank Rowand <frowand.list@gmail.com> wrote:

Sorry it took so long to respond. I am reviving this patchset now,
about to send out a new revision and I just saw this comment.

> On 2/27/20 7:20 PM, Brendan Higgins wrote:
> > Remove KUnit from init calls entirely, instead call directly from
> > kernel_init().
> >
> > Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  include/kunit/test.h | 9 +++++++++
> >  init/main.c          | 4 ++++
> >  lib/kunit/executor.c | 4 +---
> >  3 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 8a02f93a6b505..8689dd1459844 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -197,6 +197,15 @@ void kunit_init_test(struct kunit *test, const char *name);
> >
> >  int kunit_run_tests(struct kunit_suite *suite);
> >
> > +#if IS_BUILTIN(CONFIG_KUNIT)
>
> I suspected this would not work if a unittest was builtin but CONFIG_KUNIT
> was set to module.
>
> So I decided to experiment a bit to verify my assumptions (before applying
> this patch series).  I tried to set CONFIG_KUNIT to module, then set
> CONFIG_KUNIT_EXAMPLE_TEST to built in.  Kconfig does not let me do this
> because KUNIT_EXAMPLE_TEST is inside a 'if KUNIT' in lib/kunit/Kconfig,
> but instead switches KUNIT_EXAMPLE_TEST to a module, and warns that it
> has done so.  This was a bit of a surprise, but seems reasonable.
>
> So my next assumption is that the architecture of KUnit expects
> each individual unit test config option to depend upon CONFIG_KUNIT.
> If this is the case, please clearly document that requirement in
> the KUnit documentation.

Your assumption is correct. I will fix this in the Kconfig
documentation in a separate patch.

> > +int kunit_run_all_tests(void);
> > +#else
> > +static inline int kunit_run_all_tests(void)
> > +{
> > +     return 0;
> > +}
> > +#endif /* IS_BUILTIN(CONFIG_KUNIT) */
> > +
> >  /*
> >   * If a test suite is built-in, module_init() gets translated into
> >   * an initcall which we don't want as the idea is that for builtins
> > diff --git a/init/main.c b/init/main.c
> > index ee4947af823f3..7875a5c486dc4 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -104,6 +104,8 @@
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/initcall.h>
> >
> > +#include <kunit/test.h>
> > +
> >  static int kernel_init(void *);
> >
> >  extern void init_IRQ(void);
> > @@ -1444,6 +1446,8 @@ static noinline void __init kernel_init_freeable(void)
> >
> >       do_basic_setup();
> >
> > +     kunit_run_all_tests();
> > +
> >       console_on_rootfs();
> >
> >       /*
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index 6429927d598a5..b75a46c560847 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -11,7 +11,7 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
> >
> >  #if IS_BUILTIN(CONFIG_KUNIT)
> >
> > -static int kunit_run_all_tests(void)
> > +int kunit_run_all_tests(void)
> >  {
> >       struct kunit_suite * const * const *suites, * const *subsuite;
> >       bool has_test_failed = false;
> > @@ -31,6 +31,4 @@ static int kunit_run_all_tests(void)
> >       return 0;
> >  }
> >
> > -late_initcall(kunit_run_all_tests);
> > -
> >  #endif /* IS_BUILTIN(CONFIG_KUNIT) */
> >
>
