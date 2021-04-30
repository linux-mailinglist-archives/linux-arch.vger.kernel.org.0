Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16366370104
	for <lists+linux-arch@lfdr.de>; Fri, 30 Apr 2021 21:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhD3TIG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Apr 2021 15:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhD3TID (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Apr 2021 15:08:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D1CC06138C
        for <linux-arch@vger.kernel.org>; Fri, 30 Apr 2021 12:07:14 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n84so11207362wma.0
        for <linux-arch@vger.kernel.org>; Fri, 30 Apr 2021 12:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QsIOjRVDObuzB3TAj/QUXyHP2hTbDXsiJXpMnud8bTw=;
        b=feNJVQ1RjmiP25z0XbDMVEl3Wt/CAfZNpYgdwRSY9Wh2+n0aM8JgX8jY0QwDZgMchX
         Ups7Y3KALpWGD3bV3U8n/QnNnUitq+p4g/Gr1Whcokp7pVBff36nf6A7RGqYn18dJtGH
         2wwrQ+RcyNFulDrIRN5DxCjp/98T8R/hXzPOBw+SSjANKqZRdGJvPoT2HfmOzpAGy0r6
         1+yDwfdq2MLhyqfYd21/L/j8eRS9P8HtE5KNJe3xHCLruZEn91N7DcV3mRLCrQkPwsMd
         j+4llQf4dyL1rVltTM6lZD5/PXY8JvsN9DQFroofvOnMC6/gQW40X1GAVLwKjemIC8Ok
         TjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QsIOjRVDObuzB3TAj/QUXyHP2hTbDXsiJXpMnud8bTw=;
        b=gFtms/1ip+1jynayu2qLWWhJ4LJpAUHSP+wRzLF426gJTXXR0x4Oxicqxxxl/+dsov
         k8YB+5FgLmRqc0fUVy6xjbAs0B8dOSbfwvy+EvIEFcCHVd0xiDzGnqfYCIzUBQ/JsI94
         PgDehSM6JmzM/+nXfcLsn/e02CPQiyf8nvem938wBQkERFGXhHk9bxeFVNkOW3bK5GqO
         zmEIi9xBi1/gcqsHEOSXNpkZlbzsdfYeWhQabN5xPZknYuoLatbHcWiMoa4yP96TWl1p
         phw8mge2ZLi9MC+D8yjrsyv7pxGP/wJoxdWp3z3D9uGxnHIvJsdkRvzqZmHrQVCp5UvM
         UzQA==
X-Gm-Message-State: AOAM533OhEAw+h0zA7NcsvCdqH9egMyPOcopJaDxxxWA9wEKbWKMgOkU
        +davXt1zgAbm++ADIBnCJA0MYg==
X-Google-Smtp-Source: ABdhPJxl3CmvBsFsTgbZKT8UBCmij5XM7DUxig/6GHwehvyMQxbQwicz0ECpF7YdTMQ9sty2UELYvA==
X-Received: by 2002:a1c:545c:: with SMTP id p28mr18332214wmi.118.1619809633033;
        Fri, 30 Apr 2021 12:07:13 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:8eae:7187:8db5:a3e])
        by smtp.gmail.com with ESMTPSA id a9sm3801655wmj.1.2021.04.30.12.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 12:07:12 -0700 (PDT)
Date:   Fri, 30 Apr 2021 21:07:06 +0200
From:   Marco Elver <elver@google.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: siginfo_t ABI break on sparc64 from si_addr_lsb move 3y ago
Message-ID: <YIxVWkT03TqcJLY3@elver.google.com>
References: <YIpkvGrBFGlB5vNj@elver.google.com>
 <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m15z031z0a.fsf@fess.ebiederm.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 30, 2021 at 12:08PM -0500, Eric W. Biederman wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
