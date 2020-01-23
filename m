Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 686FC1473ED
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 23:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgAWWko (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 17:40:44 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35073 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbgAWWko (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 17:40:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id i23so103309pfo.2
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 14:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEO5RRq71hnfJzVbmmj/bta230sQfzGD9Q3CFZNo8bQ=;
        b=JJZJSgBA4/GNyFP89Pda6hSb1oTAE22vcl/FqnmgKFp+rlhP52bXisMa5Z1YpG2ayF
         02BwEJjwJq6gfLI8kFYia/lvubDLgINiKn1k2/rxdutHAgRfgIXvdFNfUSVEClXYIFfx
         aJMDzF803GbX9uQj7bR8+GZI5SsddDIa64sVLMbb8ztlS7Pb7IOlOMGpAehw/dNW/u3C
         x0Uftjah9HTIHs6iTqyG7KURJeCFBp0uehfmASOSu8ZM2cMZkHHcMGWHGPCICA1R9ET4
         OY4WwV85BuU8sgOAJUctUTI1u45UcC+SU1dxu/aMVMTRg6x+QCTReEX6TjgHYPo/7Z2f
         mQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEO5RRq71hnfJzVbmmj/bta230sQfzGD9Q3CFZNo8bQ=;
        b=B6SslPM5NyEOhPUJ0GuFrUjfQmm5jJ7rgO54/E20KCzQDsHSDP+teJbM5uhJL0UQLa
         YOGH6OoOjGvBScNZV1HyORqP+Bi5i20cxra9VSOosAjF87dlVA2uj8t57FLTMUZAMZAJ
         3nWxpV5VdKALMYTn2hE8mDsp/bf49SRVSQ4HM/ZgIxZ+XuyGJlXrCIPlayCyRtjvDL6D
         c6R53ZcCVxzy/fFO6+d2aM9LghBQNz8vJ+kiiJdMkKdFwsBNIaap+Xg9WeXwg1sZa3X2
         mGKWo/JXXRt9acvJbLesnPTKu6c+xwQAjqm4iaLIS2lp9Se++3qCV/X+v/WysgUosYU5
         EVkw==
X-Gm-Message-State: APjAAAWT1wj1dGmN3fUdYKo20orB72hanjem7gyF8TqIuBdkOXA/MK4p
        noRYmx8/3aNxxsBqIt/2mL3EMdHiowaLnuX+hH0uvw==
X-Google-Smtp-Source: APXvYqwc5+ImnRduKdxPTBPywNf0s9F86ySTTxo9u4cZHfgljqhVhzLbRX6dzr7ZeLApaJLaf6jrkPiJpeVQi3MwCJg=
X-Received: by 2002:a63:597:: with SMTP id 145mr651932pgf.384.1579819242951;
 Thu, 23 Jan 2020 14:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com> <20200106224022.GX11244@42.do-not-panic.com>
In-Reply-To: <20200106224022.GX11244@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 23 Jan 2020 14:40:31 -0800
Message-ID: <CAFd5g456c2Zs7rCvRPgio83G=SrtPGi25zbqAUyTBHspHwtu4w@mail.gmail.com>
Subject: Re: [RFC v1 0/6] kunit: create a centralized executor to dispatch all
 KUnit tests
To:     Luis Chamberlain <mcgrof@kernel.org>
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

Sorry for the late reply. I am still catching up from being on vacation.

On Mon, Jan 6, 2020 at 2:40 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Dec 16, 2019 at 02:05:49PM -0800, Brendan Higgins wrote:
> > ## TL;DR
> >
> > This patchset adds a centralized executor to dispatch tests rather than
> > relying on late_initcall to schedule each test suite separately along
> > with a couple of new features that depend on it.
> >
> > ## What am I trying to do?
> >
> > Conceptually, I am trying to provide a mechanism by which test suites
> > can be grouped together so that they can be reasoned about collectively.
> > The last two patches in this series add features which depend on this:
> >
> > RFC 5/6 Prints out a test plan right before KUnit tests are run[1]; this
> >         is valuable because it makes it possible for a test harness to
> >         detect whether the number of tests run matches the number of
> >         tests expected to be run, ensuring that no tests silently
> >         failed.
> >
> > RFC 6/6 Add a new kernel command-line option which allows the user to
> >         specify that the kernel poweroff, halt, or reboot after
> >         completing all KUnit tests; this is very handy for running KUnit
> >         tests on UML or a VM so that the UML/VM process exits cleanly
> >         immediately after running all tests without needing a special
> >         initramfs.
>
> The approach seems sensible to me given that it separates from a
> semantics perspective kernel subsystem init work from *testing*, and
> so we are sure we'd run the *test* stuff *after* all subsystem init
> stuff.

Cool, I thought you would find this interesting.

> Dispatching, however is still immediate, and with a bit of work, this
> dispatcher could be configurable to run at an arbirary time after boot.
> If there are not immediate use cases for that though, then I suppose
> this is not a requirement for the dispatcher. But since there exists
> another modular test framework with its own dispatcher and it seems the
> goal is to merge the work long term, this might preempt the requirement
> to define how and when we can dispatch tests post boot.
>
> And, if we're going to do that, I can suggest that a data structure
> instead of just a function init call be used to describe tests to be
> placed into an ELF section. With my linker table work this would be
> easy, I define section ranges for code describing only executable
> routines, but it defines linker tables for when a component in the
> kernel would define a data structure, part of which can be a callback.
> Such data structure stuffed into an ELF section could allow dynamic
> configuration of the dipsatching, even post boot.

The linker table work does sound interesting. Do you have a link?

I was thinking about dynamic dispatching, actually. I thought it would
be handy to be able to build all tests into a single kernel and then
run different tests on different invocations.

Also, for post boot dynamic dispatching, you should check out Alan's
debugfs patches:

https://lore.kernel.org/linux-kselftest/CAFd5g46657gZ36PaP8Pi999hPPgBU2Kz94nrMspS-AzGwdBF+g@mail.gmail.com/T/#m210cadbeee267e5c5a9253d83b7b7ca723d1f871

They look pretty handy!

> I think this is a good stepping stone forward then, and to allow
> dynamic configuration of the dispatcher could mean eventual extensions
> to kunit's init stuff to stuff init calls into a data structure which
> can then allow configuration of the dispatching. One benefit that the
> linker table work *may* be able to help here with is that it allows
> an easy way to create kunit specific ordering, at linker time.
> There is also an example of addressing / generalizing dynamic / run time
> changes of ordering, by using the x86 IOMMU initialization as an
> example case. We don't have an easy way to do this today, but if kunit
> could benefit from such framework, it'd be another use case for
> the linker table work. That is, the ability to easilly allow
> dynamically modifying run time ordering of code through ELF sections.
>
> > In addition, by dispatching tests from a single location, we can
> > guarantee that all KUnit tests run after late_init is complete, which
> > was a concern during the initial KUnit patchset review (this has not
> > been a problem in practice, but resolving with certainty is nevertheless
> > desirable).
>
> Indeed, the concern is just a real semantics limitations. With the tests
> *always* running after all subsystem init stuff, we know we'd have a
> real full kernel ready.

Yep.

> It does beg the question if this means kunit is happy to not be a tool
> to test pre basic setup stuff (terminology used in init.c, meaning prior
> to running all init levels). I suspect this is the case.

Not sure. I still haven't seen any cases where this is necessary, so I
am not super worried about it. Regardless, I don't think this patchset
really changes anything in that regard, we are moving from late_init
to after late_init, so it isn't that big of a change for most use
cases.

Please share if you can think of some things that need to be tested in
early init.

> > Other use cases for this exist, but the above features should provide an
> > idea of the value that this could provide.
> >
> > ## What work remains to be done?
> >
> > These patches were based on patches in our non-upstream branch[2], so we
> > have a pretty good idea that they are useable as presented;
> > nevertheless, some of the changes done in this patchset could
> > *definitely* use some review by subsystem experts (linker scripts, init,
> > etc), and will likely change a lot after getting feedback.
> >
> > The biggest thing that I know will require additional attention is
> > integrating this patchset with the KUnit module support patchset[3]. I
> > have not even attempted to build these patches on top of the module
> > support patches as I would like to get people's initial thoughts first
> > (especially Alan's :-) ). I think that making these patches work with
> > module support should be fairly straight forward, nevertheless.
>
> Modules just have their own sections too. That's all. So it'd be a
> matter of extending the linker script for modules too. But a module's
> init is different than the core kernel's for vmlinux.

Truth. It seems as though Alan has already fixed this for me, however.
