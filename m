Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB125152263
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2020 23:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgBDWfk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Feb 2020 17:35:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46358 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgBDWfk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Feb 2020 17:35:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so7868553pll.13
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 14:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wW0tjd+cBxeR6/lhPUUjx0fEpBoP1LYYTT0FsIiI1ho=;
        b=icGZp+gWX8+ra8EaRzj0omZeGdmp0NxlbomRJ1M8RaU/WQNP+zqgYuJZSPFcaiWcnZ
         2pCWkyEpTMGGCi9alcZbNMp01PJ6HAZzwmE6trVB6wWJfukGW4fmAYtsgfiXedtOqqRT
         bmFSWApPulYRdVfiU3CIZn8jePJi3U2HzSVo++6ZSgzVHry0vhZ3v1h/qeuxOx83W3He
         S2QBe7oA9erOEncvfIOndMP6l3GHqBJB+9L+ElZ0vc5VnS5GueU9EJ3BnmcLAsA1zQb2
         zG+yXK+320g1OiPoDFO6spKz5/W1GSM7NskP7wp/j9iQ7LQ71cVXLbv42DtWh8/5ZB7g
         33Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wW0tjd+cBxeR6/lhPUUjx0fEpBoP1LYYTT0FsIiI1ho=;
        b=mcrPtdW3LudL5kYPNmUf5I4qDD8SkttDv3GYt1MLMpzWe16+gfPx1Z1nORDwp1AApH
         m0rViN5CxTLtSwqrSMLqPw4/Tj/58dyYp4xHHf3HBtMVgnzM7kMr3KZpjD/oPuJW7588
         dUyipbtYLFwLX9zFoGvqg8F9PON1s8JE3ShJ1RDVui+ZyHeo6e8bYVFwGKpMUt20pJhf
         2fXeQ0WQcvQDunPp6hPvpQnGglleGi3odKegv2bVZrIiWVNJu5M409E+7mo2zPWzqLHd
         sm46Xg1MVYJhpsIhzl9OrQw3WlOt87Hxp3P/1cCVMm1LGzv63R11Ub9QNyf/mqTSS7OY
         ZKJw==
X-Gm-Message-State: APjAAAXJlr0hto+4oXZUXD0dTjMen9lL/1qzNuTZLr6i+t/1RW4M8RTI
        IermrYOv6RqlHyX6S0LGEKhcnLtpfTqdVwxGAJ8xFg==
X-Google-Smtp-Source: APXvYqy0w6xoiM6E9N7yfGOvN2yylEfVSD+LT3cHC469AG7ZzC1NJLwbAZS26Rmu1su+jZ8vZlXD5Lh2v7ZgeQA4us4=
X-Received: by 2002:a17:902:fe8d:: with SMTP id x13mr32717392plm.232.1580855739838;
 Tue, 04 Feb 2020 14:35:39 -0800 (PST)
MIME-Version: 1.0
References: <20200130230812.142642-1-brendanhiggins@google.com>
 <20200130230812.142642-4-brendanhiggins@google.com> <11977708-bb18-e322-db7a-9f21d7cdec54@gmail.com>
In-Reply-To: <11977708-bb18-e322-db7a-9f21d7cdec54@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 4 Feb 2020 14:35:28 -0800
Message-ID: <CAFd5g47d3=drrSAOMpn_BOf8Gw94mfdJ6NrmroRf4a__=PCEWg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] kunit: test: create a single centralized executor
 for all tests
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

On Tue, Feb 4, 2020 at 2:27 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 1/30/20 5:08 PM, Brendan Higgins wrote:
> > From: Alan Maguire <alan.maguire@oracle.com>
> >
> > Add a centralized executor to dispatch tests rather than relying on
> > late_initcall to schedule each test suite separately.  Centralized
> > execution is for built-in tests only; modules will execute tests
> > when loaded.
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > Co-developed-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  include/kunit/test.h | 73 +++++++++++++++++++++++++++-----------------
> >  lib/kunit/Makefile   |  3 +-
> >  lib/kunit/executor.c | 36 ++++++++++++++++++++++
> >  3 files changed, 83 insertions(+), 29 deletions(-)
> >  create mode 100644 lib/kunit/executor.c
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 2dfb550c6723a..8a02f93a6b505 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
>
> The following fragment does not match the test.h in Linux 5.5 or 5.4-rc1 (as one
> possible earlier version).  And we are not to Linux 5.5-rc1 yet.  (Simple way
> to check for the mis-match - 5.5 has kunit_test_suite() instead of
> kunit_test_suites().)
>
> I know that there is an alternate tree where some of the development occurs.
> Can you please add a link in MAINTAINERS?  And please note (at least in
> patch 0) what tree the series is developed against?

Yep, I was planning on sending an update to the MAINTAINERS with that
and some other updates soon.

In future revisions, I will put a link to the tree I developed
against. In the meantime, we send pull-requests from here:

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=kunit

And that is what I used as my development base for this series.