[...] 
> >> I did a quick search and the architectures that define __ARCH_SI_TRAPNO
> >> are sparc, mips, and alpha.  All have 64bit implementations.  A further
> >> quick search shows that none of those architectures have faults that
> >> use BUS_MCEERR_AR, BUS_MCEERR_AO, SEGV_BNDERR, SEGV_PKUERR, nor do
> >> they appear to use mm/memory-failure.c
> >>
> >> So it doesn't look like we have an ABI regression to fix.
> >
> > Even better!
> >
> > So if sparc is the only user of _trapno and it uses none of the later
> > fields in _sigfault, I wonder if we could take even more liberty at
> > trying to have a slightly saner definition. Can you think of anything that
> > might break if we put _trapno inside of the union along with _perf
> > and _addr_lsb?
> 
> On sparc si_trapno is only set when SIGILL ILL_TRP is set.  So we can
> limit si_trapno to that combination, and it should not be a problem for
> a new signal/si_code pair to use that storage.  Precisely because it is
> new.
> 
> Similarly on alpha si_trapno is only set for:
> 
> SIGFPE {FPE_INTOVF, FPE_INTDIV, FPE_FLTOVF, FPE_FLTDIV, FPE_FLTUND,
> FPE_FLTINV, FPE_FLTRES, FPE_FLTUNK} and SIGTRAP {TRAP_UNK}.
> 
> Placing si_trapno into the union would also make the problem that the
> union is pointer aligned a non-problem as then the union immediate
> follows a pointer.
> 
> I hadn't had a chance to look before but we must deal with this.  The
> definition of perf_sigtrap in 42dec9a936e7696bea1f27d3c5a0068cd9aa95fd
> is broken on sparc, alpha, and ia64 as it bypasses the code in
> kernel/signal.c that ensures the si_trapno or the ia64 special fields
> are set.
> 
> Not to mention that perf_sigtrap appears to abuse si_errno.

There are a few other places in the kernel that repurpose si_errno
similarly, e.g. arch/arm64/kernel/ptrace.c, kernel/seccomp.c -- it was
either that or introduce another field or not have it. It is likely we
could do without, but if there are different event types the user would
have to sacrifice a few bits of si_perf to encode the event type, and
I'd rather keep those bits for something else. Thus the decision fell to
use si_errno.

Given it'd be wasted space otherwise, and we define the semantics of
whatever is stored in siginfo on the new signal, it'd be good to keep.

> The code is only safe if the analysis that says we can move si_trapno
> and perhaps the ia64 fields into the union is correct.  It looks like
> ia64 much more actively uses it's signal extension fields including for
> SIGTRAP, so I am not at all certain the generic definition of
> perf_sigtrap is safe on ia64.

Trying to understand the requirements of si_trapno myself: safe here
would mean that si_trapno is not required if we fire our SIGTRAP /
TRAP_PERF.

As far as I can tell that is the case -- see below.

> > I suppose in theory sparc64 or alpha might start using the other
> > fields in the future, and an application might be compiled against
> > mismatched headers, but that is unlikely and is already broken
> > with the current headers.
> 
> If we localize the use of si_trapno to just a few special cases on alpha
> and sparc I think we don't even need to worry about breaking userspace
> on any architecture.  It will complicate siginfo_layout, but it is a
> complication that reflects reality.
> 
> I don't have a clue how any of this affects ia64.  Does perf work on
> ia64?  Does perf work on sparc, and alpha?
> 
> If perf works on ia64 we need to take a hard look at what is going on
> there as well.

No perf on ia64, but it seems alpha and sparc have perf:

	$ git grep 'select.*HAVE_PERF_EVENTS$' -- arch/
	arch/alpha/Kconfig:	select HAVE_PERF_EVENTS    <--
	arch/arc/Kconfig:	select HAVE_PERF_EVENTS
	arch/arm/Kconfig:	select HAVE_PERF_EVENTS
	arch/arm64/Kconfig:	select HAVE_PERF_EVENTS
	arch/csky/Kconfig:	select HAVE_PERF_EVENTS
	arch/hexagon/Kconfig:	select HAVE_PERF_EVENTS
	arch/mips/Kconfig:	select HAVE_PERF_EVENTS
	arch/nds32/Kconfig:	select HAVE_PERF_EVENTS
	arch/parisc/Kconfig:	select HAVE_PERF_EVENTS
	arch/powerpc/Kconfig:	select HAVE_PERF_EVENTS
	arch/riscv/Kconfig:	select HAVE_PERF_EVENTS
	arch/s390/Kconfig:	select HAVE_PERF_EVENTS
	arch/sh/Kconfig:	select HAVE_PERF_EVENTS
	arch/sparc/Kconfig:	select HAVE_PERF_EVENTS    <--
	arch/x86/Kconfig:	select HAVE_PERF_EVENTS
	arch/xtensa/Kconfig:	select HAVE_PERF_EVENTS

Now, given ia64 is not an issue, I wanted to understand the semantics of
si_trapno. Per https://man7.org/linux/man-pages/man2/sigaction.2.html, I
see:

	int si_trapno;    /* Trap number that caused
			     hardware-generated signal
			     (unused on most architectures) */

... its intended semantics seem to suggest it would only be used by some
architecture-specific signal like you identified above. So if the
semantics is some code of a hardware trap/fault, then we're fine and do
not need to set it.

Also bearing in mind we define the semantics any new signal, and given
most architectures do not have si_trapno, definitions of new generic
signals should probably not include odd architecture specific details
related to old architectures.

From all this, my understanding now is that we can move si_trapno into
the union, correct? What else did you have in mind?

Thanks,
-- Marco
