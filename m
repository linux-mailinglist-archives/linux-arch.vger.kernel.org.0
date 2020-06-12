Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D251F72D5
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jun 2020 06:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgFLEYJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Jun 2020 00:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgFLEYI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jun 2020 00:24:08 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24204C03E96F;
        Thu, 11 Jun 2020 21:24:07 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id o26so5469127edq.0;
        Thu, 11 Jun 2020 21:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDw2IckdwMgZNx/RcM3g1bGV48bIHbJTu1OTL4Mb9dA=;
        b=uWo82/a5SvqD5vhe4pBLnNZ5TXPTxmCro4Zb7tBB9dhuhuB5D/1snBgHddyYyoiO3d
         4XLZjfVDfB/SNN1Pdd+1Wwq0QXK7UVMe20V+NNsogHzDHMtW6Q8qPX6bgVNMDr3YKpQU
         tHuDNtcBlKoe+XBaec7zKoM7149ESQEEGDGAAHsC+TCmic3pPcg1OCyZVGEJZK58PCtN
         /D3em6zKYmJJ9lYEhrZg7wZVjOfnGKJ4kUqZX166SHuoWPVZK2T8M38ZZ0bYBrkxbkoE
         XsEyPvVzvA/1dXtgOFjIPXi6h581nJ3VxaCghZ1Y0ovtT+vs+V5xT5H7KrTKc7hQvef9
         knnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDw2IckdwMgZNx/RcM3g1bGV48bIHbJTu1OTL4Mb9dA=;
        b=a7ErASf9TYgDvpOQwTFVgYUr2fGHu+THxZu+t1skW4wHrRGrnV4OIN9pi6Lk9ffjI5
         M6/1xIcIcqSZuhrL3swjopU9qJKXCZ9OzX2U1ao6/n4riO3y2qbZEMbj/RR1o7MEtTHE
         R0p2y9zs2C+iuzgIJ97u9SJECIZObgzBop28udm5Md8ZUINcLnyvo2gMQYJu6yIBjq/7
         hRuU7G3WZXhRm9eXjTUR0ofJ0BUlSOD0fumM6TnuHdbMXT8xw1VJi+6s0LX9Ol1pTdF6
         neHax2BUcuEdj3Agm5ry+yMEOzypSmKa1gHPk5kccZNRlaolRdw5K3C4v7+QFr/ML9Ib
         NFrg==
X-Gm-Message-State: AOAM532cy5GkFnpViqVM33Rk+ssvCsyjqJ35K0rYscTjpy/4I8GM9rkz
        81UNWx0kf7UyiBAs+jpU2dMfrzE4S2YEZulBHV71pqQY7dM=
X-Google-Smtp-Source: ABdhPJymyEVd8+oMQfu2ojKyHE/Mxz7JgpMXD7uI6wrtO77fo5tKiAU6zjP5jnwXv137W70Qf3ksGdnWh/BJtTe5nAs=
X-Received: by 2002:aa7:d0cb:: with SMTP id u11mr9456640edo.381.1591935844108;
 Thu, 11 Jun 2020 21:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200602024804.GA3776630@p50-ethernet.mattst88.com> <202006021052.E52618F@keescook>
In-Reply-To: <202006021052.E52618F@keescook>
From:   Matt Turner <mattst88@gmail.com>
Date:   Thu, 11 Jun 2020 21:23:52 -0700
Message-ID: <CAEdQ38F2GP92xB2gMXTrEo-Adbbc9Cy1DWHU9yveGLzJNd2HrA@mail.gmail.com>
Subject: Re: Regression bisected to f2f84b05e02b (bug: consolidate
 warn_slowpath_fmt() usage)
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 2, 2020 at 11:03 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 01, 2020 at 07:48:04PM -0700, Matt Turner wrote:
> > I bisected a regression on alpha to f2f84b05e02b (bug: consolidate
> > warn_slowpath_fmt() usage) which looks totally innocuous.
> >
> > Reverting it on master confirms that it somehow is the trigger. At or a
> > little after starting userspace, I'll see an oops like this:
> >
> > Unable to handle kernel paging request at virtual address 0000000000000000
> > CPU 0
> > kworker/u2:5(98): Oops -1
> > pc = [<0000000000000000>]  ra = [<0000000000000000>]  ps = 0000    Not tainted
> > pc is at 0x0
>
> ^^^^ so, the instruction pointer is NULL. The only way I can imagine
> that happening would be from this line:
>
>         worker->current_func(work);
>
> > ra is at 0x0
> > v0 = 0000000000000007  t0 = 0000000000000001  t1 = 0000000000000001
> > t2 = 0000000000000000  t3 = fffffc00bfe68780  t4 = 0000000000000001
> > t5 = fffffc00bf8cc780  t6 = 00000000026f8000  t7 = fffffc00bfe70000
> > s0 = fffffc000250d310  s1 = fffffc000250d310  s2 = fffffc000250d310
> > s3 = fffffc000250ca40  s4 = fffffc000250caa0  s5 = 0000000000000000
> > s6 = fffffc000250ca40
> > a0 = fffffc00024f0488  a1 = fffffc00bfe73d98  a2 = fffffc00bfe68800
> > a3 = fffffc00bf881400  a4 = 0001000000000000  a5 = 0000000000000002
> > t8 = 0000000000000000  t9 = 0000000000000000  t10= 0000000001321800
> > t11= 000000000000ba4e  pv = fffffc000189ca00  at = 0000000000000000
> > gp = fffffc000253e430  sp = 0000000043a83c2e
> > Disabling lock debugging due to kernel taint
> > Trace:
> > [<fffffc000105c8ac>] process_one_work+0x25c/0x5a0
>
> Can you verify where this     ^^^^^^^^^^^^^^   is?

