Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CF828EAF4
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 04:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbgJOCJw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 22:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbgJOCJh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Oct 2020 22:09:37 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4D9C02524A
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 16:43:36 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id x185so455562vsb.1
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 16:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3w+czKVyohLMxBcXMIaP13GyxeCO5C8H4KHeiFeA5uE=;
        b=hV3EcZ9e3iiFPQCKxp7ayResTreDTTT76eiBKWopdm7fBfVSbydoH4uXlekHQ37vFk
         zXpjjyq2lbfupZnYFdy/4eW/r2w+5nK8rn9/C7Ni/VNeluvRNzP3QUg/mt1POZBJ9O0X
         jcnNTSyxegxhdYNM3DdKtv/sWIWampNQct9P5kInAEkhPUgYLgCN8rT0gu2Csfby6BXB
         /oxUCPbsL6bdghzdHIkIYo0VATfcR/5zNwpsmypwYFbAtMXIuB+CtBKLkcS4DP4wTIwH
         7hSJvYCS1NhA/vlYV2HrSlu2BqkSsu85i0QsR9NkaI7g60OotH2kXXOQ7SwwmjFEvGuF
         2PKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3w+czKVyohLMxBcXMIaP13GyxeCO5C8H4KHeiFeA5uE=;
        b=Vxj9hUzgyEZpSg6oxLOfklcPIRejabrAMwTy9vmxVOaSH69o+pM2mTzTIY4BiY5j10
         J/+JNa9kzx/JdwOx4sqACLl43riAy00ROITyqZUc00ICarqwDW94XTduVhoRRtLku1iJ
         rpoa573ypAtHY3dCFSVR9NHmTyo+CQ6OPZkn9JpNiaQNOubF5m57q/De71xqDfH+UEIk
         UlyFe0dYMUjwZ/PFKbqRfRKN9zsSU5zSpjyga0DjaBRm+J3WI7Yn6wJlFueb8gGZGjxf
         wgEN84rp1+RenNZMexsc0cqnhySLGbQ0JW9B3Y0/GWX7tTK28uX/FtJYJmw/TvJc2l3t
         543Q==
X-Gm-Message-State: AOAM530lA8HMNn3S4zteoBMwzXwzs0uZTVvtuw8wJYmangPB2eZEPPQ8
        FdNA5OSd/F23TseJKVdu7W9XZzgaUJVMEo2Ez5SBag==
X-Google-Smtp-Source: ABdhPJy+uau90omOax4ZnuqjzDGaW3nLTRRyJ6xot3CSnMwXblec2A/H42qx53XH50y1gjhVCjq44S8JtpYTB76HiVE=
X-Received: by 2002:a67:fb96:: with SMTP id n22mr1213426vsr.13.1602719015516;
 Wed, 14 Oct 2020 16:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200904103029.32083-1-catalin.marinas@arm.com>
 <20200904103029.32083-30-catalin.marinas@arm.com> <20200917081107.GA29031@willie-the-truck>
 <20200917090229.GA10662@gaia> <20200917161550.GA6642@arm.com> <20200918083046.GA30709@willie-the-truck>
In-Reply-To: <20200918083046.GA30709@willie-the-truck>
From:   Peter Collingbourne <pcc@google.com>
Date:   Wed, 14 Oct 2020 16:43:23 -0700
Message-ID: <CAMn1gO76z7eLcuYg_PuWPCq7_N5p29518EGy-FdY9AvyY0fDgw@mail.gmail.com>
Subject: Re: [PATCH v9 29/29] arm64: mte: Add Memory Tagging Extension documentation
To:     Will Deacon <will@kernel.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 1:30 AM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Sep 17, 2020 at 05:15:53PM +0100, Dave Martin wrote:
> > On Thu, Sep 17, 2020 at 10:02:30AM +0100, Catalin Marinas wrote:
> > > On Thu, Sep 17, 2020 at 09:11:08AM +0100, Will Deacon wrote:
> > > > On Fri, Sep 04, 2020 at 11:30:29AM +0100, Catalin Marinas wrote:
> > > > > From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > > >
> > > > > Memory Tagging Extension (part of the ARMv8.5 Extensions) provides
> > > > > a mechanism to detect the sources of memory related errors which
> > > > > may be vulnerable to exploitation, including bounds violations,
> > > > > use-after-free, use-after-return, use-out-of-scope and use before
> > > > > initialization errors.
> > > > >
> > > > > Add Memory Tagging Extension documentation for the arm64 linux
> > > > > kernel support.
> > > > >
> > > > > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > > > Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > > Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
> > > >
> > > > I'm taking this to mean that Szabolcs is happy with the proposed ABI --
> > > > please shout if that's not the case!
> > >
> > > I think Szabolcs is still on holiday. To summarise the past threads,
> > > AFAICT he's happy with this per-thread control ABI but the discussion
> > > went on whether to expand it in the future (with a new bit) to
> > > synchronise the tag checking mode across all threads of a process. This
> > > adds some complications for the kernel as it needs an IPI to the other
> > > CPUs to set SCTLR_EL1 and it's also racy with multiple threads
> > > requesting different modes.
> > >
> > > Now, in the glibc land, if the tag check mode is controlled via
> > > environment variables, the dynamic loader can set this at process start
> > > while still in single-threaded mode and not touch it at run-time. The
> > > MTE checking can still be enabled at run-time, per mapped memory range
> > > via the PROT_MTE flag. This approach doesn't require any additional
> > > changes to the current patches. But it's for Szabolcs to confirm once
> > > he's back.
> > >
> > > > Wasn't there a man page kicking around too? Would be good to see that
> > > > go upstream (to the manpages project, of course).
> > >
> > > Dave started writing one for the tagged address ABI, not sure where that
> > > is. For the MTE additions, we are waiting for the ABI to be upstreamed.
> >
> > The tagged address ABI control stuff is upstream in the man-pages-5.08
> > release.
> >
> > I don't think anyone drafted anything for MTE yet.  Do we consider the
> > MTE ABI to be sufficiently stable now for it to be worth starting
> > drafting something?
>
> I think so, yes. I'm hoping to queue it for 5.10, once I have an Ack from
> the Android tools side on the per-thread ABI.

Our main requirement on the Android side is to provide an API for
changing the tag checking mode in all threads in a process while
multiple threads are running. I think we've been able to accomplish
this [1] by using a libc private real-time signal which is sent to all
threads. The implementation has been tested on FVP via the included
unit tests. The code has also been tested on real hardware in a
multi-threaded app process (of course we don't have MTE-enabled
hardware, so the implementation was tested on hardware by hacking it
to disable the tagged address ABI instead of changing the tag checking
mode, and then verifying via ptrace(PTRACE_GETREGSET) that the tagged
address ABI was disabled in all threads).

That being said, as with any code at the nexus of concurrency and
POSIX signals, the implementation is quite tricky so I would say it
falls more into the category of "no obvious problems" than "obviously
no problems". It also relies on changes to the implementations of
pthread APIs so it wouldn't catch threads created directly via clone()
rather than via pthread_create(). I think we would be able to ignore
such threads on Android without causing compatibility issues because
we can require the process to not create threads via clone() before
calling the function. I imagine this may not necessarily work for
other libcs like glibc, though, but as I understand it glibc has no
plan to offer such an API.

I feel confident enough in the kernel API though that I think that
it's reasonable as a starting point at least, and that if a problem
with the API is discovered I would expect it to be fixable by adding
new APIs, so:

Acked-by: Peter Collingbourne <pcc@google.com>

Peter

[1] https://android-review.googlesource.com/c/platform/bionic/+/1427377
