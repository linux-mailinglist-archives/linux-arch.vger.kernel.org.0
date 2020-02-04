Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C55E15225B
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2020 23:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbgBDWbA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Feb 2020 17:31:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43531 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbgBDWa7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Feb 2020 17:30:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id u131so10375680pgc.10
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 14:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q2uQL/PRw6ZnTDrqiiea6tiCZJLGBQe2LOHyEh5sDJ4=;
        b=t2lvJ5eRV7fNHCyOWIUVU0qCE/DfBdKo5P3ClEetu7j6GGIg2XASjLWPCBjl+34JdE
         6ny6Y50jnfQsvBTWE1bwkdPqA0V8rodl3y1fXWxaInCOxiDPKI5DUt82uL3CnbUIafy9
         p08FhbQrlWgcsmJQvhAt6LDgCuDy0Fw8IFLxqHZAcrgagsyrlNbbkaF/Ii3npSR+IoUI
         7eByhr9nXLvJjCI+LJUlnSG+u4qzSxSKnByGmAj0+1wVSggoDvkGvv2O4f68xPLPiwOn
         Eo9phXx8Duaklg8yw1cjFIKRIWdEeopuCCSX9Kfw4oX4UghVR0PeWwCphaOK3w9JQYsP
         2iuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2uQL/PRw6ZnTDrqiiea6tiCZJLGBQe2LOHyEh5sDJ4=;
        b=siuMQw6ZoRZyfD4MmVMuH2wG123Oqp82d43k3hgsNHNF6Dg80SYIWtXr3ofPBfUSJp
         qf1wVjfFBtsuh6gzvA49EmnVd/aDUDgEYDsxcv7hoOqvEiW8mFAXQ76fMe8syjrMiI88
         z7UlFb7vBqnxLRMPVUxxMrXalxrEVNgTMhi5dp/xYvwrGAda522hsEyFzxdyBbQs7+vm
         cUjFVLijadgB8ou22LELISlN/lFVxvEE+g0ZHF8qm45fv2jGQUTUuqHEP42U6S2rjle8
         NGtJYm3gTUcLFbeg+O0rhqKqHWOJXwRY6HIC+4PJP3j70phZfHoCkdVwEYSCfszyE8UB
         +O+A==
X-Gm-Message-State: APjAAAVpO6fGx2wxgYS6OuEjPZ0GmxHKVvjI2s/+6qzhLbe0c5BQXVqy
        079bheqPVlqWboDWgci0KBP//oNSfqZLZ7wEZfKv8w==
X-Google-Smtp-Source: APXvYqwSZaY//8PRrbH3D4/3OyG0Roy306tCq51bwzXFTdTrGyFV7FF3+o89xhSA7oOCZ+Nwi4dbqV2Jsg3SEvbuwuI=
X-Received: by 2002:aa7:8545:: with SMTP id y5mr29917679pfn.185.1580855458475;
 Tue, 04 Feb 2020 14:30:58 -0800 (PST)
MIME-Version: 1.0
References: <20200130230812.142642-1-brendanhiggins@google.com>
 <20200130230812.142642-3-brendanhiggins@google.com> <e060bdfc-5cdb-fb62-48b0-cc54c7bc72ce@gmail.com>
In-Reply-To: <e060bdfc-5cdb-fb62-48b0-cc54c7bc72ce@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 4 Feb 2020 14:30:47 -0800
Message-ID: <CAFd5g46irbQ7j_DOY+bQPoo1TWjwvu6n9iyQ7abe9pfqydeMYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] arch: um: add linker section for KUnit test suites
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

On Tue, Feb 4, 2020 at 1:59 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 1/30/20 5:08 PM, Brendan Higgins wrote:
> > Add a linker section to UML where KUnit can put references to its test
> > suites. This patch is an early step in transitioning to dispatching all
> > KUnit tests from a centralized executor rather than having each as its
> > own separate late_initcall.
>
> All architectures please.

I *am* supporting all architectures with this patchset.

The first patch in this series adds support to all architectures
except UML (admittedly I only tried x86 and ARM, 32 bit and 64 bit for
both, but I am pretty sure someone tried it for POWER and something
else, so maybe I should try it with others before submission). A patch
specific for UML, this patch, was needed because UML is a special
snowflake and has a bunch of special linker scripts that don't make
the change in vmlinux.lds.h (the previous patch) sufficient.

> The early versions of Kunit documented reliance on UML.  Discussion lead to
> the conclusion that real architectures and real hardware would be supported.

I am *very* aware.

I would never intentionally break support for other architectures. I
know it is very important to you, Alan, and others.

> This like this are what make me reluctant to move devicetree unittests to
> KUnit.

Hopefully I can reassure you then:

With Alan as a regular contributor who cares very much about non-UML
architectures, it would be very unlikely for me to accidentally break
support for other architectures without us finding out before a
release.

I also periodically test KUnit on linux-next on x86-64. I have gotten
bugs for other architectures from Arnd Bergmann and one of the m86k
maintainers who seems to play around with it as well.

So yeah, other people care about this too, and I would really not want
to make any of them unhappy.

> Can you please add a section to the KUnit documentation that lists things
> like the expectations, requirements, limitations, etc for a test case that
> is run by KUnit?  Some examples that pop to mind from recent discussions
> and my own experiences:
>
>   - Each test case is invoked after late_init is complete.
>       + Exception: the possible value of being able to run a unit test
>         at a specific runlevel has been expressed.  If an actual unit
>         test can be shown to require running earlier, this restriction
>         will be re-visited.
>
>   - Each test case must be idempotent.  Each test case may be called
>     multiple times, and must generate the same result each time it
>     is called.
>       + Exception 1: a test case can be declared to not be idempotent
>         [[ mechanism TBD ]], in which case KUnit will not call the
>         test case a second time without the kernel rebooting.
>       + Exception 2: hardware may not be deterministic, so a test that
>         always passes or fails when run under UML may not always to
>         so on real hardware.  <--- sentence copied from
>         Documentation/dev-tools/kunit/usage.rst
>           [[ This item and 1st exception do not exist yet, but will exist
>           in some form if the proposed proc filesystem interface is
>           added. ]]
>
>   - KUnit provides a helpful wrapper to simplify building a UML kernel
>     containing the KUnit test cases, booting the UML kernel, and
>     formatting the output from the test cases.  This wrapper MUST NOT
>     be required to run the test cases or to determine a test result.
>     The formatting may provide additional analysis and improve
>     readability of a test result.
>
>   - .... There is more that belongs here, but I'm getting side tracked
>     here, when I'm trying to instead convert devicetree unittests to
>     KUnit and want to get back to that.

Sure, I think that's a great start! Thanks for that. I hope you don't
mind if I copy and paste some of it.

It kind of sounds like you are talking about more of a requirements
doc than the design doc I was imagining in my reply to you on the
cover letter, which is fine. The documentation is primarily for people
other than me, so whatever you and others think is useful, I will do.
