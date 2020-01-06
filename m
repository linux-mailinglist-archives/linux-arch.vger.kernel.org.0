Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95AA3131BA6
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2020 23:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgAFWkZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jan 2020 17:40:25 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36615 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgAFWkZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jan 2020 17:40:25 -0500
Received: by mail-pj1-f66.google.com with SMTP id n59so8360559pjb.1;
        Mon, 06 Jan 2020 14:40:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J3SHa4E3cS4gmRhRrRRBbMGMmQ7Swg+W9fTvK+8fgbo=;
        b=QghAxNwbOpNWeCKcrY4MMLZJDUQrnsxywtSSfQVR5bQV7M+M7rv++XgA1gpLo82bsC
         u59y/+LWBBr9YFYFfA0mH9/w8rXC9HyccLw7jQp1J7tS35SiY0zVscJ0WDjuRV3leyD4
         gL7MRC+3jEgMXXSKVfKqFERRppct64iAp9BqPkRDLllU/3i/SQVahZ8MyMZnOCe8gWpI
         pwViZWkaAakjgW4Lj3ptsQwvM5CuqwpE6TNYNxu8TvOUMrN43V41cpBlf/3zhVQUrpav
         kJ8xa9NBgUxpisaayWNgqQY/brAFzqZHpAiXaRRAxoPcS86fWZhQPq/IXG5TFMiHDUaQ
         +dQg==
X-Gm-Message-State: APjAAAUUxReqDbtdTWKNz8LmFT/p55tdw/2g+BT6Uew853S8b2jW/y6l
        HCj1Ra1T5PvtDw6BNNbhl6k=
X-Google-Smtp-Source: APXvYqzL/Or94L+UYrmZszgXQkyK1iniMt70cGilBDndaFa7eg0lzxl/eodRL6mwFRsCXTaDCoazNg==
X-Received: by 2002:a17:902:8f85:: with SMTP id z5mr108553143plo.43.1578350424536;
        Mon, 06 Jan 2020 14:40:24 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s24sm81687763pfd.161.2020.01.06.14.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:40:23 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9822040321; Mon,  6 Jan 2020 22:40:22 +0000 (UTC)
Date:   Mon, 6 Jan 2020 22:40:22 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        knut.omang@oracle.com, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 0/6] kunit: create a centralized executor to dispatch
 all KUnit tests
Message-ID: <20200106224022.GX11244@42.do-not-panic.com>
References: <20191216220555.245089-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216220555.245089-1-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 16, 2019 at 02:05:49PM -0800, Brendan Higgins wrote:
> ## TL;DR
> 
> This patchset adds a centralized executor to dispatch tests rather than
> relying on late_initcall to schedule each test suite separately along
> with a couple of new features that depend on it.
> 
> ## What am I trying to do?
> 
> Conceptually, I am trying to provide a mechanism by which test suites
> can be grouped together so that they can be reasoned about collectively.
> The last two patches in this series add features which depend on this:
> 
> RFC 5/6 Prints out a test plan right before KUnit tests are run[1]; this
>         is valuable because it makes it possible for a test harness to
>         detect whether the number of tests run matches the number of
>         tests expected to be run, ensuring that no tests silently
>         failed.
> 
> RFC 6/6 Add a new kernel command-line option which allows the user to
>         specify that the kernel poweroff, halt, or reboot after
>         completing all KUnit tests; this is very handy for running KUnit
>         tests on UML or a VM so that the UML/VM process exits cleanly
>         immediately after running all tests without needing a special
>         initramfs.

The approach seems sensible to me given that it separates from a
semantics perspective kernel subsystem init work from *testing*, and
so we are sure we'd run the *test* stuff *after* all subsystem init
stuff.

Dispatching, however is still immediate, and with a bit of work, this
dispatcher could be configurable to run at an arbirary time after boot.
If there are not immediate use cases for that though, then I suppose
this is not a requirement for the dispatcher. But since there exists
another modular test framework with its own dispatcher and it seems the
goal is to merge the work long term, this might preempt the requirement
to define how and when we can dispatch tests post boot.

And, if we're going to do that, I can suggest that a data structure
instead of just a function init call be used to describe tests to be
placed into an ELF section. With my linker table work this would be
easy, I define section ranges for code describing only executable
routines, but it defines linker tables for when a component in the
kernel would define a data structure, part of which can be a callback.
Such data structure stuffed into an ELF section could allow dynamic
configuration of the dipsatching, even post boot.

I think this is a good stepping stone forward then, and to allow
dynamic configuration of the dispatcher could mean eventual extensions
to kunit's init stuff to stuff init calls into a data structure which
can then allow configuration of the dispatching. One benefit that the
linker table work *may* be able to help here with is that it allows
an easy way to create kunit specific ordering, at linker time.
There is also an example of addressing / generalizing dynamic / run time
changes of ordering, by using the x86 IOMMU initialization as an
example case. We don't have an easy way to do this today, but if kunit
could benefit from such framework, it'd be another use case for
the linker table work. That is, the ability to easilly allow
dynamically modifying run time ordering of code through ELF sections.

> In addition, by dispatching tests from a single location, we can
> guarantee that all KUnit tests run after late_init is complete, which
> was a concern during the initial KUnit patchset review (this has not
> been a problem in practice, but resolving with certainty is nevertheless
> desirable).

Indeed, the concern is just a real semantics limitations. With the tests
*always* running after all subsystem init stuff, we know we'd have a
real full kernel ready.

It does beg the question if this means kunit is happy to not be a tool
to test pre basic setup stuff (terminology used in init.c, meaning prior
to running all init levels). I suspect this is the case.

> Other use cases for this exist, but the above features should provide an
> idea of the value that this could provide.
> 
> ## What work remains to be done?
> 
> These patches were based on patches in our non-upstream branch[2], so we
> have a pretty good idea that they are useable as presented;
> nevertheless, some of the changes done in this patchset could
> *definitely* use some review by subsystem experts (linker scripts, init,
> etc), and will likely change a lot after getting feedback.
> 
> The biggest thing that I know will require additional attention is
> integrating this patchset with the KUnit module support patchset[3]. I
> have not even attempted to build these patches on top of the module
> support patches as I would like to get people's initial thoughts first
> (especially Alan's :-) ). I think that making these patches work with
> module support should be fairly straight forward, nevertheless.

Modules just have their own sections too. That's all. So it'd be a
matter of extending the linker script for modules too. But a module's
init is different than the core kernel's for vmlinux.

  Luis
