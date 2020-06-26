Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4794620BB2F
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jun 2020 23:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgFZVKq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Jun 2020 17:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgFZVKp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Jun 2020 17:10:45 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2F8C03E97A
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:10:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e8so5471766pgc.5
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=09jAsYJwkYqWgGeIN0AmuyG0GtAikBUajiEMgtPwz8E=;
        b=gTf/NCTsGV+cR4OJogDUOEozyx3Kt5iCbwGn5JHed6Y70CEMvMZc/luJ26cOdFy8ke
         OYW1GQ1OMcwz4Z9uUfrZXiebF+fXcJ51ZHIJ5wKqAD3oNMe82EuutU5NiXcvHMaXW5Oc
         JbV70b8V5sFO6Va9uJXEMrt7TP12KFXr+/JMcgwCsQQKc43QlYFlNEaFxn9MFIxPvy5o
         lukPR0L3ef5ZfH+cacvZzAmasnZzJdLNCH16FmhQOFYZuhrMsqNjvR8pH0z6EgyWG/s6
         p6c02u2KroQ6jxAyHz0+CyO02PEGoJ9hPkCM5rdhl8cJB6+rJCU9gTlYgFYmqoi4mKsG
         brww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09jAsYJwkYqWgGeIN0AmuyG0GtAikBUajiEMgtPwz8E=;
        b=p+HJ50oRNDZibzD1w5nguL6knJm9We9lb0ExlgILcqYEkKywBN2Oq6q9CdcqXSPGYi
         OTfj1vY4uiGd22h7GhkMMvWQRyj+ly5lIODOraKEGaX3oUgCy64/65Kj3bhm87eQmXjg
         jHev4ZgdauG6K0jh/Gm7QZhzANv6GPlG1RK+wjZGU26f+Sq7PcaiF5AcDizUhKBMI0Tr
         WemmriihX4Gs+cIxHTykq0thXtsX6T1EK6nwAz15epy5Kxdj7UfaC5eFlByzShNbSG7n
         iX8G08jfDinwneBesOUY6RDdvvyH7n5dTesOvGsuiXpmKTaa20/T7md16lf0V268A4UD
         i1NA==
X-Gm-Message-State: AOAM532IDuVHMzMollyuDthKKl5CcR5SJHvwZbPQ70+1XHAfdf3c/AV3
        B2Y6oIbbWAz0y8Vb7AMg7hMvAATD3qCkjPBYuFpN9Q==
X-Google-Smtp-Source: ABdhPJwuegEmd5G894HChNiLM7h4gJuaN8Wc5CXNSzQMEhNA4KwPQMXU98hdZFQs5nkdIQPqCAyGMKTUoIv9MhK2mDs=
X-Received: by 2002:a62:1d52:: with SMTP id d79mr4436505pfd.106.1593205844721;
 Fri, 26 Jun 2020 14:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com> <CABVgOSnkYfXZ1YELsXAjA0GzCQT9YWO8x+Tssw_+avkDdBB4aw@mail.gmail.com>
In-Reply-To: <CABVgOSnkYfXZ1YELsXAjA0GzCQT9YWO8x+Tssw_+avkDdBB4aw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 26 Jun 2020 14:10:33 -0700
Message-ID: <CAFd5g45x04Q+r+1M+kwqkp1DsY9PjJN+Gs0Q+MkOdYTz0SdzKw@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] kunit: create a centralized executor to dispatch
 all KUnit tests
To:     David Gow <davidgow@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Frank Rowand <frowand.list@gmail.com>, catalin.marinas@arm.com,
        will@kernel.org, monstr@monstr.eu,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Wed, Jun 24, 2020 at 6:47 PM David Gow <davidgow@google.com> wrote:
>
> Glad this is back out there: a couple of minor nitpicks below:
>
> On Thu, Jun 25, 2020 at 4:58 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > ## TL;DR
> >
> > This patchset adds a centralized executor to dispatch tests rather than
> > relying on late_initcall to schedule each test suite separately along
> > with a couple of new features that depend on it.
> >
> > Also, sorry for the extreme delay in getting this out. Part of the delay
> > came from finding that there were actually several architectures that
> > the previous revision of this patchset didn't work on, so I went through
> > and attempted to test this patchset on every architecture - more on that
> > later.
> >
> > ## What am I trying to do?
> >
> > Conceptually, I am trying to provide a mechanism by which test suites
> > can be grouped together so that they can be reasoned about collectively.
> > The last two of three patches in this series add features which depend
> > on this:
> >
> > PATCH 8/11 Prints out a test plan[1] right before KUnit tests are run;
> >            this is valuable because it makes it possible for a test
> >            harness to detect whether the number of tests run matches the
> >            number of tests expected to be run, ensuring that no tests
> >            silently failed. The test plan includes a count of tests that
> >            will run. With the centralized executor, the tests are
> >            located in a single data structure and thus can be counted.
> >
>
> This appears to actually be patch 9/11.
>
> > PATCH 9/11 Add a new kernel command-line option which allows the user to
> >            specify that the kernel poweroff, halt, or reboot after
> >            completing all KUnit tests; this is very handy for running
> >            KUnit tests on UML or a VM so that the UML/VM process exits
> >            cleanly immediately after running all tests without needing a
> >            special initramfs. The centralized executor provides a
> >            definitive point when all tests have completed and the
> >            poweroff, halt, or reboot could occur.
>
> This seems to have been merged into the above patch (9/11).

