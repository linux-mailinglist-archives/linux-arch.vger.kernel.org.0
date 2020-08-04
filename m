Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F0E23C0A7
	for <lists+linux-arch@lfdr.de>; Tue,  4 Aug 2020 22:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgHDUSd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Aug 2020 16:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgHDUSb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Aug 2020 16:18:31 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6823C061756
        for <linux-arch@vger.kernel.org>; Tue,  4 Aug 2020 13:18:30 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g19so11349236plq.0
        for <linux-arch@vger.kernel.org>; Tue, 04 Aug 2020 13:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hzRXIsj1+SAs1tNlnSNXJanvh8FrwUG7dToFo76pgso=;
        b=Yeb/dQlVJPeL8Vx7ag5c0XCGsmI6B14mO/wfB4je5mHzE84Aurte2l0bCK6rN6ftOQ
         qiWBFA1NwEV85DMi2taxsi8Cf2xBN87c6islpm8jofcLJzirOXvI2tQaJAy8cqUpO/1g
         Qulj+Oto1t5n+WRVK4IQZIbwf6L1HIEdEsZv6SlQrBJvxGoc0biA8tqDCu43SCCpAlud
         qsYcX4lJa/218bfLRWcJcBpvRmp2yd0tFlo6LZH4rCQ1cM06SsI5jnnPyirAd8egQ1R+
         eVAd5M85sPA6sg0qtIuxiZcwx5qeeL9EdvdCbkdoA8bbdA8NbxhKZUPy20BrdS+dSyx9
         rzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hzRXIsj1+SAs1tNlnSNXJanvh8FrwUG7dToFo76pgso=;
        b=OJfVjJ8aXslavcSLAlOTYC8SYXl5AFTGV+nJ+njGOkV1E/MnmDj5ketb59RYG3yvNw
         y62PXaj1piQfTV9jAHapBVA8QLVMb8KWziV2n2cOo07oJZAK+qnZSPhOLjoHYmN7wsfB
         knHXkbReLrvBi9irlABe79ynbZ3b0MJLnSZViejVEp+UV6xidCYVlB7f4juvz0M+IFqS
         4Y7MF+VuTiHjXhpoF5i/d7OHk/r/SasVBpfugwU9wKMeXHyWHXrKEcuiN0RthtKadrSJ
         aFhnyYoOrZKThkc8lyWHLhintpVrZIzyxGdAhudiS1BQpndSWxM0sym55BUNZaY1zAZe
         rbSw==
X-Gm-Message-State: AOAM5323KZPI6CTYYMAiKr40b/8+jBS+T1ysObYKIrNMun25O1Z35/JH
        eNba5WX1O4+PwNCUev+DnEPdyO7C+HC3S+/G3mxS+g==
X-Google-Smtp-Source: ABdhPJxnSyniAwB6YYkeKPYxsQa+/C3NgF4fGYr1Y0yjfcIUeDxlK/6SOOMgIdqAj4vaOhHA3Dvuz8zhsjCp2po3Iwo=
X-Received: by 2002:a17:902:161:: with SMTP id 88mr21097385plb.325.1596572306459;
 Tue, 04 Aug 2020 13:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-11-brendanhiggins@google.com> <202006261436.DEF4906A5@keescook>
In-Reply-To: <202006261436.DEF4906A5@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 4 Aug 2020 13:18:15 -0700
Message-ID: <CAFd5g47UYGByhbY+8-EuKDg7HBLGdF9fxsZACXAiTrJZC0kkAw@mail.gmail.com>
Subject: Re: [PATCH v5 10/12] kunit: Add 'kunit_shutdown' option
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

On Fri, Jun 26, 2020 at 2:40 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 26, 2020 at 02:09:15PM -0700, Brendan Higgins wrote:
> > From: David Gow <davidgow@google.com>
> >
> > Add a new kernel command-line option, 'kunit_shutdown', which allows the
> > user to specify that the kernel poweroff, halt, or reboot after
> > completing all KUnit tests; this is very handy for running KUnit tests
> > on UML or a VM so that the UML/VM process exits cleanly immediately
> > after running all tests without needing a special initramfs.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  lib/kunit/executor.c                | 20 ++++++++++++++++++++
> >  tools/testing/kunit/kunit_kernel.py |  2 +-
> >  tools/testing/kunit/kunit_parser.py |  2 +-
> >  3 files changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index a95742a4ece73..38061d456afb2 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >
> > +#include <linux/reboot.h>
> >  #include <kunit/test.h>
> >
> >  /*
> > @@ -11,6 +12,23 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
> >
> >  #if IS_BUILTIN(CONFIG_KUNIT)
> >
> > +static char *kunit_shutdown;
> > +core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
> > +
> > +static void kunit_handle_shutdown(void)
> > +{
> > +     if (!kunit_shutdown)
> > +             return;
> > +
> > +     if (!strcmp(kunit_shutdown, "poweroff"))
> > +             kernel_power_off();
> > +     else if (!strcmp(kunit_shutdown, "halt"))
> > +             kernel_halt();
> > +     else if (!strcmp(kunit_shutdown, "reboot"))
> > +             kernel_restart(NULL);
> > +
> > +}
>
> If you have patches that do something just before the initrd, and then
> you add more patches to shut down immediately after an initrd, people
> may ask you to just use an initrd instead of filling the kernel with
> these changes...
>
> I mean, I get it, but it's not hard to make an initrd that poke a sysctl
> to start the tests...
>
> In fact, you don't even need a initrd to poke sysctls these days.

True, but it is nice to not have to maintain an initramfs for each
architecture that you want to test. Still, I see your point. If we can
find a convenient way to distribute the needed dependencies for
running KUnit on each non-UML architecture then I think I can abandon
this change.

So how about this: I will drop this patch from this patchset and move
it up to the follow up patchset that adds multiarchitecture support to
kunit_tool. There we can address the problem of how to best track the
necessary dependencies including possibly intitramfss.
