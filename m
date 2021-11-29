Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A0E46145A
	for <lists+linux-arch@lfdr.de>; Mon, 29 Nov 2021 12:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbhK2L6B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Nov 2021 06:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhK2L4B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Nov 2021 06:56:01 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678DEC0698E0
        for <linux-arch@vger.kernel.org>; Mon, 29 Nov 2021 02:57:38 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v11so35794795wrw.10
        for <linux-arch@vger.kernel.org>; Mon, 29 Nov 2021 02:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7vafQL9VRNu9gFf/4mCpAetbH+x6q7yQT0LZFBgrIEY=;
        b=FpAGCEzpMCHDlrye0BEfBwWwvSDdjJvOXWO1p1/HTeFUBw51K/pUg7ZN8+2hhZV2HV
         22JTf8MK/JHZYUDXEZbC+03TcrFop82Q+qtsYPzjpgh0a2kz2Tyj31pCNAlSo0pVU0EN
         1s2wOz2tBmMVxpJwr8CJDRVHdSqJ9GcDNjGn9KsDQYIjSjL3pOQzcOX38J8iZtCO7cVf
         1VsNFoQ43N5HhmH8x/M4In50SZ0JugEpRq/2UnLc5Mhi5/l/XYzd/9rvORCsTXUtfH9K
         hKbSLcZgq5l3o1EzWNRfQzE9J6l1tKsCqXva0OANeH17ADW9gxG5Ur3Js5eQVOUl0wJ0
         lk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7vafQL9VRNu9gFf/4mCpAetbH+x6q7yQT0LZFBgrIEY=;
        b=ac+DZ2/g2iHC18svlJMTbyxPRO3cFOCCNQHnlSrHnQe5JOwSKJLM7BibV5hOQGAUvX
         PniI1AMJcb2VlXyccxIom7qV1qGwunx5hKebgPV/vL4QcVk0M6MDEk23nDg0o6yTzlKb
         LrbybVAEKCsM0oJDZOYE3fC8pKAp/Yef9EVHDq2495Z6n6hbhbg0GC9VuIYqz+3Ypy9f
         npjGaWHDPnWSwHJiF5DX11w5ngmJ65aLpOYNfvoy3/dCMoinZziUXwbF58wL4DOx0IXo
         0TK4MMdwrmx7tJju8B64i1MaxfqAQHhDf6r3o84PiTy3zczYMe36KSCVh3sUOGub5e/E
         Tslg==
X-Gm-Message-State: AOAM533Z2aGKjAmXCkC6cKFkVRBF1kSTG28vdJodThoYVp097n6/4Lj0
        U0OGe2hzUFoJrOSL0YZzDyznWg==
X-Google-Smtp-Source: ABdhPJwAU8YPWeu2RrOY2XQ41C34yLkIywEO8EJrMwhVry4Q5OSTPeXL1PW8RxfOB2Xl3zforekjfA==
X-Received: by 2002:adf:d082:: with SMTP id y2mr32476986wrh.214.1638183456845;
        Mon, 29 Nov 2021 02:57:36 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:aaf:77c4:3d2:af75])
        by smtp.gmail.com with ESMTPSA id n1sm16528943wmq.6.2021.11.29.02.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 02:57:36 -0800 (PST)
Date:   Mon, 29 Nov 2021 11:57:30 +0100
From:   Marco Elver <elver@google.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v2 03/23] kcsan: Avoid checking scoped accesses from
 nested contexts
Message-ID: <YaSyGr4vW3yifWWC@elver.google.com>
References: <20211118081027.3175699-1-elver@google.com>
 <20211118081027.3175699-4-elver@google.com>
 <YaSTn3JbkHsiV5Tm@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaSTn3JbkHsiV5Tm@boqun-archlinux>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 29, 2021 at 04:47PM +0800, Boqun Feng wrote:
> Hi Marco,
> 
> On Thu, Nov 18, 2021 at 09:10:07AM +0100, Marco Elver wrote:
> > Avoid checking scoped accesses from nested contexts (such as nested
> > interrupts or in scheduler code) which share the same kcsan_ctx.
> > 
> > This is to avoid detecting false positive races of accesses in the same
> 
> Could you provide an example for a false positive?
> 
> I think we do want to detect the following race:
> 
> 	static int v = SOME_VALUE; // a percpu variable.
> 	static int other_v = ... ;
> 
> 	void foo(..)
> 	{
> 		int tmp;
> 		int other_tmp;
> 
> 		preempt_disable();
> 		{
> 			ASSERT_EXCLUSIVE_ACCESSS_SCOPED(v);
> 			tmp = v;
> 			
> 			other_tmp = other_v; // int_handler() may run here
> 			
> 			v = tmp + 2;
> 		}
> 		preempt_enabled();
> 	}
> 
> 	void int_handler() // an interrupt handler
> 	{
> 		v++;
> 	}
> 
> , if I understand correctly, we can detect this currently, but with this
> patch, we cannot detect this if the interrupt happens while we're doing
> the check for "other_tmp = other_v;", right? Of course, running tests
> multiple times may eventually catch this, but I just want to understand
> what's this patch for, thanks!

The above will still be detected. Task and interrupt contexts in this
case are distinct, i.e. kcsan_ctx differ (see get_ctx()).

But there are rare cases where kcsan_ctx is shared, such as nested
interrupts (NMI?), or when entering scheduler code -- which currently
has a KCSAN_SANITIZE := n, but I occasionally test it, which is how I
found this problem. The problem occurs frequently when enabling KCSAN in
kernel/sched and placing a random ASSERT_EXCLUSIVE_ACCESS_SCOPED() in
task context, or just enable "weak memory modeling" without this fix.
You also need CONFIG_PREEMPT=y + CONFIG_KCSAN_INTERRUPT_WATCHER=y.

The emphasis here really is on _shared kcsan_ctx_, which is not too
common. As noted in the commit description, we need to "[...] setting up
a watchpoint for a non-scoped (normal) access that also "conflicts" with
a current scoped access."

Consider this:

	static int v;
	int foo(..)
	{
		ASSERT_EXCLUSIVE_ACCESS_SCOPED(v);
		v++; // preempted during watchpoint for 'v++'
	}

Here we set up a scoped_access to be checked for v. Then on v++, a
watchpoint is set up for the normal access. While the watchpoint is set
up, the task is preempted and upon entering scheduler code, we're still
in_task() and 'current' is still the same, thus get_ctx() returns a
kcsan_ctx where the scoped_accesses list is non-empty containing the
scoped access for foo()'s ASSERT_EXCLUSIVE.

That means, when instrumenting scheduler code or any other code called
by scheduler code or nested interrupts (anything where get_ctx() still
returns the same as parent context), it'd now perform checks based on
the parent context's scoped access, and because the parent context also
has a watchpoint set up on the variable that conflicts with the scoped
access we'd report a nonsensical race.

This case is also possible:

	static int v;
	static int x;
	int foo(..)
	{
		ASSERT_EXCLUSIVE_ACCESS_SCOPED(v);
		x++; // preempted during watchpoint for 'v' after checking x++
	}

Here, all we need is for the scoped access to be checked after x++, end
up with a watchpoint for it, then enter scheduler code, which then
checked 'v', sees the conflicting watchpoint, and reports a nonsensical
race again.

By disallowing scoped access checking for a kcsan_ctx, we simply make
sure that in such nested contexts where kcsan_ctx is shared, none of
these nonsensical races would be detected nor reported.

Hopefully that clarifies what this is about.

Thanks,
-- Marco
