Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46560426BEE
	for <lists+linux-arch@lfdr.de>; Fri,  8 Oct 2021 15:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbhJHNuG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 09:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJHNuF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Oct 2021 09:50:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A315C061570;
        Fri,  8 Oct 2021 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AeZfY9f2iurPW1q+xtFtNI1W2I5709CG4W+EJzRCAMU=; b=DqeWXbPQlW8+2aIXHL4un8c8+C
        ruiELp8b0b13YYNPX7L4rPcFlICkbKbxDmpxW0wfhQri+vCj4+Un16Vk2xSx5dnHKB6XjF/nCD4Kc
        nlnyFWrwNg5WN4WEfLzCSesqGpp15v6P6xIml5ZTruuTBuiM9FYSXvBMo18CxswkMsRBySXd9+BjP
        UIzM212gfP/XKVRlc+i9DzGCdyo6ulxCGiaIh7lO+UySloIQPd2SGi0v5Xr81ivHfLGBEpUiHJRBR
        NSJhA9/LEcIXsBIVuCAiF2O2TNE5GY68jb8IP3tr8i6lQN6u1mH0yrsXX5Ji+Xu+tNprYsQ4lhIl4
        GOQBFtJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYqCJ-008fZ5-Li; Fri, 08 Oct 2021 13:46:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A494E300ECB;
        Fri,  8 Oct 2021 15:45:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64C3A2007A037; Fri,  8 Oct 2021 15:45:59 +0200 (CEST)
Date:   Fri, 8 Oct 2021 15:45:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     keescook@chromium.org, jannh@google.com,
        linux-kernel@vger.kernel.org, vcaputo@pengaru.com,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, amistry@google.com,
        Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, axboe@kernel.dk,
        metze@samba.org, laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, jpoimboe@redhat.com,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        vgupta@kernel.org, linux@armlinux.org.uk, will@kernel.org,
        guoren@kernel.org, bcain@codeaurora.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        jonas@southpole.se, mpe@ellerman.id.au, paul.walmsley@sifive.com,
        hca@linux.ibm.com, ysato@users.sourceforge.jp, davem@davemloft.net,
        chris@zankel.net
Subject: Re: [PATCH 6/7] arch: __get_wchan || STACKTRACE_SUPPORT
Message-ID: <YWBLl0mMTGPE/7hM@hirez.programming.kicks-ass.net>
References: <20211008111527.438276127@infradead.org>
 <20211008111626.392918519@infradead.org>
 <20211008124052.GA976@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008124052.GA976@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 08, 2021 at 01:40:52PM +0100, Mark Rutland wrote:
> [Adding Josh, since there might be a concern here from a livepatch pov]
> 

> > +static unsigned long __get_wchan(struct task_struct *p)
> > +{
> > +	unsigned long entry = 0;
> > +
> > +	stack_trace_save_tsk(p, &entry, 1, 0);
> 
> This assumes stack_trace_save_tsk() will skip sched functions, but I
> don't think that's ever been a requirement? It's certinaly not
> documented anywhere that I could find, and arm64 doesn't do so today,
> and this patch causes wchan to just log `__switch_to` for everything.

Confused, arm64 has arch_stack_walk() and should thus use
kernel/stacktrace.c's stack_trace_consume_entry_nosched.

> I realise you "fix" that for some arches in the next patch, but it's not
> clear to me that's the right thing to do -- I would expect that

I only actually change the behaviour on csky, both mips and nds32 have
this 'savesched = (task == current)' logic which ends up being a very
confusing way to write things, but for wchan we never call on current,
and hence don't save the __sched functions.

> stack_trace_save_tsk() *shouldn't* skip anything unless we've explicitly
> told it to via skipnr, because I'd expect that

It's what most archs happen to do today and is what
stack_trace_save_tsk() as implemented using arch_stack_walk() does.
Which is I think the closest to canonical we have.

> stack_trace_save_tsk_reliable() mustn't, in case we ever need to patch
> anything in the scheduler (or arch ctxsw code) with a livepatch, or if
> you ever *want* to have the sched functions in a trace.
> 
> So I have two big questions:
> 
> 1) Where precisely should stack_trace_save_tsk() and
>    stack_trace_save_tsk_reliable() start from?
> 
> 1) What should you do when you *do* want sched functions in a trace?
> 
> We could side-step the issue here by using arch_stack_walk(), which'd
> make it easy to skip sched functions in the core code.

arch_stack_walk() is the modern API and should be used going forward,
and I've gone with the stack_trace_save*() implementation as per that.
