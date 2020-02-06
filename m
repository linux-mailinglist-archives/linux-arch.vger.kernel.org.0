Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D86F154B6D
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2020 19:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgBFSrm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Feb 2020 13:47:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45492 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgBFSrm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Feb 2020 13:47:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so2678640pls.12
        for <linux-arch@vger.kernel.org>; Thu, 06 Feb 2020 10:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rx4sRzOip+Mq3tGXU7kM2rwUAP/FgU+xMoujRQ/y4dA=;
        b=lgvMv7Qc1FR7VzTuur5zQETjZ4R1hLqWvzzOgqfbayhBhP23i0+A0FqGpEuB7DKUBV
         qUU9Exb4rnQCoSYh7ld+zLT8gVbRvAoq7i+qdijRiM80OtiTWIgeQeYfScSMWKrN5lTr
         sh8GL0Thd6+Mk8gjOO1VtjNrXhZISbfIHIfuRZihLSeUaz/gKrNAV+pJhJTLbJd+XVis
         JjIAfW0KRiSdumBRagvfqbpvjlU+I2lSPuqP5hAupoK2wrq+jJ9W/MgeBGv/0WfSWOxY
         JdckjHdCGrx/36SdGls8IO/qyexTSmGzzfw+LoXRTxQoROJUVHIRp/HRKVQs7/q6znL1
         bufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rx4sRzOip+Mq3tGXU7kM2rwUAP/FgU+xMoujRQ/y4dA=;
        b=t0MkR/17soAkohrcCgdzYtsxq1DvB8LTgKnPwT3kUghveAi/QGMstYnl/2gxpj1EdV
         i+bu6rcqJ79wS1BQ/pIWgg3+cIawPHj/vkYy+JsSHav+YpcHWHCnlBHsHn1+rahjG8mE
         nI/KFmUB4wTFePz8kGoVC/5isUjtd4/fnxKNB4Iid7NW4qB6ia5yF2TkpxK0WnRQb6Jb
         z+MrwSM3RVjGqFO7/vzHUGqk5HWLmTYd3XAT8oBxkkYc5bYfOsxtjYJfjbF3GLsBll+8
         30KK5gZJHn+wDlvHet7o5JNuIWQrYR30c8L49bbHF6mpEtQ8T1ISRgQ9c19PopEfOiX1
         ynLA==
X-Gm-Message-State: APjAAAUd1oq8+RaKOw3S9x6qlw6UdggHvvywRHxiwppbTQfNDbq1g78O
        6j0HjrkD51YfeniVS16Fr/ryACn3EefOMdBNlQ97Swzfdw4AEw==
X-Google-Smtp-Source: APXvYqwoMLnyphmn9jqUaL6zuzdMwQhZMO0C2FVmu1LrHrHVcviCyfV/O9rId5UR/by0bAMcdwlU6ZoLG29qVB4ScLk=
X-Received: by 2002:a17:90a:6c26:: with SMTP id x35mr5868897pjj.84.1581014860109;
 Thu, 06 Feb 2020 10:47:40 -0800 (PST)
MIME-Version: 1.0
References: <20200130230812.142642-1-brendanhiggins@google.com>
 <20200130230812.142642-6-brendanhiggins@google.com> <69582db9-d379-7d2a-1342-6de9a5d79141@gmail.com>
In-Reply-To: <69582db9-d379-7d2a-1342-6de9a5d79141@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 6 Feb 2020 10:47:28 -0800
Message-ID: <CAFd5g45jHKXoMU4k103cqfeTAtUpaZh7ZK2ALpzHkRZTuVYa-g@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] kunit: test: add test plan to KUnit TAP format
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
        Knut Omang <knut.omang@oracle.com>,
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

On Tue, Feb 4, 2020 at 3:01 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 1/30/20 5:08 PM, Brendan Higgins wrote:
> > TAP 14 allows an optional test plan to be emitted before the start of
> > the start of testing[1]; this is valuable because it makes it possible
> > for a test harness to detect whether the number of tests run matches the
> > number of tests expected to be run, ensuring that no tests silently
> > failed.
> >
> > Link[1]: https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md#the-plan
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  lib/kunit/executor.c                          | 17 +++++
> >  lib/kunit/test.c                              | 11 ---
> >  tools/testing/kunit/kunit_parser.py           | 74 ++++++++++++++++---
> >  .../test_is_test_passed-all_passed.log        |  1 +
> >  .../test_data/test_is_test_passed-crash.log   |  1 +
> >  .../test_data/test_is_test_passed-failure.log |  1 +
> >  6 files changed, 82 insertions(+), 23 deletions(-)
> >
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index b75a46c560847..7fd16feff157e 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -11,11 +11,28 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
> >
> >  #if IS_BUILTIN(CONFIG_KUNIT)
> >
> > +static void kunit_print_tap_header(void)
> > +{
> > +     struct kunit_suite * const * const *suites, * const *subsuite;
> > +     int num_of_suites = 0;
> > +
> > +     for (suites = __kunit_suites_start;
> > +          suites < __kunit_suites_end;
> > +          suites++)
> > +             for (subsuite = *suites; *subsuite != NULL; subsuite++)
> > +                     num_of_suites++;
> > +
> > +     pr_info("TAP version 14\n");
> > +     pr_info("1..%d\n", num_of_suites);
> > +}
> > +
>
> Subsuites are not in Linux 5.5, as far as I can tell, so it is hard to review
> this.
>
> But I think this observation will still be valid even though I am not up
> to speed on subsuites.

"substitutes" are just an artifact from having to group together all
suites that occur in a module. It should be mostly immaterial to most
users, but we have to have all the suites that occur in a module
grouped together in order to support KUnit tests as loadable modules.

I just call them subsuites here because I didn't know what else to
call them. Still, the relationship between them should be mostly
ignored by users as you seem to recognize below.

Also, module support for KUnit was just recently accepted into torvalds/master:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=08a3ef8f6b0b1341c670caba35f782c9a452d488

You should be able to apply this change to torvalds/master now.

> num_of_suites is all test suites declared (as built in).  In Linux 5.5,
> each kunit_suite contains one or more test cases.  Each test case leads
> to either "ok" or "not ok".  So instead of counting number of tests
> suites, the number of test cases needs to be counted.

Nope, but I think you understand correctly below...

> Ahhh, I think my lack of visibility of what tree this series is against
> is about to lead me astray!  Are the test cases in the subsuite
> implemented as what TAP 14 calls "subtests"?  If so, then the above
> code that counts suites instead of test cases would be correct.

Yep! You got it! Test cases are "subtests" in TAP 14. So there is a
ok/not ok line for each suite, and nested as subtests above that are
indented ok/not ok lines for each test case. KUnit already does this
today. We are just moving some of the printing logic out so we can
count the suites and print a test plan.

Technically, what we print today (before this change) is legal TAP 14.
The test plan is not required. However, the test plan is very helpful
as it makes it possible to know if some tests just never ran for some
reason.

> I'm spinning my wheels now, since I don't know what I am
> reviewing against, so I'm going to stop reviewing, other
> than maybe a quick scan.

I just applied this patch series against torvalds/master which I
pulled this morning, and it applied cleanly. I will specify in any
subsequent revisions that this is based on linux-kselftest/kunit since
that's where these patches will be applied, but they should apply
against any rc of 5.6 just fine once they are cut.

Cheers!