It is kernel/workqueue.c:2268, which contains

        worker->current_func(work);

as you predicted.

> > [<fffffc000105cc4c>] worker_thread+0x5c/0x7d0
> > [<fffffc0001066c88>] kthread+0x188/0x1f0
> > [<fffffc0001011b48>] ret_from_kernel_thread+0x18/0x20
> > [<fffffc0001066b00>] kthread+0x0/0x1f0
> > [<fffffc000105cbf0>] worker_thread+0x0/0x7d0
> >
> > Code:
> >  00000000
> >  00000000
> >  00063301
> >  000012e2
> >  00001111
> >  0005ffde
> >
> > It seems to cause a hard lock on an SMP system, but not on a system with
> > a single CPU. Similarly, if I boot the SMP system (2 CPUs) with
> > maxcpus=1 the oops doesn't happen. Until I tested on a non-SMP system
> > today I suspected that it was unaffected, but I saw the oops there too.
> > With the revert applied, I don't see a warning or an oops.
> >
> > Any clues how this patch could have triggered the oops?
>
> I cannot begin to imagine. :P Compared to other things I've seen like
> this in the past maybe it's some kind of effect from the code size
> changing the location/alignment or timing of something else?
>
> Various questions ranging in degrees of sanity:
>
> Does alpha use work queues for WARN?

I do not know. I don't see much in a few greps of arch/alpha that
would indicate that it uses work queues.

> Which work queue is getting a NULL function? (And then things like "if
> WARN was much slower or much faster, is there a race to something
> setting itself to NULL?")
>
> Was there a WARN before the above Oops?

No, which I suspect means that your much scarier suggestion that this
is somehow due to code size or alignment is increasingly plausible.

> Does WARN have side-effects on alpha?

alpha just uses the asm-generic implementation of WARN as far as I can
tell, so I think not.

> Does __WARN_printf() do something bad that warn_slowpath_null() doesn't?
>
> Does making incremental changes narrow anything down? (e.g. instead of
> this revert, remove the __warn() call in warn_slowpath_fmt() that was
> added? (I mean, that'll be quite broken for WARN, but will it not oops?)

Commenting out the added __warn does not work around the problem.

Readding warn_slowpath_null and the EXPORT_SYMBOL (but not calling it
from WARN) does not work around the problem.

Calling warn_slowpath_fmt() with fmt=" " instead of fmt=NULL does not
work around the problem.

I also tried GCC-10.1 as a stab in the dark, and that doesn't work
around the problem.

So I'm thinking it's something about code size or alignment. I would
be worried it's to do with memory ordering (since this is on Alpha)
but I'm seeing the problem on a single CPU system, so that should be
ruled out, I think?

Using CONFIG_CC_OPTIMIZE_FOR_SIZE=y doesn't work around the problem.
So that hurts the theory of code size being the trigger.

Since I noticed earlier that using maxcpus=1 on a 2-CPU system
prevented the system from hanging, I tried disabling CONFIG_SMP on my
1-CPU system as well. In doing so, I discovered that the RCU torture
module (RCU_TORTURE_TEST) triggers some null pointer dereferences on
Alpha when CONFIG_SMP is set, but works successfully when CONFIG_SMP
is unset.

That seems likely to be a symptom of the same underlying problem that
started this thread, don't you think? If so, I'll focus my attention
on that.

> Does alpha have hardware breakpoints? When I had to track down a
> corruption in the io scheduler, I ended up setting breakpoints on the
> thing that went crazy (in this case, I assume the work queue function
> pointer) to figure out what touched it.

As far as I know we don't have anything implemented in the kernel, but
they could be implemented by faulting on read/write.

> ... I can't think of anything else.

Thanks for your time and suggestions!

Matt