Whoops, good catch.

Fixed in v5!

> > In addition, by dispatching tests from a single location, we can
> > guarantee that all KUnit tests run after late_init is complete, which
> > was a concern during the initial KUnit patchset review (this has not
> > been a problem in practice, but resolving with certainty is nevertheless
> > desirable).
> >
> > Other use cases for this exist, but the above features should provide an
> > idea of the value that this could provide.
> >
> > ## Changes since last revision:
> >  - On the last revision I got some messages from 0day that showed that
> >    this patchset didn't work on several architectures, one issue that
> >    this patchset addresses is that we were aligning both memory segments
> >    as well as structures in the segments to specific byte boundaries
> >    which was incorrect.
> >  - The issue mentioned above also caused me to test on additional
> >    architectures which revealed that some architectures other than UML
> >    do not use the default init linker section macro that most
> >    architectures use. There are now several new patches (2, 3, 4, and
> >    6).
> >  - Fixed a formatting consistency issue in the kernel params
> >    documentation patch (9/9).
> >  - Add a brief blurb on how and when the kunit_test_suite macro works.
> >
> > ## Remaining work to be done:
> >
> > The only architecture for which I was able to get a compiler, but was
> > apparently unable to get KUnit into a section that the executor to see
> > was m68k - not sure why.
> >
> > Alan Maguire (1):
> >   kunit: test: create a single centralized executor for all tests
> >
> > Brendan Higgins (10):
> >   vmlinux.lds.h: add linker section for KUnit test suites
> >   arch: arm64: add linker section for KUnit test suites
> >   arch: microblaze: add linker section for KUnit test suites
> >   arch: powerpc: add linker section for KUnit test suites
> >   arch: um: add linker section for KUnit test suites
> >   arch: xtensa: add linker section for KUnit test suites
> >   init: main: add KUnit to kernel init
> >   kunit: test: add test plan to KUnit TAP format
> >   Documentation: Add kunit_shutdown to kernel-parameters.txt
> >   Documentation: kunit: add a brief blurb about kunit_test_suite
> >
> >  .../admin-guide/kernel-parameters.txt         |   8 ++
> >  Documentation/dev-tools/kunit/usage.rst       |   5 ++
> >  arch/arm64/kernel/vmlinux.lds.S               |   3 +
> >  arch/microblaze/kernel/vmlinux.lds.S          |   4 +
> >  arch/powerpc/kernel/vmlinux.lds.S             |   4 +
> >  arch/um/include/asm/common.lds.S              |   4 +
> >  arch/xtensa/kernel/vmlinux.lds.S              |   4 +
> >  include/asm-generic/vmlinux.lds.h             |   8 ++
> >  include/kunit/test.h                          |  73 ++++++++++++-----
> >  init/main.c                                   |   4 +
> >  lib/kunit/Makefile                            |   3 +-
> >  lib/kunit/executor.c                          |  63 +++++++++++++++
> >  lib/kunit/test.c                              |  13 +--
> >  tools/testing/kunit/kunit_kernel.py           |   2 +-
> >  tools/testing/kunit/kunit_parser.py           |  74 +++++++++++++++---
> >  .../test_is_test_passed-all_passed.log        | Bin 1562 -> 1567 bytes
> >  .../test_data/test_is_test_passed-crash.log   | Bin 3016 -> 3021 bytes
> >  .../test_data/test_is_test_passed-failure.log | Bin 1700 -> 1705 bytes
> >  18 files changed, 226 insertions(+), 46 deletions(-)
> >  create mode 100644 lib/kunit/executor.c
> >
> >
> > base-commit: 4333a9b0b67bb4e8bcd91bdd80da80b0ec151162
> > prerequisite-patch-id: 2d4b5aa9fa8ada9ae04c8584b47c299a822b9455
> > prerequisite-patch-id: 582b6d9d28ce4b71628890ec832df6522ca68de0
> >
> > These patches are available for download with dependencies here:
> >
> > https://kunit-review.googlesource.com/c/linux/+/3829
> >
> > [1] https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md#the-plan
> > [2] https://patchwork.kernel.org/patch/11383635/
> >
> > --
> > 2.27.0.212.ge8ba1cc988-goog
> >
